from flask_restful import reqparse
from flask import session,abort
from hashlib import sha256
import re
import string
import random

def loginArg():
    arg = reqparse.RequestParser()
    arg.add_argument("user" , type=str ,help="user is required" ,required=True) 
    arg.add_argument("pass" , type=str ,help="pass is required" ,required=True) 
    return arg

def registerArg():
    arg = reqparse.RequestParser()
    arg.add_argument("name" , type=str ,help="name is required" ,required=True)
    arg.add_argument("username" , type=str ,help="user is required" ,required=True) 
    arg.add_argument("pass" , type=str ,help="password is required" ,required=True)
    arg.add_argument("email" , type=str ,help="email confirm is required" ,required=True) 
    arg.add_argument("carNo" , type=str ,help="car number NOT required")
    return arg

def hashPassword(password):
    return sha256(password.encode()).hexdigest()

def isUser():
    if "userID" not in session:
        abort(403 , "Not Allow")

def hasDigitAndSp(password):
    for i in password:
        if i.isdigit():
            return True
    return False

def isValidPassword(password):
    if len(password)>7 and hasDigitAndSp(password):
        return True
    return False

def isValidEmail(email):
    regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$'
    if(re.search(regex,email)):
        return True
    return False

def genCode():
    letters = string.ascii_letters + string.digits
    code = ""
    for k in range(4):
        code += ''.join(random.choice(letters) for i in range(4))
        code += "-"
    return code[0:19]