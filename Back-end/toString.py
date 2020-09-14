from keras.models import model_from_json
import tensorflow as tf
from tensorflow.python.keras.backend import set_session
from sklearn.preprocessing import LabelEncoder
from detectCars import tf_config
import numpy as np
import cv2
import os

class toString:
    def __init__(self):
        try :
            path = os.path.join(os.path.abspath("."),"weightFiles")
            self.__loadJson(path)
            self.label = LabelEncoder()
            self.label.classes_ = np.load( os.path.join(path ,'license_character_classes.npy'))
        except:
            print("load Field")

    
    def __loadJson(self , path):
        self.sess = tf.compat.v1.Session(config=tf_config)
        self.graph = tf.compat.v1.get_default_graph()
        jsonFile = open( os.path.join(path , 'MobileNets_character_recognition.json') , 'r').read()
        set_session(self.sess)
        self.model = model_from_json(jsonFile)
        self.model.load_weights(os.path.join(path , "License_character_recognition_weight.h5"))
    
    def __getChar(self , image):
        image = cv2.resize(image,(80,80))
        image = np.stack((image,)*3, axis=-1)
        prediction = self.label.inverse_transform([np.argmax(self.model.predict(image[np.newaxis,:]))])
        return prediction
    
    def getString(self , chars):
        with self.graph.as_default():
            set_session(self.sess)
            plateNum = ""
            for c in chars:
                plateNum += np.array2string(self.__getChar(c))[2]
        return plateNum