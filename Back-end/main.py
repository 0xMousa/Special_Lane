from flask import  Flask, request
from flask_restful import Resource , Api
import os
from hashlib import sha1
from detectCars import detectCars

app = Flask(__name__)
api = Api(app)
car = detectCars()
imagesPath = os.path.join(os.path.abspath("."),"images")
class test(Resource):
    def post(self):
        f = request.files["image"]
        f.save(os.path.join(imagesPath , sha1(f.filename.encode()).hexdigest()))
        t = car.findCars(os.path.join(imagesPath , sha1(f.filename.encode()).hexdigest()))
        return "Ok"


api.add_resource(test , "/test")

if __name__ == "__main__":
    app.run(debug=True)
