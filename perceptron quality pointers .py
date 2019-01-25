import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import arff
import sklearn
from sklearn import datasets
import datetime
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split
from sklearn.ensemble import AdaBoostClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB


class WJK:
    x = []
    y = []
    confusion = 0
    AUC = 0
    ROC = []
    method = ""
    time = 0

    spec = 0
    czul = 0
    dokl = 0
    prec = 0
    f1 = 0
    zbDokl = 0
    reps = 50

    def __init__(self, method):
        self.method = method

    def getCl(self, x):
        return {
            "GaussianNB": GaussianNB(),
            "LogisticRegression": LogisticRegression(),
            "MLPClassifier": MLPClassifier(),
            "AdaBoostClassifier": AdaBoostClassifier(),
        }.get(x)

    def calc(self, x, y):
        self.x = x
        self.y = y
        start = datetime.datetime.now()

        for i in range(0, self.reps):
            xTrain, xTest, yTrain, yTest = train_test_split(
                self.x, self.y, test_size=0.5
            )
            xTrain = xTrain.astype(float)
            xTest = xTest.astype(float)
            yTrain = yTrain.astype(float)
            yTest = yTest.astype(float)
            cl = self.getCl(self.method)
            cl = cl.fit(xTrain, yTrain)
            yy = cl.predict(xTest)
            yy = yy.astype(float)
            out = cl.predict_proba(xTest)
            matrix = self.confusionCalc(yTest, yy)
            self.quality(matrix)
            tmp = []
            fpr, tpr, xxx = sklearn.metrics.roc_curve(yTest, out[:, 1].astype(float))
            tmp.append(np.array((fpr, tpr)))
            score = sklearn.metrics.roc_auc_score(yTest, out[:, 1].astype(float))
            self.AUC += score
        self.ROC = tmp
        end = datetime.datetime.now()
        self.time = (end - start).seconds

    def confusionCalc(self, yTest, yy):
        TN = 0
        FP = 0
        FN = 0
        TP = 0
        for i in range(0, np.size(yTest)):
            if yTest[i] == 0 and yy[i] == 0:
                TN += 1
            if yTest[i] == 0 and yy[i] == 1:
                FP += 1
            if yTest[i] == 1 and yy[i] == 0:
                FN += 1
            if yTest[i] == 1 and yy[i] == 1:
                TP += 1

        # __| N  | P
        # N | TN | FP
        # P | FN | TP

        matrix = np.matrix("0 0; 0 0")
        matrix[0, 0] = TN
        matrix[0, 1] = FP
        matrix[1, 0] = FN
        matrix[1, 1] = TP
        return matrix

    def quality(self, matrix):
        TN = matrix[0, 0]
        FP = matrix[0, 1]
        FN = matrix[1, 0]
        TP = matrix[1, 1]
        self.confusion += matrix
        self.spec += (TN) / (TN + FP)
        self.czul += TP / (TP + FN)
        self.dokl += (TN + TP) / (TN + TP + FN + FP)
        self.prec += TP / (TP + FP)
        self.f1 += 2 * TP / ((2 * TP) + FP + FN)
        self.zbDokl += (0.5 * (TP / (TP + FN))) + (0.5 * (TN / (TN + FP)))

    def display(self):
        reps = self.reps
        print("")
        print("")
        print("METODA: ", self.method)
        print("specyficzność", self.spec / reps)
        print("czułość", self.czul / reps)
        print("dokładność: ", self.dokl / reps)
        print("precyzja", self.prec / reps)
        print("f1", self.f1 / reps)
        print("zbalansowana dokładność", self.zbDokl / reps)

    def draw(self, color):
        print("AUC", self.AUC / self.reps)
        ROCx = (self.ROC[0][0]).astype(float)
        ROCy = (self.ROC[0][1]).astype(float)
        zbDokl = 0.5 * (1 - ROCx) + 0.5 * ROCy
        maxx = np.argmax(zbDokl)
        plt.plot(ROCx[maxx], ROCy[maxx], "b*")
        line, = plt.plot(ROCx, ROCy, color)
        return line


data, meta = arff.loadarff("diabetes.arff")
df = pd.DataFrame(data)
D = np.array(df).astype("U13")

size = np.size(D, 1)
x = D[:, 0 : size - 1]
y = D[:, size - 1]

GaussianNBObj = WJK("GaussianNB")
LogisticRegressionObj = WJK("LogisticRegression")
MLPClassifierObj = WJK("MLPClassifier")
AdaBoostClassifierObj = WJK("AdaBoostClassifier")

GaussianNBObj.calc(x, y)
LogisticRegressionObj.calc(x, y)
MLPClassifierObj.calc(x, y)
AdaBoostClassifierObj.calc(x, y)

GaussianNBObj.display()
LogisticRegressionObj.display()
MLPClassifierObj.display()
AdaBoostClassifierObj.display()

plt.figure()
plt.legend(
    (
        GaussianNBObj.draw("-m"),
        LogisticRegressionObj.draw("-r"),
        MLPClassifierObj.draw("-y"),
        AdaBoostClassifierObj.draw("-g"),
    ),
    ("GaussianNB", "LogisticRegression", "MLPClassifier", "AdaBoostClassifier"),
)
plt.show()
