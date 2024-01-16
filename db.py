import sqlite3

conn = sqlite3.connect('./db/data.db', isolation_level=None)
cur = conn.cursor()

cur.execute('''
    CREATE TABLE IF NOT EXISTS links (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        link TEXT UNIQUE NOT NULL,
        visited INTEGER DEFAULT 0
    )
''')

cur.execute('''
    CREATE TABLE IF NOT EXISTS visited_links (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        link_id INTEGER NOT NULL
    )
''')

cur.execute('''
    CREATE TABLE IF NOT EXISTS markers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        scale INTEGER NOT NULL,
        link TEXT NOT NULL
    )
''')

cur.execute('''
    CREATE TABLE IF NOT EXISTS castles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        alias TEXT NOT NULL,
        desc TEXT NOT NULL,
        history TEXT NOT NULL,
        lords TEXT NOT NULL,
        build_year INTEGER NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        prefecture TEXT NOT NULL,
        area TEXT NOT NULL,
        city TEXT NOT NULL,
        address TEXT NOT NULL,
        castle_tower TEXT NOT NULL,
        type TEXT NOT NULL,
        remains TEXT NOT NULL,
        restorations TEXT NOT NULL,
        categories TEXT NOT NULL,
        site TEXT NOT NULL,
        guide TEXT NOT NULL
    )
''')
