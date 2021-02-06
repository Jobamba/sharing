# Press Shift+F10 to execute it or replace it with your code.
# This code inverts a martix A based on its LU decomposition
# for checks use:
# https://adrianstoll.com/linear-algebra/matrix-inversion.html

import numpy as np


def LUdecomposition(A):
    U1 = A.copy()
    L1 = np.eye(len(A))
    for k in range(len(U1)-1):
         row0 = U1[k]
         for r in range(k+1,len(U1)):
              row = U1[r]  # ,0:]
    #         #print("current row %f",row)
    #         #print("substract %f", row0 / row0[k] * row[k])
    #         #print("previous %f", row0)
              multiplier = row[k] / row0[k]
              U1[r]= row - row0 * multiplier # / row0[k] * row[k]
              L1[r,k] = multiplier

    return L1, U1

def LUD_decomposition(A):
    U1 = A.copy()
    L1 = np.eye(len(A))
    for k in range(len(U1)-1):
         row0 = U1[k]
         for r in range(k+1,len(U1)):
              row = U1[r]  # ,0:]
    #         #print("current row %f",row)
    #         #print("substract %f", row0 / row0[k] * row[k])
    #         #print("previous %f", row0)
              multiplier = row[k] / row0[k]
              U1[r]= row - row0 * multiplier # / row0[k] * row[k]
              L1[r,k] = multiplier

    D = np.eye(len(A))
    U2 = U1.copy()
    L2 = L1.copy()

    for k in range(len(U1)):
        D[k,k] = U1[k,k]
        U2[k] = U1[k]/U1[k,k]

    return L1, U2, D


def InvertLower(L):
    n = len(L)
    InvL = np.eye(len(L))
    for rr in range(0, n):
        InvL[rr, rr] = 1. / L[rr, rr]
        for kk in range(0, rr):
            s = 0
            for k in range(kk, rr):
                s = s + L[rr, k] * InvL[k, kk]
            InvL[rr, kk] = -s * InvL[rr, rr]

    return InvL

def InvertLUequations(L,U):
    dim1 = len(L)

    InvLU = np.empty((dim1, 0), float)

    for i in range(dim1):
        eyeRow = np.zeros(dim1)
        eyeRow[i] = 1
        d = np.linalg.solve(L, eyeRow)
        x1 = np.linalg.solve(U, d)
        InvLU = np.column_stack((InvLU, x1)) # np.column_stack

    return InvLU

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    #A = np.array([[1., 2., 1.], [2., 1., -2.], [1., 0, -1.]])
    A = np.array([[-1., -2., 1., -2., 1. ],
                  [1., 1., 2., -1., 1.],
                  [-1., -1., -1., -2., 1.],
                  [1., -1., 2., 1., 1.],
                  [-1., -1., -1., -2., -2.]])

    #L = np.array([[1., 0., 0.], [2./7., 1., 0.], [1./7., -9./31., 1.]])  # by hand
    #U = np.array([[7., 2., -3.], [0., 31./7., -15./7.], [0., 0., -192./31.]])  # by hand
    #inv_should = np.array([[11/64, -5/64, -3/64], [-3/64, 13/64, -5/64], [7/192, -3/64, -31/192]])  # known

    print("1. Input matrix A")
    print(A)

    print("-----start lu decomposition------")  # scalable, but weak against diagonal 0s
    L, U = LUdecomposition(A)

    print("-----start LUD decomposition------")  # scalable, but weak against diagonal 0s
    LL, UU, DD = LUD_decomposition(A)

    #InvA3 = InvertLower(A3)

    #print("2. inv A3")
    #print(InvA3)

    invD = np.linalg.inv(DD)
    invU2 = np.linalg.inv(UU)
    invL2 = np.linalg.inv(LL)


    print("2. DD = \n ", DD)
    print("3. UU = \n ", UU)

    #print("5. U = \n ", U)
    print("4. U = \n ", U)
    #print("7. L = \n ", L)
    print("5. L = \n ", L)

    print("6. L*U = \n ")
    print(np.matmul(L, U))

    print(" ----- start matrix inversion ----")

    algoInv = InvertLUequations(L, U)
    print("7. invA computed with numpy linear algebra")
    print(algoInv)

    print("8. invA2 - calculated with LUD")
    invA2 = np.matmul(np.matmul(invU2, invD), invL2)
    print(invA2)

    print("9. Check: A * invA2")
    print( np.matmul(invA2, A) )



# See PyCharm help at https://www.jetbrains.com/help/pycharm/


