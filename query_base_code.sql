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
