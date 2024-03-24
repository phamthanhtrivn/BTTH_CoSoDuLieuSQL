--Pham Thanh Tri
--TRUY VẤN ĐƠN GIẢN: TRUY VẤN TRÊN 1 TABLE
--Chọn tất cả các cột trong một bảng
USE Northwind
SELECT * FROM Customers
SELECT * FROM [dbo].[Order Details]
select * from [Order Details]
--Chọn một vài cột trong một bảng
SELECT * FROM EMPLOYEES
SELECT [EmployeeID],[LastName],[FirstName],[BirthDate],[Address] FROM Employees
--Kết nối các cột thành một cột
SELECT [EmployeeID],[LastName]+[FirstName],[BirthDate],[Address] FROM Employees
SELECT [EmployeeID],FULLNAME=[LastName]+' '+[FirstName],[BirthDate],[Address] FROM Employees
SELECT [EmployeeID],[LastName]+' '+[FirstName] AS FULLNAME,[BirthDate],[Address] FROM Employees
--Tạo cột tính toán
SELECT * FROM [ORDER DETAILS]
SELECT *,TOTAL =UnitPrice*Quantity FROM [ORDER DETAILS]
--Loại bỏ những dòng trùng nhau
SELECT DISTINCT CUSTOMERID FROM ORDERS
--Chỉ có n hàng đầu tiên hay n% của các hàng của bảng kết quả được xuất
SELECT * FROM Customers
--5 KH ĐẦU TIÊN
SELECT TOP 5 * FROM Customers
--5% KH ĐẦU TIÊN
SELECT TOP 10 PERCENT * FROM Customers
--DS NHÂN VIÊN GOM MANV, HOTEN, NGAY SINH , TUOI
select [EmployeeID],FULLNAME=LASTNAME +' '+FIRSTNAME, BIRTHDATE, TUOI FROM EMPLOYEES
SELECT GETDATE()
PRINT GETDATE()
PRINT YEAR(GETDATE())
SELECT  [EmployeeID],FULLNAME=[LastName]+' '+[FirstName],[BirthDate],TUOI=YEAR(GETDATE())-YEAR(BIRTHDATE),[Address] 
FROM Employees
--DS 3 NHÂN VIÊN CÓ TUỔI CAO NHẤT
SELECT [EmployeeID],FULLNAME=[LastName]+' '+[FirstName],[BirthDate],TUOI=YEAR(GETDATE())-YEAR(BIRTHDATE),[Address] 
FROM Employees
ORDER BY TUOI

SELECT [EmployeeID],FULLNAME=[LastName]+' '+[FirstName],[BirthDate],TUOI=YEAR(GETDATE())-YEAR(BIRTHDATE),[Address] 
FROM Employees
ORDER BY TUOI DESC

SELECT TOP  3 WITH TIES [EmployeeID],FULLNAME=[LastName]+' '+[FirstName],[BirthDate],TUOI=YEAR(GETDATE())-YEAR(BIRTHDATE),[Address] 
FROM Employees
ORDER BY TUOI DESC
--TRUY VẤN CÓ ĐIỀU KIỆN
SELECT * FROM CUSTOMERS

SELECT * FROM CUSTOMERS WHERE CUSTOMERID ='BOLID'
SELECT * FROM CUSTOMERS WHERE CUSTOMERID ='BOLID'OR CUSTOMERID ='ALFKI'OR CUSTOMERID='ANTON'
SELECT * FROM CUSTOMERS WHERE CUSTOMERID IN ('BOLID','ALFKI','ANTON')
--KH CÓ TÊN BẮT ĐẦU BẰNG CHỮ A
SELECT * FROM CUSTOMERS WHERE COMPANYNAME LIKE'A%'
SELECT * FROM CUSTOMERS WHERE COMPANYNAME LIKE '__A%'
SELECT * FROM CUSTOMERS WHERE PHONE LIKE '%[1-2]'
SELECT * FROM CUSTOMERS WHERE PHONE LIKE '%[^1-2]'
--KÝ TỰ CUỐI CÙNG A
SELECT * FROM CUSTOMERS WHERE COMPANYNAME LIKE '%A'
--CHỨA CHỮ A
SELECT * FROM CUSTOMERS WHERE COMPANYNAME LIKE '%A%'
--KÝ TỰ THỨ 2 LÀ A
SELECT * FROM CUSTOMERS WHERE COMPANYNAME LIKE '_A%'
SELECT * FROM CUSTOMERS WHERE COMPANYNAME LIKE '__A%'
--DS SẢN PHẨM CÓ DON GIÁ NHẬP TƯ 50 ĐẾN 100
SELECT * FROM Products WHERE [UnitPrice]>=50 AND UnitPrice<=100
SELECT * FROM Products WHERE [UnitPrice] BETWEEN 50 AND 100
--DS KH KG CÓ FAX
SELECT * FROM CUSTOMERS WHERE FAX IS NULL
----DS KH  CÓ FAX
SELECT * FROM CUSTOMERS WHERE FAX IS NOT NULL
PRINT LOWER('ABC')
PRINT UPPER('ABC')
PRINT LEFT('VUONG QUOC MINH HANG',5)
PRINT RIGHT('VUONG QUOC MINH HANG',4)
PRINT SUBSTRING('VUONG QUOC MINH HANG',7,4)
PRINT ASCII('A')
PRINT CHAR(100)
PRINT REVERSE('ABC')
PRINT DATEPART(DD,GETDATE())
PRINT DAY(GETDATE())
PRINT DATEPART(MM,GETDATE())
PRINT MONTH(GETDATE())
PRINT DATEPART(YY,GETDATE())
PRINT YEAR(GETDATE())
PRINT DATEPART(QQ,GETDATE())
PRINT DATEPART(DW,GETDATE())
SET DATEFORMAT DMY
PRINT DATEPART(DW,'18/10/2023')
PRINT DATEPART(DW,'1/1/2024')
--
--Viết lệnh thực hiện các truy vấn sau :
--1.  Liệt kê danh sách tất cả các mặt hàng (Products).
SELECT * FROM PRODUCTS
--2.  Liệt  kê  danh  sách  tất  cả  các  mặt  hàng  (Products).  Thông  tin  bao  gồm 
--ProductID, ProductName, UnitPrice.
SELECT PRODUCTID,PRODUCTNAME,UNITPRICE FROM PRODUCTS
--3.  Liệt  kê  danh  sách  các  nhân  viên  (Employees).  Thông  tin  bao  gồm 
--EmployeeID,  EmployeeName,  Phone,  Age.  Trong  đó  EmployeeName 
SELECT EMPLOYEEID,LastName +' '+ FIRSTNAME AS FULLNAME, YEAR(GETDATE()) - YEAR(BirthDate) AS AGE 
FROM EMPLOYEES
--được  ghép  từ  LastName  và  FirstName;  Age  là  tuổi  được  tính  dựa  trên
--năm hiện hành (GetDate()) và năm sinh.
--4.  Liệt  kê  danh  sách  các  khách  hàng  (Customers)  mà  người  đại  diện  có
--ContactTitle  bắt  đầu  bằng  chữ  ‘O’.  Thông  tin  bao  gồm  CustomerID, 
--CompanyName, ContactName, ContactTitle, City, Phone.
SELECT COMPANYNAME,CONTACTNAME,CONTACTTITLE,CITY,PHONE FROM CUSTOMERS
WHERE ContactTitle like 'O%'
--5.  Liệt kê danh sách  khách hàng (Customers)  ở thành phố LonDon, Boise 
--và Paris.
SELECT * FROM CUSTOMERS WHERE CITY = 'LonDon' OR CITY = 'Boise' OR CITY = 'Paris' 
--6.  Liệt kê danh sách khách hàng (Customers) có tên bắt đầu bằng chữ V mà 
--ở thành phố Lyon.
SELECT * FROM CUSTOMERS WHERE [ContactName] like 'v%' AND CITY = 'Lyon'
--7.  Liệt kê danh sách các khách hàng (Customers) không có số fax.
SELECT * FROM CUSTOMERS WHERE FAX IS NULL 
--8.  Liệt kê danh sách các khách hàng (Customers) có số Fax.
SELECT * FROM CUSTOMERS WHERE FAX is not NULL 
--9.  Liệt kê danh sách nhân viên (Employees) có năm sinh <=1960
SELECT * FROM EMPLOYEES WHERE YEAR([BirthDate]) <= 1960
--10.  Liệt kê danh sách các  sản phẩm (Products)  có  chứa chữ  ‘Boxes’ trong 
--cột QuantityPerUnit. 
SELECT * FROM Products WHERE QuantityPerUnit like '%Boxes%'
--11.  Liệt  kê  danh  sách  các  mặt  hàng  (Products)  có  đơn  giá  (Unitprice)  lớn 
--hơn 10 và nhỏ hơn 15. 
SELECT * FROM PRODUCTS WHERE Unitprice > 10 AND  Unitprice < 15
-- Liệt kê danh sách các mặt hàng (Products) có số lượng tồn nhỏ hơn 5.
SELECT * FROM PRODUCTS WHERE [UnitsInStock] < 5
--13.  Liệt kê danh sách các  mặt hàng  (Products)  ứng với tiền tồn vốn. Thông 
--tin  bao  gồm  ProductId,  ProductName,  Unitprice,  UnitsInStock,  Total. 
--Trong đó Total= UnitsInStock*Unitprice.  Được sắp xếp theo Total  giảm 
--dần.
SELECT ProductId, ProductName,Unitprice,UnitsInStock, UnitsInStock*Unitprice AS TOTAL FROM Products 
ORDER BY TOTAL DESC 
--14.  Hiển thị thông tin OrderID, OrderDate, CustomerID, EmployeeID của  2 
--hóa đơn có mã OrderID là ‘10248’ và ‘10250’
SELECT OrderID,OrderDate, CustomerID, EmployeeID FROM Orders WHERE ORDERID IN('10248','10250')
--15.  Liệt  kê  chi  tiết  của  hóa  đơn  có  OrderID  là  ‘10248’.  Thông  tin  gồm 
--OrderID,  ProductID,  Quantity,  Unitprice,  Discount,  ToTalLine  = 
--Quantity * unitPrice *(1-Discount) 
SELECT OrderID,  ProductID,Quantity, Unitprice,Discount, ToTalLine=Quantity*unitPrice*(1-Discount) FROM [dbo].[Order Details]
WHere  OrderID = '10248'
--16.  Liệt  kê  danh  sách  các  hóa  đơn  (orders)  có  OrderDate  được  lập  trong 
--tháng 9 năm 1996.  Được sắp xếp theo mã khách hàng, cùng mã khách 
--hàng sắp xếp theo ngày lập hóa đơn giảm dần.

SELECT * FROM ORDERS WHERE MONTH(ORDERDATE)=9 AND YEAR(ORDERDATE)=1996
ORDER BY CUSTOMERID, OrderDate DESC
--17.  Liệt kê danh sách các hóa đơn (Orders) được lập trong quý 4 năm 1997. 
--Thông  tin  gồm  OrderID,  OrderDate,  CustomerID,  EmployeeID.  Được 
--sắp xếp theo tháng của ngày lập hóa đơn.
SELECT  OrderID,  OrderDate,  CustomerID,  EmployeeID FROM Orders 
WHERE YEAR(OrderDate) = 1997 AND  DATEPART(QQ,Orderdate) = 4
--18.  Liệt kê danh sách các hóa đơn (Orders) được lập trong trong ngày thứ 7 
--và chủ nhật của tháng 12 năm 1997. Thông tin gồm OrderID, OrderDate, 
--Customerid,  EmployeeID,  WeekDayOfOrdate  (Ngày  thứ  mấy  trong 
--tuần). 
SELECT OrderID, OrderDate,Customerid,  EmployeeID,  WeekDayOfOrdate =  DATEPART(DW,OrderDate) FROM  Orders 
WHERE (DATEPART(DW,OrderDate) = 7 OR DATEPART(DW,OrderDate) = 1) AND  MONTH(OrderDate) = 12 AND YEAR(OrderDate) = 1997
--19.  Liệt kê danh sách 5 customers có city có ký tự bắt đầu  ‘M’.
SELECT TOP 5 * FROM CUSTOMERS 
WHERE City LIKE 'M%' 
--20.  Liệt  kê  danh  sách  2  employees  có  tuổi  lớn  nhất.  Thông  tin  bao  gồm 
--EmployeeID,  EmployeeName,  Age.  Trong  đó,  EmployeeName  được 
--ghép từ LastName và FirstName; Age là tuổi.
SELECT TOP 2 EmployeeID,  EmployeeName = LASTNAME +' ' + FIRSTNAME,  Age = YEAR(GETDATE()) - YEAR(BIRTHDATE) FROM EMPLOYEES
ORDER BY AGE DESC
--PHÂN 2: TRUY VẤN KẾT NỐI 
--BÀI TẬP 2: LỆNH SELECT – TRUY VẤN CÓ KẾT NỐI - TRUY VẤN TỪ NHIỀN BẢNG
--1.  Hiển  thị  thông  tin  về  hóa  đơn  có  mã  ‘10248’,  bao  gồm:  OrderID, 
--OrderDate,  CustomerID,  EmployeeID,  ProductID,  Quantity,  Unitprice, 
--Discount.
SELECT * FROM [Order Details]
SELECT  O.OrderID,OrderDate, CustomerID,EmployeeID,P.ProductID,Quantity, P.Unitprice,Discount
FROM [dbo].[Products] P  JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID
WHERE O.OrderID = '10248'
--2.  Liệt  kê  các  khách  hàng  có  lập  hóa  đơn  trong  tháng  7/1997  và  9/1997. 
--Thông  tin  gồm  CustomerID,  CompanyName,  Address,  OrderID, 
--Orderdate. Được sắp xếp theo CustomerID, cùng CustomerID thì sắp xếp 
--theo OrderDate giảm dần.
SELECT  C.CustomerID,CompanyName,Address,OrderID,Orderdate
FROM [dbo].[Customers] C JOIN  [dbo].[Orders] O ON C.CustomerID = O.CustomerID
WHERE (MONTH(O.OrderDate) = 7 AND  YEAR(O.OrderDate) = 1997) OR   (MONTH(O.OrderDate) = 9 AND  YEAR(O.OrderDate) = 1997)
--3.  Liệt kê danh sách các  mặt hàng  xuất bán vào ngày 19/7/1996. Thông tin 
--gồm : ProductID, ProductName, OrderID, OrderDate, Quantity.
SELECT P.ProductID, ProductName, O.OrderID, OrderDate, Quantity 
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON O.OrderID = OD.OrderID
WHERE DAY(O.OrderDate) = 19 AND MONTH(O.OrderDate) = 7 AND YEAR(O.OrderDate) = 1996
--4.  Liệt kê danh sách các mặt hàng từ nhà cung cấp (supplier) có mã 1,3,6 và
--đã  xuất  bán  trong  quý  2  năm  1997.  Thông  tin  gồm  :  ProductID, 
--ProductName,  SupplierID,  OrderID,  Quantity.  Được  sắp  xếp  theo  mã 
--nhà  cung  cấp  (SupplierID),  cùng  mã  nhà  cung  cấp  thì  sắp  xếp  theo 
--ProductID.
SELECT  P.ProductID,ProductName,  SupplierID,  O.OrderID,  Quantity
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON O.OrderID = OD.OrderID
WHERE P.SupplierID IN(1,3,6) AND DATEPART(QQ,O.ShippedDate) = 2 AND YEAR(O.ShippedDate) = 1997
SELECT PRODUCTS.ProductID, ProductName,  SupplierID,  ORDERS.OrderID,ShippedDate,  Quantity FROM Products JOIN [Order Details] ON PRODUCTS.PRODUCTID=[Order Details].ProductID
JOIN ORDERS ON ORDERS.ORDERID =[Order Details].ORDERID
WHERE [SupplierID] IN (1,3,6) AND DATEPART(QQ,ShippedDate)=2 AND YEAR([ShippedDate])=1997
ORDER BY SUPPLIERID, PRODUCTID





--5.  Liệt kê danh sách các mặt hàng có đơn giá bán bằng đơn giá mua.
SELECT * FROM [dbo].[Order Details]
SELECT OrderID,OD.UnitPrice,P.UnitPrice, P.ProductID,ProductName
FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
WHERE OD.UnitPrice = P.UnitPrice
--6.  Danh sách các  mặt hàng  bán trong ngày thứ 7 và chủ nhật của tháng 12 
--năm 1996, thông tin gồm ProductID, ProductName, OrderID, OrderDate, 
--CustomerID, Unitprice, Quantity, ToTal= Quantity*UnitPrice. Được sắp 
--xếp theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần.
SELECT  P.ProductID, ProductName, O.OrderID, OrderDate,C.CustomerID, P.Unitprice, Quantity, ToTal= Quantity*OD.UnitPrice
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON OD.OrderID = O.OrderID 
JOIN [dbo].[Customers] C ON C.CustomerID = O.CustomerID
ORDER BY P.ProductID,Quantity DESC
--7.  Liệt kê danh sách các nhân viên  đã lập hóa đơn trong tháng 7 của năm 
--1996.  Thông  tin  gồm  :  EmployeeID,  EmployeeName,  OrderID, 
--Orderdate.
SELECT E.EmployeeID,  EmployeeName = E.LastName +' '+ E.FirstName,  OrderID, Orderdate
FROM [dbo].[Orders] O JOIN [dbo].[Employees] E ON O.EmployeeID = E.EmployeeID
WHERE MONTH(O.OrderDate) = 7 AND YEAR(O.OrderDate) = 1996
--8.  Liệt kê danh sách các hóa đơn do nhân viên có Lastname  là  ‘Fuller’  lập.
--Thông tin gồm : OrderID, Orderdate, ProductID, Quantity, Unitprice.
SELECT O.OrderID, Orderdate, P.ProductID, Quantity, P.Unitprice,E.LastName
FROM  [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON O.OrderID = OD.OrderID
JOIN Employees E ON E.EmployeeID = O.EmployeeID
WHERE E.LastName = 'Fuller' 
--9.  Liệt kê chi tiết bán hàng của mỗi nhân viên theo từng hóa đơn  trong năm 
--1996. Thông tin  gồm:  EmployeeID, EmployName, OrderID, Orderdate, 
--ProductID, quantity, unitprice, ToTalLine=quantity*unitprice. 
SELECT E.EmployeeID, EmployName = E.LastName +' '+ E.FirstName, O.OrderID, Orderdate,P.ProductID, quantity, P.unitprice, ToTalLine=quantity*OD.unitprice
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID JOIN [dbo].[Orders] O ON O.OrderID = OD.OrderID
JOIN [dbo].[Employees] E ON E.EmployeeID = O.EmployeeID
WHERE YEAR(O.OrderDate) = 1996
--10.  Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm 
--1996. 
SELECT O.[OrderID],C.[CustomerID],[CompanyName], [EmployeeID],[OrderDate],[ShippedDate],P.[ProductID],[ProductName],OD.[UnitPrice],[Quantity],[Discount],TOTAL=OD.[UnitPrice]*[Quantity]-[Discount]
FROM CUSTOMERS C JOIN ORDERS O ON O.CUSTOMERID =C.CUSTOMERID JOIN [dbo].[Order Details] OD ON OD.OrderID=O.OrderID JOIN PRODUCTS P ON P.PRODUCTID=OD.ProductID
WHERE DATEPART(DW,[ShippedDate])=7 AND MONTH([ShippedDate])=12 AND YEAR([ShippedDate])=1996
--11.  Liệt  kê  danh  sách  các  nhân  viên  chưa  lập  hóa  đơn  (dùng  LEFT 
--JOIN/RIGHT JOIN).
SELECT E.EmployeeID,NAME = LASTNAME +' '+FirstName
FROM [dbo].[Employees] E LEFT JOIN [dbo].[Orders] O ON O.EmployeeID = E.EmployeeID
WHERE O.EmployeeID IS NULL
--12.  Liệt  kê  danh  sách  các  sản  phẩm  chưa  bán  được  (dùng  LEFT 
--JOIN/RIGHT JOIN).
SELECT P.[ProductID],[ProductName],[SupplierID],[CategoryID],[QuantityPerUnit] 
FROM Products P LEFT JOIN [dbo].[Order Details] OD ON P.ProductID =OD.ProductID
WHERE OD.ProductID IS NULL
--13.  Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
--JOIN/RIGHT JOIN).
SELECT C.[CustomerID], [CompanyName] FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL
