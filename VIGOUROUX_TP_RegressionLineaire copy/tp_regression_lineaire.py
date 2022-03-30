# -*- coding: utf-8 -*-
"""TP_Regression_Lineaire.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/102bovZBLl7JCV4BZ7_k7SXNy24aVmcMn

**Notebook régression**

# Importer les données :
"""

import pandas as pd 
import matplotlib.pyplot as plt          
import numpy as np
from scipy.stats import linregress

#!pip install pandas

df= pd.read_excel("Donnees_d'entree.xlsx")

X = list(df['Tableau 1'].values)
X

X = list(df['Tableau 1'].values)
X=X[1:]
Y = list(df["Unnamed: 1"].values)
Y = Y[1:]

X = [int(x) for x in X]
X

Y= [int(x) for x in Y]
Y

"""# Implémentation de la méthode des moindres carrés : """

def regLin(x, y):
    """
    Ajuste une droite d'équation a*x + b sur les points (x, y) par la méthode
    des moindres carrés.

    Args :
        * x (list): valeurs de x
        * y (list): valeurs de y

    Return:
        * a (float): pente de la droite
        * b (float): ordonnée à l'origine
    """
    # initialisation des sommes
    x_sum = 0.
    x2_sum = 0.
    y_sum = 0.
    xy_sum = 0.
    # calcul des sommes
    for xi, yi in zip(x, y):
        x_sum += xi
        x2_sum += xi**2
        y_sum += yi
        xy_sum += xi * yi
    # nombre de points
    npoints = len(x)
    # calcul des paramétras
    a = (npoints * xy_sum - x_sum * y_sum) / (npoints * x2_sum - x_sum**2)
    b = (x2_sum * y_sum - x_sum * xy_sum) / (npoints * x2_sum - x_sum**2)
    # renvoie des parametres
    return a, b

regLin(X,Y)

"""- Implémenter une fonction qui calcule cov(x,y)
- Implementer une fonction qui calcule Var(x)
- Implémenter une fonction qui calcule Moyenne (x) et Moyenne(y)
- Implémenter une fonction qui calcule les coefficients de régression linéaire par la méthode des moindres carrés
"""

def moyenne(X):
  X=np.array(X)
  return X.mean()

moyX = moyenne(X)
moyX

def Xcarre(X):
  X=np.array(X)
  Xcarre = []
  for n in X:
    Xcarre.append(n**2)
  return np.average(Xcarre)

moyXcarre = Xcarre(X)
moyXcarre

def moyenne(Y):
  Y=np.array(Y)
  return Y.mean()

moyY= moyenne(Y)
moyY

def moyenneProduit(X,Y):
  X= np.array(X)
  Y= np.array(Y)
  L=X*Y
  return L.mean()

moyXY = moyenneProduit(X,Y)
moyXY

def varX(X):
  X= np.array(X)
  vari = np.var(X)
  return vari

varianceX = varX(X)
varianceX

def covariance(X,Y):
  return moyenneProduit(X,Y)-moyenne(X)*moyenne(Y)

covXY= covariance(X,Y)
covXY

def ecartype(X):
  X= np.array(X)
  return X.std()

ecartX = ecartype(X)
ecartX

def regressionlin(X,Y):
  arrayX= np.array(X)
  arrayY= np.array(Y)
  a = moyXY - moyX * moyY / moyXcarre - moyX**2
  b = moyY - a * moyX
  return a,b

regLin = regressionlin(X,Y)
regLin

"""# Méthodes Python pour la régression linéaire :

- Numpy
- Scipy
- Scikit Learn
"""

#Methode polyfit
parametre= np.polyfit(X,Y,1)
parametre

#Methode linregress
a, b, r, p_value, std_err = linregress(X, Y)
print("a   ={:8.3f}\nb   ={:8.3f}\nr^2 ={:8.5f}".format(a, b, r**2))

#Methode LinearRegression
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2, random_state=0)

from sklearn.linear_model import LinearRegression
X_train = np.array(X_train)
X_test = np.array(X_train)

X_train = X_train.reshape(-1,1)
X_test = X_test.reshape(-1,1)

regressor = LinearRegression()
regressor.fit(X_train, y_train)

print(regressor.intercept_)

print(regressor.coef_)