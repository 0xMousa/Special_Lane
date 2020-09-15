import cv2
import numpy as np

img = cv2.imread('lane.jpg')
imgGrey = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
imgBlur = cv2.GaussianBlur(imgGrey, (7, 7), 1)
imgCanny = cv2.Canny(imgBlur, 50, 50)


def empty(a):
    pass


cv2.namedWindow('TrackBars')
cv2.createTrackbar('Hue Min', 'TrackBars', 18, 179, empty)
cv2.createTrackbar('Hue Max', 'TrackBars', 179, 179, empty)
cv2.createTrackbar('Sat Min', 'TrackBars', 127, 255, empty)
cv2.createTrackbar('Sat Max', 'TrackBars', 255, 255, empty)
cv2.createTrackbar('Val Min', 'TrackBars', 217, 255, empty)
cv2.createTrackbar('Val Max', 'TrackBars', 255, 255, empty)

# while True:
imgHSV = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
h_min = cv2.getTrackbarPos('Hue Min', 'TrackBars')
h_max = cv2.getTrackbarPos('Hue Max', 'TrackBars')
s_min = cv2.getTrackbarPos('Sat Min', 'TrackBars')
s_max = cv2.getTrackbarPos('Sat Max', 'TrackBars')
v_min = cv2.getTrackbarPos('Val Min', 'TrackBars')
v_max = cv2.getTrackbarPos('Val Max', 'TrackBars')
# print(h_min, h_max, s_min, s_max, v_min, v_max)
lower = np.array([h_min, s_min, v_min])
upper = np.array([h_max, s_max, v_max])
mask = cv2.inRange(imgHSV, lower, upper)
# cv2.imshow('Image', imgHSV)
# cv2.imshow('Mask', mask)
# cv2.waitKey(1)
# assert h_min != 179

rows = mask.shape[0]
cols = mask.shape[1]
redArea = 1
carArea = 2
laneArea = [[0 for j in range(0, cols)] for i in range(0, rows)]
doneRedArea = [[0 for j in range(0, cols)] for i in range(0, rows)]
detectionArea = [[0 for j in range(0, cols)]
                 for i in range(0, rows)]

for i in range(0, rows):
    for j in range(0, cols):
        if mask[i, j] != 0 and doneRedArea[i][j] == 0:
            laneArea[i][j] = 1
            for right in range(j, cols):
                mask[i, right] = 255
                detectionArea[i][right] = redArea
                doneRedArea[i][right] = 1

finished = [[0 for j in range(0, cols)] for i in range(0, rows)]
for j in range(0, cols):
    for i in range(0, rows):
        if laneArea[i][j] == 0 and doneRedArea[i][j] == 1 and finished[i][j] == 0:
            for k in range(i + 1, rows):
                if laneArea[k][j] == 1:
                    break
                else:
                    mask[k, j] = 255
                    detectionArea[k][j] = redArea
                    finished[k][j] = 1
            for k in range(i - 1, 0, -1):
                if laneArea[k][j] == 1:
                    break
                else:
                    mask[k, j] = 255
                    detectionArea[k][j] = redArea
                    finished[k][j] = 1

carPoints = [[200, 300], [200, 400], [400, 300], [400, 400]]
carSize = (carPoints[3][0] - carPoints[0][0]) * \
    (carPoints[1][1] - carPoints[0][1])

for i in range(carPoints[0][0], carPoints[3][0]):
    for j in range(carPoints[0][1], carPoints[1][1]):
        detectionArea[i][j] += carArea


carIn = 0
for i in range(0, rows):
    for j in range(0, cols):
        if detectionArea[i][j] == 3:
            carIn += 1

print((carIn * 100) / (carSize * 100))

cv2.imshow('Mask', mask)
cv2.waitKey(0)


# def empty(a):
#     pass

# def percent(img, carPoints)

# Convert the image
# imgGrey = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
# imgBlur = cv2.GaussianBlur(imgGrey, (7, 7), 1)
# imgCanny = cv2.Canny(imgBlur, 50, 50)

# Pick the lane's color
# cv2.namedWindow('TrackBars')
# cv2.createTrackbar('Hue Min', 'TrackBars', 18, 179, empty)
# cv2.createTrackbar('Hue Max', 'TrackBars', 179, 179, empty)
# cv2.createTrackbar('Sat Min', 'TrackBars', 127, 255, empty)
# cv2.createTrackbar('Sat Max', 'TrackBars', 255, 255, empty)
# cv2.createTrackbar('Val Min', 'TrackBars', 217, 255, empty)
# cv2.createTrackbar('Val Max', 'TrackBars', 255, 255, empty)

# Build the mask
# lower = np.array([h_min, s_min, v_min])
# upper = np.array([h_max, s_max, v_max])
# mask = cv2.inRange(imgHSV, lower, upper)

# Image Dimentions
# rows = mask.shape[0]
# cols = mask.shape[1]

# Areas
# redArea = 1
# carArea = 2

# Some 2D lists to detect all the red area
# laneArea = [[0 for j in range(0, cols)] for i in range(0, rows)]
# doneRedArea = [[0 for j in range(0, cols)] for i in range(0, rows)]
# detectionArea = [[0 for j in range(0, cols)]
#                 for i in range(0, rows)]

# Red area detection PART - 1
# for i in range(0, rows):
#     for j in range(0, cols):
#         if mask[i, j] != 0 and doneRedArea[i][j] == 0:
#             laneArea[i][j] = 1
#             for right in range(j, cols):
#                 mask[i, right] = 255
#                 detectionArea[i][right] = redArea
#                 doneRedArea[i][right] = 1

# Red area detection PART - 2
# finished = [[0 for j in range(0, cols)] for i in range(0, rows)]
# for j in range(0, cols):
#     for i in range(0, rows):
#         if laneArea[i][j] == 0 and doneRedArea[i][j] == 1 and finished[i][j] == 0:
#             for k in range(i + 1, rows):
#                 if laneArea[k][j] == 1:
#                     break
#                 else:
#                     mask[k, j] = 255
#                     detectionArea[k][j] = redArea
#                     finished[k][j] = 1
#             for k in range(i - 1, 0, -1):
#                 if laneArea[k][j] == 1:
#                     break
#                 else:
#                     mask[k, j] = 255
#                     detectionArea[k][j] = redArea
#                     finished[k][j] = 1

# Calculate the size of the car
# carSize = (carPoints[3][0] - carPoints[0][0]) * \
#     (carPoints[1][1] - carPoints[0][1])

# Detect the car area
# for i in range(carPoints[0][0], carPoints[3][0]):
#     for j in range(carPoints[0][1], carPoints[1][1]):
#         detectionArea[i][j] += carArea

# Calculate the car area percent from the red area
# carIn = 0
# for i in range(0, rows):
#     for j in range(0, cols):
#         if detectionArea[i][j] == 3:
#             carIn += 1

# print((carIn * 100) / (carSize * 100))
