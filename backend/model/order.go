package model

import "time"

type Order struct {
	ID uint `gorm:"primaryKey"`

	Code string

	Customer string

	Service string

	Price int

	Status string

	Payment string

	CreatedAt time.Time
}
