def matrixmult (A, B):
    rows_A = len(A)
    cols_A = len(A[0])
    rows_B = len(B)
    cols_B = len(B[0])

    C = [[0 for row in range(cols_B)] for col in range(rows_A)]

    for i in range(rows_A):
        for j in range(cols_B):
            for k in range(cols_A):
                C[i][j] += A[i][k] * B[k][j]
    return C


def main():
        B = ([[1, 2, 3], [4, 6, 8]])
        A = ([[8, 3], [2, 4], [3, 6]])
        C = matrixmult(A, B)
        return str(C)
