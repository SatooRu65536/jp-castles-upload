import re
import sys
import sqlite3
import requests
from time import sleep
from bs4 import BeautifulSoup
import db

INTERVAL = 2
BASE_URL = 'https://www.hb.pei.jp'

conn = sqlite3.connect('./db/data.db', isolation_level=None)
cur = conn.cursor()


def get_address(latitude, longitude):
    '''
        緯度・経度から住所を取得する
    '''
    res = requests.get(
        f'https://geoapi.heartrails.com/api/json?method=searchByGeoLocation&x={longitude}&y={latitude}'
    ).json()

    prefecture = res['response']['location'][0]['prefecture']
    city = res['response']['location'][0]['city']

    return prefecture, city


def get(url):
    '''
        指定されたURLのページを取得する
    '''
    sleep(INTERVAL)
    res = requests.get(url)
    return res


def set_links(links):
    '''
        リンクをDBに登録する
    '''
    for link in links:
        cur.execute(
            'INSERT OR IGNORE INTO links(link) VALUES (:link)',
            {'link': link}
        )


def set_castle(id, name, latitude, longitude, prefecture, area, city, html, link):
    '''
        マーカーをDBに登録する
    '''
    cur.execute('BEGIN')
    try:
        sql = '''
            INSERT OR IGNORE INTO castles(
                key, name, latitude, longitude, prefecture, area, city, html, link
            ) VALUES (
                :key, :name, :latitude, :longitude, :prefecture, :area, :city, :html, :link
            )
        '''
        values = {
            'key': f'{name}_{latitude}_{longitude}',
            'name': name,
            'latitude': latitude,
            'longitude': longitude,
            'prefecture': prefecture,
            'area': area,
            'city': city,
            'html': html,
            'link': link
        }
        cur.execute(sql, values)
        cur.execute(
            'UPDATE links SET visited = 1 WHERE id = :id',
            {'id': id}
        )
        cur.execute('COMMIT')
    except Exception as e:
        print(e)
        cur.execute('ROLLBACK')


def get_pref_links():
    '''
        都道府県のリンクを取得する
    '''
    res = get(f'{BASE_URL}/shiro/')

    soup = BeautifulSoup(res.text, "html.parser")
    elem = soup.select(
        'body > div.top-right > div:nth-child(3) > div > div.panel.is-show > div a')

    return [f'{BASE_URL}/shiro/{e.attrs["href"]}' for e in elem]


def get_castle_links(pref_link):
    '''
        城のリンクを取得する
    '''
    name_selector = 'body > div.shiro-list > div.clear > div a'

    res = get(pref_link)
    soup = BeautifulSoup(res.text, "html.parser")
    elem = soup.select(name_selector)

    return list(set([f'{BASE_URL}{e.attrs["href"]}' for e in elem]))


def get_castle_info(castle_link):
    '''
        城の情報を取得する
    '''
    res = get(castle_link)
    soup = BeautifulSoup(res.text, "html.parser")

    # 城名・地域
    name_selector = 'body > div.header > p.title-mid > ruby > rb'
    name = soup.select(name_selector)[0].text \
        .split(' ')[-1] \
        .split('(')[0]
    area = soup.select(name_selector)[0].text.split(' ')[0]

    # 緯度・経度
    options_selector = 'body > div.det select option[value^="https://maps.google.com/"]'
    map_url = soup.select(options_selector)[-1].attrs['value']
    match = re.search(r'q=(\d+\.\d+),(\d+\.\d+)', map_url)
    latitude = float(match.group(1))
    longitude = float(match.group(2))

    # 都道府県, 市区町村
    prefecture, city = get_address(latitude, longitude)

    # HTML
    html = res.text.replace('\n', '')

    return name, latitude, longitude, prefecture, area, city, html


def castle_links():
    pref_links = get_pref_links()

    for pref_link in pref_links:
        castle_links = get_castle_links(pref_link)
        print("-" * 20)
        print(pref_link)
        set_links(castle_links)


def castle_info():
    castle_db = cur.execute(
        'SELECT id, link FROM links WHERE visited = 0'
    ).fetchall()

    for c in castle_db:
        print("-" * 20)
        print(c[1])
        castle_info = get_castle_info(c[1])
        set_castle(
            c[0],
            *castle_info,
            c[1]
        )


def init_castle():
    cur.execute('DELETE FROM castles')
    cur.execute('UPDATE links SET visited = 0')
    cur.execute('DELETE FROM castles')


def test():
    get_castle_info('https://www.hb.pei.jp/shiro/echigo/kakizaki-jyo/')


if __name__ == '__main__':
    if '--test' in sys.argv:
        test()
    elif '--castle-links' in sys.argv:
        castle_links()
    elif '--castle-info' in sys.argv:
        castle_info()
    elif '--init-castle' in sys.argv:
        init_castle()

    conn.close()
