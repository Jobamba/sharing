import numpy as np

def read_file(filename):
    with open(filename) as f:
        content = f.readlines()
    y = [line[0] for line in content]
    X = [line[2:].strip() for line in content]

    ty = np.zeros(len(y))
    for k in range(len(y)):
        if y[k] == '+':
            ty[k] = 1
    return X,ty

Xtr, ytr = read_file('Names_data_train_large.txt')
Xte, yte = read_file('Names_data_test.txt')

n_samples = len(Xtr)


iters = 100
speed = 0.01

def extractX(Xtr,length):
    start=0
    tX = np.empty([0, length])
    for mys in Xtr:
        sec = np.array([ord(x) for x in mys[start:start+length]])
        tX = np.vstack((tX, sec))
    return tX

from sklearn.tree import DecisionTreeClassifier

def train_using_gini(X_train, y_train):
    # Creating the classifier object
    clf_gini = DecisionTreeClassifier(criterion="entropy",
                                      random_state=100, max_depth=5, min_samples_leaf=5)
    # Performing training
    clf_gini.fit(X_train, y_train)
    return clf_gini


# Function to make predictions
def prediction(X, clf_object):
    # Predicton on test with giniIndex
    y_pred = clf_object.predict(X)
    return y_pred



clf_gini = train_using_gini(extractX(Xtr,5), ytr)
y_pred_gini = prediction(extractX(Xte,5), clf_gini)

comp = np.hstack((np.transpose(np.array([Xte])), np.transpose([y_pred_gini])))
print(comp)

accuracy = (y_pred_gini == yte).mean()
print('accuracy = ', accuracy)



