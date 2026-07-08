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
│
│ ├── lib
│ │
│ │ ├── providers
│ │ │
│ │ ├── screens
│ │ │
│ │ ├── services
│ │ │
│ │ └── main.dart
│ │
│ └── pubspec.yaml
│
│
├── backend
│
│ ├── controllers
│ │
│ ├── models
│ │
│ ├── routes
│ │
│ ├── config
│ │
│ ├── migrations
│ │
│ └── main.go
│
│
├── database
│
├── docs
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

Backend berjalan pada:

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
Login menggunakan email dan password
JWT Authentication
Logout
Dashboard
Nama pengguna
Informasi outlet
Statistik transaksi
Ringkasan pendapatan
Transaction Management

CRUD transaksi:

Create transaksi
Read transaksi
Update transaksi
Delete transaksi
Fitur Tambahan
Search transaksi
Filter berdasarkan status
Pagination
Loading state
Empty state
API Documentation
Login

Method:

POST /login

Request:

{
    "email": "admin@gmail.com",
    "password": "123456"
}
Get All Orders

Method:

GET /items
Get Detail Order

Method:

GET /items/{id}
Create Order

Method:

POST /items
Update Order

Method:

PUT /items/{id}
Delete Order

Method:

DELETE /items/{id}
Database Design

Database menggunakan MySQL.

Table users
Field	Type
id	bigint
name	varchar
email	varchar
password	varchar
Table orders
Field	Type
id	bigint
code	varchar
customer	varchar
service	varchar
price	integer
status	varchar
payment	varchar
created_at	timestamp
Security Implementation

Implementasi keamanan:

JWT Authentication
Password hashing menggunakan bcrypt
Input validation
CORS configuration
Screenshot

Tambahkan screenshot aplikasi:

docs/screenshots/

├── login.png

├── dashboard.png

├── transaksi.png

└── detail.png

API Testing

API dapat diuji menggunakan:

Postman

Collection:

docs/Postman_Collection.json
Author

Nama:

sakila ananda putri

```powershell
git add README.md
