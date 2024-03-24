--BÀI TẬP 4: LỆNH SELECT – TRUY VẤN LỒNG NHAU
--1. Liệt kê các product có đơn giá mua lớn hơn đơn giá mua trung bình của
--tất cả các product.

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
--ORDER BY ProductID

--2. Liệt kê các product có đơn giá mua lớn hơn đơn giá mua nhỏ nhất của tất
--cả các product.

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT MIN(UnitPrice) FROM Products)

--3. Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của
--các product. Thông tin gồm ProductID, ProductName, OrderID,
--Orderdate, Unitprice.

SELECT P.ProductID, ProductName, O.OrderID, OrderDate, OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON OD.OrderID = O.OrderID
WHERE OD.UnitPrice > (SELECT AVG(UnitPrice) FROM [Order Details])
--ORDER BY ProductID

--4. Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của
--các product có ProductName bắt đầu là ‘N’.

SELECT P.ProductID, ProductName, OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.UnitPrice > (SELECT AVG(UnitPrice) FROM [Order Details]) AND ProductName LIKE 'N%'

--5. Cho biết những sản phẩm có tên bắt đầu bằng ‘T’ và có đơn giá bán lớn
--hơn đơn giá bán của (tất cả) những sản phẩm có tên bắt đầu bằng chữ
--‘V’.

SELECT P.ProductID, ProductName, OD.UnitPrice
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
WHERE ProductName LIKE 'T%' 
AND OD.UnitPrice > ALL(SELECT OD.UnitPrice FROM [Order Details] OD JOIN Products P ON OD.ProductID = P.ProductID WHERE ProductName LIKE 'V%')

--6. Cho biết sản phẩm nào có đơn giá bán cao nhất trong số những sản phẩm
--có đơn vị tính(QuantityPerUnit) có chứa chữ ‘box’ .

SELECT TOP 1 WITH TIES ProductID, ProductName, UnitPrice
FROM Products
WHERE QuantityPerUnit LIKE '%box%'
ORDER BY UnitPrice DESC

--7. Liệt kê các product có tổng số lượng bán (Quantity) trong năm 1998 lớn
--hơn tổng số lượng bán trong năm 1998 của mặt hàng có mã 71

SELECT P.ProductID, ProductName, SUM(OD.Quantity) AS TotalQuantity
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderDate = OD.OrderID
WHERE YEAR(OrderDate) = 1998
GROUP BY P.ProductID, ProductName
HAVING SUM(OD.Quantity) > (SELECT SUM(Quantity) FROM [Order Details] OD JOIN Orders O ON OD.OrderID = O.OrderID WHERE P.ProductID = 71 AND YEAR(OrderDate) = 1998)
--8. Thực hiện :
--- Thống kê tổng số lượng bán ứng với mỗi mặt hàng thuộc nhóm
--hàng có CategoryID là 4. Thông tin : ProductID, QuantityTotal
--(tập A)
WITH TAP_A AS (
	SELECT P.ProductID, SUM(Quantity) AS QuantityTotal
	FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
	WHERE CategoryID = 4
	GROUP BY P.ProductID),	
--- Thống kê tổng số lượng bán ứng với mỗi mặt hàng thuộc nhóm
--hàng khác 4 . Thông tin : ProductID, QuantityTotal (tập B)
TAP_B AS (
	SELECT P.ProductID, SUM(Quantity) AS QuantityTotal
	FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
	WHERE CategoryID <> 4
	GROUP BY P.ProductID)
--- Dựa vào 2 truy vấn trên : Liệt kê danh sách các mặt hàng trong
--tập A có QuantityTotal lớn hơn tất cả QuantityTotal của tập B
SELECT A.ProductID, A.QuantityTotal
FROM TAP_A A
WHERE A.QuantityTotal > ALL(SELECT QuantityToTal FROM TAP_B B)
--9. Danh sách các Product có tổng số lượng bán được lớn nhất trong năm
--1998
--Lưu ý : Có nhiều phương án thực hiện các truy vấn sau (dùng JOIN hoặc
--subquery ). Hãy đưa ra phương án sử dụng subquery.
SELECT TOP 1 WITH TIES P.ProductID, ProductName, SUM(OD.Quantity) AS QuantityTotal
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON OD.OrderID = O.OrderID
WHERE YEAR(OrderDate) = 1998 
GROUP BY P.ProductID, ProductName
ORDER BY P.ProductID DESC
--10. Danh sách các products đã có khách hàng mua hàng (tức là ProductID có
--trong [Order Details]). Thông tin bao gồm ProductID, ProductName,
--Unitprice
SELECT P.ProductID, ProductName, P.Unitprice
FROM Products P
WHERE P.ProductID IN (SELECT OD.ProductID FROM [Order Details] OD)
--11. Danh sách các hóa đơn của những khách hàng ở thành phố LonDon và
--Madrid.
SELECT OrderID, CustomerID
FROM Orders O 
WHERE CustomerID IN (SELECT City FROM Customers WHERE City IN ('LonDon', 'Madrid'))
--12. Liệt kê các sản phẩm có trên 20 đơn hàng trong quí 3 năm 1998, thông
--tin gồm ProductID, ProductName.
--13. Liệt kê danh sách các sản phẩm chưa bán được trong tháng 6 năm 1996
--14. Liệt kê danh sách các Employes không lập hóa đơn vào ngày hôm nay
--15. Liệt kê danh sách các Customers chưa mua hàng trong năm 1997
--16. Tìm tất cả các Customers mua các sản phẩm có tên bắt đầu bằng chữ T
--trong tháng 7 năm 1997
--17. Liệt kê danh sách các khách hàng mua các hóa đơn mà các hóa đơn này
--chỉ mua những sản phẩm có mã >=3
--18. Tìm các Customer chưa từng lập hóa đơn (viết bằng ba cách: dùng NOT
--EXISTS, dùng LEFT JOIN, dùng NOT IN )
--19. Bạn hãy mô tả kết quả của các câu truy vấn sau ?
--Select ProductID, ProductName, UnitPrice From [Products]
--Where Unitprice>ALL (Select Unitprice from [Products] where
--ProductName like ‘N%’)
--Select ProductId, ProductName, UnitPrice From [Products]
--Where Unitprice>ANY (Select Unitprice from [Products] where
--ProductName like ‘N%’)
--Select ProductId, ProductName, UnitPrice from [Products]
--Where Unitprice=ANY (Select Unitprice from [Products] where
--ProductName like ‘N%’)
--Select ProductId, ProductName, UnitPrice from [Products]
--Where ProductName like ‘N%’ and
--Unitprice>=ALL (Select Unitprice from [Products] where
--ProductName like ‘N%’)
