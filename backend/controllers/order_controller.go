package controllers

import (
	"net/http"
	"strconv"

	"backend/config"
	"backend/model"

	"github.com/gin-gonic/gin"
)

// GET /items
func GetOrders(c *gin.Context) {

	var orders []model.Order

	result := config.DB.Find(&orders)

	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": "Gagal mengambil data",
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"data": orders,
	})
}

// GET /items/:id
func GetOrderByID(c *gin.Context) {

	id, _ := strconv.Atoi(c.Param("id"))

	var order model.Order

	result := config.DB.First(&order, id)

	if result.Error != nil {

		c.JSON(http.StatusNotFound, gin.H{
			"message": "Data tidak ditemukan",
		})

		return
	}

	c.JSON(http.StatusOK, gin.H{
		"data": order,
	})
}

// POST /items
func CreateOrder(c *gin.Context) {

	var order model.Order

	if err := c.ShouldBindJSON(&order); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Input tidak valid",
		})

		return
	}

	config.DB.Create(&order)

	c.JSON(http.StatusCreated, gin.H{
		"message": "Order berhasil dibuat",
		"data":    order,
	})
}

// PUT /items/:id
func UpdateOrder(c *gin.Context) {

	id, _ := strconv.Atoi(c.Param("id"))

	var order model.Order

	if err := config.DB.First(&order, id).Error; err != nil {

		c.JSON(http.StatusNotFound, gin.H{
			"message": "Data tidak ditemukan",
		})

		return
	}

	var input model.Order

	if err := c.ShouldBindJSON(&input); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Input tidak valid",
		})

		return
	}

	config.DB.Model(&order).Updates(input)

	c.JSON(http.StatusOK, gin.H{
		"message": "Order berhasil diupdate",
		"data":    order,
	})
}

// DELETE /items/:id
func DeleteOrder(c *gin.Context) {

	id, _ := strconv.Atoi(c.Param("id"))

	var order model.Order

	if err := config.DB.First(&order, id).Error; err != nil {

		c.JSON(http.StatusNotFound, gin.H{
			"message": "Data tidak ditemukan",
		})

		return
	}

	config.DB.Delete(&order)

	c.JSON(http.StatusOK, gin.H{
		"message": "Order berhasil dihapus",
	})
}
