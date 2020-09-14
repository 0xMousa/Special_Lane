import os
import sys
import skimage.io
import tensorflow as tf
from tensorflow.python.keras.backend import set_session


root = os.path.abspath(".")
root = os.path.join(root , "Mask_RCNN")
sys.path.append(root)
from mrcnn import utils
import mrcnn.model as modellib

sys.path.append(os.path.join(root, "samples/coco/"))
import coco


class InferenceConfig(coco.CocoConfig):
    GPU_COUNT = 1
    IMAGES_PER_GPU = 1

tf_config = tf.compat.v1.ConfigProto(
                device_count={'GPU': 1},
                intra_op_parallelism_threads=1,
                allow_soft_placement=True
            )

class detectCars:
    def __init__(self):
        self.sess = tf.compat.v1.Session(config=tf_config)
        self.graph = tf.compat.v1.get_default_graph()
        rootPath = os.path.abspath(".")
        cocoFile = os.path.join(rootPath, "weightFiles" , "mask_rcnn_coco.h5")
        modelPath = os.path.join(rootPath , "logs")
        
        if not os.path.exists(cocoFile):
            utils.download_trained_weights(cocoFile)
        
        config = InferenceConfig()
        set_session(self.sess)
        self.model = modellib.MaskRCNN(mode="inference", model_dir=modelPath, config=config)
        self.model.load_weights(cocoFile, by_name=True)
        self.model.keras_model._make_predict_function()
    
    def __isCar(self , class_id , id):
        if class_id in [2,3,4,6,8]:
            return True
        return False
    
    def findCars(self , path):
        with self.graph.as_default():
            set_session(self.sess)
            image = skimage.io.imread(path)
            results = self.model.detect([image], verbose=1)
            dimensions = []
            for i,x in enumerate(results[0]['class_ids']):
                if self.__isCar(x,i):
                    dimensions.append(results[0]['rois'][i])
            return dimensions