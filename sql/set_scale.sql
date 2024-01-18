-- 全ての城の scale を 1 にする
UPDATE castles
SET
    scale = 1;

-- 特別史跡 と 国指定史跡 の scale を 4 にする
UPDATE castles
SET
    scale = 4
WHERE
    scale = 1
    AND html LIKE '%特別史跡%'
    OR html LIKE '%国指定史跡%';

-- 市史跡 と 町指定史跡 と 村指定史跡 の scale を 3 にする
UPDATE castles
SET
    scale = 3
WHERE
    scale = 1
    AND html LIKE '%市指定史跡%'
    OR html LIKE '%町指定史跡%'
    OR html LIKE '%村指定史跡%';

-- 遺構がある城の scale を 2 にする
UPDATE castles
SET
    scale = 2
WHERE
    scale = 1
    AND html NOT LIKE '%遺　構</div><div class="det-cont1 cont-color">なし%';

-- 百名城の scale を 6 にする
UPDATE castles
SET
    scale = 6
WHERE
    name IN ('根室半島チャシ跡群', '五稜郭', '松前城')
    AND prefecture = '北海道'
    OR name IN ('弘前城', '根城')
    AND prefecture = '青森県'
    OR name IN ('盛岡城')
    AND prefecture = '岩手県'
    OR name IN ('多賀城', '仙台城')
    AND prefecture = '宮城県'
    OR name IN ('久保田城')
    AND prefecture = '秋田県'
    OR name IN ('山形城')
    AND prefecture = '山形県'
    OR name IN ('二本松城', '会津若松城', '白河小峰城')
    AND prefecture = '福島県'
    OR name IN ('水戸城', '足利氏館')
    AND prefecture = '茨城県'
    OR name IN ('箕輪城', '金山城')
    AND prefecture = '群馬県'
    OR name IN ('鉢形城', '川越城')
    AND prefecture = '埼玉県'
    OR name IN ('佐倉城')
    AND prefecture = '千葉県'
    OR name IN ('江戸城', '八王子城')
    AND prefecture = '東京都'
    OR name IN ('小田原城')
    AND prefecture = '神奈川県'
    OR name IN ('武田氏館', '甲府城')
    AND prefecture = '新潟県'
    OR name IN ('松代城', '上田城', '小諸城', '松本城', '高遠城')
    AND prefecture = '長野県'
    OR name IN ('新発田城', '春日山城')
    AND prefecture = '新潟県'
    OR name IN ('高岡城')
    AND prefecture = '富山県'
    OR name IN ('七尾城', '金沢城')
    AND prefecture = '石川県'
    OR name IN ('丸岡城', '一乗谷城')
    AND prefecture = '福井県'
    OR name IN ('岩村城', '岐阜城', '山中城')
    AND prefecture = '岐阜県'
    OR name IN ('駿府城', '掛川城')
    AND prefecture = '静岡県'
    OR name IN ('犬山城', '名古屋城', '岡崎城', '長篠城')
    AND prefecture = '愛知県'
    OR name IN ('伊賀上野城', '松阪城')
    AND prefecture = '三重県'
    OR name IN ('小谷城', '彦根城', '安土城', '観音寺城')
    AND prefecture = '滋賀県'
    OR name IN ('二条城')
    AND prefecture = '京都府'
    OR name IN ('大阪城', '千早城')
    AND prefecture = '大阪府'
    OR name IN ('竹田城', '篠山城', '明石城', '姫路城', '赤穂城')
    AND prefecture = '兵庫県'
    OR name IN ('高取城')
    AND prefecture = '奈良県'
    OR name IN ('和歌山城')
    AND prefecture = '和歌山県'
    OR name IN ('鳥取城')
    AND prefecture = '鳥取県'
    OR name IN ('松江城', '月山富田城', '津和野城')
    AND prefecture = '島根県'
    OR name IN ('津山城', '備中松山城', '鬼ノ城', '岡山城')
    AND prefecture = '岡山県'
    OR name IN ('福山城', '郡山城', '広島城')
    AND prefecture = '広島県'
    OR name IN ('岩国城', '萩城')
    AND prefecture = '山口県'
    OR name IN ('徳島城')
    AND prefecture = '徳島県'
    OR name IN ('高松城', '丸亀城')
    AND prefecture = '香川県'
    OR name IN ('今治城', '湯築城', '松山城', '大洲城', '宇和島城')
    AND prefecture = '愛媛県'
    OR name IN ('高知城')
    AND prefecture = '高知県'
    OR name IN ('福岡城', '大野城', '名護屋城', '吉野ヶ里')
    AND prefecture = '福岡県'
    OR name IN ('佐賀城', '吉野ヶ里遺跡')
    AND prefecture = '佐賀県'
    OR name IN ('平戸城', '島原城')
    AND prefecture = '長崎県'
    OR name IN ('熊本城', '人吉城')
    AND prefecture = '熊本県'
    OR name IN ('大分府内城', '岡城')
    AND prefecture = '大分県'
    OR name IN ('飫肥城')
    AND prefecture = '宮崎県'
    OR name IN ('鹿児島城')
    AND prefecture = '鹿児島県'
    OR name IN ('今帰仁城', '中城城', '首里城')
    AND prefecture = '沖縄県';

-- 続百名城の scale を 5 にする
UPDATE castles
SET
    scale = 5
WHERE
    name IN ('志苔館', '上ノ国勝山館')
    AND prefecture = '北海道'
    OR name IN ('浪岡城')
    AND prefecture = '青森県'
    OR name IN ('九戸城')
    AND prefecture = '岩手県'
    OR name IN ('白石城')
    AND prefecture = '宮城県'
    OR name IN ('脇本城', '秋田城')
    AND prefecture = '秋田県'
    OR name IN ('鶴ヶ岡城', '米沢城')
    AND prefecture = '山形県'
    OR name IN ('三春城', '向羽黒山城')
    AND prefecture = '福島県'
    OR name IN ('笠間城', '土浦城')
    AND prefecture = '茨城県'
    OR name IN ('唐沢山城')
    AND prefecture = '栃木県'
    OR name IN ('名胡桃城', '沼田城', '岩櫃城')
    AND prefecture = '群馬県'
    OR name IN ('忍城', '杉山城', '菅谷館')
    AND prefecture = '埼玉県'
    OR name IN ('本佐倉城', '大多喜城')
    AND prefecture = '千葉県'
    OR name IN ('滝山城', '品川台場')
    AND prefecture = '東京都'
    OR name IN ('小机城', '石垣山城')
    AND prefecture = '神奈川県'
    OR name IN ('新府城', '要害山城')
    AND prefecture = '山梨県'
    OR name IN ('龍岡城', '高島城')
    AND prefecture = '長野県'
    OR name IN ('村上城', '高田城', '鮫ケ尾城')
    AND prefecture = '新潟県'
    OR name IN ('富山城', '増山城')
    AND prefecture = '富山県'
    OR name IN ('鳥越城')
    AND prefecture = '石川県'
    OR name IN ('福井城', '越前大野城', '佐柿国吉城')
    AND prefecture = '福井県'
    OR name IN ('郡上八幡城', '苗木城', '美濃金山城', '大垣城')
    AND prefecture = '岐阜県'
    OR name IN ('興国寺城', '諏訪原城', '高天神城', '浜松城')
    AND prefecture = '静岡県'
    OR name IN ('小牧山城', '古宮城', '吉田城')
    AND prefecture = '愛知県'
    OR name IN ('津城', '多気北畠氏城館', '田丸城', '赤木城')
    AND prefecture = '三重県'
    OR name IN ('玄蕃尾城', '鎌刃城', '八幡山城')
    AND prefecture = '滋賀県'
    OR name IN ('福知山城')
    AND prefecture = '京都府'
    OR name IN ('芥川山城', '飯盛城', '岸和田城')
    AND prefecture = '大阪府'
    OR name IN ('出石城', '有子山城', '黒井城', '洲本城')
    AND prefecture = '兵庫県'
    OR name IN ('大和郡山城', '宇陀松山城')
    AND prefecture = '奈良県'
    OR name IN ('新宮城')
    AND prefecture = '和歌山県'
    OR name IN ('若桜鬼ケ城', '米子城')
    AND prefecture = '鳥取県'
    OR name IN ('浜田城')
    AND prefecture = '島根県'
    OR name IN ('備中高松城')
    AND prefecture = '岡山県'
    OR name IN ('三原城', '新高山城')
    AND prefecture = '広島県'
    OR name IN ('大内氏館', '高嶺城')
    AND prefecture = '山口県'
    OR name IN ('勝瑞城', '一宮城', '引田城')
    AND prefecture = '徳島県'
    OR name IN ('能島城', '河後森城')
    AND prefecture = '愛媛県'
    OR name IN ('岡豊城')
    AND prefecture = '高知県'
    OR name IN ('小倉城', '水城', '久留米城')
    AND prefecture = '福岡県'
    OR name IN ('基肄城', '唐津城')
    AND prefecture = '佐賀県'
    OR name IN ('金田城', '福江城', '原城')
    AND prefecture = '長崎県'
    OR name IN ('鞠智城', '八代城')
    AND prefecture = '熊本県'
    OR name IN ('中津城', '角牟礼城', '臼杵城', '佐伯城')
    AND prefecture = '大分県'
    OR name IN ('延岡城', '佐土原城')
    AND prefecture = '宮崎県'
    OR name IN ('志布志城', '知覧城')
    AND prefecture = '鹿児島県'
    OR name IN ('座喜味城', '勝連城')
    AND prefecture = '沖縄県';

-- scale のそれぞれの数を取得する
SELECT
    scale,
    COUNT(*) AS count
FROM
    castles
GROUP BY
    scale
ORDER BY
    scale;