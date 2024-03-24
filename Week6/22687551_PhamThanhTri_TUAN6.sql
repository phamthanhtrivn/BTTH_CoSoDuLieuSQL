--Pham Thanh Tri - 22687551
--Viết lệnh thực hiện các truy vấn sau :
--1. Liệt kê danh sách tất cả các mặt hàng (Products).
SELECT * 
FROM Products
--2. Liệt kê danh sách tất cả các mặt hàng (Products). Thông tin bao gồm
--ProductID, ProductName, UnitPrice.
SELECT ProductID, ProductName, UnitPrice
FROM Products
--3. Liệt kê danh sách các nhân viên (Employees). Thông tin bao gồm
--EmployeeID, EmployeeName, Phone, Age. Trong đó EmployeeName
--được ghép từ LastName và FirstName; Age là tuổi được tính dựa trên
--năm hiện hành (GetDate()) và năm sinh.
SELECT EmployeeID, LastName +' '+FirstName AS EmployeeName, HomePhone AS Phone, YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees
--4. Liệt kê danh sách các khách hàng (Customers) mà người đại diện có
--ContactTitle bắt đầu bằng chữ ‘O’. Thông tin bao gồm CustomerID,
--CompanyName, ContactName, ContactTitle, City, Phone.
SELECT CustomerID, CompanyName, ContactName, ContactTitle, City, Phone
FROM Customers
WHERE ContactTitle like 'O%'
--5. Liệt kê danh sách khách hàng (Customers) ở thành phố LonDon, Boise
--và Paris. 
SELECT * FROM Customers 
WHERE City IN ('LonDon', 'Boise', 'Paris')
--6. Liệt kê danh sách khách hàng (Customers) có tên bắt đầu bằng chữ V mà
--ở thành phố Lyon.
SELECT * 
FROM Customers
WHERE City = 'Lyon' AND ContactName LIKE 'V%'
--7. Liệt kê danh sách các khách hàng (Customers) không có số fax.
SELECT * 
FROM Customers
WHERE Fax IS NULL
--8. Liệt kê danh sách các khách hàng (Customers) có số Fax.
SELECT * 
FROM Customers  
WHERE Fax IS NOT NULL
--9. Liệt kê danh sách nhân viên (Employees) có năm sinh <=1960
SELECT * 
FROM Employees
WHERE YEAR(BirthDate) <= 1960
--10. Liệt kê danh sách các sản phẩm (Products) có chứa chữ ‘Boxes’ trong
--cột QuantityPerUnit.
SELECT * 
FROM Products
WHERE QuantityPerUnit LIKE '%Boxes%'
--11. Liệt kê danh sách các mặt hàng (Products) có đơn giá (Unitprice) lớn
--hơn 10 và nhỏ hơn 15.
SELECT * 
FROM Products 
WHERE UnitPrice > 10 AND UnitPrice < 15
--12. Liệt kê danh sách các mặt hàng (Products) có số lượng tồn nhỏ hơn 5.
SELECT * 
FROM Products
WHERE UnitsInStock < 5
--13. Liệt kê danh sách các mặt hàng (Products) ứng với tiền tồn vốn. Thông
--tin bao gồm ProductId, ProductName, Unitprice, UnitsInStock, Total.
--Trong đó Total= UnitsInStock*Unitprice. Được sắp xếp theo Total giảm
--dần.
SELECT ProductID, ProductName, UnitPrice, UnitsInStock, UnitsInStock *  UnitPrice AS Total
FROM Products
ORDER BY Total DESC
--14. Hiển thị thông tin OrderID, OrderDate, CustomerID, EmployeeID của 2
--hóa đơn có mã OrderID là ‘10248’ và ‘10250’
SELECT OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
WHERE OrderID IN ('10248', '10250')
--15. Liệt kê chi tiết của hóa đơn có OrderID là ‘10248’. Thông tin gồm
--OrderID, ProductID, Quantity, Unitprice, Discount, ToTalLine =
--Quantity * unitPrice *(1-Discount)
SELECT OrderID, ProductID, Quantity, Unitprice, Discount, Quantity * unitPrice *(1-Discount) AS ToTalLine
FROM [Order Details]
WHERE OrderID = '10248'
--16. Liệt kê danh sách các hóa đơn (orders) có OrderDate được lập trong
--tháng 9 năm 1996. Được sắp xếp theo mã khách hàng, cùng mã khách
--hàng sắp xếp theo ngày lập hóa đơn giảm dần.
SELECT *
FROM Orders
WHERE MONTH(OrderDate) = 9 AND YEAR(OrderDate) = 1996
ORDER BY CustomerID, OrderDate DESC
--17. Liệt kê danh sách các hóa đơn (Orders) được lập trong quý 4 năm 1997.
--Thông tin gồm OrderID, OrderDate, CustomerID, EmployeeID. Được
--sắp xếp theo tháng của ngày lập hóa đơn.
SELECT OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
WHERE YEAR(OrderDate) = 1997 AND DATEPART(QUARTER,OrderDate) = 4
ORDER BY  MONTH(OrderDate) 
--18. Liệt kê danh sách các hóa đơn (Orders) được lập trong trong ngày thứ 7
--và chủ nhật của tháng 12 năm 1997. Thông tin gồm OrderID, OrderDate,
--Customerid, EmployeeID, WeekDayOfOrdate (Ngày thứ mấy trong
--tuần).
SELECT OrderID, OrderDate, CustomerID, EmployeeID, DATENAME(WEEKDAY, OrderDate) AS WeekDayOfOrder
FROM Orders
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 12 AND (DATEPART(WEEKDAY, OrderDate) = 1 OR DATEPART(WEEKDAY, OrderDate) = 7)
--19. Liệt kê danh sách 5 customers có city có ký tự bắt đầu ‘M’.
SELECT TOP 5 *
FROM Customers
WHERE City LIKE 'M%'
--20. Liệt kê danh sách 2 employees có tuổi lớn nhất. Thông tin bao gồm
--EmployeeID, EmployeeName, Age. Trong đó, EmployeeName được
--ghép từ LastName và FirstName; Age là tuổi
SELECT TOP 2 EmployeeID, LastName +' '+FirstName AS EmployeeName, YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees
ORDER BY Age DESC

--BÀI TẬP 2: LỆNH SELECT – TRUY VẤN CÓ KẾT NỐI - TRUY VẤN TỪ NHIỀN BẢNG
--1.  Hiển  thị  thông  tin  về  hóa  đơn  có  mã  ‘10248’,  bao  gồm:  OrderID, 
--OrderDate,  CustomerID,  EmployeeID,  ProductID,  Quantity,  Unitprice, 
--Discount.
SELECT O.OrderID, OrderDate, CustomerID, EmployeeID, ProductID, Quantity, Unitprice, Discount
FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderID = '10248'
--2.  Liệt  kê  các  khách  hàng  có  lập  hóa  đơn  trong  tháng  7/1997  và  9/1997. 
--Thông  tin  gồm  CustomerID,  CompanyName,  Address,  OrderID, 
--Orderdate. Được sắp xếp theo CustomerID, cùng CustomerID thì sắp xếp 
--theo OrderDate giảm dần.
SELECT C.CustomerID, C.CompanyName, C.Address, O.OrderID, O.OrderDate
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID 
WHERE YEAR(OrderDate) = 1997 AND (MONTH(OrderDate) = 7 OR MONTH(OrderDate) = 9)
ORDER BY CustomerID, OrderDate DESC
--3.  Liệt kê danh sách các  mặt hàng  xuất bán vào ngày 19/7/1996. Thông tin 
--gồm : ProductID, ProductName, OrderID, OrderDate, Quantity.
SET DATEFORMAT DMY
SELECT P.ProductID, ProductName, O.OrderID, OrderDate, Quantity
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = O.OrderID
WHERE O.OrderDate = '19/7/1996'
--4.  Liệt kê danh sách các mặt hàng từ nhà cung cấp (supplier) có mã 1,3,6 và
--đã  xuất  bán  trong  quý  2  năm  1997.  Thông  tin  gồm  :  ProductID, 
--ProductName,  SupplierID,  OrderID,  Quantity.  Được  sắp  xếp  theo  mã 
--nhà  cung  cấp  (SupplierID),  cùng  mã  nhà  cung  cấp  thì  sắp  xếp  theo 
--ProductID.
SELECT P.ProductID, ProductName, SupplierID, O.OrderID, Quantity
FROM Products P JOIN [Order Details] OD ON OD.ProductID = P.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE (DATEPART(QQ, O.OrderDate) = 2 AND YEAR(O.OrderDate) = 1997) AND SupplierID IN (1, 3, 6)
ORDER BY SupplierID, ProductID
--5.  Liệt kê danh sách các mặt hàng có đơn giá bán bằng đơn giá mua.
SELECT P.ProductID, ProductName, P.UnitPrice AS 'Gia Mua', OrderID, OD.UnitPrice AS 'Gia Ban'
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE P.UnitPrice = OD.UnitPrice
--6.  Danh sách các  mặt hàng  bán trong ngày thứ 7 và chủ nhật của tháng 12 
--năm 1996, thông tin gồm ProductID, ProductName, OrderID, OrderDate, 
--CustomerID, Unitprice, Quantity, ToTal= Quantity*UnitPrice. Được sắp 
--xếp theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần.
SELECT P.ProductID, ProductName, O.OrderID, OrderDate, CustomerID, OD.Unitprice, Quantity, ToTal= Quantity*OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE (DATEPART(DW, OrderDate) = 7 OR DATEPART(DW, OrderDate) = 1) AND MONTH(O.OrderDate) = 12 AND YEAR(OrderDate) = 1996
ORDER BY ProductID, Quantity DESC
--7.  Liệt kê danh sách các nhân viên  đã lập hóa đơn trong tháng 7 của năm 
--1996.  Thông  tin  gồm  :  EmployeeID,  EmployeeName,  OrderID, 
--Orderdate.
SELECT E.EmployeeID,  EmployeeName = FirstName + ' ' + LastName, OrderID, Orderdate
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE MONTH(OrderDate) = 7 AND YEAR(OrderDate) = 1996
--8.  Liệt kê danh sách các hóa đơn do nhân viên có Lastname  là  ‘Fuller’  lập.
--Thông tin gồm : OrderID, Orderdate, ProductID, Quantity, Unitprice.
SELECT O.OrderID, Orderdate, ProductID, Quantity, Unitprice
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE E.LastName = 'Fuller'
--9.  Liệt kê chi tiết bán hàng của mỗi nhân viên theo từng hóa đơn  trong năm 
--1996. Thông tin  gồm:  EmployeeID, EmployName, OrderID, Orderdate, 
--ProductID, quantity, unitprice, ToTalLine=quantity*unitprice. 
SELECT E.EmployeeID, EmployName = FirstName + ' ' + LastName, O.OrderID, Orderdate, OD.ProductID, quantity, unitprice, ToTalLine=quantity*unitprice
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE YEAR(OrderDate) = 1996
--10.  Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm 
--1996. 
SELECT * FROM Orders
WHERE DATEPART(DW, ShippedDate) = 7 AND MONTH(ShippedDate) = 12 AND YEAR(ShippedDate) = 1996
--11.  Liệt  kê  danh  sách  các  nhân  viên  chưa  lập  hóa  đơn  (dùng  LEFT 
--JOIN/RIGHT JOIN).
SELECT E.EmployeeID, FullName = FirstName + ' ' + LastName
FROM Employees E LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE O.EmployeeID IS NULL
--12.  Liệt  kê  danh  sách  các  sản  phẩm  chưa  bán  được  (dùng  LEFT 
--JOIN/RIGHT JOIN).
SELECT P.ProductID, ProductName 
FROM Products P LEFT JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL
--13.  Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
--JOIN/RIGHT JOIN).
SELECT C.CustomerId, CompanyName
FROM Customers C LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL