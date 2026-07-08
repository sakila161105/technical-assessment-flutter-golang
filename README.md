# Technical Assessment Flutter & Golang Developer

## Deskripsi

Aplikasi manajemen laundry berbasis Flutter sebagai frontend dan Golang sebagai backend REST API.

Aplikasi memiliki fitur:

- Login Authentication
- Dashboard
- Manajemen transaksi laundry
- CRUD transaksi
- Search
- Filter
- Pagination


---

# Teknologi yang Digunakan


## Frontend

- Flutter
- Dart
- Provider State Management
- Material Design


## Backend

- Golang
- Gin Framework
- GORM


## Database

- MySQL


## Security

- JWT Authentication
- bcrypt Password Hashing
- CORS Configuration


---

# Struktur Project



technical-assessment

├── frontend
│ ├── lib
│ │ ├── providers
│ │ ├── screens
│ │ ├── services
│ │ └── main.dart
│ │
│ └── pubspec.yaml
│
├── backend
│ ├── controllers
│ ├── models
│ ├── routes
│ ├── middleware
│ ├── database
│ └── main.go
│
├── docs
│ ├── ERD_Laundry_Management_System.png
│ ├── Postman_Collection.json
│ └── screenshots
│
├── database
│ ├── migration.sql
│ ├── schema.sql
│ └── seed.sql
│
└── README.md



---

# Cara Menjalankan Aplikasi


## Backend Golang

Masuk folder backend:

```bash
cd backend

Install dependency:

go mod tidy

Jalankan server:

go run main.go

Backend berjalan:

http://localhost:8080
Frontend Flutter

Masuk folder frontend:

cd frontend

Install package:

flutter pub get

Jalankan aplikasi:

flutter run -d chrome
Login Demo

Email:

admin@gmail.com

Password:

123456
Fitur Aplikasi
Authentication
Login dengan email dan password
JWT Authentication
Logout
Dashboard
Nama pengguna
Informasi outlet
Statistik transaksi
Ringkasan pendapatan
Transaction Management

CRUD transaksi:

Create
Read
Update
Delete
Fitur Tambahan
Search transaksi
Filter status
Pagination
Loading state
Empty state
API Documentation
Authentication
Login

POST

/login

Request:

{
  "email": "admin@gmail.com",
  "password": "123456"
}
Order API
Get All Orders

GET

/items
Get Detail Order

GET

/items/{id}
Create Order

POST

/items
Update Order

PUT

/items/{id}
Delete Order

DELETE

/items/{id}
Database Design

Database menggunakan MySQL.

Entity Relationship Diagram (ERD)

Table Users
Field	Type
id	BIGINT
name	VARCHAR
email	VARCHAR
password	VARCHAR
role	VARCHAR
created_at	TIMESTAMP
updated_at	TIMESTAMP
Table Orders
Field	Type
id	BIGINT
code	VARCHAR
customer	VARCHAR
service	VARCHAR
price	INT
status	VARCHAR
payment	VARCHAR
estimate	VARCHAR
service_count	VARCHAR
created_at	TIMESTAMP
updated_at	TIMESTAMP
Security Implementation
JWT Authentication
Password hashing menggunakan bcrypt
Input validation
CORS Configuration
API Testing

Menggunakan:

Postman

File:

docs/Postman_Collection.json
Screenshot

Dokumentasi tampilan aplikasi:

docs/screenshots/

├── login.png
├── dashboard.png
├── transaksi.png
└── detail.png
Author

Sakila Ananda Putri
