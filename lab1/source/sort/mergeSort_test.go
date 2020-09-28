package main

import (
	"math/rand"
	"sort"
	"testing"
	"time"
)

func isEqual(a []int, b []int) bool {
	result := true
	if len(a) != len(b) {
		result = false
	} else {
		length := len(a)
		for i := 0; i < length; i++ {
			if a[i] != b[i] {
				result = false
			}
		}
	}
	return result
}

func TestMergeSort(t *testing.T) {
	rand.Seed(time.Now().UTC().UnixNano())
	testCase := 10
	testLength := 1000000
	for rnd := 0; rnd < testCase; rnd++ {
		t.Run("random array test", func(t *testing.T) {
			length := testLength
			got := make([]int, length)
			want := make([]int, length)
			for i := 0; i < length; i++ {
				got[i] = rand.Intn(100)
				want[i] = got[i]
			}
			mySort(got)
			sort.Ints(want)
			if isEqual(got, want) == false {
				t.Errorf("Wrong Answer")
			}
		})
	}
}
