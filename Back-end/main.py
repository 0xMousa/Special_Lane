from flask import  Flask, request ,g,json,session,abort
from flask_restful import Resource , Api,reqparse
import os
from hashlib import sha1
from helper import *
import sqlite3

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
    cur.close()
    return (rv[0] if rv else None) if one else rv

'''
RestFul API
'''

class upload(Resource):
    def post(self):
        if isUser():
            f = request.files["image"]
            f.save(os.path.join(imagesPath , sha1(f.filename.encode()).hexdigest()))
        else:
            abort(403 , "Not Allow")
        return {"message" : "thanks"}

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
            print("*"*10)
            abort(400 , "username or email is exist")
        elif not isValidPassword(args['pass']):
            #print("*"*10)
            abort(400 , "the password must has a at lest one digit and more 7 chars")
        elif not isValidEmail(args['email'].lower()):
            print("*"*10)
            abort(400 , "Email not valid")
        else:
            res = queryDb("INSERT INTO users (username , name , password , email ,points , carNo) VALUES(?,?,?,?,?,?)" ,
                    (args["username"] , args["name"], hashPassword(args['pass']),args['email'].lower() , 0 ,  args['carNo']))
            message = "Registration Successful" 
        
        return {"message" : message}

class userInformation(Resource):
    def get(self , username):
        pass

class carInformation(Resource):
    def get(self , carNumber):
        pass

class allMenu(Resource):
    def get(self , shopName):
        pass

class menu(Resource):
    def get(self , shopName , item):
        pass
    def put(self ,shopName ,item):
        pass#Gen Code

api.add_resource(upload , "/upload")
api.add_resource(login , "/login")
api.add_resource(register , "/register")
api.add_resource(userInformation , "/users/<string:username>")
api.add_resource(carInformation , "/cars/<string:carNumber>")
api.add_resource(allMenu , "/shop/<string:shopname>")
api.add_resource(menu , "/shop/<string:shopname>/<string:item>")


if __name__ == "__main__":
    app.run(debug=True , host="0.0.0.0" , port=1337)
