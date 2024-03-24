﻿--Pham Thanh Tri - 22687551
CREATE DATABASE QLBH
ON PRIMARY
	(NAME = 'QLBH_Data',
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week4\QLBH_Data.MDF',
	SIZE = 20, MAXSIZE = 40, FILEGROWTH = 1)
LOG ON
	(NAME = 'QLBH_Log',
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week4\QLBH_Log.LDF',
	SIZE = 10, MAXSIZE = 20, FILEGROWTH = 1)

USE QLBH

CREATE TABLE NHOMSANPHAM
	(MaNhom INT PRIMARY KEY,
	TenNhom NVARCHAR(15))

CREATE TABLE NhaCungCap
	(MaNCC INT PRIMARY KEY,
	TenNCC NVARCHAR(15) NOT NULL,
	DiaChi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50))

CREATE TABLE KHACHHANG
	(MaKH CHAR(5) PRIMARY KEY,
	TenKH NVARCHAR(40) NOT NULL,
	LoaiKH NVARCHAR(3) CHECK(LoaiKH IN('VIP', 'TV', 'VL')),
	DiaChi NVARCHAR(60),
	Phone NVARCHAR(24),
	DCMail NVARCHAR(50),
	DiemTL INT CHECK(DiemTL >= 0))

CREATE TABLE HOADON
	(MaHD INT PRIMARY KEY,
	NgayLapHD DATETIME DEFAULT GETDATE() CHECK(NgayLapHD >= GETDATE()),
	NgayGiao DATETIME,
	NoiChuyen NVARCHAR(60) NOT NULL,
	MaKH CHAR(5) REFERENCES KHACHHANG(MaKH))

CREATE TABLE SANPHAM
	(MaSP INT PRIMARY KEY,
	TenSP NVARCHAR(40) NOT NULL,
	MaNCC INT REFERENCES NhaCungCap(MaNCC),
	MoTa NVARCHAR(50),
	MaNhom INT REFERENCES NHOMSANPHAM(MaNhom),
	DonViTinh NVARCHAR(20))

CREATE TABLE CT_HoaDon
	(MaHD INT NOT NULL REFERENCES HOADON(MaHD),
	MaSP INT NOT NULL REFERENCES SANPHAM(MaSP),
	SoLuong SMALLINT CHECK(SoLuong > 0),
	DonGia MONEY,
	ChietKhau MONEY CHECK(ChietKhau >= 0),
	PRIMARY KEY(MaHD, MaSP))

ALTER TABLE HOADON
	ADD LoaiHD CHAR(1) DEFAULT 'N' CHECK(LoaiHD IN ('N', 'X', 'C', 'T'))

ALTER TABLE HOADON
	ADD CONSTRAINT NgayGiao CHECK(NgayGiao >= NgayLapHD)


--1. INSERT
--Bang NHOMSANPHAM
ALTER TABLE NHOMSANPHAM
	ALTER COLUMN TenNhom NVARCHAR(40)

INSERT NHOMSANPHAM VALUES
(1, N'Điện Tử'), 
(2, N'Gia Dụng'), 
(3, N'Dụng Cụ Gia Đình'), 
(4, N'Các Mặt Hàng Khác')
SELECT * FROM NHOMSANPHAM

--Bang NHACUNGCAP
INSERT NHACUNGCAP VALUES 
(1, N'Công Ty TNHH Nam Phương', N'1 Lê Lợi, Phường 4, Quận Gò Vấp', '083843456', '32343434', 'NamPhuong@yahoo.com'),
(2, N'Công Ty Lan Ngọc', N'12 Cao Bá Quát, Quận 1, Tp.Hồ Chí Minh', '086234567', '834834834', 'LanNhoc@gmail.com')
SELECT * FROM NHACUNGCAP

--Bang SANPHAM
INSERT SANPHAM VALUES 
(1, N'Máy Tính', 1, N'Máy Sony RAM 2 GB', 1, N'Cái', 70000, 100),
(2, N'Bàn phím', 1, N'bàn phím 101 phím', 1, N'Cái', 1000, 50),
(3, N'Chuột', 1, N'chuột không dây', 1, N'Cái', 800, 150),
(4, N'CPU', 1, N'CPU', 1, N'Cái', 3000, 200),
(5, N'USB', 1, N'8GB', 1, N'Cái', 500, 100)
INSERT SANPHAM (MaSP, TenSP, MaNCC, MaNhom, DonViTinh, GiaGoc, SLTon)VALUES (6, N'Lò Vi Sóng', 2, 3, N'Cái', 1000000, 20)
SELECT * FROM SANPHAM

--Bang KHACHHANG
INSERT KHACHHANG (MaKH, TenKH, DiaChi, LoaiKH) VALUES ('KH1', N'Nguyễn Thu Hằng', N'12 Nguyễn Du', 'VL')
INSERT KHACHHANG (MaKH, TenKH, DiaChi, Phone, LoaiKH, DCMail, DiemTL) VALUES ('KH2', N'Lê Minh', N'34 Điện Biên Phủ', '0123943455', 'TV', 'LeMinh@yahoo.com', 100)
INSERT KHACHHANG (MaKH, TenKH, DiaChi, Phone, LoaiKH, DCMail, DiemTL) VALUES ('KH3', N'Nguyễn Minh Trung', N'3 Lê Lợi Quận Gò Vấp', '098343434', 'VIP', 'Trung@gmail.com', 800)
SELECT * FROM KHACHHANG

--Bang HOADON
INSERT HOADON VALUES 
(1, '2023/10/5', '2023/10/7', N'Cửa Hàng ABC', 'KH1', 'N'),
(2, '2023/10/6', '2023/10/9', N'23 Lê Lợi', 'KH2', 'N'),
(3, '2023/10/7', '2023/10/8', N'2 Nguyễn Du', 'KH3', 'N')

--Bang CT_HoaDon
INSERT CT_HoaDon (MaHD, MaSP, DonGia, SoLuong) VALUES 
(1, 1, 8000, 5),
(1, 2, 1200, 4),
(1, 3, 1000, 15),
(2, 2, 1200, 9),
(2, 4, 800, 5),
(3, 2, 3500, 20),
(3, 3, 1000, 15)

--2. UPDATE
--a)
UPDATE CT_HoaDon 
SET DonGia = DonGia + 0.05 * DonGia 
WHERE MaSP = 2 

--b)
UPDATE SANPHAM
SET SLTon = 100
WHERE MaNhom = 3 AND MANCC = 2

--c)
UPDATE SANPHAM
SET MoTa = N'Hâm nóng thức ăn'
WHERE TenSP = N'Lò Vi Sóng'

--d)
UPDATE KHACHHANG
SET MaKH = 'VI003'
WHERE MaKH = 'KH3'

sp_helpconstraint HOADON 

ALTER TABLE HOADON 
	DROP CONSTRAINT FK__HOADON__MaKH__534D60F1

ALTER TABLE HOADON 
	ADD CONSTRAINT FK__HOADON__MaKH__1A14E395 FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH) 
	ON UPDATE CASCADE
	ON DELETE CASCADE

--e)
UPDATE KHACHHANG
SET MaKH = 'VL001'
WHERE MaKH = 'KH1'

UPDATE KHACHHANG
SET MaKH = 'T0002'
WHERE MaKH = 'KH2'

--3.
--a)
DELETE FROM NHOMSANPHAM WHERE MaNhom = 4 

--b)
DELETE FROM CT_HoaDon WHERE  MaHD = 1 AND MaSP = 3

--c)
DELETE FROM HOADON WHERE MaHD = 1

sp_helpconstraint CT_HoaDon

ALTER TABLE CT_HoaDon
	DROP CONSTRAINT FK__CT_HoaDon__MaHD__5BE2A6F2

ALTER TABLE CT_HoaDon
	ADD CONSTRAINT  FK_CT_HoaDon_MaHD  FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD)
	ON DELETE CASCADE
	ON UPDATE CASCADE

--d)
DELETE FROM HOADON WHERE MaHD = 2

