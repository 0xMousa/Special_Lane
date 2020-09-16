from flask import  Flask, request ,g,json,session,abort
from flask_restful import Resource , Api,reqparse
import os
from hashlib import sha1
from helper import *
import sqlite3
from laneDetection import isViolated
from detectCars import detectCars
from detectPlate import detectPlate
from toString import toString

app = Flask(__name__)
api = Api(app)
app.secret_key = "Change It in server"

imagesPath = os.path.join(os.path.abspath("."),"images")
DATABASE = "example.db"

def getDb():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

def queryDb(query, args=(), one=False):
    cur = getDb().execute(query, args)
    rv = cur.fetchall()
    getDb().commit()
    cur.close()
    return (rv[0] if rv else None) if one else rv

car = detectCars()
plate = detectPlate()
convert = toString()

def getPl(image):
    plateType = plate.getPlateType(image)
    print(plateType)
    if plateType == "Rectangular":
        chars = plate.getRectangularPlate(image)
    elif plateType == "Square":
        chars = plate.getSquarePlate(image)
    elif plateType == "Didn't find a plate":
        abort(400 , "Didn't find a plate")
    
    if len(chars)==0:
        chars = 0 #must review manually
    chars = convert.getString(chars)
    return chars

def checkImage(imageName):
    t = False
    cars = car.findCars(imageName)
    print(cars)
    if len(cars) == 0:
        abort(400 , "No cars in your image")
    image = cv2.imread(imageName)
    plt.imshow(image)
    plt.show()
    for i in cars:
        y = int(i[0]/10)
        x = int(i[1]/10)
        h = int(i[2]/10)
        w = int(i[3]/10)
        ss =isViolated(image , [[x,y],[w,y],[x,h],[w,h]])
        if ss:
            t = True
            carNo = getPl(image[i[0]:i[2] , i[1]:i[3]])
            print(carNo)
            now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            queryDb("insert into submit ('userID' , 'imageName' , 'carNo' , date) VALUES(?,?,?,?)",(session["userID"],imageName , carNo,now))
            queryDb("update users set points=points+20 where id=?",(session["userID"],))

    if not t:
        abort(400 , "no violated car ")
    return "thanks for your submission"


'''
RestFul API
'''

class upload(Resource):
    def post(self):
        isUser()
        f = request.files["image"]
        imagePath = os.path.join(imagesPath , sha1(f.filename.encode()).hexdigest())
        f.save(imagePath)
        message = checkImage(imagePath)
        return {"message" : message}

class login(Resource):
    def post(self):
        args = loginArg().parse_args()
        password = hashPassword(args["pass"])
        res = queryDb("select id,username from users where username=? and password=?" , (args["user"] , password ))
        if len(res) == 1:
            session["userID"] = res[0][0]
            session["username"] = res[0][1]
            message = "Login Successful"
        else:
            abort(403 , "Login Failed")
        return {"message" : message}

class register(Resource):
    def post(self):
        args = registerArg().parse_args()
        res = queryDb("select id from users where username=? or email=?" , (args["username"] , args["email"]))
        if len(res)>0:
            abort(400 , "username or email is exist")
        elif not isValidPassword(args['pass']):
            abort(400 , "the password must has a at lest one digit and more 7 chars")
        elif not isValidEmail(args['email'].lower()):
            abort(400 , "Email not valid")
        else:
            res = queryDb("INSERT INTO users (username , name , password , email ,points , carNo) VALUES(?,?,?,?,?,?)" ,
                    (args["username"] , args["name"], hashPassword(args['pass']),args['email'].lower() , 0 ,  args['carNo']))
            message = "Registration Successful" 
        
        return {"message" : message}

class userInformation(Resource):
    def get(self , username):
        isUser()
        if session['username'] != username:
            abort(403 , "Not Allow")
        l = ["id" , "username" , "name" , "email" , "points" , "carNo"]
        res = queryDb(f"select {','.join(l)} FROM users WHERE username= ?" ,args=(username,) , one=True)
        finalRes = {}
        for i,v in enumerate(res):
            finalRes[l[i]] = v
        res = queryDb(f"select date FROM submit WHERE userID= ?" ,args=(finalRes["id"],))
        finalRes["submit"] = [i[0] for i in res]
        return finalRes

class carInformation(Resource):
    def get(self , carNumber):
        isUser()
        res = queryDb("select date FROM submit WHERE carNo=?" , (carNumber,))
        submitDate = [date[0] for date in res]
        return {"submitDate" : submitDate}

class allMenu(Resource):
    def get(self , shopName):
        isUser()
        res = queryDb(f"select name,point FROM menu WHERE shopID=(select id from shops where shopName=?)" , (shopName,))
        l = [{"name" : i[0] , "point" :i[1]} for i in res]
        return {"menu" : l}

class menu(Resource):
    def get(self , shopName , item):
        isUser()
        res = queryDb(f"select code FROM prizes WHERE status=1 and userID=? and menuID= (select id from menu where name=?)" ,args=(session["userID"],item))
        l = [i[0] for i in res]
        return {"codes" : l}
        
    def put(self ,shopName ,item):
        isUser()
        res = queryDb("select points from users where id=?",(session["userID"],) , one=True)
        userPoint = res[0]
        res = queryDb('''select id,point from menu where name=? and
                shopID=(select id from shops where shopName=?)''' , (item , shopName) , one=True)
        try :
            itemID = res[0]
            itemPoint = res[1]
        except:
            abort( 400 , "didn't find the item")
        
        if userPoint < itemPoint:
            abort( 405 , "Don't have point")
        newPoint = userPoint-itemPoint
        res = queryDb("update users set points=? where id=?",(newPoint,session["userID"],))
        code = genCode()
        queryDb("insert into prizes ('menuID' , 'userID' , 'code' ,'status') VALUES(?,?,?,1)",( itemID, session["userID"], code))
        return {"code" : code}

class shops(Resource):
    def get(self):
        isUser()
        res = queryDb("SELECT shopName from shops")
        shops = [shop[0] for shop in res]
        return {"shops" : shops}

api.add_resource(upload , "/upload")
api.add_resource(login , "/login")
api.add_resource(register , "/register")
api.add_resource(userInformation , "/users/<string:username>")
api.add_resource(carInformation , "/cars/<string:carNumber>")
api.add_resource(allMenu , "/shops/<string:shopName>")
api.add_resource(menu , "/shops/<string:shopName>/<string:item>")
api.add_resource(shops , "/shops")

if __name__ == "__main__":
    app.run(debug=True , host="0.0.0.0" , port=1337)
