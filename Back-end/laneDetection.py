import cv2
import numpy as np
import matplotlib.pyplot as plt

def isViolated(src, carPoints):
    # Resize the image
    scale_percent = 10
    width = int(src.shape[1] * scale_percent / 100)
    height = int(src.shape[0] * scale_percent / 100)
    dsize = (width, height)

    # Make the image ready for masking
    img = cv2.resize(src, dsize)
    imgGrey = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    imgBlur = cv2.GaussianBlur(imgGrey, (7, 7), 1)
    imgCanny = cv2.Canny(imgBlur, 50, 50)

    # Building the mask
    imgHSV = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

    plt.imshow(img)
    plt.show()
    # HSV values
    h_min = 11
    h_max = 14
    s_min = 131
    s_max = 159
    v_min = 204
    v_max = 255

    # Color Detection
    lower = np.array([h_min, s_min, v_min])
    upper = np.array([h_max, s_max, v_max])
    mask = cv2.inRange(imgHSV, lower, upper)

    # Directions for more accuracy
    dy = [0, 0, -1, 1, -1, 1, 1, -1]
    dx = [1, -1, -1, 1, 1, -1, 0, 0]

    # Dimensions
    rows = mask.shape[0]
    cols = mask.shape[1]

    # Red area and car area
    redArea = 1
    carArea = 2

    # Some lists to speed up the algorithm
    laneArea = [[0 for j in range(0, cols)] for i in range(0, rows)]
    doneRedArea = [[0 for j in range(0, cols)] for i in range(0, rows)]
    detectionArea = [[0 for j in range(0, cols)]
                     for i in range(0, rows)]

    # Lane detection
    for i in range(0, rows):
        for j in range(0, cols):
            take = False
            for k in range(0, 8):
                if i + dx[k] >= 0 and i + dx[k] < rows and j + dy[k] >= 0 and j + dy[k] < cols:
                    if mask[i + dx[k], j + dy[k]] != 0:
                        take = True
            if take == False:
                mask[i, j] = 0
            if mask[i, j] != 0 and doneRedArea[i][j] == 0:
                laneArea[i][j] = 1
                for right in range(j, cols):
                    mask[i, right] = 255
                    detectionArea[i][right] = redArea
                    doneRedArea[i][right] = 1

    # Red area detection
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

    # Car size
    carSize = (carPoints[3][0] - carPoints[0][0]) * \
        (carPoints[2][1] - carPoints[0][1])

    # Car area detection
    for i in range(carPoints[0][0], carPoints[3][0]):
        for j in range(carPoints[0][1], carPoints[2][1]):
            detectionArea[i][j] += carArea

    # Percent calculation
    carIn = 0
    for i in range(0, rows):
        for j in range(0, cols):
            if detectionArea[i][j] == 3:
                carIn += 1
    print((carIn * 100) / (carSize * 100))
    return (carIn * 100) / (carSize * 100) > 0.3
