package main

import (
	"net/http"
	"os"
	"time"
	"fmt"

	"github.com/codegangsta/negroni"
	"github.com/gorilla/mux"
	"github.com/unrolled/render"
)

// NewServer configures and returns a Server.
func NewServer() *negroni.Negroni {

	formatter := render.New(render.Options{
		IndentJSON: true,
	})

	n := negroni.Classic()
	mx := mux.NewRouter()

	initRoutes(mx, formatter)

	n.UseHandler(mx)
	return n
}

//return current date in jason format:
//{	Year: xx, 
//	Month: xx,
//	Day: xx
//}
func TimeJsHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		//get current daye, parse it to year, month, day and return in jason
		CurrentYear, CurrentMonth, CurrentDay := time.Now().Date();
		formatter.JSON(w, http.StatusOK, struct {
			Year      string `json:"Year"`
			Month 	  string `json:"Month"`
			Day		  string `json:"Day"`
		}{Year: fmt.Sprintf("%d",CurrentYear), Month: CurrentMonth.String(), Day: fmt.Sprintf("%d",CurrentDay)})
	}
}

// return a html page with form
func LoginHandler(formatter *render.Render) http.HandlerFunc{
	return func(w http.ResponseWriter, req *http.Request) {
		formatter.HTML(w, http.StatusOK, "index", struct {
		}{})
	}
}

// return a html page with table
func PostHandler(formatter *render.Render) http.HandlerFunc{
	return func(w http.ResponseWriter, req *http.Request) {
		req.ParseForm();
		//use posted information to update template
		formatter.HTML(w, http.StatusOK, "AfterPost", struct {
			UserName      string `json:"UserName"`
			Password string `json:"Password"`
		}{UserName: req.Form["username"][0], Password: req.Form["password"][0]})
	}
}

// return not implemented
func UnknownHandler(formatter *render.Render) http.HandlerFunc{
	return func(w http.ResponseWriter, req *http.Request) {
		w.WriteHeader(501)
		w.Write([]byte("501 page not implemented"))
	}
}

// init router, handler will be added here
func initRoutes(mx *mux.Router, formatter *render.Render) {
	webRoot := os.Getenv("WEBROOT")
	if len(webRoot) == 0 {
		if root, err := os.Getwd(); err != nil {
			panic("Could not retrive working directory")
		} else {
			webRoot = root
			//fmt.Println(root)
		}
	}
	//task1: static file, will read index.html in /assets
	mx.PathPrefix("/static").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir(webRoot+"/assets/"))))
	//task2: javascript, will return date in jason format
	mx.HandleFunc("/time/js", TimeJsHandler(formatter)).Methods("GET")
	//task3: get and post
	mx.HandleFunc("/login", LoginHandler(formatter)).Methods("GET")
	mx.HandleFunc("/login", PostHandler(formatter)).Methods("POST")
	//task4: unknown
	mx.HandleFunc("/unknown", UnknownHandler(formatter)).Methods("GET")
}