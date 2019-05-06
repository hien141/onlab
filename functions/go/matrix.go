package main

import (
	"fmt"
)

func main() {
	A := [2][3]int{
		[3]int{1, 1, 1},
		[3]int{1, 1, 1},
	}
	B := [3]2]int{
		[2]int{1, 1},
		[2]int{1, 1},
		[2]int{1, 1},
	}

	var C [3][3]int

	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			C[i][j] = 0
			for k := 0; k < 3; k++ {
				C[i][j] =  A[i][k] * B[k][j]
			}
		}
	}

	twoDimensionalMatrices := [3][3][3]int{m1, m2, m3}

	matrixNames := []string{"MATRIX1", "MATRIX2", "MATRIX3 = MATRIX1*MATRIX2"}
	for index, m := range twoDimensionalMatrices {
		fmt.Println(matrixNames[index],":")
		showMatrixElements(m)
		fmt.Println()
	}
}

//A function that displays matix elements
func showMatrixElements(m [3][3]int) {
	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			fmt.Printf("%d\t", m[i][j])
		}
		fmt.Println()
	}
}