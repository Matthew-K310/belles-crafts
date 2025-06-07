package main

import (
	"context"
	"log"
	"net/http"
	"os" // Import os for checking if a file exists (optional but good practice for static server)

	"github.com/Matthew-K310/belles-crafts.git/templates/pages"
)

const (
	staticFilesDir = "./static"
	staticURLPath  = "/static/"
)

func main() {
	mux := http.NewServeMux()

	// Handle home page
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/" {
			http.NotFound(w, r)
			return
		}

		w.Header().Set("Content-Type", "text/html; charset=utf-8")

		err := pages.HomePage().Render(context.Background(), w)
		if err != nil {
			log.Printf("Error rendering HomePage: %v", err)
			http.Error(w, "Failed to render home page", http.StatusInternalServerError)
			return
		}
	})

	// Handle shop page
	mux.HandleFunc("/shop", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/shop" {
			http.NotFound(w, r)
			return
		}

		w.Header().Set("Content-Type", "text/html; charset=utf-8")

		err := pages.ShopPage().Render(context.Background(), w)
		if err != nil {
			log.Printf("Error rendering ShopPage: %v", err)
			http.Error(w, "Failed to render shop page", http.StatusInternalServerError)
			return
		}
	})

	// Handle about page
	mux.HandleFunc("/about", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/about" {
			http.NotFound(w, r)
			return
		}

		w.Header().Set("Content-Type", "text/html; charset=utf-8")

		err := pages.AboutPage().Render(context.Background(), w)
		if err != nil {
			log.Printf("Error rendering AboutPage: %v", err)
			http.Error(w, "Failed to render about page", http.StatusInternalServerError)
			return
		}
	})

	// Handler for serving static files.
	staticHandler := http.StripPrefix(staticURLPath, http.FileServer(http.Dir(staticFilesDir)))

	if _, err := os.Stat(staticFilesDir); os.IsNotExist(err) {
		log.Fatalf("Static files directory not found: %s", staticFilesDir)
	}

	// Register static file handler.
	mux.Handle(staticURLPath, staticHandler)

	port := ":8000"
	log.Printf("Server starting on port %s", port)

	if err := http.ListenAndServe(port, mux); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
