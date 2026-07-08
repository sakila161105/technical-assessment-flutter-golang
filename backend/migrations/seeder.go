package migrations

import (
	"backend/config"
	"backend/model"

	"golang.org/x/crypto/bcrypt"
)


func SeedUser(){

	var user model.User

	result := config.DB.Where(
		"email = ?",
		"admin@gmail.com",
	).First(&user)


	// kalau user sudah ada jangan insert lagi
	if result.Error == nil {
		return
	}


	password, _ := bcrypt.GenerateFromPassword(
		[]byte("123456"),
		bcrypt.DefaultCost,
	)


	newUser := model.User{

		Name: "Mario Wicaksono",

		Email:"admin@gmail.com",

		Password:string(password),
	}


	config.DB.Create(&newUser)

}