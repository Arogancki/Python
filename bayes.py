import pandas as pd
import numpy as np

import matplotlib.pyplot as plt

from scipy.io import arff

data = arff.loadarff('./datasets/zoo.arff')
df = pd.DataFrame(data[0])
D=np.array(df).astype('U13')

WCZYTANE = np.hstack((D[:,1:13],D[:,14:]))

iloscTestow = range(5,100,1)

LAPLAS=1

ILOSC_OKRAZEN=100

super_wynik_super=[]
for czy_to_test_z_laplasem in range(0, 2):
    wynik=[]
    for okrazenie in range(0, ILOSC_OKRAZEN):
        wynik.append([])
        for TESTOWYPODIAL in iloscTestow:
            TESTOWYPODIAL*=0.01


            D=np.random.permutation(WCZYTANE);

            podz=int(np.ceil(len(D)*TESTOWYPODIAL))
            K=D[0:podz]
            Test=D[podz:]
            D=K

            classes = {}
            for c in list(set(D[:,15])):
                classes[c]=list(filter(lambda d: d[15] == c, D))

            licznosci = {}
            wartosci = {}
            P = {}
            for key in classes.keys():
                licznosci[key]=len(classes[key])
                wartosci[key] = {}
                index = 0
                for animal in classes[key]:
                    for kk in range(15):
                        k = animal[kk]
                        if not kk in wartosci[key]:
                            wartosci[key][kk] = {}
                        if k in wartosci[key][kk]:
                            wartosci[key][kk][k] += 1
                        else:
                            wartosci[key][kk][k] = 1
                    index+=1
                p=0
                if 'false' in wartosci[key][0]:
                    p+=wartosci[key][0]['false']
                if 'true' in wartosci[key][0]:
                    p+=wartosci[key][0]['true']
                P[key]={}
                for a in wartosci[key].keys():
                    P[key][a]={}
                    P[key][a]={}
                    if 'false' in wartosci[key][a]:
                        P[key][a]['false']=(wartosci[key][a]['false']/p)
                    else:
                        P[key][a]['false']=0
                    if 'true' in wartosci[key][a]:
                        P[key][a]['true']=(wartosci[key][a]['true']/p)
                    else:
                        P[key][a]['true']=0

            def getMaxType(animal):
                ap={}
                for type in P:
                    s=1
                    i=1
                    for a in P[type]:
                        i+=1
                        if czy_to_test_z_laplasem==1:
                            s*=P[type][a][animal[a]]+LAPLAS
                        else:
                            s*=P[type][a][animal[a]]
                        if s==0:
                            break
                    ap[type]=s#/i
                max = -1
                maxType = ''
                for type in ap:
                    if max < ap[type]:
                        max=ap[type]
                        maxType=type
                # print(maxType)#, 'na', max, '%!')
                return maxType

            qq=0
            q=0
            for t in Test:
                wykryty_typ=getMaxType(t)
                #print(t[15] + ' wykrylem jako ' + getMaxType(t)) 
                q+=t[15]==wykryty_typ
                qq+=1
            if not qq==0:
                q=q/qq
            else:
                q=0
            wynik[okrazenie].append(q)


    super_wynik={}
    for okrazenie in range(0, ILOSC_OKRAZEN):
        for i in range(0, len(wynik[okrazenie])):
            if not i in super_wynik:
                super_wynik[i]=0
            super_wynik[i]+=wynik[okrazenie][i]

    super_wynik_super.append([])
    for i in range(0, len(super_wynik)):
        super_wynik_super[czy_to_test_z_laplasem].append(super_wynik[i]/ILOSC_OKRAZEN)

plt.figure()
plt.plot(iloscTestow, super_wynik_super[0], 'r-', label="bez poprawki")
plt.plot(iloscTestow, super_wynik_super[1], 'b-', label="z poprawka")
plt.show()

#naiwnosc - niezaleznosc zmiennych
#kiedy poprawka jest git - kiedy prawdopodobeiscnktwo atryboutow jest rowne 0
#wzor - p(x|y)=P(x)*P(y)/P(x) ?? - sprawdzic w zeszyciuku
# moze przeliczyc jakis prosty przykald