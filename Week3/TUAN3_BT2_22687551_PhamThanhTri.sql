--1. Tao CSDL Movies
CREATE DATABASE Movies
ON PRIMARY
	(NAME = 'Movies_data',
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week3\Movies_data.MDF',
	SIZE = 25, MAXSIZE = 40, FILEGROWTH = 1)
LOG ON
	(NAME = 'Movies_log',
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week3\Movies_log.LDF',
	SIZE = 6, MAXSIZE = 8, FILEGROWTH = 1)

USE Movies

                                                                                                                                                                                    
ALTER DATABASE Movies 
ADD FILE (NAME = 'Movies_data2',
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week3\Movies_data2.NDF',
	SIZE = 10)

sp_helpdb Movies

ALTER DATABASE Movies
	MODIFY FILE (NAME = 'Movies_data2', SIZE = 15MB)

ALTER DATABASE Movies
	ADD FILEGROUP DataGroup

ALTER DATABASE Movies
	MODIFY FILE (NAME = 'Movies_log', MAXSIZE = 10MB)

ALTER DATABASE Movies
	ADD FILE (NAME = 'Movies_data3',
			FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week3\Movies_data3.NDF',
			SIZE = 10, MAXSIZE = 20, FILEGROWTH = 1) TO FILEGROUP DataGroup

--2. Tao Bang

EXEC sp_addtype 'Movie_num', 'INT', 'NOT NULL'
EXEC sp_addtype 'Category_num', 'INT', 'NOT NULL'
EXEC sp_addtype 'Cust_num', 'INT', 'NOT NULL'
EXEC sp_addtype 'Invoice_num', 'INT', 'NOT NULL'

sp_help Movies

CREATE TABLE Customer
	(Cust_num Cust_num IDENTITY(300, 1) NOT NULL,
	 Lname VARCHAR(20) NOT NULL,
	 Fname VARCHAR(20) NOT NULL,
	 Address1 VARCHAR(30),
	 Address2 VARCHAR(20),
	 City VARCHAR(20),
	 State CHAR(2),
	 Zip CHAR(10),
	 Phone CHAR(10) NOT NULL,
	 Join_date SMALLDATETIME NOT NULL)

CREATE TABLE Category
	(Category_num Category_num IDENTITY(1, 1) NOT NULL,
	 Description VARCHAR(20) NOT NULL)

CREATE TABLE Movie
	(Movie_num Movie_num NOT NULL,
	 Title Cust_num NOT NULL,
	 Category_Num Category_num NOT NULL,
	 Date_purch SMALLDATETIME,
	 Rental_price INT,
	 Rating CHAR(5))

CREATE TABLE Rental
	(Invoice_num Invoice_num NOT NULL,
	 Cust_num Cust_num NOT NULL,
	 Rental_date SMALLDATETIME NOT NULL,
	 Due_date SMALLDATETIME NOT NULL)

CREATE TABLE Rental_Detail
	(Invoice_num Invoice_num NOT NULL,
	 Line_num INT NOT NULL,
	 Movie_num Movie_num NOT NULL,
	 Rental_price SMALLMONEY NOT NULL)

--3. Khoa Chinh
sp_helpconstraint Movie
ALTER TABLE Movie
	ADD CONSTRAINT PK_movie PRIMARY KEY (Movie_num)

sp_helpconstraint Customer
ALTER TABLE Customer
	ADD CONSTRAINT PK_customer PRIMARY KEY (Cust_num)

sp_helpconstraint Category
ALTER TABLE Category
	ADD CONSTRAINT PK_category PRIMARY KEY (Category_num)

sp_helpconstraint Rental
ALTER TABLE Rental
	ADD CONSTRAINT PK_rental PRIMARY KEY (Invoice_num)

--4. Khoa ngoai
sp_helpconstraint Movie
ALTER TABLE Movie
	ADD CONSTRAINT FK_movie FOREIGN KEY (Category_num) REFERENCES Category(Category_num)

sp_helpconstraint Rental
ALTER TABLE Rental
	ADD CONSTRAINT FK_rental FOREIGN KEY (Cust_num) REFERENCES Customer(Cust_num) 

sp_helpconstraint Rental_detail
ALTER TABLE Rental_detail
	ADD CONSTRAINT FK_detail_invoice FOREIGN KEY (Invoice_num) REFERENCES Rental(Invoice_num) ON DELETE CASCADE
ALTER TABLE Rental_detail                
	ADD CONSTRAINT PK_detail_movie FOREIGN KEY (Movie_num) REFERENCES Movie(Movie_num)

--4. Default Constraint
sp_helpconstraint Movie
ALTER TABLE Movie
	ADD CONSTRAINT DK_movie_date_purch DEFAULT GETDATE() FOR Date_purch 

sp_helpconstraint Customer
ALTER TABLE Customer 
	ADD CONSTRAINT DK_customer_join_date DEFAULT GETDATE() FOR join_date

sp_helpconstraint Rental
ALTER TABLE Rental
	ADD CONSTRAINT DK_rental_rental_date DEFAULT GETDATE() FOR Rental_date

ALTER TABLE Rental
	ADD CONSTRAINT DK_rental_due_date DEFAULT GETDATE() + 2 FOR Due_date

--5. Check Constraint
sp_helpconstraint Movie
ALTER TABLE Movie
	ADD CONSTRAINT CK_movie CHECK (Rating IN ('G', 'PG', 'R', 'NC17', 'NR'))

sp_helpconstraint Rental
ALTER TABLE Rental
	ADD CONSTRAINT CK_Due_date CHECK(Due_date >= Rental_date)

