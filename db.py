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
    CREATE TABLE IF NOT EXISTS castles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        prefecture TEXT NOT NULL,
        area TEXT NOT NULL,
        city TEXT NOT NULL,
        html TEXT NOT NULL,
        link TEXT NOT NULL
    )
''')
