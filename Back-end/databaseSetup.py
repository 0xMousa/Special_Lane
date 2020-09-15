import sqlite3
conn = sqlite3.connect('example.db')
c = conn.cursor()


c.execute('''CREATE TABLE users (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    username text NOT NULL UNIQUE,
    name text NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    points INTEGER NOT NULL,
    carNo INTEGER
)''')

c.execute('''CREATE TABLE IF NOT EXISTS shops (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    category text NOT NULL ,
    shopName text NOT NULL
)''')

c.executemany(
    'INSERT INTO shops ("category","shopName") VALUES (?,?)',
    [
        ("coffee" , "starbucks"),
        ("resturant" , "firefly")
    ]
)

c.execute('''CREATE TABLE IF NOT EXISTS menu (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    shopID INTEGER NOT NULL,
    name text NOT NULL ,
    point INTEGER,
    FOREIGN KEY (shopID) REFERENCES shop(id)
)''')

c.executemany(
    'INSERT INTO menu ("shopID","name" , "point") VALUES (?,?,?)',
    [
        (1 , "cafe Latte" , 500),
        (1 , "Iced cafe Latte" , 500),
        (2 , "Angus Burger Sandwich" , 500),
        (2,"Blue Cheese Burger Sandwich" , 500)
    ]
)

c.execute('''CREATE TABLE IF NOT EXISTS submit (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    userID INTEGER NOT NULL,
    imageName text NOT NULL ,
    carNo INTEGER NOT NULL ,
    date text NOT NULL ,
    FOREIGN KEY (userID) REFERENCES users(id)
)''')

c.executemany(
    'INSERT INTO submit ("userID","imageName","carNo","date") VALUES (?,?,?,?)',
    [
        (1 , "a","123456" , "9-9-9"),
        (1 , "b","15888" , "6-9-9"),
        (1 , "c","19999" , "5-9-9")
    ]
)

c.execute('''CREATE TABLE IF NOT EXISTS prizes (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    menuID INTEGER NOT NULL,
    userID INTEGER NOT NULL,
    code text NOT NULL ,
    status INTEGER NOT NULL,
    FOREIGN KEY (menuID) REFERENCES menu(id),
    FOREIGN KEY (userID) REFERENCES users(id)
)''')


c.executemany(
    'INSERT INTO prizes ("menuID","userID","code","status") VALUES (?,?,?,?)',
    [
        (1 , 1,"mosa-mosa" , 1),
        (1 , 1,"bbbb-bbbb" , 1),
        (1 , 1,"cccc-cccc" , 0)
    ]
)

c.execute('''INSERT INTO users (username , name , password , email ,points , carNo) VALUES("admin" , "Mousa" , "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918" , "admin@lane.com" , 10000 , "")''')
c.execute('''INSERT INTO users (username , name , password , email ,points , carNo) VALUES("mustafa" , "mustafa" , "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918" , "mustafa@lane.com" , 0 , "")''')


conn.commit()
c.close()


'''
def getDb():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

def hash_password(password):
    """ Hash password with a secure hashing function """
    return sha256(password.encode()).hexdigest()


def queryDb(query, args=(), one=False):
    cur = getDb().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv


    
isViolatied( cv2.imread(image),
    [[ , ]#top-left
     [ , ]#top-right
     [ , ]#button-left
     [ .]]#button-right
     )
'''