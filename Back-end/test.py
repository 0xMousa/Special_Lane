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

root = os.path.abspath(".")
image = os.path.join(root , "images/IMG_3816.JPG")
 
plate = detectPlate()
convert = toString()

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
