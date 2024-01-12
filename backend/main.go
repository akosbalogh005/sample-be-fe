package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
)

func getenv(key, def string) string {
	value := os.Getenv(key)
	if len(value) == 0 {
		return def
	}
	return value
}

var port string
var hostname string

func main() {

	port = getenv("PORT", "9090")
	hostname, _ = os.Hostname()

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/message", Message)
	router.HandleFunc("/health", Health)

	log.Printf("Test Backend. Listening on :%v. ", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), router))
}

func Health(w http.ResponseWriter, r *http.Request) {
	log.Printf("Call from %v. Path: %v", r.RemoteAddr, r.URL.Path)
	_, err := w.Write(([]byte)("OK"))
	if err != nil {
		log.Printf("Error while responding: %v", err)
	}
}

func Message(w http.ResponseWriter, r *http.Request) {
	log.Printf("Call from %v. Path: %v", r.RemoteAddr, r.URL.Path)
	resp := fmt.Sprintf("Hello message from %v. Time: %v", hostname, time.Now())
	w.Header().Set("Content-Type", "text; charset=utf-8")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	_, err := w.Write(([]byte)(resp))
	if err != nil {
		log.Printf("Error while responding: %v", err)
	}
}
