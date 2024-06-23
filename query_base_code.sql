--Họ và tên: Đặng Nguyên Giáp
--MSSV: DE180345
USE FUH_COMPANY
SELECT *
FROM tblDepartment
SELECT *
FROM tblDependent
SELECT *
FROM tblDepLocation
SELECT *
FROM tblEmployee
SELECT *
FROM tblLocation
SELECT *
FROM tblProject
SELECT *
FROM tblWorksOn

--Question 1:
SELECT e.empSSN, e.empName, d.depNum, d.depName
FROM tblDepartment d
         JOIN tblEmployee e ON d.mgrSSN = e.empSSN
WHERE d.depName = N'Phòng Nghiên cứu và phát triển'

--Question 2:
SELECT p.proNum, p.proName, d.depName
FROM tblProject p
         JOIN tblDepartment d ON p.depNum = d.depNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển'

--Question 3:
SELECT p.proNum, p.proName, d.depName
FROM tblProject p
         JOIN tblDepartment d ON p.depNum = d.depNum
WHERE p.proName = N'ProjectB'

--Question 4:
SELECT e.empSSN, e.empName
FROM tblEmployee e
         JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
WHERE s.empName = N'Mai Duy An'

--Question 5:
SELECT s.empSSN, s.empName
FROM tblEmployee e
         JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
WHERE e.empName = N'Mai Duy An'

--Question 6:
SELECT l.locNum, l.locName
FROM tblProject p
         JOIN tblLocation l ON p.locNum = l.locNum
WHERE p.proName = N'ProjectA'

--Question 7:
SELECT p.proNum, p.proName
FROM tblProject p
         JOIN tblLocation l ON p.locNum = l.locNum
WHERE l.locName = N'TP Hồ Chí Minh'

--Question 8:
SELECT d.depName, d.depBirthdate, e.empName
FROM tblDependent d
         JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18;

--Question 9:
SELECT d.depName, d.depBirthdate, e.empName
FROM tblDependent d
         JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE d.depSex = 'M';

--Question 10:
SELECT d.depNum, d.depName, l.locName
FROM tblDepartment d
         JOIN tblDepLocation dl ON d.depNum = dl.depNum
         JOIN tblLocation l ON dl.locNum = l.locNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển'

--Question 11:
SELECT p.proNum, p.proName, d.depName
FROM tblProject p
         JOIN tblLocation l ON p.locNum = l.locNum
         JOIN tblDepartment d ON p.depNum = d.depNum
WHERE l.locName = N'TP Hồ Chí Minh'

--Question 12:
SELECT e.empName, d.depName, d.depRelationship
FROM tblDependent d
         JOIN tblEmployee e ON d.empSSN = e.empSSN
         JOIN tblDepartment dp ON e.depNum = dp.depNum
WHERE d.depSex = 'F'
  AND dp.depName = N'Phòng Nghiên cứu và phát triển'

--Question 13:
SELECT e.empName, d.depName, d.depRelationship
FROM tblDependent d
         JOIN tblEmployee e ON d.empSSN = e.empSSN
         JOIN tblDepartment dp ON e.depNum = dp.depNum
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18
  AND dp.depName = N'Phòng Nghiên cứu và phát triển'
--Họ và tên: Lâm Gia Kiệt
--MSSV: DE180340
USE FUH_COMPANY
--27.	Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum, P.proName, SUM(W.workHours) AS totalWorkHours
FROM tblProject P
JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName;

--28. Cho biết dự án nào có số lượng thành viên là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT TOP 1 P.proNum, P.proName, COUNT(W.empSSN) AS memberCount
FROM tblProject P
JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
ORDER BY memberCount ASC;

--29. Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT TOP 1 P.proNum, P.proName, COUNT(W.empSSN) AS memberCount
FROM tblProject P
JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
ORDER BY memberCount DESC;

--30. Cho biết dự án nào có tổng số giờ làm là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT TOP 1 P.proNum, P.proName, SUM(W.workHours) AS totalWorkHours
FROM tblProject P
JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
ORDER BY totalWorkHours ASC;

--31. Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT TOP 1 P.proNum, P.proName, SUM(W.workHours) AS totalWorkHours
FROM tblProject P
JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
ORDER BY totalWorkHours DESC;

--32. Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT L.locName, COUNT(DISTINCT D.depNum) AS departmentCount
FROM tblLocation L
JOIN tblDepLocation DL ON L.locNum = DL.locNum
JOIN tblDepartment D ON DL.depNum = D.depNum
GROUP BY L.locName;

--33. Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT D.depNum, D.depName, COUNT(DISTINCT DL.locNum) AS locationCount
FROM tblDepartment D
JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName;

--34. Cho biết phòng ban nào có nhiều chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT TOP 1 D.depNum, D.depName, COUNT(DISTINCT DL.locNum) AS locationCount
FROM tblDepartment D
JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName
ORDER BY locationCount DESC;

--35. Cho biết phòng ban nào có it chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT TOP 1 D.depNum, D.depName, COUNT(DISTINCT DL.locNum) AS locationCount
FROM tblDepartment D
JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName
ORDER BY locationCount ASC;

--36. Cho biết địa điểm nào có nhiều phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT TOP 1 L.locName, COUNT(DISTINCT D.depNum) AS departmentCount
FROM tblLocation L
JOIN tblDepLocation DL ON L.locNum = DL.locNum
JOIN tblDepartment D ON DL.depNum = D.depNum
GROUP BY L.locName
ORDER BY departmentCount DESC;

--37. Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT TOP 1 L.locName, COUNT(DISTINCT D.depNum) AS departmentCount
FROM tblLocation L
JOIN tblDepLocation DL ON L.locNum = DL.locNum
JOIN tblDepartment D ON DL.depNum = D.depNum
GROUP BY L.locName
ORDER BY departmentCount ASC;

--38. Cho biết nhân viên nào có nhiều người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
SELECT TOP 1 E.empSSN, E.empName, COUNT(D.depName) AS dependentCount
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
GROUP BY E.empSSN, E.empName
ORDER BY dependentCount DESC;

--39. Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
SELECT TOP 1 E.empSSN, E.empName, COUNT(D.depName) AS dependentCount
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
GROUP BY E.empSSN, E.empName
ORDER BY dependentCount ASC;

--Họ và tên: Nguyễn Quang Nhật
--MSSV: DE180423

--40:Cho biết nhân viên nào không có người phụ thuộc. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
Select e.empSSN as 'mã số nhân viên', e.empName as 'Họ và tên nhân viên', dp.depName as 'tên phòng ban', dp.depNum
from tblEmployee e
left join tblDependent d on e.empSSN = d.empSSN
left join tblDepartment dp on dp.depNum = e.depNum
WHERE d.empSSN IS NULL;

--41:Cho biết phòng ban nào không có người phụ thuộc. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT DISTINCT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban'
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent p ON e.empSSN = p.empSSN
WHERE p.empSSN IS NULL;

Select e.empSSN, e.empName
From tblEmployee e
LEFT JOIN tblDepartment d ON e.depNum = d.depNum
where d.depNum = 3;

SELECT d.depName, COUNT(e.empSSN) AS num_employees
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
GROUP BY d.depName;

--42: Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào. Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên
SELECT e.empSSN as 'mã số nhân viên', e.empName as 'Họ và tên nhân viên', d.depName as 'tên phòng ban'
FROM tblEmployee e
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
LEFT JOIN tblDepartment d ON e.depNum = d.depNum
WHERE w.proNum IS NULL;

--43: Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban'
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY d.depNum, d.depName
HAVING COUNT(w.proNum) = 0;

----Chỉ ra nhân viên thuộc phòng ban 5
select empSSN, empName from tblEmployee
where depNum = 5

--44: Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban'
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
LEFT JOIN tblProject p ON w.proNum = p.proNum AND p.proName = 'ProjectA'
GROUP BY d.depNum, d.depName
HAVING COUNT(p.proNum) = 0;

--45: Cho biết số lượng dự án được quản lý theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban', COUNT(p.proNum) as 'Số lượng dự án'
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName;

--46: Cho biết phòng ban nào quản lý it dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban', COUNT(p.proNum) as 'Số lượng dự án'
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName
HAVING COUNT(p.proNum) <= ALL (
    SELECT COUNT(p2.proNum)
    FROM tblDepartment d2
    LEFT JOIN tblProject p2 ON d2.depNum = p2.depNum
    GROUP BY d2.depNum
)
ORDER BY N'Số lượng dự án';

--47: Cho biết phòng ban nào quản lý nhiều dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban', COUNT(p.proNum) as 'Số lượng dự án'
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName
HAVING COUNT(p.proNum) >= ALL (
    SELECT COUNT(p2.proNum)
    FROM tblDepartment d2
    LEFT JOIN tblProject p2 ON d2.depNum = p2.depNum
    GROUP BY d2.depNum
)
ORDER BY N'Số lượng dự án';

--48: Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý
SELECT d.depNum as 'Mã số phòng ban', d.depName as 'tên phòng ban', COUNT(e.empSSN) as 'Số lượng nhân viên', p.proName as 'tên dự án quản lý'
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName, p.proName
HAVING COUNT(e.empSSN) > 4;

--49: Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên
SELECT e.empSSN AS 'Mã nhân viên', e.empName AS 'họ tên nhân viên'
FROM tblEmployee e
JOIN tblDepartment d ON d.depNum = e.depNum
JOIN tblDependent dep ON dep.empSSN = e.empSSN
WHERE d.depName = N'Phòng Nghiên cứu và phát triển'
  AND dep.empSSN IS NULL
GROUP BY e.empSSN, e.empName;

--50: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm
SELECT e.empSSN AS 'Mã nhân viên', e.empName AS 'họ tên nhân viên', SUM(w.workHours) AS 'tổng số giờ làm'
FROM tblEmployee e
LEFT JOIN tblDependent p ON e.empSSN = p.empSSN
JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE p.empSSN IS NULL
GROUP BY e.empSSN, e.empName;

--51: Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm
SELECT e.empSSN AS 'Mã nhân viên', e.empName AS 'họ tên nhân viên', COUNT(p.empSSN) AS 'Số lượng người phụ thuộc', SUM(w.workHours) AS 'Tổng số giờ làm'
FROM tblEmployee e
LEFT JOIN tblDependent p ON e.empSSN = p.empSSN
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(p.empSSN) >= 3;

select * from tblDependent
--52: Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi) của nhân viên Mai Duy An. Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm
SELECT e.empSSN AS 'Mã nhân viên', e.empName AS 'họ tên nhân viên', SUM(w.workHours) AS 'Tổng số giờ làm'
FROM tblEmployee e
JOIN tblEmployee s ON e.supervisorSSN = s.empSSN
JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE s.empName = 'Mai Duy An'
GROUP BY e.empSSN, e.empName;