--SU DUNG CSDL SV1
USE SV1
--TẠO TABLE CHƯA CÓ RÀNG BUỘC
CREATE TABLE Sanpham 
( Masp CHAR(5), 
  Tensp VARCHAR(15), Dvt VARCHAR(10), Dongia SMALLMONEY, SlTon INT ) 
--Tạo cột có giá trị phát sinh tự động
CREATE TABLE NhaCungCap
	(MaNCC int Identity NOT NULL Primary key, TenNCC VarChar(25)) 
----Tạo cột có giá trị phát sinh tự động
CREATE TABLE NhaCungCap1
	(MaNCC int Identity(3,5) NOT NULL Primary key, TenNCC VarChar(25)) 
--Cột tính toán - Computed column

CREATE TABLE cthoadon
( 		sohd int NOT NULL,
		MaHang char(5) NOT NULL,
		SoLuong int NOT NULL,
		DonGia money,
		ThanhTien AS SoLuong*DonGia
)
--THÊM CỘT
ALTER TABLE SanPham
	ADD NgayNhap SmallDateTime 
--SỬA DỮ LIỆU CHO CỘT
ALTER TABLE SANPHAM
	ALTER COLUMN NGAYNHAP DATE
--XÓA CỘT
ALTER TABLE SanPham
	DROP COLUMN NgayNhap 
--THÊM CỘT MANCC
ALTER TABLE SanPham
	ADD MANCC INT
--TẠO RÀNG BUỘC KHOÁ CHÍNH
ALTER TABLE SanPham
	ADD PRIMARY KEY (MASP)
ALTER TABLE SanPham
	ALTER COLUMN MASP CHAR(5)NOT NULL
--TẠO KHÓA NGOẠI
ALTER TABLE SanPham
	ADD FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC)