package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	"github.com/thedevsaddam/renderer"
)

const indexhtml string = `<!DOCTYPE html>
<html>
	<head>
		<title>Test Frontend</title>
	</head>
	<body>
		<h1>TEST Frontend</h1>
		<p>Backend is: %s</p>
		<p>Browser - Backend communication: </p>
		<div id="result">
		<script>
			fetch("%s").then(function (response) {
				return response.text();
			}).then(function (html) {
				// This is the HTML from our response as a text string
				const doc = document.getElementById('result');
				doc.innerHTML = html
				console.log(html);
			}).catch(function (error) {
				console.log("Error: " + error);
			});
		</script>
		</div>
		<p>Server - Backend communication: </p>
		<div>
			%v
		</div>

	</body>
</html>
`

func getenv(key, def string) string {
	value := os.Getenv(key)
	if len(value) == 0 {
		return def
	}
	return value
}

var backend_internal string
var backend_external string
var port string

func main() {

	backend_internal = getenv("BACKEND_URL_INTERNAL", "http://localhost:9090")
	backend_external = getenv("BACKEND_URL_EXTERNAL", "http://localhost:9090")
	port = getenv("PORT", "8080")

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", Index)
	router.HandleFunc("/health", health)
	router.HandleFunc("/health_with_be_check", healthWithBeCheck)

	log.Printf("Frontend. Listening on :%v. Backend internal %v, Backend external: %v", port, backend_internal, backend_external)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), router))
}

func health(w http.ResponseWriter, r *http.Request) {
	log.Printf("Call (healthcheck) from %v. Path: %v", r.RemoteAddr, r.URL.Path)
	w.Write(([]byte)("OK"))
}

func healthWithBeCheck(w http.ResponseWriter, r *http.Request) {
	log.Printf("Call (healthcheck with be check) from %v. Path: %v", r.RemoteAddr, r.URL.Path)
	_, err := callHTTP("/health")
	if err != nil {
		log.Printf("Error: %v (BE Return with HTTP 500) ", err)
		w.WriteHeader(http.StatusInternalServerError)
		w.Write(([]byte)(err.Error()))
	}

	w.Write(([]byte)("OK"))
}

func callHTTP(path string) (string, error) {
	be := backend_internal + path
	req, err := http.NewRequest("GET", be, nil)
	if err != nil {
		return fmt.Sprintf("Error:%v", err), err
	}

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return fmt.Sprintf("Error:%v", err), err
	}

	defer resp.Body.Close()

	b, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Sprintf("Error:%v", err), err
	}

	return string(b), nil
}

func Index(w http.ResponseWriter, r *http.Request) {
	log.Printf("Call (index) from %v. Path: %v", r.RemoteAddr, r.URL.Path)
	b := backend_external + "/message"
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	ret, _ := callHTTP("/message")
	resp := fmt.Sprintf(indexhtml, b, b, ret)
	rnd := renderer.New()
	rnd.HTMLString(w, http.StatusOK, resp)
}
