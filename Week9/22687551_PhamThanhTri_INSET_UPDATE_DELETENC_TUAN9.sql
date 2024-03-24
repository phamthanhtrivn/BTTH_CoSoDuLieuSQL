--1.	Dùng lệnh Insert…Select…
--Lệnh INSERT … SELECT …  cho phép nhập dữ liệu vào một bảng (bảng đích) bằng cách lấy 
--(truy vấn) dữ liệu từ bảng đã tồn tại (bảng nguồn). Bảng đích và bảng nguồn có thể nằm 
--trong cùng CSDL hay thuộc những CSDL khác nhau.
--Lưu ý : tập dữ liệu lấy từ bảng nguồn phải phù hợp cấu trúc, kiểu dữ liệu và ràng buộc 
--dữ liệu trên bảng đích.
--Áp dụng lệnh INSERT … SELECT … để nhập dữ liệu vào các bảng trong csdl QLBH dựa trên 
--dữ liệu trong csdl Northwind ? Kiểm tra kết quả sau mỗi lần thực hiện ?

--a.	Insert dữ liệu vào bảng KhachHang trong QLBH với dữ liệu nguồn là bảng Customers trong NorthWind.
INSERT QLBH..KhachHang
SELECT [CustomerID], CompanyName, NULL, Address, Phone, NULL, NULL
FROM Customers

SElECT * FROM QLBH..KHACHHANG
--b.	Insert dữ liệu vào bảng Sanpham trong QLBH. 
--Dữ liệu nguồn là các sản phẩm có SupplierID từ 4 đến 29 trong bảng Northwind.dbo.Products 
--SELECT..INTO TENBANG: TẠO 1 BẢNG MỚI MÀ DỮ LIỆU LẤY RA TỪ CÂU TRUY VẤN (BẢNG MỚI CHƯA CÓ)
--INSERT..SELECT:THÊM DỮ LIỆU VÀO 1 TABLE ĐÃ CÓ TỪ CÂU TRUY VẤN

--SanPham
INSERT QLBH..SanPham
SELECT [ProductID], [ProductName], [SupplierID], NULL, [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock]
FROM Products

SELECT * FROM QLBH..SanPham
--NhaCungCap
INSERT QLBH..NHACUNGCAP
SELECT [SupplierID], [CompanyName], [Address], [Phone], [Fax], NULL
FROM Suppliers

SELECT * FROM QLBH..NHACUNGCAP
--NhomSanPham
INSERT QLBH..NHOMSANPHAM
SELECT [CategoryID], [CategoryName]
FROM Categories

SELECT * FROM QLBH..NHOMSANPHAM

--c.	Insert dữ liệu vào bảng HoaDon trong QLBH. Dữ liệu nguồn là các hoá đơn có OrderID 
--nằm trong khoảng 10248 đến 10350 trong NorthWind.dbo.[Orders]
INSERT QLBH..HoaDon
SELECT [OrderID],NULL,[ShippedDate],[ShipAddress], [CustomerID], NULL
FROM Orders
WHERE OrderID BETWEEN 10248 AND 10350

SELECT * FROM QLBH..HoaDon
--d.	Insert dữ liệu vào bảng CT_HoaDon trong QLBH. Dữ liệu nguồn là các 
--chi tiết hoá đơn có OderID nằm trong khoảng 10248 đến 10350 trong NorthWind.dbo.[Order Detail]


INSERT QLBH..CT_HOADON
SELECT [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount]
FROM [Order Details]
WHERE OrderID BETWEEN 10248 AND 10350

SELECT * FROM QLBH..CT_HoaDon

--BÀI TẬP 2: LỆNH UPDATE
--Cú pháp 2: UPDATE <table_name>
--SET <column_name> = value , [, ...]
--FROM <table_name> [, ...]
--WHERE <condition>
--Sử dụng cú pháp 2 hoặc dùng subquery thực hiện các yêu cầu sau :
--1. Cập nhật chiết khấu 0.1 cho các mặt hàng trong các hóa đơn xuất bán
--vào ngày ‘1/1/1997’
SET DATEFORMAT DMY

UPDATE [Order Details]
SET [Discount] = 0.1
WHERE ProductID IN (SELECT ProductID 
					FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
					WHERE OrderDate = '1/1/1997')

SELECT * FROM [Order Details]

--2. Cập nhật đơn giá bán 17.5 cho mặt hàng có mã 11 trong các hóa đơn
--xuất bán vào tháng 2 năm 1997
UPDATE [Order Details]
SET UnitPrice = 17.5
WHERE OrderID IN (SELECT O.OrderID 
				FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
				WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 2 AND OD.ProductID = 11)

SELECT * FROM [Order Details]
--3. Cập nhật giá bán các sản phẩm trong bảng [Order Details] bằng với đơn
--giá mua trong bảng [Products] của các sản phẩm được cung cấp từ nhà
--cung cấp có mã là 4 hay 7 và xuất bán trong tháng 4 năm 1997
UPDATE [Order Details]
SET UnitPrice = P.UnitPrice
FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID
WHERE OrderID IN (SELECT O.OrderID 
				FROM Orders O 
				JOIN [Order Details] OD ON O.OrderID = OD.OrderID 
				JOIN Products P ON P.ProductID = OD.ProductID 
				JOIN Suppliers S ON S.SupplierID = P.SupplierID
				WHERE S.SupplierID BETWEEN 4 AND 7 AND YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 4)


--4. Cập nhật tăng phí vận chuyển (Freight) lên 20% cho những hóa đơn có
--tổng trị giá hóa đơn >= 10000 và xuất bán trong tháng 1/1997
UPDATE Orders
SET Freight = Freight + Freight * 0.2
WHERE EXISTS (SELECT O.OrderID, SUM(Quantity * UnitPrice)
				FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
				WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
				GROUP BY O.OrderID
				HAVING SUM(Quantity * UnitPrice) >= 10000)

--5. Thêm 1 cột vào bảng Customers lưu thông tin về loại thành viên :
--Member97 varchar(3) . Cập nhật cột Member97 là ‘VIP’ cho những
--khách hàng có tổng trị giá các đơn hàng trong năm 1997 từ 50000 trở
--lên.
ALTER TABLE Customers
	ADD Member97 VARCHAR(3)

UPDATE Customers
SET Member97 = 'VIP'
WHERE EXISTS (SELECT C.CustomerID, SUM(Quantity * UnitPrice)
				FROM Customers C 
				JOIN Orders O ON O.CustomerID = C.CustomerID
				JOIN [Order Details] OD ON OD.OrderID = O.OrderID
				WHERE YEAR(OrderDate) = 1997
				GROUP BY C.CustomerID
				HAVING SUM(Quantity * UnitPrice) > 50000)

--BÀI TẬP 3: LỆNH DELETE
--Cú pháp 2: DELETE FROM <table_name>
--FROM <table_name> [, ...]
--WHERE <condition>
--Sử dụng cú pháp 2 hoặc dùng subquery thực hiện các yêu cầu sau :
--HD : Các lệnh sau sẽ xóa những dòng dữ liệu trong [Order Details], là chi tiết
--của các hóa đơn bán cho khách hàng có mã ‘SANTG’ . Có thể sử dụng lệnh
--SELECT ... INTO ... để sao lưu những dòng này trước khi thực hiện lệnh xóa.

--1. Xóa các dòng trong [Order Details] có ProductID 24, là “chi tiết của
--hóa đơn” xuất bán cho khách hàng có mã ‘SANTG’
DELETE FROM [Order Details]
WHERE ProductID = 24 AND OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 'SANTG')

--2. Xóa các dòng trong [Order Details] có ProductID 35, là “chi tiết của
--hóa đơn” xuất bán trong năm 1998 cho khách hàng có mã ‘SANTG’
DELETE [Order Details]
WHERE ProductID = 35 AND OrderID IN (SELECT OrderID 
									FROM Orders 
									WHERE YEAR(OrderDate) = 1998 AND CustomerID = 'SANTG')

--3. Thực hiện xóa tất cả các dòng trong [Order Details] là “chi tiết của
--các hóa đơn” bán cho khách hàng có mã ‘SANTG’
DELETE [Order Details]
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 'SANTG')