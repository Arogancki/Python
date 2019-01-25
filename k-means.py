import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import math
import scipy.io
from scipy.io import arff
from functools import reduce
from mpl_toolkits.mplot3d import axes3d, Axes3D
from random import randint

def getRandomElements(a, n):
    return np.random.permutation(a)[0:n if len(a) > n else len(a)]

def createRandomData(n, d, min, max):
    return np.array([np.random.randint(low=min, high=max, size=d) for y in range(n) ])

def sum(a):
    return reduce((lambda r, v: a[v] + r), a if type(a)==type({}) else range(len(a)), 0.0)

def sqrt(x, n):
    return x**(1/float(n))

def euclidean(a, b):
    return sqrt(sum(list(map(lambda i: math.pow(math.fabs(a[i] - b[i]), len(a)), range(len(a))))), len(a))

def getMahalanobis(X):
    V = np.cov(np.transpose(X))
    return (lambda a, b: mahalanobis(np.array(a), np.array(b), V))

def mahalanobis(a, b, V):
    return np.sqrt(np.dot(np.dot((a-b), np.linalg.inv(V)), np.transpose(a-b)))

def getDistance(a, b, f):
    return f(a, b)

def hasSameSize(a, b):
    return len(a) == len(b)

def areEqual(a, b, t):
    if not hasSameSize(a, b):
        return False
    for i in range(len(a)):
        if math.fabs(a[i]-b[i]) > t:
            return False
    return True

def contains(arr, e, t):
    for a in arr:
        if areEqual(a, e, t):
            return True
    return False

def _areArraysEqual(a, b, t):
    for e in a:
        if not contains(b, e, t):
            return False
    return True

def areArraysEqual(a, b, t):
    return hasSameSize(a, b) and _areArraysEqual(a, b, t) and _areArraysEqual(b, a, t)

def alignToNearest(data, cs, distanceFun):
    points = {}
    for c in cs:
        for di in range(len(data)):
            dist = getDistance(c, data[di], distanceFun)
            if not di in points or points[di]["nearest"]["distance"] > dist:
                points[di] = {"point": data[di], "nearest": {"point": c, "distance": dist}}
    return points

def getMeans(points, cs):
    neighbors = {}
    for ci in range(len(cs)):
        neighbors[ci] = {}
        neighbors[ci]["points"] = list(map(lambda i: points[i],
            list(filter(lambda di: areEqual(points[di]["nearest"]["point"], cs[ci], 0.0), points))
        ))
        neighbors[ci]["mean"] = list(map(lambda coor: sum(
                list(map(lambda p: p["point"][coor], neighbors[ci]["points"]))
         )/float(len(neighbors[ci]["points"])), range(len(neighbors[ci]["points"][0]["point"]))))
    return neighbors

def quantizationError(data, mean):
    return math.sqrt(sum(list(map(lambda d: math.pow(sum(
        list(map(lambda i: d[i] - mean[i], range(len(d))))
    ), 2), data))))

def kMeans(data, distanceFun, k, t):
    k = k if not k > len(data) else len(data)
    cs = getRandomElements(data, k)
    virtualData = np.copy(data)
    while(True):
        points = alignToNearest(virtualData, cs, distanceFun)
        means = getMeans(points, cs)
        meansCS = list(map(lambda m: means[m]["mean"], means))
        if areArraysEqual(cs, meansCS, t):
            return list(map(lambda g: {"mean": g["mean"], "points": g["points"], "error": round(quantizationError(g["points"], g["mean"]), 2)} ,
            list(map(lambda g: {
                "mean": g[0]["nearest"]["point"], 
                "points": list(map(lambda p: p["point"], g))
            }, list(map(lambda i:
                list(filter(lambda m: contains(data, m["point"], 0.0), means[i]["points"]))
            , means))))))
        cs = meansCS
        virtualData = np.append(virtualData, meansCS, axis=0)


def getOneDimmension(df, coor):
    return list(map(lambda d: d[coor], df))

def colorGenerator():
    colors = 'bgrcmyk'
    max = len(colors)
    i = randint(0, max)
    while True:
        i = i + 1
        if i >= max:
            i = 0
        yield colors[i]
        
def pca(df, coor):
    ww = np.linalg.eig(np.cov(np.transpose(np.array(df))))
    sortedIndexesWw = np.argsort(ww[0])[::-1]
    return np.dot(df, ww[1][:,sortedIndexesWw[:coor]])

def plotData(kMeans):
    fig=plt.figure()
    title = ""
    colors = colorGenerator()
    plt.subplot(121)
    for mean in kMeans:
        #sorted = pca(mean["points"], 2)
        sorted = mean["points"]
        plt.plot(getOneDimmension(sorted, 0), getOneDimmension(sorted, 1), next(colors)+'.')

    for mean in kMeans:
        #sorted = pca([mean["mean"]], 2)
        sorted = [mean["mean"]]
        marker = next(colors)+'+'
        title += "Marker " + marker + " quantization error: " + str(mean["error"]) + ", \n"
        plt.plot(getOneDimmension(sorted, 0), getOneDimmension(sorted, 1), marker)

    plt.subplot(122, projection='3d')
    for mean in kMeans:
        #sorted = pca(mean["points"], 3)
        sorted = mean["points"]
        plt.plot(getOneDimmension(sorted, 0), getOneDimmension(sorted, 1), getOneDimmension(sorted, 2), next(colors)+'.')

    for mean in kMeans:
        #sorted = pca([mean["mean"]], 3)
        sorted = [mean["mean"]]
        marker = next(colors)+'+'
        title += "Marker " + marker + " quantization error: " + str(mean["error"]) + ", \n"
        plt.plot(getOneDimmension(sorted, 0), getOneDimmension(sorted, 1), getOneDimmension(sorted, 2), marker)

    fig.suptitle(title, fontsize=11)
    plt.show()

testData1 = [
    [0, 0, 0],    [0, 0, 2],    [0, 2, 0],    [0, 2, 2],
    [2, 0, 0],    [2, 0, 2],    [2, 2, 0],    [2, 2, 2],
    [4, 4, 4],    [4, 4, 6],    [4, 6, 4],    [4, 6, 6],
    [6, 4, 4],    [6, 4, 6],    [6, 6, 4],    [6, 6, 6],
]

testData2 = [
    [0, 0, 0, 6],    [0, 0, 2, 3],    [0, 2, 0, 6],    [0, 2, 2, 3],
    [2, 0, 0, 6],    [2, 0, 2, 3],    [2, 2, 0, 6],    [2, 2, 2, 3],
    [4, 4, 4, 6],    [4, 4, 6, 3],    [4, 6, 4, 6],    [4, 6, 6, 3],
    [6, 4, 4, 6],    [6, 4, 6, 3],    [6, 6, 4, 6],    [6, 6, 6, 3],
]

testData3 = [
    [4, 4, 4, 1],    [4, 4, 6, 0],    [4, 6, 4, 1],    [4, 6, 6, 0],
    [0, 0, 0, 1],    [0, 0, 2, 0],    [0, 2, 0, 1],    [0, 2, 2, 0],
    [1, 1, 3, 1],    [1, 9, 8, 0],    [6, 6, 6, 1],    [2, 3, 5, 0],
    [2, 0, 0, 1],    [2, 0, 2, 0],    [2, 2, 0, 1],    [2, 2, 2, 0],
    [6, 4, 4, 1],    [6, 4, 6, 0],    [6, 6, 4, 1],    [6, 6, 6, 0],
]

testData4 = (np.array(pd.DataFrame(arff.loadarff('./iris.arff')[0]))[:,:3]).astype(float)
testData5 = (np.array(pd.DataFrame(arff.loadarff('./waveform5000.arff')[0]))[:,:-1]).astype(float)

testData6 = createRandomData(100, 3, 1, 50)

# config

testData = testData6

testData = pca((testData), 3)
# fun to d wylicczania odleglosci - getMahalanobis(testData) or euclidean
fun = getMahalanobis(testData)
#fun = euclidean
k=2
Lambda = 0.0

# end config

plotData(kMeans(testData, fun, k, Lambda))