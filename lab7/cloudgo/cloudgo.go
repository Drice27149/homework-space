package main

import (
	/*
	"fmt"
	"log"
	"net/http"
	"strings"*/
	//"fmt"
	//"time"
)

//method: curl -v local:9000

func main() {
	//year, month, day := time.Now().Date()
	//fmt.Print(year,month,day)
	nServer := NewServer()
	nServer.Run(":9000")
}