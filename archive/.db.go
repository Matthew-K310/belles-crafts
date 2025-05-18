package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// add filter options for crocheted goods, painted, and other (tbd)
// need to add color options and wood options

type Product struct {
	ID          uint   `gorm:"primaryKey"`
	Name        string `gorm:"type:varchar(100);not null"`
	Description string
	Price       float64 `gorm:"not null"`
	Quantity    int     `gorm:"default:0"`
	CreatedAt   time.Time
}

func main() {
	// Database
	dsn := "host=localhost user=postgres password=kdfbr4woe8c7tcj dbname=storefront port=5432 sslmode=disable"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("failed to connect:", err)
	}

	err = db.AutoMigrate(&Product{})
	if err != nil {
		log.Fatal("failed to migrate:", err)
	}

	log.Println("Connected and migrated successfully!")

	// Seed data
	products := []Product{
		{
			Name:        "Cutting Board",
			Description: "Hand-painted, custom design",
			Price:       25,
			Quantity:    50,
		},
		{
			Name:        "Bandana",
			Description: "Hand-made, crocheted",
			Price:       15,
			Quantity:    50,
		},
	}

	for _, product := range products {
		result := db.Create(&product)
		if result.Error != nil {
			log.Println("Failed to insert product:", product.Name, "-", result.Error)
		} else {
			log.Println("Inserted product:", product.Name)
		}
	}

	// HTTP Test Server
	http.Handle("/", http.FileServer(http.Dir(".")))

	http.HandleFunc("/hi", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hi")
	})

	port := ":8080"
	fmt.Println("Server is running on port" + port)

	log.Fatal(http.ListenAndServe(port, nil))
}
