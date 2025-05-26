// main.go
package main

import (
	"log"
	"net/http"

	"github.com/Matthew-K310/belles-crafts.git/component"
)

func handleIndex(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html; charset=utf-8")

	err := component.HeaderTemplate().Render(r.Context(), w) // render the HeaderTemplate component
	if err != nil {
		log.Printf("Error rendering HeaderTemplate: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}

func main() {
	http.HandleFunc("/", handleIndex)

	http.Handle("/assets/", http.StripPrefix("/assets/", http.FileServer(http.Dir("assets"))))

	println("Server is starting on :8080")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatalf("Error starting server: %v", err)
	}
}
