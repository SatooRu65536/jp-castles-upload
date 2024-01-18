import sqlite3
import requests
import time
import json
import db

conn = sqlite3.connect('./db/data.db', isolation_level=None)
cur = conn.cursor()


def get_castles_from_db(offset, limit):
    """
        データベースから城の情報を取得する
    """
    query = f'''
        SELECT name, latitude, longitude, scale 
        FROM castles
        LIMIT {limit}
        OFFSET {limit * offset}
    '''
    cur.execute(query)
    return cur.fetchall()


def to_markers(castles):
    """
        データベースから取得した城の情報をマーカー情報に変換する
    """
    return [
        {
            "name": castle[0],
            "coordinates": {
                "lat": castle[1],
                "lng": castle[2]
            },
            "scale": castle[3]
        }
        for castle in castles
    ]


def upload_d1(host='http://localhost:8000'):
    """
        データベースから城の情報を取得し、cloudflare D1にアップロードする
    """

    url = f'{host}/markers'

    print('start uploading.')
    print(f'url: {url}')

    i = 0
    limit = 10

    headers = {
        'Content-Type': 'application/json'
    }
    while True:
        castles = get_castles_from_db(i, limit)
        if len(castles) == 0:
            return

        reqBody = json.dumps({"markers": to_markers(castles)})
        [
            print(f'> {castle[0]}_{castle[1]}_{castle[2]}') for castle in castles
        ]
        res = requests.post(url, data=reqBody, headers=headers)
        print(f'{res.status_code}: {i}-{limit}')

        if res.status_code != 200:
            print(res.text)

        # break
        i += 1
        # time.sleep(1)

    print('finish uploading.')


if __name__ == '__main__':
    upload_d1(host='https://api.castles.satooru.dev')
