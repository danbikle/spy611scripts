#!/usr/bin/env python

import sklearn.ensemble
import numpy

x_is  = numpy.loadtxt('/tmp/x_is.csv', delimiter=',')
x_oos = numpy.loadtxt('/tmp/x_oos.csv', delimiter=',')
          			           
y_is_n1dg  = numpy.loadtxt('/tmp/y_is_n1dg.csv', delimiter=',')
y_is_n2dg  = numpy.loadtxt('/tmp/y_is_n2dg.csv', delimiter=',')
y_is_n1wg  = numpy.loadtxt('/tmp/y_is_n1wg.csv', delimiter=',')
          			           
y_oos_n1dg = numpy.loadtxt('/tmp/y_oos_n1dg.csv', delimiter=',')
y_oos_n2dg = numpy.loadtxt('/tmp/y_oos_n2dg.csv', delimiter=',')
y_oos_n1wg = numpy.loadtxt('/tmp/y_oos_n1wg.csv', delimiter=',')


ab_clf_n1dg = sklearn.ensemble.AdaBoostClassifier(n_estimators=100)

clf_n1dg = ab_clf_n1dg.fit(x_is,y_is_n1dg)

print('clf_n1dg.score(x_oos,y_oos_n1dg)) is:')
print(clf_n1dg.score(x_oos,y_oos_n1dg))

print(clf_n1dg.predict(x_oos))

