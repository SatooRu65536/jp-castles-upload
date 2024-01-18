-- 重複データの削除
DELETE FROM castles
WHERE
    (name, prefecture, city) IN (
        SELECT
            name,
            prefecture,
            city
        FROM
            castles
        WHERE
            name != ''
        GROUP BY
            name,
            prefecture,
            city
        HAVING
            COUNT(*) > 1
    )
    AND (name, prefecture, city) NOT IN (
        SELECT
            name,
            prefecture,
            city
        FROM
            castles
        WHERE
            name != ''
        GROUP BY
            name,
            prefecture,
            city
        ORDER BY
            name
        LIMIT
            1
    );

-- 重複データの確認
SELECT
    name,
    prefecture,
    city,
    COUNT(*) AS count
FROM
    castles
WHERE
    name != ''
GROUP BY
    name,
    prefecture,
    city
ORDER BY
    count DESC;