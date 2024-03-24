--Pham Thanh Tri
--BÀI TẬP 4: LỆNH SELECT – TRUY VẤN LỒNG NHAU
--1.	Liệt kê các product có đơn giá mua lớn hơn đơn giá mua trung bình của tất cả các product.
SELECT P.ProductID, ProductName, OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.UnitPrice > (SELECT AVG(UnitPrice) FROM [Order Details])
--2.	Liệt kê các product có đơn giá mua lớn hơn đơn giá mua nhỏ nhất của tất cả các product.
SELECT ProductID, ProductName, UnitPrice
FROM Products 
WHERE UnitPrice > (SELECT MIN(UnitPrice) FROM Products)

--3.	Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product. 
--Thông tin gồm ProductID, ProductName, OrderID, Orderdate,  Unitprice .
SELECT P.ProductID, ProductName, O.OrderID, Orderdate,  OD.Unitprice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE OD.UnitPrice > (SELECT AVG(UnitPrice) FROM [Order Details])
--4.1	Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product 
--có ProductName bắt đầu là ‘N’.
SELECT P.[ProductID],[ProductName],[SupplierID],[CategoryID], DGB=OD.[UnitPrice] 
FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
WHERE OD.UnitPrice>
	(SELECT AVG(OD.[UnitPrice]) FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
	WHERE ProductName LIKE 'N%')
--đơn giá bán trung bình của các product có ProductName bắt đầu là ‘N’.
SELECT AVG(OD.[UnitPrice]) FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
 WHERE ProductName LIKE 'N%'
--
--4.2	Liệt kê các product có TEN BAT DAU BANG CHU N MA CO đơn giá 
--bán lớn hơn đơn giá bán trung bình của TAT CA các product 
SELECT DISTINCT P.[ProductID],[ProductName],[SupplierID],[CategoryID], DGB=OD.[UnitPrice] 
FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
WHERE ProductName LIKE 'N%' AND  OD.UnitPrice>(SELECT AVG(OD.[UnitPrice]) FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID)
--
--4.2	Liệt kê các product có TEN BAT DAU BANG CHU N MA CO đơn giá 
--bán lớn hơn đơn giá bán trung bình của TAT CA các product KHAC
SELECT DISTINCT P.[ProductID],[ProductName],[SupplierID],[CategoryID], DGB=OD.[UnitPrice] 
FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
WHERE ProductName LIKE 'N%' AND  OD.UnitPrice>(SELECT AVG(OD.[UnitPrice]) FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
WHERE ProductName NOT LIKE 'N%')



--đơn giá bán trung bình của các product có ProductName bắt đầu là ‘N’.
SELECT AVG(OD.[UnitPrice]) FROM [dbo].[Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID
 WHERE ProductName LIKE 'N%'
--5.	Cho biết những sản phẩm có tên bắt đầu bằng ‘T’ và có đơn giá bán lớn hơn đơn giá bán của (tất cả) 
--những sản phẩm có tên bắt đầu bằng chữ ‘V’.
SELECT P.ProductID, ProductName, OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE ProductName LIKE 'T%' AND OD.UnitPrice > 
	ALL(SELECT OD.UnitPrice FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID 
		WHERE ProductName LIKE 'T%')
--6.	Cho biết sản phẩm nào có đơn giá bán cao nhất trong số những sản phẩm có đơn vị tính có chứa chữ ‘box’ .
SELECT TOP 1 P.ProductID, ProductName, OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE (OD.UnitPrice) > ANY(SELECT OD.UnitPrice FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID WHERE QuantityPerUnit LIKE '%box%')
ORDER BY UnitPrice DESC
--7.	Liệt kê các product có tổng số lượng bán (Quantity) trong năm 1998 lớn hơn 
--tổng số lượng bán trong năm 1998 của mặt hàng có mã 71
SELECT P.ProductID, ProductName, SUM(OD.Quantity)
FROM [Order Details] OD JOIN Orders O ON O.OrderID = OD.OrderID JOIN Products P ON P.ProductID = OD.ProductID
WHERE YEAR(OrderDate) = 1998
GROUP BY P.ProductID, ProductName
HAVING SUM(OD.Quantity) > (SELECT SUM(OD.Quantity) 
							FROM [Order Details] OD JOIN Orders O ON O.OrderID = OD.OrderID JOIN Products P ON P.ProductID = OD.ProductID
							WHERE YEAR(OrderDate) = 1998 AND P.ProductID = 71)

--8.	Thực hiện :
---	Thống kê tổng số lượng bán ứng với mỗi mặt hàng thuộc nhóm hàng có CategoryID là 4. Thông tin : ProductID, QuantityTotal (tập A) 
WITH TAP_A AS 
(SELECT P.ProductID, QuantityTotal = SUM(OD.Quantity)
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryID = 4
GROUP BY P.ProductID),
---	Thống kê tổng số lượng bán ứng với mỗi mặt hàng thuộc nhóm hàng khác 4 . Thông tin : ProductID, QuantityTotal (tập B)
TAP_B AS
(SELECT P.ProductID, QuantityTotal = SUM(OD.Quantity)
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryID <> 4
GROUP BY P.ProductID)
---	Dựa vào 2 truy vấn trên : Liệt kê danh sách các mặt hàng trong tập A có QuantityTotal lớn hơn tất cả QuantityTotal của tập B
SELECT A.ProductID, A.QuantityTotal
FROM TAP_A A
WHERE A.QuantityTotal > ALL (SELECT QuantityTotal FROM TAP_B)
--9.	Danh sách các Product có tổng số lượng bán được lớn nhất trong năm 1998
--Lưu ý : Có nhiều phương án thực hiện các truy vấn sau (dùng JOIN hoặc subquery ). Hãy đưa ra phương án sử dụng subquery.
--SELECT ProductID, ProductName
--FROM Products
--WHERE ProductID IN (SELECT TOP 1 WITH TIES P.ProductID, QuantityTotal = SUM(OD.Quantity)
--						FROM Products P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
--						WHERE YEAR(OrderDate) = 1998
--						GROUP BY  P.ProductID
--						ORDER BY QuantityTotal DESC)
SELECT *
FROM Products
WHERE EXISTS (SELECT TOP 1 WITH TIES P.ProductID, SUM(OD.Quantity) AS TotalQuantity 
					FROM Products P 
					JOIN [Order Details] OD ON P.ProductID = OD.ProductID 
					JOIN Orders O ON O.OrderID = OD.OrderID
					WHERE YEAR(OrderDate) = 1998
					GROUP BY P.ProductID
					ORDER BY TotalQuantity DESC)
--10.	Danh sách các products đã có khách hàng mua hàng 
--(tức là ProductID có trong [Order Details]). Thông tin bao gồm ProductID, ProductName, Unitprice
SELECT DISTINCT P.ProductID, ProductName
FROM Products P 
WHERE P.ProductID IN (SELECT DISTINCT OD.ProductID FROM [Order Details] OD)
--11.	Danh sách các hóa đơn của những khách hàng ở thành phố LonDon và Madrid.
SELECT DISTINCT OrderID, C.CustomerID, CompanyName
FROM Orders O JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.CustomerID IN (SELECT CustomerID FROM Customers WHERE City IN ('LonDon', 'Madrid')) 
--12.	Liệt kê các sản phẩm có trên 20 đơn hàng trong quí 3 năm 1998, thông tin gồm ProductID, ProductName.
SELECT ProductID, ProductName
FROM Products
WHERE EXISTS (SELECT P.ProductID, COUNT(OD.OrderID)
					FROM [Order Details] OD 
					JOIN Orders O ON O.OrderID = OD.OrderID 
					JOIN Products P ON P.ProductID = OD.ProductID
					WHERE YEAR(OrderDate) = 1998 AND DATEPART(QQ, OrderDate) = 3 
					GROUP BY P.ProductID
					HAVING COUNT(OD.OrderID) >= 20)
--13.	Liệt kê danh sách các sản phẩm chưa bán được trong tháng 6 năm 1996
SELECT ProductID, ProductName
FROM Products P 
WHERE ProductID IN (SELECT DISTINCT P.ProductID 
						FROM Products P 
						JOIN [Order Details] OD ON P.ProductID = OD.ProductID 
						JOIN Orders O ON O.OrderID = OD.OrderID
						WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 6 AND OD.ProductID IS NOT NULL)
--14.	Liệt kê danh sách các Employes không lập hóa đơn vào ngày hôm nay
SELECT EmployeeID, EmployeeName = FirstName + ' ' + LastName
FROM Employees
WHERE EmployeeID IN (SELECT DISTINCT E.EmployeeID 
						FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID
						WHERE OrderDate <> GETDATE())
--15.	Liệt kê danh sách các Customers chưa mua hàng trong năm 1997
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT C.CustomerID
						FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID
						WHERE O.CustomerID IS NOT NULL AND YEAR(OrderDate) = 1997)
--16.	Tìm tất cả các Customers mua các sản phẩm có tên bắt đầu bằng chữ T trong tháng 7 năm 1997
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (SELECT O.CustomerID
					FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID JOIN Products P ON P.ProductID = OD.ProductID
					WHERE ProductName LIKE 'T%' AND YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 7)
--17.	Liệt kê danh sách các khách hàng mua các hóa đơn mà các hóa đơn này chỉ mua những sản phẩm có mã >=3 
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT O.CustomerID
					FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID JOIN Products P ON P.ProductID = OD.ProductID
					WHERE P.ProductID >= 3)
--18.	Tìm các Customer chưa từng lập hóa đơn (viết bằng ba cách: dùng NOT EXISTS, dùng  LEFT JOIN, 
--dùng NOT IN )
--NOT EXISTS
SELECT CustomerID, CompanyName
FROM Customers
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders 
    WHERE Orders.CustomerID = Customers.CustomerID
);
--LEFT JOIN
SELECT C.CustomerID, CompanyName
FROM Customers C LEFT JOIN Orders O ON O.CustomerID = C.CustomerID
WHERE O.CustomerID IS NULL

--NOT IN
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID
						FROM Orders)
--19.	Bạn hãy mô tả kết quả của các câu truy vấn sau ?

--Select ProductID, ProductName, UnitPrice  From [Products]
--Where Unitprice>ALL (Select Unitprice from [Products] where ProductName like ‘N%’)
	--Liệt kê các sản phẩm có giá bán lớn hơn giá bán của tất cả các sản phẩm có tên bắt đầu bằng 'N'

--Select ProductId, ProductName, UnitPrice  From [Products]
--Where Unitprice>ANY (Select Unitprice from [Products] where 
--ProductName like ‘N%’)
	--Liệt kê các sản phẩm có giá bán lớn hơn giá bán của một trong số các sản phẩm có tên bắt đầu bằng 'N'

--Select ProductId, ProductName, UnitPrice from [Products]
--Where Unitprice=ANY (Select Unitprice from [Products] where
-- ProductName like ‘N%’)
	--Liệt kê các sản phẩm có giá bán bằng giá bán của một trong số các sản phẩm có tên bắt đầu bằng 'N'

--Select ProductId, ProductName, UnitPrice from [Products]
--Where ProductName like ‘N%’ and 
--Unitprice>=ALL (Select Unitprice from [Products] where
-- ProductName like ‘N%’)
	--Liệt kê các sản phẩm có tên bắt đầu bằng N và có giá bán lớn hơn hoặc bằng giá bán của tất cả các sản phẩm có tên bắt đầu bằng 'N'

--BÀI TẬP 5: LỆNH SELECT – CÁC LOẠI TRUY VẤN KHÁC
--1. Sử dụng Select và Union để “hợp” tập dữ liệu lấy từ bảng Customers và
--Employees. Thông tin gồm CodeID, Name, Address, Phone. Trong đó
--CodeID là CustomerID/EmployeeID, Name là Companyname/LastName
--+ FirstName, Phone là Homephone.
SELECT CustomerID AS CodeID, CompanyName AS Name, Address, Phone
FROM Customers
UNION
SELECT CONVERT(NCHAR(5), EmployeeID) AS CodeID, FirstName + ' ' +  LastName AS Name, Address, HomePhone AS Phone
FROM Employees
--2. Dùng lệnh SELECT...INTO tạo bảng HDKH_71997 chứa thông tin về
--các khách hàng gồm : CustomerID, CompanyName, Address, ToTal
--=sum(quantity*Unitprice) , với total là tổng tiền khách hàng đã mua
--trong tháng 7 năm 1997.
SELECT C.CustomerID, CompanyName, Address, Total = SUM(Quantity * UnitPrice)
INTO HDKH_71997
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 7
GROUP BY C.CustomerID, CompanyName, Address

SELECT * FROM HDKH_71997
--3. Dùng lệnh SELECT...INTO tạo bảng LuongNV chứa dữ liệu về nhân
--viên gổm : EmployeeID, Name = LastName + FirstName, Address,
--ToTal =10%*sum(quantity*Unitprice) , với Total là tổng lương của nhân
--viên trong tháng 12 năm 1996.
SELECT E.EmployeeID, Name = LastName + ' ' + FirstName, Address, Total = 0.1 * SUM(Quantity * UnitPrice)
INTO LuongNV
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 12
GROUP BY E.EmployeeID, LastName, FirstName, Address

SELECT * FROM LuongNV
--4. Dùng lệnh SELECT...INTO tạo bảng Ger_USA chứa thông tin về các
--hóa đơn xuất bán trong quý 1 năm 1998 với địa chỉ nhận hàng thuộc các
--quốc gia (ShipCountry) là 'Germany' và 'USA', do công ty vận chuyển
--‘Speedy Express’ thực hiện.
SELECT [OrderID], [CustomerID], [EmployeeID], [OrderDate], [ShipCountry], [ShipVia], [CompanyName]
INTO Ger_USA
FROM Orders O JOIN Shippers S ON O.ShipVia = S.ShipperID
WHERE ShipCountry IN ('Germany', 'USA') AND CompanyName = 'Speedy Express' AND DATEPART(QQ, OrderDate) = 1 AND YEAR(OrderDate) = 1997

SELECT * FROM Ger_USA
--5. Pivot Query
--Tạo bảng dbo.HoaDonBanHang có cấu trúc sau
CREATE TABLE HoaDonBanHang( 
OrderID INT NOT NULL,
OrderDate DATE NOT NULL,
EmpID INT NOT NULL,
CustID VARCHAR(5) NOT NULL,
QTY INT NOT NULL,
CONSTRAINT PK_Orders2 PRIMARY KEY(OrderID)
)
--Chèn dữ liệu vào bảng
INSERT HoaDonBanHang VALUES
(30001, '20070802', 3, 'A', 10),
(10001, '20071224', 2, 'A', 12),
(10005, '20071224', 1, 'B', 20),
(40001, '20080109', 2, 'A', 40),
(10006, '20080118', 1, 'C', 14),
(20001, '20080212', 2, 'B', 12),
(40005, '20090212', 3, 'A', 10),
(20002, '20090216', 1, 'C', 20),
(30003, '20090418', 2, 'B', 15),
(30004, '20070418', 3, 'C', 22),
(30007, '20090907', 3, 'D', 30)
--a) Tính tổng Qty cho mỗi nhân viên. Thông tin gồm empid, custid
SELECT EmpID, CustID, SUM(QTY) AS TotalQTY
FROM HoaDonBanHang
GROUP BY EmpID, CustID
--b) Tạo bảng Pivot có dạng sau
--Gợi ý:
--SELECT empid, A, B, C, D
--FROM (SELECT empid, custid, qty
--FROM dbo.Orders) AS D
--PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P
--c) Tạo 1 query lấy dữ liệu từ bảng dbo.HoaDonBanHang trả về số hóa đơn
--đã lập của nhân viên employee trong mỗi năm.
--d) Tạo bảng pivot hiển thị số đơn đặt hàng được thực hiện bởi nhân viên có
--mã 1, 3, 4, 8, 9.