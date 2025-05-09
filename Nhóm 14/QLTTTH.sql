--Bài 14: QUẢN LÝ HỌC VIÊN Ở MỘT TRUNG TÂM TIN HỌC Trung tâm tin học KTCT thường xuyên mở các lớp tin học ngắn hạn và dài hạn. Mỗi lớp ngắn hạn có một hoặc nhiều môn học (chẳng hạn như lớp Tin học văn phòng thì có các môn : Word, Power Point, Excel, còn lớp lập trình Pascal thì chỉ học một môn Pascal). Các lớp dài hạn (chẳng hạn như lớp kỹ thuật viên đồ hoạ đa truyền thông, lớp kỹ thuật viên lập trình, lớp kỹ thuật viên phần cứng và mạng,...) thì có thể học nhiều học phần và mỗi học phần có thể có nhiều môn học. Mỗi học viên có một mã học viên(MAHV) duy nhất và chỉ thuộc về một lớp duy nhất (nếu học viên cùng lúc học nhiều lớp thì ứng với mỗi lớp, học viên đó có một MAHV khác nhau). Mỗi học viên xác định họ tên (HOTEN), ngày sinh (NGAYSINH),nơi sinh (NOISINH), phái nam hay nữ (PHAI), nghề nghiệp (NGHENGHIEP) - nghề nghiệp là SINH VIÊN, GIÁO VIÊN, KỸ SƯ, HỌC SINH, BUÔN BÁN,... Trung tâm KTCT có nhiều lớp, mỗi lớp có một mã lớp duy nhất (MALOP), mỗi lớp xác định các thông tin: tên lớp (TENLOP), thời khoá biểu, ngày khai giảng (NGAYKG), học phí (HOCPHI). Chú ý rằng tại một thời điểm, trung tâm có thể mở nhiều lớp cho cùng một chương trình học. Với các lớp dài hạn thì ngày khai giảng được xem là ngày bắt đầu của mỗi học phần và HỌC PHÍ là học phí của mỗi học phần, với lớp ngắn hạn thì HỌC PHÍ là học phí của toàn khoá học đó. Trung tâm có nhiều môn học, mỗi môn học có mã môn học (MAMH) duy nhất, mỗi môn học xác định tên môn học(TENMH), số tiết lý thuyết (SOTIETLT), số tiết thực hành (SOTIETTH). Mỗi học viên ứng với mỗi môn học có một điểm thi(DIEMTHI) duy nhất. Mỗi lần đóng học phí, học viên sẽ được trung tâm giao cho một phiếu biên lai thu tiền, mỗi biên lai có một số biên lai duy nhất để quản lý. Một số yêu cầu của hệ thống này như::Lập danh sách những học viên khai giảng khoá ngày nào đó. Lập danh sách các học viên của một lớp ? Cho biết số lượng học viên của mỗi lớp khai giảng khoá ngày nào đó ?
--1.	Cài đặt CSDL - Tạo database trên SSMS, nhập dữ liệu (tự nghĩ ra mỗi bảng ít nhất 5 dòng): toàn bộ dùng lệnh SQL và nộp file database (file backup)
--Cài đặt CSDL và nhập dữ liệu bằng lệnh SQL (ví dụ):
---TẠO DATABASE:
CREATE DATABASE QUANLYTRUNGTAMTINHOC;
GO
USE QUANLYTRUNGTAMTINHOC;
GO
------TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG:
---TẠO BẢNG LOPHOC:
CREATE TABLE LOPHOC (
   MALOP VARCHAR(10) PRIMARY KEY,
   TENLOP NVARCHAR(50) NOT NULL,
   THOIKHOABIEU NVARCHAR(255),
   NGAYKG DATE NOT NULL,
   HOCPHI DECIMAL(10, 2) NOT NULL,
   LOAILOP VARCHAR(10) NOT NULL CHECK (LOAILOP IN ('NGANHAN', 'DAIHAN')))
---TẠO BẢNG MONHOC:
CREATE TABLE MONHOC (
   MAMH VARCHAR(10) PRIMARY KEY,
   TENMH NVARCHAR(50) NOT NULL,
   SOTIETLT INT NOT NULL,
   SOTIETTH INT NOT NULL)
---TẠO BẢNG LOPMONHOC:
CREATE TABLE LOPMONHOC (
   MALOP VARCHAR(10) FOREIGN KEY REFERENCES LOPHOC(MALOP),
   MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
   PRIMARY KEY (MALOP, MAMH))
---TẠO BẢNG HOCVIEN:
CREATE TABLE HOCVIEN (
   MAHV VARCHAR(10) PRIMARY KEY,
   MALOP VARCHAR(10) FOREIGN KEY REFERENCES LOPHOC(MALOP),
   HOTEN NVARCHAR(50) NOT NULL,
   NGAYSINH DATE,
   NOISINH NVARCHAR(50),
   PHAI NVARCHAR(3) CHECK (PHAI IN (N'NAM', N'NỮ')),
   NGHENGHIEP NVARCHAR(50))
---TẠO BẢNG DIEMTHI:
CREATE TABLE DIEMTHI (
   MAHV VARCHAR(10) FOREIGN KEY REFERENCES HOCVIEN(MAHV),
   MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
   DIEMTHI FLOAT,
   PRIMARY KEY (MAHV, MAMH))
-- TẠO BẢNG BIENLAI
CREATE TABLE BIENLAI (
   SOBIENLAI VARCHAR(20) PRIMARY KEY,
   MAHV VARCHAR(10) FOREIGN KEY REFERENCES HOCVIEN(MAHV),
   NGAYTHU DATE NOT NULL,
   SOTIEN DECIMAL(10, 2) NOT NULL)
 
-------NHẬP DỮ LIỆU MẪU:
--- NHẬP DỮ LIỆU MẪU CHO BẢNG LOPHOC:
INSERT INTO LOPHOC (MALOP, TENLOP, THOIKHOABIEU, NGAYKG, HOCPHI, LOAILOP)
VALUES
   ('L001', N'TIN HỌC VĂN PHÒNG A', N'T2-T4-T6 (7:00-9:00)', '2025-06-02', 1500000, 'NGANHAN'),
   ('L002', N'TIN HỌC VĂN PHÒNG B', N'T3-T5-T7 (13:00-15:00)', '2025-06-03', 1500000, 'NGANHAN'),
   ('L003', N'LẬP TRÌNH JAVA CƠ BẢN', N'T2-T4-T6 (14:00-17:00)', '2025-07-07', 2000000, 'DAIHAN'),
   ('L004', N'KỸ THUẬT VIÊN ĐỒ HỌA', N'T3-T5-T7 (7:00-11:30)', '2025-07-08', 3000000, 'DAIHAN'),
   ('L005', N'CƠ BẢN VỀ MÁY TÍNH', N'CN (12:00-15:00)', '2025-06-15', 1000000, 'NGANHAN');
--- NHẬP DỮ LIỆU MẪU CHO BẢNG MONHOC:
INSERT INTO MONHOC (MAMH, TENMH, SOTIETLT, SOTIETTH)
VALUES
   ('MH01', N'MICROSOFT WORD', 25, 30),
   ('MH02', N'MICROSOFT EXCEL', 20, 35),
   ('MH03', N'MICROSOFT POWERPOINT', 20, 40),
   ('MH04', N'LẬP TRÌNH JAVA', 45, 60),
   ('MH05', N'ADOBE PHOTOSHOP', 15, 20);
 
--- NHẬP DỮ LIỆU MẪU CHO BẢNG LOPMONHOC:
INSERT INTO LOPMONHOC (MALOP, MAMH)
VALUES
   ('L001', 'MH01'),
   ('L002', 'MH02'),
   ('L003', 'MH03'),
   ('L004', 'MH04'),
   ('L005', 'MH05');
 
-- NHẬP DỮ LIỆU MẪU CHO BẢNG HOCVIEN:
INSERT INTO HOCVIEN (MAHV, MALOP, HOTEN, NGAYSINH, NOISINH, PHAI, NGHENGHIEP)
VALUES
   ('HV001', 'L001', N'NGUYỄN VĂN A', '2005-06-20', N'HÀ NỘI', N'NAM', N'SINH VIÊN'),
   ('HV002', 'L002', N'TRẦN ĐÌNH B', '2001-10-20', N'HỒ CHÍ MINH', N'NỮ', N'NHÂN VIÊN VĂN PHÒNG'),
   ('HV003', 'L003', N'LÊ TRƯƠNG C', '1999-03-08', N'ĐÀ NẴNG', N'NỮ', N'GIÁO VIÊN'),
   ('HV004', 'L004', N'PHẠM THỊ D', '2006-07-29', N'QUY NHƠN', N'NỮ', N'HỌC SINH'),
   ('HV005', 'L005', N'PHAN ĐĂNG E', '2000-12-25', N'HẢI PHÒNG', N'NAM', N'BUÔN BÁN');
 
-- NHẬP DỮ LIỆU MẪU CHO BẢNG DIEMTHI:
INSERT INTO DIEMTHI (MAHV, MAMH, DIEMTHI)
VALUES
   ('HV001', 'MH01', 9.0),
   ('HV001', 'MH02', 8.0),
   ('HV002', 'MH03', 9.5),
   ('HV003', 'MH04', 7.5),
   ('HV004', 'MH05', 8.0);
 
-- NHẬP DỮ LIỆU MẪU CHO BẢNG BIENLAI:
INSERT INTO BIENLAI (SOBIENLAI, MAHV, NGAYTHU, SOTIEN)
VALUES
   ('BL001', 'HV001', '2025-05-29', 1500000),
   ('BL002', 'HV002', '2025-05-30', 1500000),
   ('BL003', 'HV003', '2025-07-05', 2000000),
   ('BL004', 'HV004', '2025-07-06', 3000000),
   ('BL005', 'HV005', '2025-06-10', 1000000);

