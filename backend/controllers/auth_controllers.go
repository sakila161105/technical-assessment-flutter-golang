package controllers

import (
	"net/http"

	"backend/config"
	"backend/model"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

var jwtKey = []byte("laundry_secret_key")

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}


func Login(c *gin.Context) {

	var request LoginRequest


	if err := c.ShouldBindJSON(&request); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"message":"Input tidak valid",
		})

		return
	}


	var user model.User


	result := config.DB.Where(
		"email = ?",
		request.Email,
	).First(&user)



	if result.Error != nil {

		c.JSON(http.StatusUnauthorized, gin.H{
			"message":"Email tidak ditemukan",
		})

		return
	}



	err := bcrypt.CompareHashAndPassword(
		[]byte(user.Password),
		[]byte(request.Password),
	)


	if err != nil {

		c.JSON(http.StatusUnauthorized, gin.H{
			"message":"Password salah",
		})

		return
	}



	token := jwt.NewWithClaims(
		jwt.SigningMethodHS256,
		jwt.MapClaims{

			"user_id": user.ID,

			"email": user.Email,
		},
	)


	tokenString, _ := token.SignedString(jwtKey)



	c.JSON(http.StatusOK, gin.H{

		"message":"Login berhasil",

		"token": tokenString,

		"user": gin.H{

			"id":user.ID,

			"name":user.Name,

			"email":user.Email,
		},
	})

}