import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import math
import scipy.io
from scipy.io import arff

data1 = arff.loadarff('./datasets/contact-lenses.arff')
data2 = arff.loadarff('./datasets/zoo.arff')
data3 = scipy.io.loadmat("./datasets/reuters.mat")

desiredCountry = "japan"
places = np.array(pd.DataFrame(data3["PLACES"]))
placesMatNames = data3["PLACES_COLUMN_NAMES"]
idx = 0
for i in range(np.size(placesMatNames)):
   if(placesMatNames[0][i][0] == "japan"):
        idx = i
        break
places = places[:, idx]
metaMat = data3["TOPICS_COLUMN_NAMES"]
meta = []
for i in range(0, np.size(metaMat)):
    meta.append(metaMat[0][i][0].astype("U13"))

placesN = np.ones((np.size(places),1))
for i in range(0, np.size(placesN)):
    placesN[i] = places[i]
D = np.hstack((np.array(pd.DataFrame(data3["TOPICS"])), placesN))

## python nie ma hoistingu xxxDDDDD 
## taki byl nowoczesny a teraz umiera 
def createData(name, data, classes, max):
    return {'name': name, "data": data, "classes": classes, "max": max}

def freq(self,x):
    uniqueVals = np.unique(x)
    uniqueValsSize = np.size(uniqueVals)
    uniqueValsCount = np.zeros(uniqueValsSize)
    for i in range(0, np.size(x)):
        currVal = x[i]
        for j in range(0, uniqueValsSize):
            if(uniqueVals[j] == currVal):
                uniqueValsCount[j] = uniqueValsCount[j] + 1
    return np.column_stack((uniqueVals, uniqueValsCount))

def freq2(x,y):
    columnCount = np.size(x)
    xOut = []
    partialEntropy = [];
    freqX = self.freq(x)
    uniqueY = self.freq(y)
    for j in range(0, np.size(freqX,0)):
        entropyTmp = 0
        for i in range(0, np.size(uniqueY,0)):        
            tmpVal = 0
            for k in range(0, np.size(x)):
                if((x[k] == freqX[j,0]) and (y[k] == uniqueY[i,0])):
                    tmpVal = tmpVal + 1
            val = tmpVal / freqX[j,1].astype(float)
            if((math.isnan(val) == False) and (val > 0)):
                entropyTmp = entropyTmp - (val * np.log2(val))
        partialEntropy.append(entropyTmp)
    totalEntropy = sum(freqX[:,1].astype(float))
    outSum = 0
    ##Obliczanie dla kazdej z wartosci
    for i in range(0, np.size(freqX,0)):
        curr = partialEntropy[i] * (freqX[i,1].astype(float) / np.sum(freqX[:,1].astype(float)))
        outSum = outSum + curr
    return outSum

def entropy(D, meta):
    yIdx = np.size(D,1)-1
    Y = D[:,yIdx]
    X = np.delete(D, np.s_[yIdx], axis=1)
    colNum = np.size(X,1)         
    entropyArray = []
    for currentColumn in range(0, colNum):
        x = X[:,currentColumn]
        xUnique = self.freq(x)      
        entropy = 0
        sumEntropy = np.sum(xUnique[:,1].astype(float))
        valEntropy = 0
        for i in range (0, np.size(xUnique,0)):          
            entropy = entropy - (xUnique[i,1].astype(float) / sumEntropy) * np.log2(xUnique[i,1].astype(float) / sumEntropy)
        entropyArray.append(entropy - self.freq2(Y, x))
    sortedIndex = np.argsort(entropyArray)[::-1]
    sorted = []
    for i in range(0, np.size(sortedIndex)):
        sorted.append((sortedIndex[i], meta[sortedIndex[i]], entropyArray[sortedIndex[i]]))
    return sorted

for d in data:
    result = entropy(data1[d].data, data1[d].classes)
    if(np.size(result,0) < data1[d].max):
        data1[d].max = np.size(result,0)
    print(data1[d].name+ ":")
    for i in range(0, data1[d].max):
        print(result[i][0] + " " + result[i][1] + " = " + result[i][2])
