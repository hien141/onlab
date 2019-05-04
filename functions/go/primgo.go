package main

import (
    "fmt"
	"math"
	"net/http"
	"io"
	"bytes"
	"encoding/json"
	"io/ioutil"
	"log"
)

func IsPrime(value int) bool {
    for i := 2; i <= int(math.Floor(float64(value) / 2)); i++ {
        if value%i == 0 {
            return false
        }
    }
    return value > 1
}

func main() {
    for i := 1; i <= 100; i++ {
        if IsPrime(i) {
            fmt.Printf("%v ", i)
        }
    }
}

func Handler(rw http.ResponseWriter, req *http.Request) {
    id := r.PostFormValue("id")
	io.WriteString(rw, "pokemon")
}