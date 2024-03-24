--22687551 - Pham Thanh Tri
USE NorthWnd
--1). CHO BIET TONG TIEN CUA TUNG HÓA ĐƠN
SELECT DISTINCT OrderID FROM [Order Details]
SELECT  TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details]
--
SELECT [OrderID], TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details]
GROUP BY [OrderID]
--
SELECT [OrderID], [ProductID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details]
GROUP BY [OrderID], [ProductID] --SAI
--
SELECT O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
--
SELECT OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
--
--
SELECT OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID] --SAI
--
--TRUNG BINH
SELECT [OrderID], AVG =AVG([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details]
GROUP BY [OrderID]

SELECT OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL_TB =AVG([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
--GIÁ TRỊ THÀNH TIỀN LỚN NHẤT CỦA TỪNG HÓA ĐƠN 

SELECT OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],GTLN =MAX([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
--CHO BIẾT HÓA ĐƠN NÀO CÓ THÀNH TIỀN LỚN NHẤT
SELECT TOP 1 WITH TIES OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],THANHTIENLN =([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
ORDER BY THANHTIENLN DESC
--CHO BIẾT HÓA ĐƠN NÀO CÓ TỔNG TIỀN THÀNH TIỀN LỚN NHẤT
SELECT TOP 1 WITH TIES O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
ORDER BY TOTAL DESC

--GIÁ TRỊ THÀNH TIỀN NHỎ NHẤT CỦA TỪNG HÓA ĐƠN 

SELECT OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],GTNN =MIN([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY OD.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]

--ĐIỀU KIỆN : NẾU LỌC XONG MỚI DÙNG CÁC HÀM THỐNG KÊ THÌ SỬ DỤNG MỆNH ĐỀ WHERE
--CHO BIẾT TỔNG TIỀN CÁC HD ĐC LÂP TRONG 10/1997
SELECT O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
WHERE MONTH([OrderDate])=10 AND YEAR([OrderDate])=1997
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
--ĐIỀU KIỆN XẢY RA SAU KHI THỐNG KÊ  MỆNH ĐỀ HAVING
--CHO BIẾT CÁC HÓA ĐƠN CÓ TỔNG TIỀN LỚN HƠN 2000
SELECT O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
HAVING TOTAL>2000--SAI
--
SELECT O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
HAVING SUM([UnitPrice]*[Quantity]) >2000
--CHO BIẾT CÁC HÓA ĐƠN CÓ TỔNG TIỀN LỚN HƠN 2000 ĐƯỢC LẬP TRONG 10/1997
SELECT O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
WHERE MONTH([OrderDate])=10 AND YEAR([OrderDate])=1997
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
HAVING SUM([UnitPrice]*[Quantity]) >2000
----CHO BIẾT CÁC HÓA ĐƠN CÓ TỔNG TIỀN LỚN HƠN 2000 ĐƯỢC LẬP TRONG 10/1997 ĐƯỢC SẮP XẾP THEO MAKH, CUNG MAKH THEO TONG TIEN GIAM DẤN
SELECT O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID],TOTAL =SUM([UnitPrice]*[Quantity]) 
FROM [dbo].[Order Details] OD JOIN Orders O ON O.OrderID=OD.OrderID
WHERE MONTH([OrderDate])=10 AND YEAR([OrderDate])=1997
GROUP BY O.[OrderID],[OrderDate] ,[CustomerID],[EmployeeID]
HAVING SUM([UnitPrice]*[Quantity]) >2000
ORDER BY CustomerID,TOTAL DESC
--
--BÀI TẬP 3: LỆNH SELECT – TRUY VẤN GOM NHÓM
--1.  Liệt kê danh sách các orders ứng với tổng tiền của từng hóa đơn. Thông tin 
--bao gồm OrderID, OrderDate, Total. Trong đó Total  là Sum của Quantity * 
--Unitprice, kết nhóm theo OrderID.
SELECT O.OrderID, OrderDate, Total = SUM(Quantity * UnitPrice)
FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, OrderDate
--2.  Liệt kê danh sách các orders  mà địa chỉ nhận hàng ở  thành phố    ‘Madrid’
--(Shipcity). Thông tin bao gồm OrderID, OrderDate, Total. Trong đó Total
--là tổng trị giá hóa đơn, kết nhóm theo OrderID. 
SELECT O.OrderID, OrderDate, Total = SUM(Quantity * UnitPrice)
FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE ShipCity = 'Madrid'
GROUP BY O.OrderID, OrderDate
--3.  Viết các truy vấn để thống kê số lượng các hóa đơn : 
---  Trong mỗi năm. Thông tin hiển thị : Year , CoutOfOrders ?
SELECT YEAR(OrderDate) AS YEAR, COUNT(OrderID) AS CountOdOrder
FROM Orders
GROUP BY  YEAR(OrderDate)
---  Trong  mỗi  tháng/năm  .  Thông  tin  hiển  thị  :  Year  ,  Month, 
--CoutOfOrders ?
SELECT YEAR(OrderDate) AS YEAR, MONTH(OrderDate) AS MONTH, COUNT(OrderID) AS CountOfOrders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
---  Trong mỗi tháng/năm và ứng với mỗi nhân viên. Thông tin hiển 
--thị : Year, Month, EmployeeID, CoutOfOrders ?
SELECT YEAR(OrderDate) AS YEAR, MONTH(OrderDate) AS MONTH, EmployeeID, COUNT(OrderID) AS CountofOrder
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate), EmployeeID
--4.  Cho  biết  mỗi  Employee  đã  lập  bao  nhiêu  hóa  đơn.  Thông  tin  gồm 
--EmployeeID,  EmployeeName,  CountOfOrder. Trong đó CountOfOrder là 
--tổng  số  hóa  đơn  của  từng  employee.  EmployeeName  được  ghép  từ 
--LastName và FirstName.
SELECT E.EmployeeID,  EmployeeName = FirstName + ' ' + LastName, COUNT(OrderID) AS CountOfOrder
FROM Employees E LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, FirstName, LastName
--5.  Cho biết mỗi Employee đã lập được bao nhiêu hóa đơn, ứng với tổng tiền
--các  hóa  đơn  tương  ứng.  Thông  tin  gồm  EmployeeID,  EmployeeName, 
--CountOfOrder , Total.
SELECT  E.EmployeeID,  EmployeeName = FirstName + ' ' + LastName, COUNT(DISTINCT O.OrderID) AS CountOfOrder , Total = SUM(Quantity * UnitPrice)
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID,  FirstName, LastName
--6.  Liệt  kê  bảng  lương  của  mỗi  Employee  theo  từng  tháng  trong  năm  1996 
--gồm  EmployeeID,  EmployName,  Month_Salary,  Salary  = 
--sum(quantity*unitprice)*10%.  Được  sắp  xếp  theo  Month_Salary,  cùmg 
--Month_Salary thì sắp xếp theo Salary giảm dần.
SELECT E.EmployeeID,  EmployName = FirstName + ' ' + LastName, MONTH(OrderDate) AS Month_Salary,  Salary = SUM(quantity*unitprice)*0.1
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(OrderDate) = 1996
GROUP BY E.EmployeeID, FirstName, LastName, MONTH(OrderDate)
ORDER BY Month_Salary, Salary DESC
--7.  Tính tổng số hóa đơn và tổng tiền các hóa đơn  của mỗi nhân viên đã bán 
--trong  tháng  3/1997,  có  tổng  tiền  >4000.  Thông  tin  gồm  EmployeeID, 
--LastName, FirstName, CountofOrder, Total.
SELECT E.EmployeeID, LastName, FirstName, count(distinct O.OrderID) AS CountofOrder, Total = SUM(Quantity * UnitPrice)
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE MONTH(OrderDate) = 3 AND YEAR(OrderDate) = 1997
GROUP BY E.EmployeeID, LastName, FirstName
HAVING SUM(Quantity * UnitPrice) > 4000
--8.  Liệt kê danh sách các customer ứng với tổng số hoá đơn, tổng tiền các hoá 
--đơn, mà các hóa đơn được lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các 
--hóa  đơn  >20000.  Thông  tin  được  sắp  xếp  theo  CustomerID,  cùng  mã  thì 
--sắp xếp theo tổng tiền giảm dần.
SET DATEFORMAT DMY
SELECT C.CustomerId, CompanyName, COUNT(DISTINCT O.OrderId) AS CountOfOrder, SUM(Quantity * UnitPrice) AS Total
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE OrderDate >= '31/12/1996' AND OrderDate <= '1/1/1998'
GROUP BY C.CustomerID, CompanyName
HAVING SUM(Quantity * UnitPrice) > 20000
ORDER BY C.CustomerID, Total DESC
--9.  Liệt kê danh sách các customer ứng với tổng tiền của các hóa đơn ở từng 
--tháng.  Thông  tin  bao  gồm  CustomerID,  CompanyName,  Month_Year, 
--Total. Trong đó Month_year là tháng và năm lập hóa đơn, Total là tổng của 
--Unitprice* Quantity.
SELECT C.CustomerID,  CompanyName, CONCAT(MONTH(OrderDate), '/',YEAR(OrderDate)) AS Month_Year, Total = SUM(Quantity * UnitPrice)
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID,  CompanyName, MONTH(OrderDate), YEAR(OrderDate)
--10.  Liệt  kê  danh  sách  các  nhóm  hàng  (category)  có  tổng  số  lượng  tồn 
--(UnitsInStock) lớn hơn 300, đơn giá trung bình nhỏ hơn 25. Thông tin bao 
--gồm CategoryID, CategoryName, Total_UnitsInStock, Average_Unitprice.
SELECT C.CategoryID, CategoryName, Total_UnitsInStock = SUM(UnitsInStock), Average_Unitprice = AVG(UnitPrice)
FROM Categories C JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID, CategoryName
HAVING SUM(UnitsInStock) > 300 AND AVG(UnitPrice) < 25
--11.  Liệt kê danh sách các  nhóm hàng (category)  có tổng số  mặt hàng  (product)
--nhỏ  hớn  10.  Thông  tin  kết  quả  bao  gồm  CategoryID,  CategoryName, 
--CountOfProducts.  Được sắp xếp theo CategoryName, cùng  CategoryName
--thì sắp theo CountOfProducts giảm dần.
SELECT C.CategoryID,  CategoryName, COUNT(ProductID) AS CountOfProducts
FROM Categories C JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID,  CategoryName
HAVING COUNT(ProductID) < 10
ORDER BY CategoryName, CountOfProducts DESC
--12.  Liệt kê danh sách các  Product  bán trong  quý  1 năm 1998 có tổng số lượng 
--bán ra >200, thông tin gồm [ProductID], [ProductName], SumofQuatity 
SELECT P.ProductID, ProductName, SUM(OD.Quantity) AS SumOfQuantity
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE DATEPART(QQ, OrderDate) = 1 AND YEAR(OrderDate) = 1998
GROUP BY P.ProductID, ProductName
HAVING SUM(OD.Quantity) > 200
--13.  Cho biết Employee nào bán được nhiều tiền nhất trong tháng 7 năm 1997
SELECT TOP 1 WITH TIES E.EmployeeID, EmployeeName = FirstName + ' '+ LastName, Total = Quantity * UnitPrice
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 7
ORDER BY Total DESC
--14.  Liệt kê danh sách 3 Customer có nhiều đơn hàng nhất của năm 1996.
SELECT TOP 3 WITH TIES C.CustomerID, CompanyName, Count(*) AS CountOfOrder
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(OrderDate) = 1996
GROUP BY C.CustomerID, CompanyName
ORDER BY COUNT(*) DESC
--15.  Liệt  kê  danh  sách  các  Products  có  tổng  số  lượng  lập  hóa  đơn  lớn  nhất.
--Thông tin gồm ProductID, ProductName, CountOfOrders.
SELECT TOP 1 WITH TIES P.ProductID, ProductName, COUNT(OrderID) AS CountOfOrders
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID 
GROUP BY P.ProductID, ProductName
ORDER BY COUNT(OrderID) DESC