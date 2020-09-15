from flask_restful import reqparse
from hashlib import sha256

def loginArg():
    arg = reqparse.RequestParser()
    arg.add_argument("user" , type=str ,help="user is required" ,required=True) 
    arg.add_argument("pass" , type=str ,help="pass is required" ,required=True) 
    return arg

def registerArg():
    arg = reqparse.RequestParser()
    arg.add_argument("name" , type=str ,help="name is required" ,required=True)
    arg.add_argument("user" , type=str ,help="user is required" ,required=True) 
    arg.add_argument("pass" , type=str ,help="password is required" ,required=True)
    arg.add_argument("passConfirm" , type=str ,help="password confirm is required" ,required=True)
    arg.add_argument("email" , type=str ,help="email confirm is required" ,required=True) 
    arg.add_argument("carNo" , type=str ,help="car number NOT required")
    return arg

def hashPassword(password):
    return sha256(password.encode()).hexdigest()

