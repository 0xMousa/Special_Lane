import os
import tensorflow as tf
from tensorflow.python.keras.backend import set_session
from keras.models import model_from_json
import cv2
import numpy as np
from local_utils import detect_lp
from detectCars import tf_config

import matplotlib.pyplot as plt


class detectPlate:
    def __init__(self):
        path = os.path.join(os.path.abspath(".") , "weightFiles/wpod-net")
        self.__loadJson(path)

    def __loadJson(self , path):
        self.sess = tf.compat.v1.Session(config=tf_config)
        self.graph = tf.compat.v1.get_default_graph()
        with open(f"{path}.json" , 'r') as json:
            modelJson = json.read()
        set_session(self.sess)
        self.model = model_from_json(modelJson, custom_objects={})
        self.model.load_weights(f"{path}.h5")

    def __changeImage(self , image):
        image = cv2.cvtColor(image , cv2.COLOR_BGR2RGB)
        return (image / 255)
    
    def __getPlate(self,image, Dmax=608, Dmin = 608):
        with self.graph.as_default():
            set_session(self.sess)
            car = self.__changeImage(image)
            ratio = float(max(car.shape[:2])) / min(car.shape[:2])
            side = int(ratio * Dmin)
            bound_dim = min(side, Dmax)
            _ , LpImg, _, cor = detect_lp(self.model, car, bound_dim, lp_threshold=0.5)
            return car, LpImg, cor
    
    def __sortContours(self,cnts,reverse = False):
        i = 0
        boundingBoxes = [cv2.boundingRect(c) for c in cnts]
        (cnts, boundingBoxes) = zip(*sorted(zip(cnts, boundingBoxes),
                                        key=lambda b: b[1][i], reverse=reverse))
        return cnts
    
    def __imageX(self , plate):
        plate_image = cv2.convertScaleAbs(plate, alpha=(255.0))
        gray = cv2.cvtColor(plate_image, cv2.COLOR_BGR2GRAY)
        blur = cv2.GaussianBlur(gray,(7,7),0)
        binary = cv2.threshold(blur, 180, 255,cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)[1]
        kernel3 = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))
        threMor = cv2.morphologyEx(binary, cv2.MORPH_DILATE, kernel3)

        plt.imshow(binary)
        plt.show()

        return plate_image,binary,threMor
    
    def getRectangularPlate(self,image):
        car, plate, dim = self.__getPlate(image)
        plate = plate[0]
        plt.imshow(plate)
        plt.show()
        return self.__getChars(plate, 1 , 2 , 4.0 )

    def getSquarePlate(self,image):
        car, plate, dim = self.__getPlate(image)
        h = plate[0].shape[0]
        plate = np.concatenate((plate[0][0:int(h*0.55)],plate[0][int(h*0.45):h]) ,axis = 1 )#To make it rectangular
        return self.__getChars(plate ,1.5 ,2.5,5.5)
        
    def __getChars(self , plate , minRatio , maxRatio , oneRatio):
        plateImage,binary,threMor = self.__imageX(plate)
        cont, _  = cv2.findContours(binary, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        cropCharacters = []
        onePostions = []
        digit_w, digit_h = 30, 60
        i=0
        print(len(cont))
        for c in self.__sortContours(cont):
            (x, y, w, h) = cv2.boundingRect(c)
            print((x, y, w, h))
            charRatio = h/w
            if minRatio<=charRatio<=maxRatio and h/plateImage.shape[0]>=0.5:
                currNum = threMor[y:y+h,x:x+w]
                currNum = cv2.resize(currNum, dsize=(digit_w, digit_h))
                _, currNum = cv2.threshold(currNum, 220, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
                cropCharacters.append(currNum)
                i+=1
            elif oneRatio<=charRatio<=(oneRatio+3) and h/plateImage.shape[0]>=0.5:
                currNum = threMor[y:y+h,x:x+w]
                currNum = cv2.resize(currNum, dsize=(digit_w, digit_h))
                _, currNum = cv2.threshold(currNum, 220, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
                cropCharacters.append(currNum)
                onePostions.append(i)
                i+=1

        # the number one on jordan's plate different , it's like | not 1
        # here I fix this bug        
        if len(onePostions):
            noOneImage = os.path.join(os.path.abspath(".") ,"images/one.jpg")
            image = cv2.imread(noOneImage)
            image = self.__changeImage(image)
            plateImage,binary,threMor = self.__imageX(image)
            cont, _  = cv2.findContours(binary, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            numOneImage = []
            for c in self.__sortContours(cont):
                (x, y, w, h) = cv2.boundingRect(c)
                if h/plateImage.shape[0] >= 0.7:
                    currNum = threMor[y:y+h,x:x+w]
                    currNum = cv2.resize(currNum, dsize=(digit_w, digit_h))
                    _, currNum = cv2.threshold(currNum, 220, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
                    numOneImage= currNum

            for i in onePostions:
                cropCharacters[i] = numOneImage
        
        return cropCharacters #return crop characters from thre_mor image
    
    def getPlateType(self , image):
        try:
            car, plate, dim = self.__getPlate(image)
            if len(plate):
                h = plate[0].shape[0]
                w = plate[0].shape[1]
                if 90<=h<=130 and 420<=w<=520:
                    plateType = "Rectangular"
                elif 170<=h<=240 and 250<=w<=310:
                    plateType = "Square"
            else:
                plateType = "Didn't find a plate"
        except:
            plateType = "Didn't find a plate"
        return plateType
