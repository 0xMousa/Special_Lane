from detectCars import detectCars

import os
import cv2
import matplotlib.pyplot as plt
from detectPlate import detectPlate


root = os.path.abspath(".")
image = os.path.join(root , "images/Jordan2.jpeg")
 
plate = detectPlate()

i = cv2.imread(image)
print(plate.getPlateType(i))
plt.imshow(i)
plt.show()