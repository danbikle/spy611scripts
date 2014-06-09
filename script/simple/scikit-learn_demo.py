#!/usr/bin/env python

# ~/spy611/script/simple/scikit-learn_demo.py

# Demo:
# python ~/spy611/script/simple/scikit-learn_demo.py

# Ref:
# http://scikit-learn.org/stable/modules/ensemble.html#classification

from sklearn.datasets import make_hastie_10_2
from sklearn.ensemble import GradientBoostingClassifier
X, y = make_hastie_10_2(random_state=0)
X_train, X_test = X[:2000], X[2000:]
y_train, y_test = y[:2000], y[2000:]
clf = GradientBoostingClassifier(n_estimators=100, learning_rate=1.0, max_depth=1, random_state=0).fit(X_train, y_train)
myscore = clf.score(X_test, y_test)                 
print myscore
