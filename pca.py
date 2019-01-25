import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d, Axes3D

import pandas as pd
import numpy as np

from scipy.io import arff

data1 = arff.loadarff('./datasets/waveform5000.arff')
data2 = arff.loadarff('./datasets/iris.arff')
df1 = np.array(pd.DataFrame(data1[0]))
df2 = np.array(pd.DataFrame(data2[0]))

klasaDf1 = df1[:,-1]
klasaDf2 = df2[:,-1]

df1=df1[:,0:-1].astype('float64')
df2=df2[:,0:-1].astype('float64')

mk1 = np.cov(np.transpose(df1))
mk2 = np.cov(np.transpose(df2))

ww1 = np.linalg.eig(mk1)
ww2 = np.linalg.eig(mk2)

sortedIndexesWw1 = np.argsort(ww1[0])[::-1]
sortedIndexesWw2 = np.argsort(ww2[0])[::-1]

plt.figure()

plt.subplot(321)

newdf1 = np.dot(df1, ww1[1][:,sortedIndexesWw1[-3:-1]])
klasyDla1 = np.unique(klasaDf1)
plt.plot(newdf1[klasaDf1==klasyDla1[0]][:,0], newdf1[klasaDf1==klasyDla1[0]][:,1], 'b*')
plt.plot(newdf1[klasaDf1==klasyDla1[1]][:,0], newdf1[klasaDf1==klasyDla1[1]][:,1], 'r*')
plt.plot(newdf1[klasaDf1==klasyDla1[2]][:,0], newdf1[klasaDf1==klasyDla1[2]][:,1], 'g*')

#2d
#2
plt.subplot(322)

newdf2 = np.dot(df2, ww2[1][:,sortedIndexesWw2[-3:-1]])
klasyDla2 = np.unique(klasaDf2)
plt.plot(newdf2[klasaDf2==klasyDla2[0]][:,0], newdf2[klasaDf2==klasyDla2[0]][:,1], 'b*')
plt.plot(newdf2[klasaDf2==klasyDla2[1]][:,0], newdf2[klasaDf2==klasyDla2[1]][:,1], 'r*')
plt.plot(newdf2[klasaDf2==klasyDla2[2]][:,0], newdf2[klasaDf2==klasyDla2[2]][:,1], 'g*')

#2d
#1
plt.subplot(323)

newdf1 = np.dot(df1, ww1[1][:,sortedIndexesWw1[:2]])
klasyDla1 = np.unique(klasaDf1)
plt.plot(newdf1[klasaDf1==klasyDla1[0]][:,0], newdf1[klasaDf1==klasyDla1[0]][:,1], 'b*')
plt.plot(newdf1[klasaDf1==klasyDla1[1]][:,0], newdf1[klasaDf1==klasyDla1[1]][:,1], 'r*')
plt.plot(newdf1[klasaDf1==klasyDla1[2]][:,0], newdf1[klasaDf1==klasyDla1[2]][:,1], 'g*')

#2d
#2
plt.subplot(324)

newdf2 = np.dot(df2, ww2[1][:,sortedIndexesWw2[:2]])
klasyDla2 = np.unique(klasaDf2)
plt.plot(newdf2[klasaDf2==klasyDla2[0]][:,0], newdf2[klasaDf2==klasyDla2[0]][:,1], 'b*')
plt.plot(newdf2[klasaDf2==klasyDla2[1]][:,0], newdf2[klasaDf2==klasyDla2[1]][:,1], 'r*')
plt.plot(newdf2[klasaDf2==klasyDla2[2]][:,0], newdf2[klasaDf2==klasyDla2[2]][:,1], 'g*')

#3d
#1
plt.subplot(325, projection='3d')

newdf1 = np.dot(df1, ww1[1][:,sortedIndexesWw1[:3]])
klasyDla1 = np.unique(klasaDf1)
plt.plot(newdf1[klasaDf1==klasyDla1[0]][:,0], newdf1[klasaDf1==klasyDla1[0]][:,1], newdf1[klasaDf1==klasyDla1[0]][:,2], 'b*')
plt.plot(newdf1[klasaDf1==klasyDla1[1]][:,0], newdf1[klasaDf1==klasyDla1[1]][:,1], newdf1[klasaDf1==klasyDla1[1]][:,2], 'r*')
plt.plot(newdf1[klasaDf1==klasyDla1[2]][:,0], newdf1[klasaDf1==klasyDla1[2]][:,1], newdf1[klasaDf1==klasyDla1[2]][:,2], 'g*')

plt.subplot(326, projection='3d')

newdf2 = np.dot(df2, ww2[1][:,sortedIndexesWw2[:3]])
klasyDla2 = np.unique(klasaDf2)
plt.plot(newdf2[klasaDf2==klasyDla2[0]][:,0], newdf2[klasaDf2==klasyDla2[0]][:,1], newdf2[klasaDf2==klasyDla2[0]][:,2], 'b*')
plt.plot(newdf2[klasaDf2==klasyDla2[1]][:,0], newdf2[klasaDf2==klasyDla2[1]][:,1], newdf2[klasaDf2==klasyDla2[1]][:,2], 'r*')
plt.plot(newdf2[klasaDf2==klasyDla2[2]][:,0], newdf2[klasaDf2==klasyDla2[2]][:,1], newdf2[klasaDf2==klasyDla2[2]][:,2], 'g*')

plt.show()