from detectCars import detectCars

import os
import cv2
import matplotlib.pyplot as plt
root = os.path.abspath(".")
image = os.path.join(root , "images/Jordan2.jpeg")
 
car = detectCars()

print(car.findCars(image))
i = cv2.imread(image)
plt.imshow(i)
plt.show()
