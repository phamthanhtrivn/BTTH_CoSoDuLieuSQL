--1.Tao CSDL
CREATE DATABASE QLBH
ON PRIMARY 
	(NAME = QLBH_data1,
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week1\BaiTap\QLBH_data1.mdf',
	SIZE = 10MB, MAXSIZE = 40MB, FILEGROWTH = 1MB)
LOG ON 
	(NAME = QLBH_Log,
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week1\BaiTap\QLBH.ldf',
	SIZE = 6MB, MAXSIZE = 8MB, FILEGROWTH = 1MB)

--2. Tao tap tin thu cap
CREATE DATABASE SACH
ON PRIMARY 
	(NAME = QLBH_data1,
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week1\BaiTap\SACH_data1.mdf',
	SIZE = 10MB, MAXSIZE = 40MB, FILEGROWTH = 1MB),
	(NAME = QLBH_data2,
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week1\BaiTap\SACH_data2.ndf',
	SIZE = 8MB, MAXSIZE = 20MB, FILEGROWTH = 1MB)
LOG ON (NAME = SACH_Log,
	FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week1\BaiTap\SACH_Log.ldf',
	SIZE = 6MB, MAXSIZE = 8MB, FILEGROWTH = 1MB)

--3. Su dung DB LBH
USE QLBH

--4. Xem thong tin cua tat ca cac db
SP_HELPDB

--5. Xem thong tin cua db QLBH
sp_helpdb QLBH

--6. Xem khong gian su dung
sp_spaceused

--7. Them filegroup DuLieuQLBH
ALTER DATABASE QLBH
	ADD FILEGROUP DuLieuQLBH

--8. Them file thu cap vao filegroup DuLieuQLBH
ALTER DATABASE QLBH
	ADD FILE (NAME = QLBH_data2, FILENAME = 'D:\HK1(2023-2024)\HeCoSoDuLieu\ThucHanh\Week1\BaiTap\QLBH.ndf',
		SIZE = 5, MAXSIZE = 15, FILEGROWTH = 1) TO FILEGROUP DuLieuQLBH

--9. Xem cac filegroup da co
SP_HELPFILEGROUP

--10. Chinh sua SIZE cua tap tin
ALTER DATABASE QLBH
	MODIFY FILE (NAME = QLBH_data2, SIZE = 10MB)
ALTER DATABASE QLBH
	MODIFY FILE (NAME = QLBH_data2, MAXSIZE = 20)

--11. Xoa FILE thu cap
ALTER DATABASE QLBH
	REMOVE FILE QLBH_data2

--12. Xoa FILEGROUP 
ALTER DATABASE QLBH
	REMOVE FILEGROUP DuLieuQLBH

--13. Thay doi thuoc tinh
ALTER DATABASE QLBH
	SET READ_ONLY
ALTER DATABASE QLBH
	SET READ_WRITE

--14. Doi ten CSDL
SP_RENAMEDB 'QLBH', 'BanHang'

--15. Xoa CSDL
USE QLSach
DROP DATABASE BanHang