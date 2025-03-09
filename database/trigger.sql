
CREATE TRIGGER tr_InsertManagerOrDriverOnAccountInsert
ON Account
AFTER INSERT
AS
BEGIN
    -- Declare variables to store values from the inserted account
    DECLARE @InsertedAccountID INT, @InsertedRole VARCHAR(50);
    SELECT @InsertedAccountID = AccountID, @InsertedRole = Role FROM inserted;

    -- Insert into Manager table if Role is 'Manager'
    IF @InsertedRole = 'Manager'
    BEGIN
        INSERT INTO Manager (ManagerName, Phone, Gender, DateOfBirth, Image, AccountID)
        VALUES ('DefaultName', '0123456789', 'Male', GETDATE(), 'image/default.jpg', @InsertedAccountID);
    END

    -- Insert into Driver table if Role is 'Driver'
    ELSE IF @InsertedRole = 'Driver'
    BEGIN
     INSERT INTO Driver(DriverName, Phone, Gender, DateOfBirth, Image, AccountID)
        VALUES ('DefaultName', '0123456789', 'Male', GETDATE(), 'image/default.jpg', @InsertedAccountID);
    END
END;


GO
CREATE TRIGGER trg_InsertPick
ON Trip
AFTER INSERT
AS
BEGIN
    INSERT INTO Pick (StudentID, TripID, StopID, PickTime, DropTime)
    SELECT 
        A.StudentID,               
        I.TripID,                  
        S.StopID,                 
        '00:00:00' AS PickTime,    
        '00:00:00' AS DropTime     
    FROM 
        Attendance A
    JOIN 
        Student S ON A.StudentID = S.StudentID   -- Liên kết với bảng Student
    JOIN 
        inserted I ON A.AttendanceDate = I.TripDate  -- So sánh ngày Attendance với TripDate
    WHERE 
        A.Status = 'Present'       -- Chỉ lấy những học sinh có trạng thái "Present"
        AND A.TimePeriod = I.TimePeriod
        AND I.TripDate = A.AttendanceDate;  -- So khớp TripDate giữa Attendance và Trip
END;
GO


CREATE TRIGGER UpdatePickEstimate
ON Trip
AFTER INSERT
AS
BEGIN
    DECLARE @TripID INT;
    DECLARE @TripDate DATE;
    DECLARE @TimePeriod VARCHAR(255);
    DECLARE @DepartureTime TIME;
    DECLARE @RouteID INT;

    -- Lấy thông tin từ bảng inserted
    SELECT @TripID = TripID, @TripDate = TripDate, @TimePeriod = TimePeriod, @DepartureTime = DepartureTime
    FROM inserted;

    -- Lấy RouteID từ bảng Bus
    SELECT @RouteID = b.RouteID
    FROM Bus b
    JOIN Trip t ON t.BusID = b.BusID
    WHERE t.TripID = @TripID;

    -- Update PickEstimate và DropEstimate dựa vào TimePeriod
    UPDATE Attendance
    SET 
        PickEstimate = DATEADD(MINUTE, s.StopOrder * 15, @DepartureTime),
        DropEstimate = CASE 
            WHEN @TimePeriod = 'AM' THEN DATEADD(MINUTE, s.StopOrder * 15 + 300, @DepartureTime) -- 300 phút = 5 giờ
            WHEN @TimePeriod = 'PM' THEN DATEADD(MINUTE, s.StopOrder * 15 + 210, @DepartureTime) -- 210 phút = 3 giờ 30 phút
            ELSE NULL
        END
    FROM Attendance a
    JOIN Student st ON st.AccountID = (SELECT AccountID FROM Parent WHERE ParentID = a.ParentID)
    JOIN Stop s ON st.StopID = s.StopID
    WHERE a.AttendanceDate = @TripDate 
      AND a.TimePeriod = @TimePeriod
      AND s.RouteID = @RouteID; 
END;
GO

