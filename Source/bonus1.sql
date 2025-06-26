-- Adding New Users (Lecturers and Students)
-- New Lecturers
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'thangnvlec', N'123', N'LEC06', N'Nguyễn Văn Thắng', N'male', CAST(N'1988-03-15' AS Date), N'Hải Phòng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'minhhtlec', N'123', N'LEC07', N'Hoàng Thị Minh', N'female', CAST(N'1992-07-20' AS Date), N'Đà Nẵng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'longdplec', N'123', N'LEC08', N'Đặng Phi Long', N'male', CAST(N'1985-11-01' AS Date), N'Hà Nội')
GO

-- New Students (HE021 - HE070, total 50 students)
-- Batch 1: HE021-HE030 (Start FA24)
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user021', N'123', N'HE021', N'Student HE021', N'male', CAST(N'2006-01-10' AS Date), N'Bắc Ninh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user022', N'123', N'HE022', N'Student HE022', N'female', CAST(N'2006-02-11' AS Date), N'Hải Dương')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user023', N'123', N'HE023', N'Student HE023', N'male', CAST(N'2006-03-12' AS Date), N'Hưng Yên')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user024', N'123', N'HE024', N'Student HE024', N'female', CAST(N'2006-04-13' AS Date), N'Vĩnh Phúc')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user025', N'123', N'HE025', N'Student HE025', N'male', CAST(N'2006-05-14' AS Date), N'Thái Bình')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user026', N'123', N'HE026', N'Student HE026', N'female', CAST(N'2006-06-15' AS Date), N'Nam Định')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user027', N'123', N'HE027', N'Student HE027', N'male', CAST(N'2006-07-16' AS Date), N'Hà Nam')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user028', N'123', N'HE028', N'Student HE028', N'female', CAST(N'2006-08-17' AS Date), N'Ninh Bình')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user029', N'123', N'HE029', N'Student HE029', N'male', CAST(N'2006-09-18' AS Date), N'Quảng Ninh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user030', N'123', N'HE030', N'Student HE030', N'female', CAST(N'2006-10-19' AS Date), N'Lạng Sơn')
-- Batch 2: HE031-HE040 (Start SP25)
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user031', N'123', N'HE031', N'Student HE031', N'male', CAST(N'2005-01-20' AS Date), N'Cao Bằng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user032', N'123', N'HE032', N'Student HE032', N'female', CAST(N'2005-02-21' AS Date), N'Bắc Kạn')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user033', N'123', N'HE033', N'Student HE033', N'male', CAST(N'2005-03-22' AS Date), N'Thái Nguyên')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user034', N'123', N'HE034', N'Student HE034', N'female', CAST(N'2005-04-23' AS Date), N'Phú Thọ')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user035', N'123', N'HE035', N'Student HE035', N'male', CAST(N'2005-05-24' AS Date), N'Tuyên Quang')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user036', N'123', N'HE036', N'Student HE036', N'female', CAST(N'2005-06-25' AS Date), N'Hà Giang')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user037', N'123', N'HE037', N'Student HE037', N'male', CAST(N'2005-07-26' AS Date), N'Lào Cai')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user038', N'123', N'HE038', N'Student HE038', N'female', CAST(N'2005-08-27' AS Date), N'Yên Bái')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user039', N'123', N'HE039', N'Student HE039', N'male', CAST(N'2005-09-28' AS Date), N'Sơn La')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user040', N'123', N'HE040', N'Student HE040', N'female', CAST(N'2005-10-29' AS Date), N'Điện Biên')
-- Batch 3: HE041-HE050 (Start SU25)
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user041', N'123', N'HE041', N'Student HE041', N'male', CAST(N'2004-01-01' AS Date), N'Lai Châu')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user042', N'123', N'HE042', N'Student HE042', N'female', CAST(N'2004-02-02' AS Date), N'Hòa Bình')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user043', N'123', N'HE043', N'Student HE043', N'male', CAST(N'2004-03-03' AS Date), N'Thanh Hóa')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user044', N'123', N'HE044', N'Student HE044', N'female', CAST(N'2004-04-04' AS Date), N'Nghệ An')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user045', N'123', N'HE045', N'Student HE045', N'male', CAST(N'2004-05-05' AS Date), N'Hà Tĩnh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user046', N'123', N'HE046', N'Student HE046', N'female', CAST(N'2004-06-06' AS Date), N'Quảng Bình')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user047', N'123', N'HE047', N'Student HE047', N'male', CAST(N'2004-07-07' AS Date), N'Quảng Trị')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user048', N'123', N'HE048', N'Student HE048', N'female', CAST(N'2004-08-08' AS Date), N'Thừa Thiên Huế')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user049', N'123', N'HE049', N'Student HE049', N'male', CAST(N'2004-09-09' AS Date), N'Đà Nẵng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user050', N'123', N'HE050', N'Student HE050', N'female', CAST(N'2004-10-10' AS Date), N'Quảng Nam')
-- Batch 4: HE051-HE060 (Start FA25)
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user051', N'123', N'HE051', N'Student HE051', N'male', CAST(N'2007-01-11' AS Date), N'Quảng Ngãi')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user052', N'123', N'HE052', N'Student HE052', N'female', CAST(N'2007-02-12' AS Date), N'Bình Định')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user053', N'123', N'HE053', N'Student HE053', N'male', CAST(N'2007-03-13' AS Date), N'Phú Yên')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user054', N'123', N'HE054', N'Student HE054', N'female', CAST(N'2007-04-14' AS Date), N'Khánh Hòa')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user055', N'123', N'HE055', N'Student HE055', N'male', CAST(N'2007-05-15' AS Date), N'Ninh Thuận')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user056', N'123', N'HE056', N'Student HE056', N'female', CAST(N'2007-06-16' AS Date), N'Bình Thuận')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user057', N'123', N'HE057', N'Student HE057', N'male', CAST(N'2007-07-17' AS Date), N'Kon Tum')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user058', N'123', N'HE058', N'Student HE058', N'female', CAST(N'2007-08-18' AS Date), N'Gia Lai')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user059', N'123', N'HE059', N'Student HE059', N'male', CAST(N'2007-09-19' AS Date), N'Đắk Lắk')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user060', N'123', N'HE060', N'Student HE060', N'female', CAST(N'2007-10-20' AS Date), N'Đắk Nông')
-- Batch 5: HE061-HE070 (Start SP26)
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user061', N'123', N'HE061', N'Student HE061', N'male', CAST(N'2006-11-21' AS Date), N'Lâm Đồng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user062', N'123', N'HE062', N'Student HE062', N'female', CAST(N'2006-12-22' AS Date), N'Bình Phước')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user063', N'123', N'HE063', N'Student HE063', N'male', CAST(N'2006-01-23' AS Date), N'Tây Ninh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user064', N'123', N'HE064', N'Student HE064', N'female', CAST(N'2006-02-24' AS Date), N'Bình Dương')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user065', N'123', N'HE065', N'Student HE065', N'male', CAST(N'2006-03-25' AS Date), N'Đồng Nai')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user066', N'123', N'HE066', N'Student HE066', N'female', CAST(N'2006-04-26' AS Date), N'Bà Rịa - Vũng Tàu')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user067', N'123', N'HE067', N'Student HE067', N'male', CAST(N'2006-05-27' AS Date), N'Hồ Chí Minh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user068', N'123', N'HE068', N'Student HE068', N'female', CAST(N'2006-06-28' AS Date), N'Long An')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user069', N'123', N'HE069', N'Student HE069', N'male', CAST(N'2006-07-29' AS Date), N'Tiền Giang')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'user070', N'123', N'HE070', N'Student HE070', N'female', CAST(N'2006-08-30' AS Date), N'Bến Tre')
GO

-- Assigning Roles to New Users
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC06', N'R002')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC07', N'R002')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC08', N'R002')
GO
DECLARE @i INT = 21
WHILE @i <= 70
BEGIN
    DECLARE @user_id VARCHAR(10) = 'HE' + FORMAT(@i, '000')
    INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (@user_id, N'R003')
    SET @i = @i + 1
END
GO

-- Adding New Lecturers to Lecturers Table
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC06', N'D04') -- D04: Software Engineering
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC07', N'D01') -- D01: Computing Fundamental
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC08', N'D02') -- D02: Artificial Intelligence
GO

-- Adding New Students to Students Table
-- Batch 1: HE021-HE030 (Start FA24) - 2 SE, 3 IS, 2 AI, 3 IA
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE021', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE022', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE023', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE024', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE025', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE026', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE027', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE028', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE029', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE030', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
-- Batch 2: HE031-HE040 (Start SP25) - 3 SE, 2 IS, 3 AI, 2 IA
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE031', N'SE', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE032', N'SE', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE033', N'SE', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE034', N'IS', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE035', N'IS', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE036', N'AI', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE037', N'AI', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE038', N'AI', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE039', N'IA', CAST(N'2025-01-01' AS Date), N'SP25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE040', N'IA', CAST(N'2025-01-01' AS Date), N'SP25')
-- Batch 3: HE041-HE050 (Start SU25) - 2 SE, 3 IS, 2 AI, 3 IA
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE041', N'SE', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE042', N'SE', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE043', N'IS', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE044', N'IS', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE045', N'IS', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE046', N'AI', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE047', N'AI', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE048', N'IA', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE049', N'IA', CAST(N'2025-05-01' AS Date), N'SU25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE050', N'IA', CAST(N'2025-05-01' AS Date), N'SU25')
-- Batch 4: HE051-HE060 (Start FA25) - 3 SE, 2 IS, 3 AI, 2 IA
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE051', N'SE', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE052', N'SE', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE053', N'SE', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE054', N'IS', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE055', N'IS', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE056', N'AI', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE057', N'AI', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE058', N'AI', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE059', N'IA', CAST(N'2025-09-01' AS Date), N'FA25')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE060', N'IA', CAST(N'2025-09-01' AS Date), N'FA25')
-- Batch 5: HE061-HE070 (Start SP26) - 2 SE, 3 IS, 2 AI, 3 IA
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE061', N'SE', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE062', N'SE', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE063', N'IS', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE064', N'IS', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE065', N'IS', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE066', N'AI', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE067', N'AI', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE068', N'IA', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE069', N'IA', CAST(N'2026-01-01' AS Date), N'SP26')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE070', N'IA', CAST(N'2026-01-01' AS Date), N'SP26')
GO

-- Adding New Courses (5 total new courses)
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'DBI', N'Database Introduction', 3, N'Fundamental concepts of database systems, data modeling, and SQL.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'PFP', N'Programming Fundamentals with Python', 3, N'Introduction to programming concepts using Python, including variables, control structures, functions, and basic data structures.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'DSA', N'Data Structures and Algorithms', 3, N'Covers fundamental data structures and algorithms, analysis of algorithms, and problem-solving techniques.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'WEB', N'Web Application Development', 3, N'Focuses on front-end and back-end web development technologies, including HTML, CSS, JavaScript, and server-side scripting.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'NET', N'Computer Networks', 3, N'An introduction to computer networks, network protocols, and layered architectures.')
GO

-- Defining Grade Components for New Courses
-- DBI (already added in previous thought, ensuring it's here)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DBI_Assignment', N'DBI', N'Assignment', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DBI_Midterm_Exam', N'DBI', N'Midterm Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DBI_Final_Exam', N'DBI', N'Final Exam', 0.4)
-- PFP (already added in previous thought, ensuring it's here)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'PFP_Lab_1', N'PFP', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'PFP_Lab_2', N'PFP', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'PFP_Assignment', N'PFP', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'PFP_Practical_Exam', N'PFP', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'PFP_Final_Exam', N'PFP', N'Final Exam', 0.3)
-- DSA
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DSA_Assignment_1', N'DSA', N'Assignment 1', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DSA_Assignment_2', N'DSA', N'Assignment 2', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DSA_Midterm_Exam', N'DSA', N'Midterm Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'DSA_Final_Exam', N'DSA', N'Final Exam', 0.3)
-- WEB
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'WEB_Project_1', N'WEB', N'Project 1', 0.25)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'WEB_Project_2', N'WEB', N'Project 2', 0.25)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'WEB_Presentation', N'WEB', N'Presentation', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'WEB_Final_Exam', N'WEB', N'Final Exam', 0.3)
-- NET
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NET_Lab_Assignments', N'NET', N'Lab Assignments', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NET_Midterm_Exam', N'NET', N'Midterm Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NET_Final_Exam', N'NET', N'Final Exam', 0.4)
GO

-- Linking New Courses to Majors in Curriculums
-- DBI (already added, ensuring it's here)
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'DBI')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'DBI')
-- PFP (already added, ensuring it's here)
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'PFP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'PFP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'PFP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'PFP')
-- DSA
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'DSA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'DSA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'DSA')
-- WEB
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'WEB')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'WEB')
-- NET
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'NET')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'NET')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'NET')
GO

-- Creating New ClassCourse Offerings (~35-40 records)
-- FA24
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_PFP_FA24', N'AI01', N'PFP', N'LEC07', N'FA24')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_PFP_FA24', N'SE01', N'PFP', N'LEC07', N'FA24')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IS01_PFP_FA24', N'IS01', N'PFP', N'LEC07', N'FA24')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IA01_PFP_FA24', N'IA01', N'PFP', N'LEC07', N'FA24')
-- SP25
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_DSA_SP25', N'AI01', N'DSA', N'LEC08', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_DSA_SP25', N'SE01', N'DSA', N'LEC06', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IS01_DSA_SP25', N'IS01', N'DSA', N'LEC06', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_DBI_SP25', N'SE01', N'DBI', N'LEC06', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_AIL_SP25_L2', N'AI01', N'AIL', N'LEC01', N'SP25') -- Another AIL class offering
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IA01_IAM_SP25_L2', N'IA01', N'IAM', N'LEC05', N'SP25') -- Another IAM class offering
-- SU25
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IS01_DBI_SU25', N'IS01', N'DBI', N'LEC06', N'SU25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_WEB_SU25', N'SE01', N'WEB', N'LEC06', N'SU25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_PFP_SU25', N'AI01', N'PFP', N'LEC07', N'SU25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IA01_NET_SU25', N'IA01', N'NET', N'LEC07', N'SU25')
-- FA25
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_NET_FA25', N'SE01', N'NET', N'LEC07', N'FA25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IS01_WEB_FA25', N'IS01', N'WEB', N'LEC06', N'FA25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_DSA_FA25', N'AI01', N'DSA', N'LEC08', N'FA25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_PFP_FA25', N'SE01', N'PFP', N'LEC07', N'FA25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IS01_MAE_FA25', N'IS01', N'MAE', N'LEC01', N'FA25') -- Existing MAE with LEC01 for IS in FA25
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_NLP_FA25', N'AI01', N'NLP', N'LEC05', N'FA25') -- Existing NLP with LEC05 for AI in FA25
-- SP26
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IA01_NET_SP26', N'IA01', N'NET', N'LEC07', N'SP26')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_DSA_SP26', N'SE01', N'DSA', N'LEC06', N'SP26')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IS01_DBI_SP26', N'IS01', N'DBI', N'LEC06', N'SP26')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_WEB_SP26', N'AI01', N'WEB', N'LEC06', N'SP26') -- AI students might take WEB as elective
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'SE01_AIL_SP26', N'SE01', N'AIL', N'LEC01', N'SP26') -- SE students might take AIL as elective
GO

-- Adding Enrollments (Example for a subset of students and courses, this would be much larger)
-- Student HE021 (SE, FA24 start)
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE021_SE01_PFP_FA24', N'HE021', N'SE01_PFP_FA24', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE021_AI01_MAE_FA24', N'HE021', N'AI01_MAE', 0, N'Studying') -- Assumes SE students take MAE from AI01 class offering
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE021_SE01_DSA_SP25', N'HE021', N'SE01_DSA_SP25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE021_SE01_DBI_SP25', N'HE021', N'SE01_DBI_SP25', 0, N'Studying')

-- Student HE026 (AI, FA24 start)
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE026_AI01_PFP_FA24', N'HE026', N'AI01_PFP_FA24', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE026_AI01_MAE_FA24', N'HE026', N'AI01_MAE', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE026_AI01_DSA_SP25', N'HE026', N'AI01_DSA_SP25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE026_AI01_AIL_SP25_L2', N'HE026', N'AI01_AIL_SP25_L2', 0, N'Studying')


-- Student HE031 (SE, SP25 start)
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE031_SE01_DSA_SP25', N'HE031', N'SE01_DSA_SP25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE031_SE01_DBI_SP25', N'HE031', N'SE01_DBI_SP25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE031_SE01_WEB_SU25', N'HE031', N'SE01_WEB_SU25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE031_SE01_NET_FA25', N'HE031', N'SE01_NET_FA25', 0, N'Studying')


-- Student HE041 (SE, SU25 start)
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE041_SE01_WEB_SU25', N'HE041', N'SE01_WEB_SU25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE041_AI01_PFP_SU25', N'HE041', N'AI01_PFP_SU25', 0, N'Studying') -- Assuming SE can take PFP from AI class
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE041_SE01_NET_FA25', N'HE041', N'SE01_NET_FA25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE041_SE01_DSA_SP26', N'HE041', N'SE01_DSA_SP26', 0, N'Studying')

-- Student HE051 (SE, FA25 start)
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE051_SE01_NET_FA25', N'HE051', N'SE01_NET_FA25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE051_SE01_PFP_FA25', N'HE051', N'SE01_PFP_FA25', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE051_SE01_DSA_SP26', N'HE051', N'SE01_DSA_SP26', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE051_SE01_AIL_SP26', N'HE051', N'SE01_AIL_SP26', 0, N'Studying')
GO
-- ... (This section would have ~150 enrollments for HE021-HE070)

-- Schedules for new ClassCourse Offerings (Example for a few, this section would be very large)
-- Schedules for AI01_PFP_FA24 (Room R007, FA24: Sep-Dec 2024)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_PFP_FA24_1', N'AI01_PFP_FA24', CAST(N'2024-09-02T07:30:00.000' AS DateTime), CAST(N'2024-09-02T09:50:00.000' AS DateTime), N'R007', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_PFP_FA24_2', N'AI01_PFP_FA24', CAST(N'2024-09-04T10:00:00.000' AS DateTime), CAST(N'2024-09-04T12:20:00.000' AS DateTime), N'R007', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_PFP_FA24_3', N'AI01_PFP_FA24', CAST(N'2024-09-09T07:30:00.000' AS DateTime), CAST(N'2024-09-09T09:50:00.000' AS DateTime), N'R007', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_PFP_FA24_4', N'AI01_PFP_FA24', CAST(N'2024-09-11T10:00:00.000' AS DateTime), CAST(N'2024-09-11T12:20:00.000' AS DateTime), N'R007', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_PFP_FA24_5', N'AI01_PFP_FA24', CAST(N'2024-09-16T07:30:00.000' AS DateTime), CAST(N'2024-09-16T09:50:00.000' AS DateTime), N'R007', 5)

-- Schedules for SE01_DSA_SP25 (Room R008, SP25: Jan-Apr 2025)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_DSA_SP25_1', N'SE01_DSA_SP25', CAST(N'2025-01-06T12:50:00.000' AS DateTime), CAST(N'2025-01-06T15:10:00.000' AS DateTime), N'R008', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_DSA_SP25_2', N'SE01_DSA_SP25', CAST(N'2025-01-08T15:20:00.000' AS DateTime), CAST(N'2025-01-08T17:40:00.000' AS DateTime), N'R008', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_DSA_SP25_3', N'SE01_DSA_SP25', CAST(N'2025-01-13T12:50:00.000' AS DateTime), CAST(N'2025-01-13T15:10:00.000' AS DateTime), N'R008', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_DSA_SP25_4', N'SE01_DSA_SP25', CAST(N'2025-01-15T15:20:00.000' AS DateTime), CAST(N'2025-01-15T17:40:00.000' AS DateTime), N'R008', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_DSA_SP25_5', N'SE01_DSA_SP25', CAST(N'2025-01-20T12:50:00.000' AS DateTime), CAST(N'2025-01-20T15:10:00.000' AS DateTime), N'R008', 5)

-- Schedules for SE01_WEB_SU25 (Room R009, SU25: May-Aug 2025 - First month is past)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_WEB_SU25_1', N'SE01_WEB_SU25', CAST(N'2025-05-05T07:30:00.000' AS DateTime), CAST(N'2025-05-05T09:50:00.000' AS DateTime), N'R009', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_WEB_SU25_2', N'SE01_WEB_SU25', CAST(N'2025-05-07T10:00:00.000' AS DateTime), CAST(N'2025-05-07T12:20:00.000' AS DateTime), N'R009', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_WEB_SU25_3', N'SE01_WEB_SU25', CAST(N'2025-05-12T07:30:00.000' AS DateTime), CAST(N'2025-05-12T09:50:00.000' AS DateTime), N'R009', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_WEB_SU25_4', N'SE01_WEB_SU25', CAST(N'2025-05-14T10:00:00.000' AS DateTime), CAST(N'2025-05-14T12:20:00.000' AS DateTime), N'R009', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_WEB_SU25_5', N'SE01_WEB_SU25', CAST(N'2025-05-19T07:30:00.000' AS DateTime), CAST(N'2025-05-19T09:50:00.000' AS DateTime), N'R009', 5)

-- Schedules for SE01_NET_FA25 (Room R010, FA25: Sep-Dec 2025 - Future)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_NET_FA25_1', N'SE01_NET_FA25', CAST(N'2025-09-01T07:30:00.000' AS DateTime), CAST(N'2025-09-01T09:50:00.000' AS DateTime), N'R010', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_NET_FA25_2', N'SE01_NET_FA25', CAST(N'2025-09-03T10:00:00.000' AS DateTime), CAST(N'2025-09-03T12:20:00.000' AS DateTime), N'R010', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_NET_FA25_3', N'SE01_NET_FA25', CAST(N'2025-09-08T07:30:00.000' AS DateTime), CAST(N'2025-09-08T09:50:00.000' AS DateTime), N'R010', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_NET_FA25_4', N'SE01_NET_FA25', CAST(N'2025-09-10T10:00:00.000' AS DateTime), CAST(N'2025-09-10T12:20:00.000' AS DateTime), N'R010', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'SE01_NET_FA25_5', N'SE01_NET_FA25', CAST(N'2025-09-15T07:30:00.000' AS DateTime), CAST(N'2025-09-15T09:50:00.000' AS DateTime), N'R010', 5)
GO
-- ... (This section would have schedules for all ~35-40 ClassCourse offerings)

-- Attendance Data (Example for a few enrollments, this section would be very large)
-- Attendance for HE021_SE01_PFP_FA24 (Past)
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE021_SE01_PFP_FA24', N'AI01_PFP_FA24_1', N'Present') -- Corrected schedule_id to match classcourse
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE021_SE01_PFP_FA24', N'AI01_PFP_FA24_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE021_SE01_PFP_FA24', N'AI01_PFP_FA24_3', N'Absent')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE021_SE01_PFP_FA24', N'AI01_PFP_FA24_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE021_SE01_PFP_FA24', N'AI01_PFP_FA24_5', N'Present')

-- Attendance for HE031_SE01_DSA_SP25 (Past)
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE031_SE01_DSA_SP25', N'SE01_DSA_SP25_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE031_SE01_DSA_SP25', N'SE01_DSA_SP25_2', N'Absent')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE031_SE01_DSA_SP25', N'SE01_DSA_SP25_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE031_SE01_DSA_SP25', N'SE01_DSA_SP25_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE031_SE01_DSA_SP25', N'SE01_DSA_SP25_5', N'Present')

-- Attendance for HE041_SE01_WEB_SU25 (SU25 - Slots are past based on current date June 2, 2025)
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE041_SE01_WEB_SU25', N'SE01_WEB_SU25_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE041_SE01_WEB_SU25', N'SE01_WEB_SU25_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE041_SE01_WEB_SU25', N'SE01_WEB_SU25_3', N'Absent')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE041_SE01_WEB_SU25', N'SE01_WEB_SU25_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE041_SE01_WEB_SU25', N'SE01_WEB_SU25_5', N'Present')

-- Attendance for HE051_SE01_NET_FA25 (Future)
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE051_SE01_NET_FA25', N'SE01_NET_FA25_1', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE051_SE01_NET_FA25', N'SE01_NET_FA25_2', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE051_SE01_NET_FA25', N'SE01_NET_FA25_3', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE051_SE01_NET_FA25', N'SE01_NET_FA25_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE051_SE01_NET_FA25', N'SE01_NET_FA25_5', N'Future')
GO
-- ... (This section would have ~750 attendance records)

-- Student Grade Details (Example for a few, this section would be large)
-- Grades for HE021_SE01_PFP_FA24 (Past course)
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE021_SE01_PFP_FA24', N'PFP_Lab_1', 8.0, N'Good work')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE021_SE01_PFP_FA24', N'PFP_Lab_2', 7.5, N'Improvement shown')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE021_SE01_PFP_FA24', N'PFP_Assignment', 8.5, N'Excellent submission')
-- Simulate final grade calculation for HE021_SE01_PFP_FA24 (0.1*8 + 0.1*7.5 + 0.2*8.5 + 0.3*Practical_Exam + 0.3*Final_Exam) - Need more grades for actual average
-- For now, just individual components. If this student passed:
UPDATE [dbo].[Enrollments] SET [average] = 8.2, [status] = N'Passed' WHERE [enrollment_id] = N'HE021_SE01_PFP_FA24' -- Example average

-- Grades for HE031_SE01_DSA_SP25 (Past course)
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE031_SE01_DSA_SP25', N'DSA_Assignment_1', 7.0, N'Submitted')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE031_SE01_DSA_SP25', N'DSA_Assignment_2', 6.5, N'Needs more detail')
-- If this student failed:
-- UPDATE [dbo].[Enrollments] SET [average] = 4.5, [status] = N'Failed' WHERE [enrollment_id] = N'HE031_SE01_DSA_SP25'

-- Grades for HE041_SE01_WEB_SU25 (SU25 - current/past, some grades might be in)
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE041_SE01_WEB_SU25', N'WEB_Project_1', 9.0, N'Very creative project')
-- UPDATE [dbo].[Enrollments] SET [status] = N'Studying' WHERE [enrollment_id] = N'HE041_SE01_WEB_SU25' (already studying)
GO
-- ... (This section would have ~200 StudentGradeDetails records)