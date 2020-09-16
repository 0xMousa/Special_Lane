

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


car = detectCars()
plate = detectPlate()
convert = toString()

image = "images/test_1.jpg"

def check(imagePath):
    imageOpened = cv2.imread(image)
    cars = car.findCars(imagePath)
    for i in cars:
        y = i[0]
        x = i[1]
        h = i[2]
        w = i[3]
        test = isViolated(imageOpened , [ [x,y],[w,y],[x,h],[w,h]])
        print("*"*10)
        print(test)
        print("*"*10)

print(isViolated(cv2.imread(image), [[0, 100], [0, 200], [200, 100], [200, 200]]))



'''
i = cv2.imread(image)

plateType = plate.getPlateType(i)
print(plateType)
if plateType == "Rectangular":
    chars = plate.getRectangularPlate(i)
elif plateType == "Square":
    chars = plate.getSquarePlate(i)
elif plateType == "Didn't find a plate":
    pass

print(convert.getString(chars))
'''