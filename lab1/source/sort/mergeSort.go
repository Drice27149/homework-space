package main

import (
	"fmt"
)

func mergeSort(a []int, l int, r int) {
	if l < r {
		mid := (l + r) / 2
		mergeSort(a, l, mid)
		mergeSort(a, mid+1, r)
		t := make([]int, r-l+1)
		pl := l
		pr := mid + 1
		for i := l; i <= r; i++ {
			if pl <= mid && (pr > r || a[pl] < a[pr]) {
				t[i-l] = a[pl]
				pl++
			} else {
				t[i-l] = a[pr]
				pr++
			}
		}
		for i := l; i <= r; i++ {
			a[i] = t[i-l]
		}
	}
}

func printArray(a []int) {
	length := len(a)
	for i := 0; i < length; i++ {
		fmt.Printf("%d ", a[i])
	}
	fmt.Printf("\n")
}

func mySort(a []int) {
	mergeSort(a, 0, len(a)-1)
}

func main() {
	a := []int{3, 2, 1, 6, 7, 8}
	mySort(a)
	printArray(a)
}
