
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