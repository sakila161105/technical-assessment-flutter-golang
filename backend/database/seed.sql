USE laundry_db;


INSERT INTO users
(
name,
email,
password,
role
)
VALUES
(
'Mario Wicaksono',
'admin@gmail.com',
'$2a$10$examplehashpassword',
'Owner'
);



INSERT INTO orders
(
code,
customer,
service,
price,
status,
payment,
estimate,
service_count
)
VALUES

(
'TRX-001',
'Bunda Ana',
'Cuci Setrika',
35000,
'Selesai',
'Lunas',
'Besok',
'3 Kg'
),


(
'TRX-002',
'Andi',
'Laundry Express',
50000,
'Diproses',
'Belum Lunas',
'Hari Ini',
'5 Kg'
);