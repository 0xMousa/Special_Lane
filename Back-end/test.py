

from detectCars import detectCars

import os
import cv2
import matplotlib.pyplot as plt
from detectPlate import detectPlate

import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from local_utils import detect_lp
from os.path import splitext,basename
from keras.models import model_from_json
from keras.preprocessing.image import load_img, img_to_array
from keras.applications.mobilenet_v2 import preprocess_input
from sklearn.preprocessing import LabelEncoder
import glob
from toString import toString
from detectCars import detectCars
from laneDetection import isViolated


#car = detectCars()
#plate = detectPlate()
#convert = toString()

image = "images/test_4.jpg"
'''
def check(imagePath):
    imageOpened = cv2.imread(image)
    cars = car.findCars(imagePath)
    for i in cars:
        y = i[0]
        x = i[1]
        h = i[2]
        w = i[3]
        print(i)

print(isViolated(cv2.imread(image), [[0, 100], [0, 200], [200, 100], [200, 200]]))




i = cv2.imread(image)
plateType = plate.getPlateType(i)
print(plateType)
if plateType == "Rectangular":
    chars = plate.getRectangularPlate(i)
elif plateType == "Square":
    chars = plate.getSquarePlate(i)
elif plateType == "Didn't find a plate":
    pass
)
print(
'''

def getPl(image):
    plateType = plate.getPlateType(image)
    print(plateType)
    if plateType == "Rectangular":
        chars = plate.getRectangularPlate(image)
    elif plateType == "Square":
        chars = plate.getSquarePlate(image)
    elif plateType == "Didn't find a plate":
        #abort(403 , "Didn't find a plate")
        print("Sasa")
        pass
    #return convert.getString(chars)

def checkImage(imageName):
    t = False
    cars = car.findCars(imageName)
    print(cars)
    if len(cars) == 0:
        #abort(403 , "Login Failed")
        pass
    image = cv2.imread(imageName)
    for i in cars:
        y = int(i[0]/10)
        x = int(i[1]/10)
        h = int(i[2]/10)
        w = int(i[3]/10)
        print(y , x, h ,w)
        print([[x,y],[w,y],[x,h],[w,h]])
        ss =isViolated(image , [[x,y],[w,y],[x,h],[w,h]])
        print(ss)
        if ss:
            t = True
            carNo = getPl(image)
            print(carNo)
    
    if not t:
        #abort(403 , "Login Failed")
        pass
    return "thanks"

root = os.path.abspath(".")
image = "images/test_4.jpg"
image = os.path.join(root , image)
print(image)
i = cv2.imread(os.path.join(root , image))
plt.imshow(i)
plt.show()
plt.imshow(i[891:1671 , 887:1773])
plt.show()

plate = detectPlate()

plateType = plate.getPlateType(i[891:1671 , 887:1773])
print(plateType)
if plateType == "Rectangular":
    print("Sa")
    chars = plate.getRectangularPlate(i[891:1671 , 887:1773])
    print(chars)
elif plateType == "Square":
    chars = plate.getSquarePlate(i[891:1671 , 887:1773])
elif plateType == "Didn't find a plate":
    pass
print(chars)
'''
 y     x    h    w
[ 891  887 1671 1773]
[1026  888 1120 1002]
[877 875 903 907]
'''