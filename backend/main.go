package main

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"

	"backend/config"
	"backend/controllers"
	"backend/migrations"
	"backend/model"
)

func main() {

	// koneksi database MySQL
	config.ConnectDatabase()

	// membuat tabel otomatis
	config.DB.AutoMigrate(
		&model.User{},
		&model.Order{},
	)

	// data awal user
	migrations.SeedUser()

	router := gin.Default()

	// CORS untuk Flutter
	router.Use(cors.Default())

	// test API
	router.GET("/", func(c *gin.Context) {

		c.JSON(200, gin.H{
			"message": "Laundry API Running",
		})

	})

	// LOGIN JWT
	router.POST("/login", controllers.Login)

	router.GET("/items", controllers.GetOrders)

	router.GET("/items/:id", controllers.GetOrderByID)

	router.POST("/items", controllers.CreateOrder)

	router.PUT("/items/:id", controllers.UpdateOrder)

	router.DELETE("/items/:id", controllers.DeleteOrder)

	// akses semua interface (Chrome + Android Emulator)
	router.Run("0.0.0.0:8080")
}
