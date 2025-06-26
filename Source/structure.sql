USE [master]
GO
CREATE DATABASE [text_to_sql_final]
GO
ALTER DATABASE [text_to_sql_final] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [text_to_sql_final] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [text_to_sql_final] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [text_to_sql_final] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [text_to_sql_final] SET ARITHABORT OFF 
GO
ALTER DATABASE [text_to_sql_final] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [text_to_sql_final] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [text_to_sql_final] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [text_to_sql_final] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [text_to_sql_final] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [text_to_sql_final] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [text_to_sql_final] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [text_to_sql_final] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [text_to_sql_final] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [text_to_sql_final] SET  ENABLE_BROKER 
GO
ALTER DATABASE [text_to_sql_final] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [text_to_sql_final] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [text_to_sql_final] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [text_to_sql_final] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [text_to_sql_final] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [text_to_sql_final] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [text_to_sql_final] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [text_to_sql_final] SET RECOVERY FULL 
GO
ALTER DATABASE [text_to_sql_final] SET  MULTI_USER 
GO
ALTER DATABASE [text_to_sql_final] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [text_to_sql_final] SET DB_CHAINING OFF 
GO
ALTER DATABASE [text_to_sql_final] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [text_to_sql_final] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [text_to_sql_final] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [text_to_sql_final] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'text_to_sql_final', N'ON'
GO
ALTER DATABASE [text_to_sql_final] SET QUERY_STORE = OFF
GO
USE [text_to_sql_final]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[enrollment_id] [varchar](50) NOT NULL,
	[schedule_id] [varchar](50) NOT NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED 
(
	[enrollment_id] ASC,
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassCourse]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassCourse](
	[class_course_id] [varchar](50) NOT NULL,
	[class_id] [varchar](10) NOT NULL,
	[course_id] [varchar](10) NOT NULL,
	[lecturer_id] [varchar](10) NOT NULL,
	[semester] [varchar](10) NOT NULL,
 CONSTRAINT [PK_ClassCourse] PRIMARY KEY CLUSTERED 
(
	[class_course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[class_id] [varchar](10) NOT NULL,
	[class_name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[class_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CourseGrade]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseGrade](
	[course_grade_id] [varchar](50) NOT NULL,
	[course_id] [varchar](10) NOT NULL,
	[grade_name] [nvarchar](150) NOT NULL,
	[grade_weight] [float] NOT NULL,
 CONSTRAINT [PK_CourseGrade] PRIMARY KEY CLUSTERED 
(
	[course_grade_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[course_id] [varchar](10) NOT NULL,
	[course_name] [nvarchar](150) NOT NULL,
	[no_credit] [tinyint] NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Curriculums]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curriculums](
	[major_id] [varchar](10) NOT NULL,
	[course_id] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Curriculumns] PRIMARY KEY CLUSTERED 
(
	[major_id] ASC,
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[dep_id] [varchar](10) NOT NULL,
	[dep_name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[dep_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[enrollment_id] [varchar](50) NOT NULL,
	[student_id] [varchar](10) NOT NULL,
	[class_course_id] [varchar](50) NOT NULL,
	[average] [float] NOT NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Enrollments] PRIMARY KEY CLUSTERED 
(
	[enrollment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturers]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturers](
	[lecturer_id] [varchar](10) NOT NULL,
	[dep_id] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Lecturers] PRIMARY KEY CLUSTERED 
(
	[lecturer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Majors]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Majors](
	[major_id] [varchar](10) NOT NULL,
	[major_name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Majors] PRIMARY KEY CLUSTERED 
(
	[major_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[permission_id] [varchar](10) NOT NULL,
	[permission_name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermission]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermission](
	[role_id] [varchar](10) NOT NULL,
	[permission_id] [varchar](10) NOT NULL,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [varchar](10) NOT NULL,
	[role_name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedules]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedules](
	[schedule_id] [varchar](50) NOT NULL,
	[class_course_id] [varchar](50) NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[room] [nvarchar](50) NOT NULL,
	[slot] [tinyint] NOT NULL,
 CONSTRAINT [PK_Schedules] PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentGradeDetails]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentGradeDetails](
	[enrollment_id] [varchar](50) NOT NULL,
	[course_grade_id] [varchar](50) NOT NULL,
	[grade_value] [float],
	[comment] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_StudentGradeDetails] PRIMARY KEY CLUSTERED 
(
	[enrollment_id] ASC,
	[course_grade_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[student_id] [varchar](10) NOT NULL,
	[major_id] [varchar](10) NOT NULL,
	[start_date] [date] NOT NULL,
	[start_semester] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[user_id] [varchar](10) NOT NULL,
	[role_id] [varchar](10) NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/9/2025 2:56:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](150) NOT NULL,
	[user_id] [varchar](10) NOT NULL,
	[fullname] [nvarchar](50) NOT NULL,
	[user_gender] [nvarchar](50) NOT NULL,
	[user_dob] [date] NOT NULL,
	[user_address] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Enrollments]    Script Date: 3/9/2025 2:56:56 AM ******/
ALTER TABLE [dbo].[Enrollments] ADD  CONSTRAINT [IX_Enrollments] UNIQUE NONCLUSTERED 
(
	[student_id] ASC,
	[class_course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users]    Script Date: 3/9/2025 2:56:56 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Enrollments] FOREIGN KEY([enrollment_id])
REFERENCES [dbo].[Enrollments] ([enrollment_id])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Enrollments]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Schedules] FOREIGN KEY([schedule_id])
REFERENCES [dbo].[Schedules] ([schedule_id])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Schedules]
GO
ALTER TABLE [dbo].[ClassCourse]  WITH CHECK ADD  CONSTRAINT [FK_ClassCourse_Classes] FOREIGN KEY([class_id])
REFERENCES [dbo].[Classes] ([class_id])
GO
ALTER TABLE [dbo].[ClassCourse] CHECK CONSTRAINT [FK_ClassCourse_Classes]
GO
ALTER TABLE [dbo].[ClassCourse]  WITH CHECK ADD  CONSTRAINT [FK_ClassCourse_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
GO
ALTER TABLE [dbo].[ClassCourse] CHECK CONSTRAINT [FK_ClassCourse_Courses]
GO
ALTER TABLE [dbo].[ClassCourse]  WITH CHECK ADD  CONSTRAINT [FK_ClassCourse_Lecturers] FOREIGN KEY([lecturer_id])
REFERENCES [dbo].[Lecturers] ([lecturer_id])
GO
ALTER TABLE [dbo].[ClassCourse] CHECK CONSTRAINT [FK_ClassCourse_Lecturers]
GO
ALTER TABLE [dbo].[CourseGrade]  WITH CHECK ADD  CONSTRAINT [FK_CourseGrade_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
GO
ALTER TABLE [dbo].[CourseGrade] CHECK CONSTRAINT [FK_CourseGrade_Courses]
GO
ALTER TABLE [dbo].[Curriculums]  WITH CHECK ADD  CONSTRAINT [FK_Curriculumns_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([course_id])
GO
ALTER TABLE [dbo].[Curriculums] CHECK CONSTRAINT [FK_Curriculumns_Courses]
GO
ALTER TABLE [dbo].[Curriculums]  WITH CHECK ADD  CONSTRAINT [FK_Curriculumns_Majors] FOREIGN KEY([major_id])
REFERENCES [dbo].[Majors] ([major_id])
GO
ALTER TABLE [dbo].[Curriculums] CHECK CONSTRAINT [FK_Curriculumns_Majors]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_ClassCourse] FOREIGN KEY([class_course_id])
REFERENCES [dbo].[ClassCourse] ([class_course_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_ClassCourse]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[Lecturers]  WITH CHECK ADD  CONSTRAINT [FK_Lecturers_Departments] FOREIGN KEY([dep_id])
REFERENCES [dbo].[Departments] ([dep_id])
GO
ALTER TABLE [dbo].[Lecturers] CHECK CONSTRAINT [FK_Lecturers_Departments]
GO
ALTER TABLE [dbo].[Lecturers]  WITH CHECK ADD  CONSTRAINT [FK_Lecturers_Users] FOREIGN KEY([lecturer_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Lecturers] CHECK CONSTRAINT [FK_Lecturers_Users]
GO
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permissions] ([permission_id])
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Permissions]
GO
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Roles]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [FK_Schedules_ClassCourse] FOREIGN KEY([class_course_id])
REFERENCES [dbo].[ClassCourse] ([class_course_id])
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [FK_Schedules_ClassCourse]
GO
ALTER TABLE [dbo].[StudentGradeDetails]  WITH CHECK ADD  CONSTRAINT [FK_StudentGradeDetails_CourseGrade] FOREIGN KEY([course_grade_id])
REFERENCES [dbo].[CourseGrade] ([course_grade_id])
GO
ALTER TABLE [dbo].[StudentGradeDetails] CHECK CONSTRAINT [FK_StudentGradeDetails_CourseGrade]
GO
ALTER TABLE [dbo].[StudentGradeDetails]  WITH CHECK ADD  CONSTRAINT [FK_StudentGradeDetails_Enrollments] FOREIGN KEY([enrollment_id])
REFERENCES [dbo].[Enrollments] ([enrollment_id])
GO
ALTER TABLE [dbo].[StudentGradeDetails] CHECK CONSTRAINT [FK_StudentGradeDetails_Enrollments]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Majors] FOREIGN KEY([major_id])
REFERENCES [dbo].[Majors] ([major_id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Majors]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Users] FOREIGN KEY([student_id])
REFERENCES [dbo].[Users] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Users]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Roles]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Users]
GO
USE [master]
GO
ALTER DATABASE [text_to_sql_final] SET  READ_WRITE 
GO

INSERT INTO Majors (major_id, major_name) VALUES
('AI', N'Artificial Intelligence'),       
('IA', N'Information Assurance'),      
('SE', N'Software Engineering'),     
('CS', N'Computer Science');         

INSERT INTO Departments (dep_id, dep_name) VALUES
('D01', N'Computing Fundamental'),  
('D02', N'Artificial Intelligence'),    
('D03', N'Information Assurance'),     
('D04', N'Software Engineering');     

INSERT INTO Roles (role_id, role_name) VALUES
('R001', N'Student'),                  
('R002', N'Lecturer'),                
('R003', N'Training Manager');       

INSERT INTO Courses (course_id, course_name, no_credit, description) VALUES
-- Core/Fundamental Courses
('PRF192', N'Programming Fundamentals', 3, N'Introduction to basic programming concepts and problem-solving.'),
('DBI202', N'Database Systems', 3, N'Fundamentals of database design, modeling, and SQL.'),
('MAD101', N'Mathematics for Developers', 3, N'Essential mathematical concepts for software development.'),
('CSD201', N'Data Structures and Algorithms', 3, N'Study of fundamental data structures and algorithmic techniques.'),

-- AI Major Courses
('AIL301', N'Artificial Intelligence and Machine Learning', 3, N'Core concepts of AI and machine learning algorithms.'),
('NLP302', N'Natural Language Processing', 3, N'Techniques for enabling computers to process and understand human language.'),
('AIE303', N'AI Ethics and Society', 3, N'Ethical considerations and societal impact of AI technologies.'),
('AIV304', N'AI in Vision', 3, N'Application of AI techniques in computer vision tasks.'),

-- IA Major Courses
('IAS301', N'Information Assurance and Security', 3, N'Principles of information assurance, risk management, and security policies.'),
('NET302', N'Network Security', 3, N'Techniques for securing computer networks and communications.'),
('CRY303', N'Cryptography', 3, N'Foundations of cryptographic algorithms and protocols.'),
('ISS304', N'Information Security Systems', 3, N'Design and implementation of secure information systems.'),

-- SE Major Courses
('SWE301', N'Software Engineering Principles', 3, N'Fundamental principles and practices of software engineering.'),
('PRJ302', N'Software Project Management', 3, N'Managing software development projects, including planning and execution.'),
('SDE303', N'Software Design and Architecture', 3, N'Principles of software design patterns and architectural styles.'),
('SWT304', N'Software Testing and Quality Assurance', 3, N'Methods for software testing, verification, and validation.'),

-- CS Major Courses
('TOC201', N'Theory of Computation', 3, N'Formal languages, automata theory, and computability.'),
('OSG202', N'Operating Systems', 3, N'Principles of operating system design and implementation.'),
('CNW203', N'Computer Networks', 3, N'Fundamentals of computer networking, protocols, and architectures.'),
('PPL204', N'Programming Paradigms', 3, N'Exploration of different programming language paradigms.');

-- Ngành Artificial Intelligence (AI) - 6 môn
INSERT INTO Curriculums (major_id, course_id) VALUES
('AI', 'PRF192'), -- Programming Fundamentals
('AI', 'CSD201'), -- Data Structures and Algorithms
('AI', 'AIL301'), -- Artificial Intelligence and Machine Learning
('AI', 'NLP302'), -- Natural Language Processing
('AI', 'AIE303'), -- AI Ethics and Society
('AI', 'AIV304'); -- AI in Vision

-- Ngành Information Assurance (IA) - 6 môn
INSERT INTO Curriculums (major_id, course_id) VALUES
('IA', 'PRF192'), -- Programming Fundamentals
('IA', 'DBI202'), -- Database Systems
('IA', 'IAS301'), -- Information Assurance and Security
('IA', 'NET302'), -- Network Security
('IA', 'CRY303'), -- Cryptography
('IA', 'ISS304'); -- Information Security Systems

-- Ngành Software Engineering (SE) - 6 môn
INSERT INTO Curriculums (major_id, course_id) VALUES
('SE', 'PRF192'), -- Programming Fundamentals
('SE', 'MAD101'), -- Mathematics for Developers
('SE', 'SWE301'), -- Software Engineering Principles
('SE', 'PRJ302'), -- Software Project Management
('SE', 'SDE303'), -- Software Design and Architecture
('SE', 'SWT304'); -- Software Testing and Quality Assurance

-- Ngành Computer Science (CS) - 6 môn
INSERT INTO Curriculums (major_id, course_id) VALUES
('CS', 'CSD201'), -- Data Structures and Algorithms
('CS', 'DBI202'), -- Database Systems
('CS', 'TOC201'), -- Theory of Computation
('CS', 'OSG202'), -- Operating Systems
('CS', 'CNW203'), -- Computer Networks
('CS', 'PPL204'); -- Programming Paradigms


-- Training Manager (1 record)
INSERT INTO Users (user_id, username, password, fullname, user_gender, user_dob, user_address) VALUES
('TM001', 'quantm', 'hashed_password_tm', N'Quản Trọng Minh', 'male', '1975-05-10', N'Hà Nội');

-- Lecturers (10 records)
INSERT INTO Users (user_id, username, password, fullname, user_gender, user_dob, user_address) VALUES
('LEC001', 'binhnv', 'hashed_password_lec', N'Nguyễn Văn Bình', 'male', '1980-03-15', N'Hà Nội'),
('LEC002', 'hoangnt', 'hashed_password_lec', N'Nguyễn Thị Hoàng', 'female', '1982-07-22', N'Hải Phòng'),
('LEC003', 'trungtd', 'hashed_password_lec', N'Trần Đức Trung', 'male', '1978-11-05', N'Đà Nẵng'),
('LEC004', 'linhph', 'hashed_password_lec', N'Phạm Hoài Linh', 'female', '1985-01-30', N'TP. Hồ Chí Minh'),
('LEC005', 'anhdv', 'hashed_password_lec', N'Đỗ Việt Anh', 'male', '1983-09-12', N'Cần Thơ'),
('LEC006', 'maitt', 'hashed_password_lec', N'Trần Thị Mai', 'female', '1988-06-25', N'Bắc Ninh'),
('LEC007', 'longlh', 'hashed_password_lec', N'Lê Hoàng Long', 'male', '1976-12-01', N'Nghệ An'),
('LEC008', 'quyenvp', 'hashed_password_lec', N'Vũ Phương Quyên', 'female', '1990-04-18', N'Thanh Hóa'),
('LEC009', 'sonhv', 'hashed_password_lec', N'Hoàng Việt Sơn', 'male', '1981-08-08', N'Quảng Ninh'),
('LEC010', 'thaohtp', 'hashed_password_lec', N'Hồ Thị Phương Thảo', 'female', '1987-02-14', N'Huế');

-- Students (50 records)
-- For brevity, student usernames can be derived from user_id. Passwords are the same generic hashed one.
-- User IDs will be HE00001 to HE00050
INSERT INTO Users (user_id, username, password, fullname, user_gender, user_dob, user_address) VALUES
('HE00001', 'he00001_user', 'hashed_password_stu', N'Nguyễn Văn An', 'male', '2003-01-10', N'Hà Nội'),
('HE00002', 'he00002_user', 'hashed_password_stu', N'Trần Thị Bình', 'female', '2003-02-15', N'TP. Hồ Chí Minh'),
('HE00003', 'he00003_user', 'hashed_password_stu', N'Lê Văn Cường', 'male', '2004-03-20', N'Đà Nẵng'),
('HE00004', 'he00004_user', 'hashed_password_stu', N'Phạm Thị Dung', 'female', '2003-04-25', N'Hải Phòng'),
('HE00005', 'he00005_user', 'hashed_password_stu', N'Hoàng Văn Giang', 'male', '2004-05-30', N'Cần Thơ'),
('HE00006', 'he00006_user', 'hashed_password_stu', N'Vũ Thị Hương', 'female', '2003-06-05', N'An Giang'),
('HE00007', 'he00007_user', 'hashed_password_stu', N'Đặng Văn Khánh', 'male', '2004-07-10', N'Bà Rịa - Vũng Tàu'),
('HE00008', 'he00008_user', 'hashed_password_stu', N'Bùi Thị Lan', 'female', '2003-08-15', N'Bắc Giang'),
('HE00009', 'he00009_user', 'hashed_password_stu', N'Hồ Văn Minh', 'male', '2004-09-20', N'Bắc Kạn'),
('HE00010', 'he00010_user', 'hashed_password_stu', N'Ngô Thị Nga', 'female', '2003-10-25', N'Bạc Liêu'),
('HE00011', 'he00011_user', 'hashed_password_stu', N'Dương Văn Oai', 'male', '2004-11-30', N'Bắc Ninh'),
('HE00012', 'he00012_user', 'hashed_password_stu', N'Đoàn Thị Phượng', 'female', '2003-12-05', N'Bến Tre'),
('HE00013', 'he00013_user', 'hashed_password_stu', N'Lý Văn Quân', 'male', '2004-01-10', N'Bình Định'),
('HE00014', 'he00014_user', 'hashed_password_stu', N'Mai Thị Quỳnh', 'female', '2003-02-15', N'Bình Dương'),
('HE00015', 'he00015_user', 'hashed_password_stu', N'Phan Văn Sơn', 'male', '2004-03-20', N'Bình Phước'),
('HE00016', 'he00016_user', 'hashed_password_stu', N'Châu Thị Thảo', 'female', '2003-04-25', N'Bình Thuận'),
('HE00017', 'he00017_user', 'hashed_password_stu', N'Tăng Văn Toàn', 'male', '2004-05-30', N'Cà Mau'),
('HE00018', 'he00018_user', 'hashed_password_stu', N'Kiều Thị Trinh', 'female', '2003-06-05', N'Cao Bằng'),
('HE00019', 'he00019_user', 'hashed_password_stu', N'Trịnh Văn Tuấn', 'male', '2004-07-10', N'Đắk Lắk'),
('HE00020', 'he00020_user', 'hashed_password_stu', N'Vương Thị Uyên', 'female', '2003-08-15', N'Đắk Nông'),
('HE00021', 'he00021_user', 'hashed_password_stu', N'Nguyễn Đình Anh', 'male', '2002-09-01', N'Điện Biên'),
('HE00022', 'he00022_user', 'hashed_password_stu', N'Lê Ngọc Bích', 'female', '2003-10-11', N'Đồng Nai'),
('HE00023', 'he00023_user', 'hashed_password_stu', N'Trần Minh Chiến', 'male', '2002-11-21', N'Đồng Tháp'),
('HE00024', 'he00024_user', 'hashed_password_stu', N'Phạm Thu Diệu', 'female', '2003-12-01', N'Gia Lai'),
('HE00025', 'he00025_user', 'hashed_password_stu', N'Võ Thành Đạt', 'male', '2002-01-15', N'Hà Giang'),
('HE00026', 'he00026_user', 'hashed_password_stu', N'Hoàng Thị Kim Anh', 'female', '2003-02-25', N'Hà Nam'),
('HE00027', 'he00027_user', 'hashed_password_stu', N'Đỗ Quốc Bảo', 'male', '2002-03-05', N'Hà Tĩnh'),
('HE00028', 'he00028_user', 'hashed_password_stu', N'Nguyễn Phương Linh', 'female', '2003-04-15', N'Hải Dương'),
('HE00029', 'he00029_user', 'hashed_password_stu', N'Lê Quang Huy', 'male', '2002-05-25', N'Hậu Giang'),
('HE00030', 'he00030_user', 'hashed_password_stu', N'Trần Diệu My', 'female', '2003-06-08', N'Hòa Bình'),
('HE00031', 'he00031_user', 'hashed_password_stu', N'Phan Anh Tuấn', 'male', '2002-07-18', N'Hưng Yên'),
('HE00032', 'he00032_user', 'hashed_password_stu', N'Vũ Thùy Dương', 'female', '2003-08-28', N'Khánh Hòa'),
('HE00033', 'he00033_user', 'hashed_password_stu', N'Hoàng Minh Đức', 'male', '2002-09-09', N'Kiên Giang'),
('HE00034', 'he00034_user', 'hashed_password_stu', N'Lê Thị Thu Trang', 'female', '2003-10-19', N'Kon Tum'),
('HE00035', 'he00035_user', 'hashed_password_stu', N'Nguyễn Tiến Dũng', 'male', '2002-11-29', N'Lai Châu'),
('HE00036', 'he00036_user', 'hashed_password_stu', N'Trần Ngọc Mai', 'female', '2003-12-09', N'Lâm Đồng'),
('HE00037', 'he00037_user', 'hashed_password_stu', N'Phạm Văn Hải', 'male', '2002-01-01', N'Lạng Sơn'),
('HE00038', 'he00038_user', 'hashed_password_stu', N'Võ Thị Kim Chi', 'female', '2003-02-11', N'Lào Cai'),
('HE00039', 'he00039_user', 'hashed_password_stu', N'Đặng Minh Khôi', 'male', '2002-03-21', N'Long An'),
('HE00040', 'he00040_user', 'hashed_password_stu', N'Bùi Thanh Thảo', 'female', '2003-04-01', N'Nam Định'),
('HE00041', 'he00041_user', 'hashed_password_stu', N'Hồ Đức Anh', 'male', '2002-05-12', N'Nghệ An'),
('HE00042', 'he00042_user', 'hashed_password_stu', N'Ngô Thùy Linh', 'female', '2003-06-22', N'Ninh Bình'),
('HE00043', 'he00043_user', 'hashed_password_stu', N'Dương Công Thành', 'male', '2002-07-02', N'Ninh Thuận'),
('HE00044', 'he00044_user', 'hashed_password_stu', N'Đoàn Minh Nguyệt', 'female', '2003-08-12', N'Phú Thọ'),
('HE00045', 'he00045_user', 'hashed_password_stu', N'Lý Hoàng Nam', 'male', '2002-09-22', N'Phú Yên'),
('HE00046', 'he00046_user', 'hashed_password_stu', N'Mai Bảo Châu', 'female', '2003-10-03', N'Quảng Bình'),
('HE00047', 'he00047_user', 'hashed_password_stu', N'Phan Tuấn Kiệt', 'male', '2002-11-13', N'Quảng Nam'),
('HE00048', 'he00048_user', 'hashed_password_stu', N'Châu Mỹ Lệ', 'female', '2003-12-23', N'Quảng Ngãi'),
('HE00049', 'he00049_user', 'hashed_password_stu', N'Tăng Quốc Hùng', 'male', '2002-01-04', N'Quảng Ninh'),
('HE00050', 'he00050_user', 'hashed_password_stu', N'Kiều Diễm My', 'female', '2003-02-14', N'Quảng Trị');


-- Sinh viên ngành Artificial Intelligence (AI) - 13 sinh viên
-- Phân bổ: ~4 FA23, ~5 SP24, ~4 SU24
INSERT INTO Students (student_id, major_id, start_date, start_semester) VALUES
('HE00001', 'AI', '2023-09-04', 'FA23'),
('HE00002', 'AI', '2023-09-04', 'FA23'),
('HE00003', 'AI', '2023-09-04', 'FA23'),
('HE00004', 'AI', '2023-09-04', 'FA23'),
('HE00005', 'AI', '2024-01-08', 'SP24'),
('HE00006', 'AI', '2024-01-08', 'SP24'),
('HE00007', 'AI', '2024-01-08', 'SP24'),
('HE00008', 'AI', '2024-01-08', 'SP24'),
('HE00009', 'AI', '2024-01-08', 'SP24'),
('HE00010', 'AI', '2024-05-06', 'SU24'),
('HE00011', 'AI', '2024-05-06', 'SU24'),
('HE00012', 'AI', '2024-05-06', 'SU24'),
('HE00013', 'AI', '2024-05-06', 'SU24');

-- Sinh viên ngành Information Assurance (IA) - 12 sinh viên
-- Phân bổ: ~4 FA23, ~4 SP24, ~4 SU24
INSERT INTO Students (student_id, major_id, start_date, start_semester) VALUES
('HE00014', 'IA', '2023-09-04', 'FA23'),
('HE00015', 'IA', '2023-09-04', 'FA23'),
('HE00016', 'IA', '2023-09-04', 'FA23'),
('HE00017', 'IA', '2023-09-04', 'FA23'),
('HE00018', 'IA', '2024-01-08', 'SP24'),
('HE00019', 'IA', '2024-01-08', 'SP24'),
('HE00020', 'IA', '2024-01-08', 'SP24'),
('HE00021', 'IA', '2024-01-08', 'SP24'),
('HE00022', 'IA', '2024-05-06', 'SU24'),
('HE00023', 'IA', '2024-05-06', 'SU24'),
('HE00024', 'IA', '2024-05-06', 'SU24'),
('HE00025', 'IA', '2024-05-06', 'SU24');

-- Sinh viên ngành Software Engineering (SE) - 13 sinh viên
-- Phân bổ: ~4 FA23, ~5 SP24, ~4 SU24
INSERT INTO Students (student_id, major_id, start_date, start_semester) VALUES
('HE00026', 'SE', '2023-09-04', 'FA23'),
('HE00027', 'SE', '2023-09-04', 'FA23'),
('HE00028', 'SE', '2023-09-04', 'FA23'),
('HE00029', 'SE', '2023-09-04', 'FA23'),
('HE00030', 'SE', '2024-01-08', 'SP24'),
('HE00031', 'SE', '2024-01-08', 'SP24'),
('HE00032', 'SE', '2024-01-08', 'SP24'),
('HE00033', 'SE', '2024-01-08', 'SP24'),
('HE00034', 'SE', '2024-01-08', 'SP24'),
('HE00035', 'SE', '2024-05-06', 'SU24'),
('HE00036', 'SE', '2024-05-06', 'SU24'),
('HE00037', 'SE', '2024-05-06', 'SU24'),
('HE00038', 'SE', '2024-05-06', 'SU24');

-- Sinh viên ngành Computer Science (CS) - 12 sinh viên
-- Phân bổ: ~4 FA23, ~4 SP24, ~4 SU24
INSERT INTO Students (student_id, major_id, start_date, start_semester) VALUES
('HE00039', 'CS', '2023-09-04', 'FA23'),
('HE00040', 'CS', '2023-09-04', 'FA23'),
('HE00041', 'CS', '2023-09-04', 'FA23'),
('HE00042', 'CS', '2023-09-04', 'FA23'),
('HE00043', 'CS', '2024-01-08', 'SP24'),
('HE00044', 'CS', '2024-01-08', 'SP24'),
('HE00045', 'CS', '2024-01-08', 'SP24'),
('HE00046', 'CS', '2024-01-08', 'SP24'),
('HE00047', 'CS', '2024-05-06', 'SU24'),
('HE00048', 'CS', '2024-05-06', 'SU24'),
('HE00049', 'CS', '2024-05-06', 'SU24'),
('HE00050', 'CS', '2024-05-06', 'SU24');


INSERT INTO Lecturers (lecturer_id, dep_id) VALUES
('LEC001', 'D02'),
('LEC002', 'D04'), 
('LEC003', 'D01'), 
('LEC004', 'D03'), 
('LEC005', 'D02'), 
('LEC006', 'D04'), 
('LEC007', 'D01'), 
('LEC008', 'D03'), 
('LEC009', 'D02'), 
('LEC010', 'D04'); 


-- Training Manager (1 record)
INSERT INTO UserRole (user_id, role_id) VALUES
('TM001', 'R003');

-- Lecturers (10 records)
INSERT INTO UserRole (user_id, role_id) VALUES
('LEC001', 'R002'),
('LEC002', 'R002'),
('LEC003', 'R002'),
('LEC004', 'R002'),
('LEC005', 'R002'),
('LEC006', 'R002'),
('LEC007', 'R002'),
('LEC008', 'R002'),
('LEC009', 'R002'),
('LEC010', 'R002');

-- Students (50 records)
INSERT INTO UserRole (user_id, role_id) VALUES
('HE00001', 'R001'),
('HE00002', 'R001'),
('HE00003', 'R001'),
('HE00004', 'R001'),
('HE00005', 'R001'),
('HE00006', 'R001'),
('HE00007', 'R001'),
('HE00008', 'R001'),
('HE00009', 'R001'),
('HE00010', 'R001'),
('HE00011', 'R001'),
('HE00012', 'R001'),
('HE00013', 'R001'),
('HE00014', 'R001'),
('HE00015', 'R001'),
('HE00016', 'R001'),
('HE00017', 'R001'),
('HE00018', 'R001'),
('HE00019', 'R001'),
('HE00020', 'R001'),
('HE00021', 'R001'),
('HE00022', 'R001'),
('HE00023', 'R001'),
('HE00024', 'R001'),
('HE00025', 'R001'),
('HE00026', 'R001'),
('HE00027', 'R001'),
('HE00028', 'R001'),
('HE00029', 'R001'),
('HE00030', 'R001'),
('HE00031', 'R001'),
('HE00032', 'R001'),
('HE00033', 'R001'),
('HE00034', 'R001'),
('HE00035', 'R001'),
('HE00036', 'R001'),
('HE00037', 'R001'),
('HE00038', 'R001'),
('HE00039', 'R001'),
('HE00040', 'R001'),
('HE00041', 'R001'),
('HE00042', 'R001'),
('HE00043', 'R001'),
('HE00044', 'R001'),
('HE00045', 'R001'),
('HE00046', 'R001'),
('HE00047', 'R001'),
('HE00048', 'R001'),
('HE00049', 'R001'),
('HE00050', 'R001');


INSERT INTO Classes (class_id, class_name) VALUES
('AI_K1_FA23','AI01'),
('AI_K2_SP24','AI02'),
('IA_K1_FA23', 'IA01'),
('IA_K2_SU24', 'IA02'),
('SE_K1_SP24', 'SE01'),
('SE_K2_SU24', 'SE02'),
('CS_K1_FA23', 'CS01'),
('CS_K2_SP24', 'CS02');


-- Class: AI_K1_FA23 (Major AI)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23', 'PRF192', 'LEC001', 'SP24'),
('AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23', 'CSD201', 'LEC002', 'SP24'),
('AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23', 'AIL301', 'LEC003', 'SU24'),
('AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23', 'NLP302', 'LEC004', 'SU24');

-- Class: AI_K2_SP24 (Major AI)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24', 'PRF192', 'LEC005', 'SP24'),
('AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24', 'CSD201', 'LEC006', 'SP24'),
('AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24', 'AIL301', 'LEC007', 'SU24'),
('AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24', 'NLP302', 'LEC008', 'SU24');

-- Class: IA_K1_FA23 (Major IA)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23', 'PRF192', 'LEC009', 'SP24'),
('IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23', 'DBI202', 'LEC010', 'SP24'),
('IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23', 'IAS301', 'LEC001', 'SU24'),
('IA_K1_FA23_NET302_SU24', 'IA_K1_FA23', 'NET302', 'LEC002', 'SU24');

-- Class: IA_K2_SU24 (Major IA)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24', 'PRF192', 'LEC003', 'SP24'),
('IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24', 'DBI202', 'LEC004', 'SP24'),
('IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24', 'IAS301', 'LEC005', 'SU24'),
('IA_K2_SU24_NET302_SU24', 'IA_K2_SU24', 'NET302', 'LEC006', 'SU24');

-- Class: SE_K1_SP24 (Major SE)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24', 'PRF192', 'LEC007', 'SP24'),
('SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24', 'MAD101', 'LEC008', 'SP24'),
('SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24', 'SWE301', 'LEC009', 'SU24'),
('SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24', 'PRJ302', 'LEC010', 'SU24');

-- Class: SE_K2_SU24 (Major SE)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24', 'PRF192', 'LEC001', 'SP24'),
('SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24', 'MAD101', 'LEC002', 'SP24'),
('SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24', 'SWE301', 'LEC003', 'SU24'),
('SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24', 'PRJ302', 'LEC004', 'SU24');

-- Class: CS_K1_FA23 (Major CS)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23', 'CSD201', 'LEC005', 'SP24'),
('CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23', 'DBI202', 'LEC006', 'SP24'),
('CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23', 'TOC201', 'LEC007', 'SU24'),
('CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23', 'OSG202', 'LEC008', 'SU24');

-- Class: CS_K2_SP24 (Major CS)
INSERT INTO ClassCourse (class_course_id, class_id, course_id, lecturer_id, semester) VALUES
('CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24', 'CSD201', 'LEC009', 'SP24'),
('CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24', 'DBI202', 'LEC010', 'SP24'),
('CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24', 'TOC201', 'LEC001', 'SU24'),
('CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24', 'OSG202', 'LEC002', 'SU24');


-- Bảng Enrollment
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00001_AI_K1_FA23_PRF192_SP24', 'HE00001', 'AI_K1_FA23_PRF192_SP24', 7.5, 'Passed'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'HE00001', 'AI_K1_FA23_CSD201_SP24', 8.0, 'Passed'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'HE00001', 'AI_K1_FA23_AIL301_SU24', 0, 'Studying'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'HE00001', 'AI_K1_FA23_NLP302_SU24', 0, 'Studying');
-- Student HE00002
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00002_AI_K1_FA23_PRF192_SP24', 'HE00002', 'AI_K1_FA23_PRF192_SP24', 4.2, 'Failed'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'HE00002', 'AI_K1_FA23_CSD201_SP24', 6.5, 'Passed'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'HE00002', 'AI_K1_FA23_AIL301_SU24', 0, 'Studying'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'HE00002', 'AI_K1_FA23_NLP302_SU24', 0, 'Studying');
-- Student HE00003
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00003_AI_K1_FA23_PRF192_SP24', 'HE00003', 'AI_K1_FA23_PRF192_SP24', 8.8, 'Passed'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'HE00003', 'AI_K1_FA23_CSD201_SP24', 9.0, 'Passed'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'HE00003', 'AI_K1_FA23_AIL301_SU24', 0, 'Studying'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'HE00003', 'AI_K1_FA23_NLP302_SU24', 0, 'Studying');
-- Student HE00004
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00004_AI_K1_FA23_PRF192_SP24', 'HE00004', 'AI_K1_FA23_PRF192_SP24', 5.5, 'Passed'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'HE00004', 'AI_K1_FA23_CSD201_SP24', 3.9, 'Failed'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'HE00004', 'AI_K1_FA23_AIL301_SU24', 0, 'Studying'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'HE00004', 'AI_K1_FA23_NLP302_SU24', 0, 'Studying');

-- Enrollments for Class AI_K2_SP24 (SP24 Intake: HE00005-HE00009)
-- Student HE00005
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00005_AI_K2_SP24_PRF192_SP24', 'HE00005', 'AI_K2_SP24_PRF192_SP24', 9.2, 'Passed'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'HE00005', 'AI_K2_SP24_CSD201_SP24', 8.5, 'Passed'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'HE00005', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'HE00005', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- ... (HE00006 - HE00009 following similar pattern, 4 enrollments each, SP24 grades varied, SU24 studying)
-- Student HE00006
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00006_AI_K2_SP24_PRF192_SP24', 'HE00006', 'AI_K2_SP24_PRF192_SP24', 7.0, 'Passed'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'HE00006', 'AI_K2_SP24_CSD201_SP24', 6.8, 'Passed'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'HE00006', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'HE00006', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- Student HE00007
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00007_AI_K2_SP24_PRF192_SP24', 'HE00007', 'AI_K2_SP24_PRF192_SP24', 3.5, 'Failed'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'HE00007', 'AI_K2_SP24_CSD201_SP24', 5.0, 'Passed'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'HE00007', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'HE00007', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- Student HE00008
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00008_AI_K2_SP24_PRF192_SP24', 'HE00008', 'AI_K2_SP24_PRF192_SP24', 8.1, 'Passed'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'HE00008', 'AI_K2_SP24_CSD201_SP24', 7.7, 'Passed'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'HE00008', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'HE00008', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- Student HE00009
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00009_AI_K2_SP24_PRF192_SP24', 'HE00009', 'AI_K2_SP24_PRF192_SP24', 6.2, 'Passed'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'HE00009', 'AI_K2_SP24_CSD201_SP24', 4.8, 'Failed'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'HE00009', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'HE00009', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');

-- Enrollments for Class AI_K2_SP24 (SU24 Intake: HE00010-HE00013 - Only SU24 Courses)
-- Student HE00010
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00010_AI_K2_SP24_AIL301_SU24', 'HE00010', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'HE00010', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- Student HE00011
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00011_AI_K2_SP24_AIL301_SU24', 'HE00011', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'HE00011', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- Student HE00012
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00012_AI_K2_SP24_AIL301_SU24', 'HE00012', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'HE00012', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');
-- Student HE00013
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00013_AI_K2_SP24_AIL301_SU24', 'HE00013', 'AI_K2_SP24_AIL301_SU24', 0, 'Studying'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'HE00013', 'AI_K2_SP24_NLP302_SU24', 0, 'Studying');

-- Enrollments for Class IA_K1_FA23 (Students: HE00014-HE00017)
-- Student HE00014
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00014_IA_K1_FA23_PRF192_SP24', 'HE00014', 'IA_K1_FA23_PRF192_SP24', 6.0, 'Passed'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'HE00014', 'IA_K1_FA23_DBI202_SP24', 7.2, 'Passed'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'HE00014', 'IA_K1_FA23_IAS301_SU24', 0, 'Studying'),
('HE00014_IA_K1_FA23_NET302_SU24', 'HE00014', 'IA_K1_FA23_NET302_SU24', 0, 'Studying');
-- ... (HE00015 - HE00017 following similar pattern)
-- Student HE00015
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00015_IA_K1_FA23_PRF192_SP24', 'HE00015', 'IA_K1_FA23_PRF192_SP24', 3.0, 'Failed'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'HE00015', 'IA_K1_FA23_DBI202_SP24', 5.5, 'Passed'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'HE00015', 'IA_K1_FA23_IAS301_SU24', 0, 'Studying'),
('HE00015_IA_K1_FA23_NET302_SU24', 'HE00015', 'IA_K1_FA23_NET302_SU24', 0, 'Studying');
-- Student HE00016
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00016_IA_K1_FA23_PRF192_SP24', 'HE00016', 'IA_K1_FA23_PRF192_SP24', 8.5, 'Passed'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'HE00016', 'IA_K1_FA23_DBI202_SP24', 9.0, 'Passed'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'HE00016', 'IA_K1_FA23_IAS301_SU24', 0, 'Studying'),
('HE00016_IA_K1_FA23_NET302_SU24', 'HE00016', 'IA_K1_FA23_NET302_SU24', 0, 'Studying');
-- Student HE00017
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00017_IA_K1_FA23_PRF192_SP24', 'HE00017', 'IA_K1_FA23_PRF192_SP24', 7.8, 'Passed'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'HE00017', 'IA_K1_FA23_DBI202_SP24', 4.1, 'Failed'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'HE00017', 'IA_K1_FA23_IAS301_SU24', 0, 'Studying'),
('HE00017_IA_K1_FA23_NET302_SU24', 'HE00017', 'IA_K1_FA23_NET302_SU24', 0, 'Studying');

-- Enrollments for Class IA_K2_SU24 (SP24 Intake: HE00018-HE00021)
-- Student HE00018
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00018_IA_K2_SU24_PRF192_SP24', 'HE00018', 'IA_K2_SU24_PRF192_SP24', 5.2, 'Passed'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'HE00018', 'IA_K2_SU24_DBI202_SP24', 6.7, 'Passed'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'HE00018', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00018_IA_K2_SU24_NET302_SU24', 'HE00018', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');
-- ... (HE00019 - HE00021 following similar pattern)
-- Student HE00019
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00019_IA_K2_SU24_PRF192_SP24', 'HE00019', 'IA_K2_SU24_PRF192_SP24', 9.0, 'Passed'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'HE00019', 'IA_K2_SU24_DBI202_SP24', 8.8, 'Passed'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'HE00019', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00019_IA_K2_SU24_NET302_SU24', 'HE00019', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');
-- Student HE00020
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00020_IA_K2_SU24_PRF192_SP24', 'HE00020', 'IA_K2_SU24_PRF192_SP24', 4.5, 'Failed'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'HE00020', 'IA_K2_SU24_DBI202_SP24', 3.8, 'Failed'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'HE00020', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00020_IA_K2_SU24_NET302_SU24', 'HE00020', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');
-- Student HE00021
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00021_IA_K2_SU24_PRF192_SP24', 'HE00021', 'IA_K2_SU24_PRF192_SP24', 7.3, 'Passed'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'HE00021', 'IA_K2_SU24_DBI202_SP24', 6.1, 'Passed'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'HE00021', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00021_IA_K2_SU24_NET302_SU24', 'HE00021', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');

-- Enrollments for Class IA_K2_SU24 (SU24 Intake: HE00022-HE00025 - Only SU24 Courses)
-- Student HE00022
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00022_IA_K2_SU24_IAS301_SU24', 'HE00022', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00022_IA_K2_SU24_NET302_SU24', 'HE00022', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');
-- ... (HE00023 - HE00025, 2 enrollments each for SU24)
-- Student HE00023
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00023_IA_K2_SU24_IAS301_SU24', 'HE00023', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00023_IA_K2_SU24_NET302_SU24', 'HE00023', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');
-- Student HE00024
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00024_IA_K2_SU24_IAS301_SU24', 'HE00024', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00024_IA_K2_SU24_NET302_SU24', 'HE00024', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');
-- Student HE00025
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00025_IA_K2_SU24_IAS301_SU24', 'HE00025', 'IA_K2_SU24_IAS301_SU24', 0, 'Studying'),
('HE00025_IA_K2_SU24_NET302_SU24', 'HE00025', 'IA_K2_SU24_NET302_SU24', 0, 'Studying');


-- Enrollments for Class SE_K1_SP24 (Students: HE00026-HE00029 - FA23 Intake)
-- Student HE00026
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00026_SE_K1_SP24_PRF192_SP24', 'HE00026', 'SE_K1_SP24_PRF192_SP24', 7.8, 'Passed'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'HE00026', 'SE_K1_SP24_MAD101_SP24', 8.2, 'Passed'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'HE00026', 'SE_K1_SP24_SWE301_SU24', 0, 'Studying'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'HE00026', 'SE_K1_SP24_PRJ302_SU24', 0, 'Studying');
-- ... (HE00027 - HE00029)
-- Student HE00027
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00027_SE_K1_SP24_PRF192_SP24', 'HE00027', 'SE_K1_SP24_PRF192_SP24', 4.0, 'Failed'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'HE00027', 'SE_K1_SP24_MAD101_SP24', 6.0, 'Passed'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'HE00027', 'SE_K1_SP24_SWE301_SU24', 0, 'Studying'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'HE00027', 'SE_K1_SP24_PRJ302_SU24', 0, 'Studying');
-- Student HE00028
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00028_SE_K1_SP24_PRF192_SP24', 'HE00028', 'SE_K1_SP24_PRF192_SP24', 9.5, 'Passed'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'HE00028', 'SE_K1_SP24_MAD101_SP24', 8.9, 'Passed'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'HE00028', 'SE_K1_SP24_SWE301_SU24', 0, 'Studying'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'HE00028', 'SE_K1_SP24_PRJ302_SU24', 0, 'Studying');
-- Student HE00029
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00029_SE_K1_SP24_PRF192_SP24', 'HE00029', 'SE_K1_SP24_PRF192_SP24', 5.0, 'Passed'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'HE00029', 'SE_K1_SP24_MAD101_SP24', 4.3, 'Failed'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'HE00029', 'SE_K1_SP24_SWE301_SU24', 0, 'Studying'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'HE00029', 'SE_K1_SP24_PRJ302_SU24', 0, 'Studying');

-- Enrollments for Class SE_K2_SU24 (SP24 Intake: HE00030-HE00034)
-- Student HE00030
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00030_SE_K2_SU24_PRF192_SP24', 'HE00030', 'SE_K2_SU24_PRF192_SP24', 8.0, 'Passed'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'HE00030', 'SE_K2_SU24_MAD101_SP24', 7.5, 'Passed'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'HE00030', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'HE00030', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- ... (HE00031 - HE00034)
-- Student HE00031
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00031_SE_K2_SU24_PRF192_SP24', 'HE00031', 'SE_K2_SU24_PRF192_SP24', 6.5, 'Passed'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'HE00031', 'SE_K2_SU24_MAD101_SP24', 7.0, 'Passed'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'HE00031', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'HE00031', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- Student HE00032
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00032_SE_K2_SU24_PRF192_SP24', 'HE00032', 'SE_K2_SU24_PRF192_SP24', 3.2, 'Failed'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'HE00032', 'SE_K2_SU24_MAD101_SP24', 5.8, 'Passed'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'HE00032', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'HE00032', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- Student HE00033
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00033_SE_K2_SU24_PRF192_SP24', 'HE00033', 'SE_K2_SU24_PRF192_SP24', 8.8, 'Passed'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'HE00033', 'SE_K2_SU24_MAD101_SP24', 9.1, 'Passed'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'HE00033', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'HE00033', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- Student HE00034
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00034_SE_K2_SU24_PRF192_SP24', 'HE00034', 'SE_K2_SU24_PRF192_SP24', 5.9, 'Passed'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'HE00034', 'SE_K2_SU24_MAD101_SP24', 4.0, 'Failed'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'HE00034', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'HE00034', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');

-- Enrollments for Class SE_K2_SU24 (SU24 Intake: HE00035-HE00038 - Only SU24 Courses)
-- Student HE00035
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00035_SE_K2_SU24_SWE301_SU24', 'HE00035', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'HE00035', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- ... (HE00036 - HE00038)
-- Student HE00036
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00036_SE_K2_SU24_SWE301_SU24', 'HE00036', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'HE00036', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- Student HE00037
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00037_SE_K2_SU24_SWE301_SU24', 'HE00037', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'HE00037', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');
-- Student HE00038
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00038_SE_K2_SU24_SWE301_SU24', 'HE00038', 'SE_K2_SU24_SWE301_SU24', 0, 'Studying'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'HE00038', 'SE_K2_SU24_PRJ302_SU24', 0, 'Studying');

-- Enrollments for Class CS_K1_FA23 (Students: HE00039-HE00042 - FA23 Intake)
-- Student HE00039
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00039_CS_K1_FA23_CSD201_SP24', 'HE00039', 'CS_K1_FA23_CSD201_SP24', 8.5, 'Passed'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'HE00039', 'CS_K1_FA23_DBI202_SP24', 7.0, 'Passed'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'HE00039', 'CS_K1_FA23_TOC201_SU24', 0, 'Studying'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'HE00039', 'CS_K1_FA23_OSG202_SU24', 0, 'Studying');
-- ... (HE00040 - HE00042)
-- Student HE00040
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00040_CS_K1_FA23_CSD201_SP24', 'HE00040', 'CS_K1_FA23_CSD201_SP24', 4.8, 'Failed'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'HE00040', 'CS_K1_FA23_DBI202_SP24', 6.2, 'Passed'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'HE00040', 'CS_K1_FA23_TOC201_SU24', 0, 'Studying'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'HE00040', 'CS_K1_FA23_OSG202_SU24', 0, 'Studying');
-- Student HE00041
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00041_CS_K1_FA23_CSD201_SP24', 'HE00041', 'CS_K1_FA23_CSD201_SP24', 9.0, 'Passed'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'HE00041', 'CS_K1_FA23_DBI202_SP24', 9.3, 'Passed'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'HE00041', 'CS_K1_FA23_TOC201_SU24', 0, 'Studying'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'HE00041', 'CS_K1_FA23_OSG202_SU24', 0, 'Studying');
-- Student HE00042
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00042_CS_K1_FA23_CSD201_SP24', 'HE00042', 'CS_K1_FA23_CSD201_SP24', 6.7, 'Passed'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'HE00042', 'CS_K1_FA23_DBI202_SP24', 3.3, 'Failed'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'HE00042', 'CS_K1_FA23_TOC201_SU24', 0, 'Studying'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'HE00042', 'CS_K1_FA23_OSG202_SU24', 0, 'Studying');

-- Enrollments for Class CS_K2_SP24 (SP24 Intake: HE00043-HE00046)
-- Student HE00043
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00043_CS_K2_SP24_CSD201_SP24', 'HE00043', 'CS_K2_SP24_CSD201_SP24', 7.1, 'Passed'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'HE00043', 'CS_K2_SP24_DBI202_SP24', 8.0, 'Passed'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'HE00043', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'HE00043', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');
-- ... (HE00044 - HE00046)
-- Student HE00044
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00044_CS_K2_SP24_CSD201_SP24', 'HE00044', 'CS_K2_SP24_CSD201_SP24', 5.5, 'Passed'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'HE00044', 'CS_K2_SP24_DBI202_SP24', 6.5, 'Passed'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'HE00044', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'HE00044', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');
-- Student HE00045
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00045_CS_K2_SP24_CSD201_SP24', 'HE00045', 'CS_K2_SP24_CSD201_SP24', 2.5, 'Failed'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'HE00045', 'CS_K2_SP24_DBI202_SP24', 4.9, 'Failed'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'HE00045', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'HE00045', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');
-- Student HE00046
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00046_CS_K2_SP24_CSD201_SP24', 'HE00046', 'CS_K2_SP24_CSD201_SP24', 9.8, 'Passed'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'HE00046', 'CS_K2_SP24_DBI202_SP24', 8.7, 'Passed'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'HE00046', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'HE00046', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');

-- Enrollments for Class CS_K2_SP24 (SU24 Intake: HE00047-HE00050 - Only SU24 Courses)
-- Student HE00047
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00047_CS_K2_SP24_TOC201_SU24', 'HE00047', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'HE00047', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');
-- ... (HE00048 - HE00050)
-- Student HE00048
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00048_CS_K2_SP24_TOC201_SU24', 'HE00048', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'HE00048', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');
-- Student HE00049
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00049_CS_K2_SP24_TOC201_SU24', 'HE00049', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'HE00049', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');
-- Student HE00050
INSERT INTO Enrollments (enrollment_id, student_id, class_course_id, average, status) VALUES
('HE00050_CS_K2_SP24_TOC201_SU24', 'HE00050', 'CS_K2_SP24_TOC201_SU24', 0, 'Studying'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'HE00050', 'CS_K2_SP24_OSG202_SU24', 0, 'Studying');


-- ClassCourse: AI_K1_FA23_PRF192_SP24 (Thứ 2, Slot 1, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K1_FA23_PRF192_SP24_S1', 'AI_K1_FA23_PRF192_SP24', '2024-01-08 07:30:00', '2024-01-08 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S2', 'AI_K1_FA23_PRF192_SP24', '2024-01-15 07:30:00', '2024-01-15 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S3', 'AI_K1_FA23_PRF192_SP24', '2024-01-22 07:30:00', '2024-01-22 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S4', 'AI_K1_FA23_PRF192_SP24', '2024-01-29 07:30:00', '2024-01-29 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S5', 'AI_K1_FA23_PRF192_SP24', '2024-02-05 07:30:00', '2024-02-05 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S6', 'AI_K1_FA23_PRF192_SP24', '2024-02-12 07:30:00', '2024-02-12 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S7', 'AI_K1_FA23_PRF192_SP24', '2024-02-19 07:30:00', '2024-02-19 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S8', 'AI_K1_FA23_PRF192_SP24', '2024-02-26 07:30:00', '2024-02-26 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S9', 'AI_K1_FA23_PRF192_SP24', '2024-03-04 07:30:00', '2024-03-04 09:50:00', N'R001', 1),
('AI_K1_FA23_PRF192_SP24_S10', 'AI_K1_FA23_PRF192_SP24', '2024-03-11 07:30:00', '2024-03-11 09:50:00', N'R001', 1);

-- ClassCourse: AI_K1_FA23_CSD201_SP24 (Thứ 3, Slot 1, Room R002)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K1_FA23_CSD201_SP24_S1', 'AI_K1_FA23_CSD201_SP24', '2024-01-09 07:30:00', '2024-01-09 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S2', 'AI_K1_FA23_CSD201_SP24', '2024-01-16 07:30:00', '2024-01-16 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S3', 'AI_K1_FA23_CSD201_SP24', '2024-01-23 07:30:00', '2024-01-23 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S4', 'AI_K1_FA23_CSD201_SP24', '2024-01-30 07:30:00', '2024-01-30 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S5', 'AI_K1_FA23_CSD201_SP24', '2024-02-06 07:30:00', '2024-02-06 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S6', 'AI_K1_FA23_CSD201_SP24', '2024-02-13 07:30:00', '2024-02-13 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S7', 'AI_K1_FA23_CSD201_SP24', '2024-02-20 07:30:00', '2024-02-20 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S8', 'AI_K1_FA23_CSD201_SP24', '2024-02-27 07:30:00', '2024-02-27 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S9', 'AI_K1_FA23_CSD201_SP24', '2024-03-05 07:30:00', '2024-03-05 09:50:00', N'R002', 1),
('AI_K1_FA23_CSD201_SP24_S10', 'AI_K1_FA23_CSD201_SP24', '2024-03-12 07:30:00', '2024-03-12 09:50:00', N'R002', 1);

-- ClassCourse: AI_K2_SP24_PRF192_SP24 (Thứ 4, Slot 1, Room R003)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K2_SP24_PRF192_SP24_S1', 'AI_K2_SP24_PRF192_SP24', '2024-01-10 07:30:00', '2024-01-10 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S2', 'AI_K2_SP24_PRF192_SP24', '2024-01-17 07:30:00', '2024-01-17 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S3', 'AI_K2_SP24_PRF192_SP24', '2024-01-24 07:30:00', '2024-01-24 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S4', 'AI_K2_SP24_PRF192_SP24', '2024-01-31 07:30:00', '2024-01-31 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S5', 'AI_K2_SP24_PRF192_SP24', '2024-02-07 07:30:00', '2024-02-07 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S6', 'AI_K2_SP24_PRF192_SP24', '2024-02-14 07:30:00', '2024-02-14 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S7', 'AI_K2_SP24_PRF192_SP24', '2024-02-21 07:30:00', '2024-02-21 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S8', 'AI_K2_SP24_PRF192_SP24', '2024-02-28 07:30:00', '2024-02-28 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S9', 'AI_K2_SP24_PRF192_SP24', '2024-03-06 07:30:00', '2024-03-06 09:50:00', N'R003', 1),
('AI_K2_SP24_PRF192_SP24_S10', 'AI_K2_SP24_PRF192_SP24', '2024-03-13 07:30:00', '2024-03-13 09:50:00', N'R003', 1);

-- ClassCourse: AI_K2_SP24_CSD201_SP24 (Thứ 5, Slot 1, Room R004)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K2_SP24_CSD201_SP24_S1', 'AI_K2_SP24_CSD201_SP24', '2024-01-11 07:30:00', '2024-01-11 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S2', 'AI_K2_SP24_CSD201_SP24', '2024-01-18 07:30:00', '2024-01-18 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S3', 'AI_K2_SP24_CSD201_SP24', '2024-01-25 07:30:00', '2024-01-25 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S4', 'AI_K2_SP24_CSD201_SP24', '2024-02-01 07:30:00', '2024-02-01 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S5', 'AI_K2_SP24_CSD201_SP24', '2024-02-08 07:30:00', '2024-02-08 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S6', 'AI_K2_SP24_CSD201_SP24', '2024-02-15 07:30:00', '2024-02-15 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S7', 'AI_K2_SP24_CSD201_SP24', '2024-02-22 07:30:00', '2024-02-22 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S8', 'AI_K2_SP24_CSD201_SP24', '2024-02-29 07:30:00', '2024-02-29 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S9', 'AI_K2_SP24_CSD201_SP24', '2024-03-07 07:30:00', '2024-03-07 09:50:00', N'R004', 1),
('AI_K2_SP24_CSD201_SP24_S10', 'AI_K2_SP24_CSD201_SP24', '2024-03-14 07:30:00', '2024-03-14 09:50:00', N'R004', 1);

-- ClassCourse: IA_K1_FA23_PRF192_SP24 (Thứ 6, Slot 1, Room R005)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K1_FA23_PRF192_SP24_S1', 'IA_K1_FA23_PRF192_SP24', '2024-01-12 07:30:00', '2024-01-12 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S2', 'IA_K1_FA23_PRF192_SP24', '2024-01-19 07:30:00', '2024-01-19 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S3', 'IA_K1_FA23_PRF192_SP24', '2024-01-26 07:30:00', '2024-01-26 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S4', 'IA_K1_FA23_PRF192_SP24', '2024-02-02 07:30:00', '2024-02-02 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S5', 'IA_K1_FA23_PRF192_SP24', '2024-02-09 07:30:00', '2024-02-09 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S6', 'IA_K1_FA23_PRF192_SP24', '2024-02-16 07:30:00', '2024-02-16 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S7', 'IA_K1_FA23_PRF192_SP24', '2024-02-23 07:30:00', '2024-02-23 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S8', 'IA_K1_FA23_PRF192_SP24', '2024-03-01 07:30:00', '2024-03-01 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S9', 'IA_K1_FA23_PRF192_SP24', '2024-03-08 07:30:00', '2024-03-08 09:50:00', N'R005', 1),
('IA_K1_FA23_PRF192_SP24_S10', 'IA_K1_FA23_PRF192_SP24', '2024-03-15 07:30:00', '2024-03-15 09:50:00', N'R005', 1);

-- ClassCourse: IA_K1_FA23_DBI202_SP24 (Thứ 2, Slot 2, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K1_FA23_DBI202_SP24_S1', 'IA_K1_FA23_DBI202_SP24', '2024-01-08 10:00:00', '2024-01-08 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S2', 'IA_K1_FA23_DBI202_SP24', '2024-01-15 10:00:00', '2024-01-15 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S3', 'IA_K1_FA23_DBI202_SP24', '2024-01-22 10:00:00', '2024-01-22 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S4', 'IA_K1_FA23_DBI202_SP24', '2024-01-29 10:00:00', '2024-01-29 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S5', 'IA_K1_FA23_DBI202_SP24', '2024-02-05 10:00:00', '2024-02-05 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S6', 'IA_K1_FA23_DBI202_SP24', '2024-02-12 10:00:00', '2024-02-12 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S7', 'IA_K1_FA23_DBI202_SP24', '2024-02-19 10:00:00', '2024-02-19 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S8', 'IA_K1_FA23_DBI202_SP24', '2024-02-26 10:00:00', '2024-02-26 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S9', 'IA_K1_FA23_DBI202_SP24', '2024-03-04 10:00:00', '2024-03-04 12:20:00', N'R001', 2),
('IA_K1_FA23_DBI202_SP24_S10', 'IA_K1_FA23_DBI202_SP24', '2024-03-11 10:00:00', '2024-03-11 12:20:00', N'R001', 2);

-- ClassCourse: IA_K2_SU24_PRF192_SP24 (Thứ 3, Slot 2, Room R002)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K2_SU24_PRF192_SP24_S1', 'IA_K2_SU24_PRF192_SP24', '2024-01-09 10:00:00', '2024-01-09 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S2', 'IA_K2_SU24_PRF192_SP24', '2024-01-16 10:00:00', '2024-01-16 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S3', 'IA_K2_SU24_PRF192_SP24', '2024-01-23 10:00:00', '2024-01-23 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S4', 'IA_K2_SU24_PRF192_SP24', '2024-01-30 10:00:00', '2024-01-30 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S5', 'IA_K2_SU24_PRF192_SP24', '2024-02-06 10:00:00', '2024-02-06 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S6', 'IA_K2_SU24_PRF192_SP24', '2024-02-13 10:00:00', '2024-02-13 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S7', 'IA_K2_SU24_PRF192_SP24', '2024-02-20 10:00:00', '2024-02-20 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S8', 'IA_K2_SU24_PRF192_SP24', '2024-02-27 10:00:00', '2024-02-27 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S9', 'IA_K2_SU24_PRF192_SP24', '2024-03-05 10:00:00', '2024-03-05 12:20:00', N'R002', 2),
('IA_K2_SU24_PRF192_SP24_S10', 'IA_K2_SU24_PRF192_SP24', '2024-03-12 10:00:00', '2024-03-12 12:20:00', N'R002', 2);

-- ClassCourse: IA_K2_SU24_DBI202_SP24 (Thứ 4, Slot 2, Room R003)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K2_SU24_DBI202_SP24_S1', 'IA_K2_SU24_DBI202_SP24', '2024-01-10 10:00:00', '2024-01-10 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S2', 'IA_K2_SU24_DBI202_SP24', '2024-01-17 10:00:00', '2024-01-17 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S3', 'IA_K2_SU24_DBI202_SP24', '2024-01-24 10:00:00', '2024-01-24 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S4', 'IA_K2_SU24_DBI202_SP24', '2024-01-31 10:00:00', '2024-01-31 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S5', 'IA_K2_SU24_DBI202_SP24', '2024-02-07 10:00:00', '2024-02-07 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S6', 'IA_K2_SU24_DBI202_SP24', '2024-02-14 10:00:00', '2024-02-14 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S7', 'IA_K2_SU24_DBI202_SP24', '2024-02-21 10:00:00', '2024-02-21 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S8', 'IA_K2_SU24_DBI202_SP24', '2024-02-28 10:00:00', '2024-02-28 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S9', 'IA_K2_SU24_DBI202_SP24', '2024-03-06 10:00:00', '2024-03-06 12:20:00', N'R003', 2),
('IA_K2_SU24_DBI202_SP24_S10', 'IA_K2_SU24_DBI202_SP24', '2024-03-13 10:00:00', '2024-03-13 12:20:00', N'R003', 2);

-- ClassCourse: SE_K1_SP24_PRF192_SP24 (Thứ 5, Slot 2, Room R004)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K1_SP24_PRF192_SP24_S1', 'SE_K1_SP24_PRF192_SP24', '2024-01-11 10:00:00', '2024-01-11 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S2', 'SE_K1_SP24_PRF192_SP24', '2024-01-18 10:00:00', '2024-01-18 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S3', 'SE_K1_SP24_PRF192_SP24', '2024-01-25 10:00:00', '2024-01-25 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S4', 'SE_K1_SP24_PRF192_SP24', '2024-02-01 10:00:00', '2024-02-01 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S5', 'SE_K1_SP24_PRF192_SP24', '2024-02-08 10:00:00', '2024-02-08 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S6', 'SE_K1_SP24_PRF192_SP24', '2024-02-15 10:00:00', '2024-02-15 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S7', 'SE_K1_SP24_PRF192_SP24', '2024-02-22 10:00:00', '2024-02-22 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S8', 'SE_K1_SP24_PRF192_SP24', '2024-02-29 10:00:00', '2024-02-29 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S9', 'SE_K1_SP24_PRF192_SP24', '2024-03-07 10:00:00', '2024-03-07 12:20:00', N'R004', 2),
('SE_K1_SP24_PRF192_SP24_S10', 'SE_K1_SP24_PRF192_SP24', '2024-03-14 10:00:00', '2024-03-14 12:20:00', N'R004', 2);

-- ClassCourse: SE_K1_SP24_MAD101_SP24 (Thứ 6, Slot 2, Room R005)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K1_SP24_MAD101_SP24_S1', 'SE_K1_SP24_MAD101_SP24', '2024-01-12 10:00:00', '2024-01-12 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S2', 'SE_K1_SP24_MAD101_SP24', '2024-01-19 10:00:00', '2024-01-19 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S3', 'SE_K1_SP24_MAD101_SP24', '2024-01-26 10:00:00', '2024-01-26 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S4', 'SE_K1_SP24_MAD101_SP24', '2024-02-02 10:00:00', '2024-02-02 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S5', 'SE_K1_SP24_MAD101_SP24', '2024-02-09 10:00:00', '2024-02-09 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S6', 'SE_K1_SP24_MAD101_SP24', '2024-02-16 10:00:00', '2024-02-16 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S7', 'SE_K1_SP24_MAD101_SP24', '2024-02-23 10:00:00', '2024-02-23 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S8', 'SE_K1_SP24_MAD101_SP24', '2024-03-01 10:00:00', '2024-03-01 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S9', 'SE_K1_SP24_MAD101_SP24', '2024-03-08 10:00:00', '2024-03-08 12:20:00', N'R005', 2),
('SE_K1_SP24_MAD101_SP24_S10', 'SE_K1_SP24_MAD101_SP24', '2024-03-15 10:00:00', '2024-03-15 12:20:00', N'R005', 2);

-- ClassCourse: SE_K2_SU24_PRF192_SP24 (Thứ 2, Slot 3, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K2_SU24_PRF192_SP24_S1', 'SE_K2_SU24_PRF192_SP24', '2024-01-08 12:50:00', '2024-01-08 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S2', 'SE_K2_SU24_PRF192_SP24', '2024-01-15 12:50:00', '2024-01-15 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S3', 'SE_K2_SU24_PRF192_SP24', '2024-01-22 12:50:00', '2024-01-22 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S4', 'SE_K2_SU24_PRF192_SP24', '2024-01-29 12:50:00', '2024-01-29 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S5', 'SE_K2_SU24_PRF192_SP24', '2024-02-05 12:50:00', '2024-02-05 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S6', 'SE_K2_SU24_PRF192_SP24', '2024-02-12 12:50:00', '2024-02-12 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S7', 'SE_K2_SU24_PRF192_SP24', '2024-02-19 12:50:00', '2024-02-19 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S8', 'SE_K2_SU24_PRF192_SP24', '2024-02-26 12:50:00', '2024-02-26 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S9', 'SE_K2_SU24_PRF192_SP24', '2024-03-04 12:50:00', '2024-03-04 15:10:00', N'R001', 3),
('SE_K2_SU24_PRF192_SP24_S10', 'SE_K2_SU24_PRF192_SP24', '2024-03-11 12:50:00', '2024-03-11 15:10:00', N'R001', 3);

-- ClassCourse: SE_K2_SU24_MAD101_SP24 (Thứ 3, Slot 3, Room R002)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K2_SU24_MAD101_SP24_S1', 'SE_K2_SU24_MAD101_SP24', '2024-01-09 12:50:00', '2024-01-09 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S2', 'SE_K2_SU24_MAD101_SP24', '2024-01-16 12:50:00', '2024-01-16 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S3', 'SE_K2_SU24_MAD101_SP24', '2024-01-23 12:50:00', '2024-01-23 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S4', 'SE_K2_SU24_MAD101_SP24', '2024-01-30 12:50:00', '2024-01-30 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S5', 'SE_K2_SU24_MAD101_SP24', '2024-02-06 12:50:00', '2024-02-06 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S6', 'SE_K2_SU24_MAD101_SP24', '2024-02-13 12:50:00', '2024-02-13 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S7', 'SE_K2_SU24_MAD101_SP24', '2024-02-20 12:50:00', '2024-02-20 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S8', 'SE_K2_SU24_MAD101_SP24', '2024-02-27 12:50:00', '2024-02-27 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S9', 'SE_K2_SU24_MAD101_SP24', '2024-03-05 12:50:00', '2024-03-05 15:10:00', N'R002', 3),
('SE_K2_SU24_MAD101_SP24_S10', 'SE_K2_SU24_MAD101_SP24', '2024-03-12 12:50:00', '2024-03-12 15:10:00', N'R002', 3);

-- ClassCourse: CS_K1_FA23_CSD201_SP24 (Thứ 4, Slot 3, Room R003)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K1_FA23_CSD201_SP24_S1', 'CS_K1_FA23_CSD201_SP24', '2024-01-10 12:50:00', '2024-01-10 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S2', 'CS_K1_FA23_CSD201_SP24', '2024-01-17 12:50:00', '2024-01-17 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S3', 'CS_K1_FA23_CSD201_SP24', '2024-01-24 12:50:00', '2024-01-24 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S4', 'CS_K1_FA23_CSD201_SP24', '2024-01-31 12:50:00', '2024-01-31 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S5', 'CS_K1_FA23_CSD201_SP24', '2024-02-07 12:50:00', '2024-02-07 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S6', 'CS_K1_FA23_CSD201_SP24', '2024-02-14 12:50:00', '2024-02-14 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S7', 'CS_K1_FA23_CSD201_SP24', '2024-02-21 12:50:00', '2024-02-21 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S8', 'CS_K1_FA23_CSD201_SP24', '2024-02-28 12:50:00', '2024-02-28 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S9', 'CS_K1_FA23_CSD201_SP24', '2024-03-06 12:50:00', '2024-03-06 15:10:00', N'R003', 3),
('CS_K1_FA23_CSD201_SP24_S10', 'CS_K1_FA23_CSD201_SP24', '2024-03-13 12:50:00', '2024-03-13 15:10:00', N'R003', 3);

-- ClassCourse: CS_K1_FA23_DBI202_SP24 (Thứ 5, Slot 3, Room R004)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K1_FA23_DBI202_SP24_S1', 'CS_K1_FA23_DBI202_SP24', '2024-01-11 12:50:00', '2024-01-11 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S2', 'CS_K1_FA23_DBI202_SP24', '2024-01-18 12:50:00', '2024-01-18 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S3', 'CS_K1_FA23_DBI202_SP24', '2024-01-25 12:50:00', '2024-01-25 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S4', 'CS_K1_FA23_DBI202_SP24', '2024-02-01 12:50:00', '2024-02-01 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S5', 'CS_K1_FA23_DBI202_SP24', '2024-02-08 12:50:00', '2024-02-08 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S6', 'CS_K1_FA23_DBI202_SP24', '2024-02-15 12:50:00', '2024-02-15 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S7', 'CS_K1_FA23_DBI202_SP24', '2024-02-22 12:50:00', '2024-02-22 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S8', 'CS_K1_FA23_DBI202_SP24', '2024-02-29 12:50:00', '2024-02-29 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S9', 'CS_K1_FA23_DBI202_SP24', '2024-03-07 12:50:00', '2024-03-07 15:10:00', N'R004', 3),
('CS_K1_FA23_DBI202_SP24_S10', 'CS_K1_FA23_DBI202_SP24', '2024-03-14 12:50:00', '2024-03-14 15:10:00', N'R004', 3);

-- ClassCourse: CS_K2_SP24_CSD201_SP24 (Thứ 6, Slot 3, Room R005)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K2_SP24_CSD201_SP24_S1', 'CS_K2_SP24_CSD201_SP24', '2024-01-12 12:50:00', '2024-01-12 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S2', 'CS_K2_SP24_CSD201_SP24', '2024-01-19 12:50:00', '2024-01-19 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S3', 'CS_K2_SP24_CSD201_SP24', '2024-01-26 12:50:00', '2024-01-26 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S4', 'CS_K2_SP24_CSD201_SP24', '2024-02-02 12:50:00', '2024-02-02 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S5', 'CS_K2_SP24_CSD201_SP24', '2024-02-09 12:50:00', '2024-02-09 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S6', 'CS_K2_SP24_CSD201_SP24', '2024-02-16 12:50:00', '2024-02-16 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S7', 'CS_K2_SP24_CSD201_SP24', '2024-02-23 12:50:00', '2024-02-23 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S8', 'CS_K2_SP24_CSD201_SP24', '2024-03-01 12:50:00', '2024-03-01 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S9', 'CS_K2_SP24_CSD201_SP24', '2024-03-08 12:50:00', '2024-03-08 15:10:00', N'R005', 3),
('CS_K2_SP24_CSD201_SP24_S10', 'CS_K2_SP24_CSD201_SP24', '2024-03-15 12:50:00', '2024-03-15 15:10:00', N'R005', 3);

-- ClassCourse: CS_K2_SP24_DBI202_SP24 (Thứ 2, Slot 4, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K2_SP24_DBI202_SP24_S1', 'CS_K2_SP24_DBI202_SP24', '2024-01-08 15:30:00', '2024-01-08 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S2', 'CS_K2_SP24_DBI202_SP24', '2024-01-15 15:30:00', '2024-01-15 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S3', 'CS_K2_SP24_DBI202_SP24', '2024-01-22 15:30:00', '2024-01-22 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S4', 'CS_K2_SP24_DBI202_SP24', '2024-01-29 15:30:00', '2024-01-29 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S5', 'CS_K2_SP24_DBI202_SP24', '2024-02-05 15:30:00', '2024-02-05 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S6', 'CS_K2_SP24_DBI202_SP24', '2024-02-12 15:30:00', '2024-02-12 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S7', 'CS_K2_SP24_DBI202_SP24', '2024-02-19 15:30:00', '2024-02-19 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S8', 'CS_K2_SP24_DBI202_SP24', '2024-02-26 15:30:00', '2024-02-26 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S9', 'CS_K2_SP24_DBI202_SP24', '2024-03-04 15:30:00', '2024-03-04 17:50:00', N'R001', 4),
('CS_K2_SP24_DBI202_SP24_S10', 'CS_K2_SP24_DBI202_SP24', '2024-03-11 15:30:00', '2024-03-11 17:50:00', N'R001', 4);

-- Kỳ SU24 (Bắt đầu từ 2024-05-06)

-- ClassCourse: AI_K1_FA23_AIL301_SU24 (Thứ 2, Slot 1, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K1_FA23_AIL301_SU24_S1', 'AI_K1_FA23_AIL301_SU24', '2024-05-06 07:30:00', '2024-05-06 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S2', 'AI_K1_FA23_AIL301_SU24', '2024-05-13 07:30:00', '2024-05-13 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S3', 'AI_K1_FA23_AIL301_SU24', '2024-05-20 07:30:00', '2024-05-20 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S4', 'AI_K1_FA23_AIL301_SU24', '2024-05-27 07:30:00', '2024-05-27 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S5', 'AI_K1_FA23_AIL301_SU24', '2024-06-03 07:30:00', '2024-06-03 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S6', 'AI_K1_FA23_AIL301_SU24', '2024-06-10 07:30:00', '2024-06-10 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S7', 'AI_K1_FA23_AIL301_SU24', '2024-06-17 07:30:00', '2024-06-17 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S8', 'AI_K1_FA23_AIL301_SU24', '2024-06-24 07:30:00', '2024-06-24 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S9', 'AI_K1_FA23_AIL301_SU24', '2024-07-01 07:30:00', '2024-07-01 09:50:00', N'R001', 1),
('AI_K1_FA23_AIL301_SU24_S10', 'AI_K1_FA23_AIL301_SU24', '2024-07-08 07:30:00', '2024-07-08 09:50:00', N'R001', 1);

-- ClassCourse: AI_K1_FA23_NLP302_SU24 (Thứ 3, Slot 1, Room R002)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K1_FA23_NLP302_SU24_S1', 'AI_K1_FA23_NLP302_SU24', '2024-05-07 07:30:00', '2024-05-07 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S2', 'AI_K1_FA23_NLP302_SU24', '2024-05-14 07:30:00', '2024-05-14 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S3', 'AI_K1_FA23_NLP302_SU24', '2024-05-21 07:30:00', '2024-05-21 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S4', 'AI_K1_FA23_NLP302_SU24', '2024-05-28 07:30:00', '2024-05-28 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S5', 'AI_K1_FA23_NLP302_SU24', '2024-06-04 07:30:00', '2024-06-04 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S6', 'AI_K1_FA23_NLP302_SU24', '2024-06-11 07:30:00', '2024-06-11 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S7', 'AI_K1_FA23_NLP302_SU24', '2024-06-18 07:30:00', '2024-06-18 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S8', 'AI_K1_FA23_NLP302_SU24', '2024-06-25 07:30:00', '2024-06-25 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S9', 'AI_K1_FA23_NLP302_SU24', '2024-07-02 07:30:00', '2024-07-02 09:50:00', N'R002', 1),
('AI_K1_FA23_NLP302_SU24_S10', 'AI_K1_FA23_NLP302_SU24', '2024-07-09 07:30:00', '2024-07-09 09:50:00', N'R002', 1);

-- ... (Tương tự cho 14 ClassCourse còn lại của SU24, mỗi ClassCourse 10 records)
-- Tổng cộng 160 records cho SP24 và 160 records cho SU24 = 320 records.
-- Cấu trúc lặp lại cho các ClassCourse tiếp theo của SU24:

-- ClassCourse: AI_K2_SP24_AIL301_SU24 (Thứ 4, Slot 1, Room R003)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K2_SP24_AIL301_SU24_S1', 'AI_K2_SP24_AIL301_SU24', '2024-05-08 07:30:00', '2024-05-08 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S2', 'AI_K2_SP24_AIL301_SU24', '2024-05-15 07:30:00', '2024-05-15 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S3', 'AI_K2_SP24_AIL301_SU24', '2024-05-22 07:30:00', '2024-05-22 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S4', 'AI_K2_SP24_AIL301_SU24', '2024-05-29 07:30:00', '2024-05-29 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S5', 'AI_K2_SP24_AIL301_SU24', '2024-06-05 07:30:00', '2024-06-05 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S6', 'AI_K2_SP24_AIL301_SU24', '2024-06-12 07:30:00', '2024-06-12 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S7', 'AI_K2_SP24_AIL301_SU24', '2024-06-19 07:30:00', '2024-06-19 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S8', 'AI_K2_SP24_AIL301_SU24', '2024-06-26 07:30:00', '2024-06-26 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S9', 'AI_K2_SP24_AIL301_SU24', '2024-07-03 07:30:00', '2024-07-03 09:50:00', N'R003', 1),
('AI_K2_SP24_AIL301_SU24_S10', 'AI_K2_SP24_AIL301_SU24', '2024-07-10 07:30:00', '2024-07-10 09:50:00', N'R003', 1);

-- ClassCourse: AI_K2_SP24_NLP302_SU24 (Thứ 5, Slot 1, Room R004)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('AI_K2_SP24_NLP302_SU24_S1', 'AI_K2_SP24_NLP302_SU24', '2024-05-09 07:30:00', '2024-05-09 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S2', 'AI_K2_SP24_NLP302_SU24', '2024-05-16 07:30:00', '2024-05-16 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S3', 'AI_K2_SP24_NLP302_SU24', '2024-05-23 07:30:00', '2024-05-23 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S4', 'AI_K2_SP24_NLP302_SU24', '2024-05-30 07:30:00', '2024-05-30 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S5', 'AI_K2_SP24_NLP302_SU24', '2024-06-06 07:30:00', '2024-06-06 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S6', 'AI_K2_SP24_NLP302_SU24', '2024-06-13 07:30:00', '2024-06-13 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S7', 'AI_K2_SP24_NLP302_SU24', '2024-06-20 07:30:00', '2024-06-20 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S8', 'AI_K2_SP24_NLP302_SU24', '2024-06-27 07:30:00', '2024-06-27 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S9', 'AI_K2_SP24_NLP302_SU24', '2024-07-04 07:30:00', '2024-07-04 09:50:00', N'R004', 1),
('AI_K2_SP24_NLP302_SU24_S10', 'AI_K2_SP24_NLP302_SU24', '2024-07-11 07:30:00', '2024-07-11 09:50:00', N'R004', 1);

-- ClassCourse: IA_K1_FA23_IAS301_SU24 (Thứ 6, Slot 1, Room R005)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K1_FA23_IAS301_SU24_S1', 'IA_K1_FA23_IAS301_SU24', '2024-05-10 07:30:00', '2024-05-10 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S2', 'IA_K1_FA23_IAS301_SU24', '2024-05-17 07:30:00', '2024-05-17 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S3', 'IA_K1_FA23_IAS301_SU24', '2024-05-24 07:30:00', '2024-05-24 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S4', 'IA_K1_FA23_IAS301_SU24', '2024-05-31 07:30:00', '2024-05-31 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S5', 'IA_K1_FA23_IAS301_SU24', '2024-06-07 07:30:00', '2024-06-07 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S6', 'IA_K1_FA23_IAS301_SU24', '2024-06-14 07:30:00', '2024-06-14 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S7', 'IA_K1_FA23_IAS301_SU24', '2024-06-21 07:30:00', '2024-06-21 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S8', 'IA_K1_FA23_IAS301_SU24', '2024-06-28 07:30:00', '2024-06-28 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S9', 'IA_K1_FA23_IAS301_SU24', '2024-07-05 07:30:00', '2024-07-05 09:50:00', N'R005', 1),
('IA_K1_FA23_IAS301_SU24_S10', 'IA_K1_FA23_IAS301_SU24', '2024-07-12 07:30:00', '2024-07-12 09:50:00', N'R005', 1);

-- ClassCourse: IA_K1_FA23_NET302_SU24 (Thứ 2, Slot 2, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K1_FA23_NET302_SU24_S1', 'IA_K1_FA23_NET302_SU24', '2024-05-06 10:00:00', '2024-05-06 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S2', 'IA_K1_FA23_NET302_SU24', '2024-05-13 10:00:00', '2024-05-13 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S3', 'IA_K1_FA23_NET302_SU24', '2024-05-20 10:00:00', '2024-05-20 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S4', 'IA_K1_FA23_NET302_SU24', '2024-05-27 10:00:00', '2024-05-27 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S5', 'IA_K1_FA23_NET302_SU24', '2024-06-03 10:00:00', '2024-06-03 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S6', 'IA_K1_FA23_NET302_SU24', '2024-06-10 10:00:00', '2024-06-10 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S7', 'IA_K1_FA23_NET302_SU24', '2024-06-17 10:00:00', '2024-06-17 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S8', 'IA_K1_FA23_NET302_SU24', '2024-06-24 10:00:00', '2024-06-24 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S9', 'IA_K1_FA23_NET302_SU24', '2024-07-01 10:00:00', '2024-07-01 12:20:00', N'R001', 2),
('IA_K1_FA23_NET302_SU24_S10', 'IA_K1_FA23_NET302_SU24', '2024-07-08 10:00:00', '2024-07-08 12:20:00', N'R001', 2);

-- ClassCourse: IA_K2_SU24_IAS301_SU24 (Thứ 3, Slot 2, Room R002)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K2_SU24_IAS301_SU24_S1', 'IA_K2_SU24_IAS301_SU24', '2024-05-07 10:00:00', '2024-05-07 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S2', 'IA_K2_SU24_IAS301_SU24', '2024-05-14 10:00:00', '2024-05-14 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S3', 'IA_K2_SU24_IAS301_SU24', '2024-05-21 10:00:00', '2024-05-21 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S4', 'IA_K2_SU24_IAS301_SU24', '2024-05-28 10:00:00', '2024-05-28 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S5', 'IA_K2_SU24_IAS301_SU24', '2024-06-04 10:00:00', '2024-06-04 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S6', 'IA_K2_SU24_IAS301_SU24', '2024-06-11 10:00:00', '2024-06-11 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S7', 'IA_K2_SU24_IAS301_SU24', '2024-06-18 10:00:00', '2024-06-18 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S8', 'IA_K2_SU24_IAS301_SU24', '2024-06-25 10:00:00', '2024-06-25 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S9', 'IA_K2_SU24_IAS301_SU24', '2024-07-02 10:00:00', '2024-07-02 12:20:00', N'R002', 2),
('IA_K2_SU24_IAS301_SU24_S10', 'IA_K2_SU24_IAS301_SU24', '2024-07-09 10:00:00', '2024-07-09 12:20:00', N'R002', 2);

-- ClassCourse: IA_K2_SU24_NET302_SU24 (Thứ 4, Slot 2, Room R003)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('IA_K2_SU24_NET302_SU24_S1', 'IA_K2_SU24_NET302_SU24', '2024-05-08 10:00:00', '2024-05-08 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S2', 'IA_K2_SU24_NET302_SU24', '2024-05-15 10:00:00', '2024-05-15 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S3', 'IA_K2_SU24_NET302_SU24', '2024-05-22 10:00:00', '2024-05-22 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S4', 'IA_K2_SU24_NET302_SU24', '2024-05-29 10:00:00', '2024-05-29 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S5', 'IA_K2_SU24_NET302_SU24', '2024-06-05 10:00:00', '2024-06-05 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S6', 'IA_K2_SU24_NET302_SU24', '2024-06-12 10:00:00', '2024-06-12 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S7', 'IA_K2_SU24_NET302_SU24', '2024-06-19 10:00:00', '2024-06-19 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S8', 'IA_K2_SU24_NET302_SU24', '2024-06-26 10:00:00', '2024-06-26 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S9', 'IA_K2_SU24_NET302_SU24', '2024-07-03 10:00:00', '2024-07-03 12:20:00', N'R003', 2),
('IA_K2_SU24_NET302_SU24_S10', 'IA_K2_SU24_NET302_SU24', '2024-07-10 10:00:00', '2024-07-10 12:20:00', N'R003', 2);

-- ClassCourse: SE_K1_SP24_SWE301_SU24 (Thứ 5, Slot 2, Room R004)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K1_SP24_SWE301_SU24_S1', 'SE_K1_SP24_SWE301_SU24', '2024-05-09 10:00:00', '2024-05-09 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S2', 'SE_K1_SP24_SWE301_SU24', '2024-05-16 10:00:00', '2024-05-16 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S3', 'SE_K1_SP24_SWE301_SU24', '2024-05-23 10:00:00', '2024-05-23 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S4', 'SE_K1_SP24_SWE301_SU24', '2024-05-30 10:00:00', '2024-05-30 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S5', 'SE_K1_SP24_SWE301_SU24', '2024-06-06 10:00:00', '2024-06-06 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S6', 'SE_K1_SP24_SWE301_SU24', '2024-06-13 10:00:00', '2024-06-13 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S7', 'SE_K1_SP24_SWE301_SU24', '2024-06-20 10:00:00', '2024-06-20 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S8', 'SE_K1_SP24_SWE301_SU24', '2024-06-27 10:00:00', '2024-06-27 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S9', 'SE_K1_SP24_SWE301_SU24', '2024-07-04 10:00:00', '2024-07-04 12:20:00', N'R004', 2),
('SE_K1_SP24_SWE301_SU24_S10', 'SE_K1_SP24_SWE301_SU24', '2024-07-11 10:00:00', '2024-07-11 12:20:00', N'R004', 2);

-- ClassCourse: SE_K1_SP24_PRJ302_SU24 (Thứ 6, Slot 2, Room R005)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K1_SP24_PRJ302_SU24_S1', 'SE_K1_SP24_PRJ302_SU24', '2024-05-10 10:00:00', '2024-05-10 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S2', 'SE_K1_SP24_PRJ302_SU24', '2024-05-17 10:00:00', '2024-05-17 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S3', 'SE_K1_SP24_PRJ302_SU24', '2024-05-24 10:00:00', '2024-05-24 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S4', 'SE_K1_SP24_PRJ302_SU24', '2024-05-31 10:00:00', '2024-05-31 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S5', 'SE_K1_SP24_PRJ302_SU24', '2024-06-07 10:00:00', '2024-06-07 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S6', 'SE_K1_SP24_PRJ302_SU24', '2024-06-14 10:00:00', '2024-06-14 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S7', 'SE_K1_SP24_PRJ302_SU24', '2024-06-21 10:00:00', '2024-06-21 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S8', 'SE_K1_SP24_PRJ302_SU24', '2024-06-28 10:00:00', '2024-06-28 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S9', 'SE_K1_SP24_PRJ302_SU24', '2024-07-05 10:00:00', '2024-07-05 12:20:00', N'R005', 2),
('SE_K1_SP24_PRJ302_SU24_S10', 'SE_K1_SP24_PRJ302_SU24', '2024-07-12 10:00:00', '2024-07-12 12:20:00', N'R005', 2);

-- ClassCourse: SE_K2_SU24_SWE301_SU24 (Thứ 2, Slot 3, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K2_SU24_SWE301_SU24_S1', 'SE_K2_SU24_SWE301_SU24', '2024-05-06 12:50:00', '2024-05-06 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S2', 'SE_K2_SU24_SWE301_SU24', '2024-05-13 12:50:00', '2024-05-13 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S3', 'SE_K2_SU24_SWE301_SU24', '2024-05-20 12:50:00', '2024-05-20 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S4', 'SE_K2_SU24_SWE301_SU24', '2024-05-27 12:50:00', '2024-05-27 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S5', 'SE_K2_SU24_SWE301_SU24', '2024-06-03 12:50:00', '2024-06-03 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S6', 'SE_K2_SU24_SWE301_SU24', '2024-06-10 12:50:00', '2024-06-10 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S7', 'SE_K2_SU24_SWE301_SU24', '2024-06-17 12:50:00', '2024-06-17 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S8', 'SE_K2_SU24_SWE301_SU24', '2024-06-24 12:50:00', '2024-06-24 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S9', 'SE_K2_SU24_SWE301_SU24', '2024-07-01 12:50:00', '2024-07-01 15:10:00', N'R001', 3),
('SE_K2_SU24_SWE301_SU24_S10', 'SE_K2_SU24_SWE301_SU24', '2024-07-08 12:50:00', '2024-07-08 15:10:00', N'R001', 3);

-- ClassCourse: SE_K2_SU24_PRJ302_SU24 (Thứ 3, Slot 3, Room R002)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('SE_K2_SU24_PRJ302_SU24_S1', 'SE_K2_SU24_PRJ302_SU24', '2024-05-07 12:50:00', '2024-05-07 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S2', 'SE_K2_SU24_PRJ302_SU24', '2024-05-14 12:50:00', '2024-05-14 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S3', 'SE_K2_SU24_PRJ302_SU24', '2024-05-21 12:50:00', '2024-05-21 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S4', 'SE_K2_SU24_PRJ302_SU24', '2024-05-28 12:50:00', '2024-05-28 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S5', 'SE_K2_SU24_PRJ302_SU24', '2024-06-04 12:50:00', '2024-06-04 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S6', 'SE_K2_SU24_PRJ302_SU24', '2024-06-11 12:50:00', '2024-06-11 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S7', 'SE_K2_SU24_PRJ302_SU24', '2024-06-18 12:50:00', '2024-06-18 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S8', 'SE_K2_SU24_PRJ302_SU24', '2024-06-25 12:50:00', '2024-06-25 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S9', 'SE_K2_SU24_PRJ302_SU24', '2024-07-02 12:50:00', '2024-07-02 15:10:00', N'R002', 3),
('SE_K2_SU24_PRJ302_SU24_S10', 'SE_K2_SU24_PRJ302_SU24', '2024-07-09 12:50:00', '2024-07-09 15:10:00', N'R002', 3);

-- ClassCourse: CS_K1_FA23_TOC201_SU24 (Thứ 4, Slot 3, Room R003)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K1_FA23_TOC201_SU24_S1', 'CS_K1_FA23_TOC201_SU24', '2024-05-08 12:50:00', '2024-05-08 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S2', 'CS_K1_FA23_TOC201_SU24', '2024-05-15 12:50:00', '2024-05-15 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S3', 'CS_K1_FA23_TOC201_SU24', '2024-05-22 12:50:00', '2024-05-22 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S4', 'CS_K1_FA23_TOC201_SU24', '2024-05-29 12:50:00', '2024-05-29 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S5', 'CS_K1_FA23_TOC201_SU24', '2024-06-05 12:50:00', '2024-06-05 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S6', 'CS_K1_FA23_TOC201_SU24', '2024-06-12 12:50:00', '2024-06-12 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S7', 'CS_K1_FA23_TOC201_SU24', '2024-06-19 12:50:00', '2024-06-19 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S8', 'CS_K1_FA23_TOC201_SU24', '2024-06-26 12:50:00', '2024-06-26 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S9', 'CS_K1_FA23_TOC201_SU24', '2024-07-03 12:50:00', '2024-07-03 15:10:00', N'R003', 3),
('CS_K1_FA23_TOC201_SU24_S10', 'CS_K1_FA23_TOC201_SU24', '2024-07-10 12:50:00', '2024-07-10 15:10:00', N'R003', 3);

-- ClassCourse: CS_K1_FA23_OSG202_SU24 (Thứ 5, Slot 3, Room R004)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K1_FA23_OSG202_SU24_S1', 'CS_K1_FA23_OSG202_SU24', '2024-05-09 12:50:00', '2024-05-09 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S2', 'CS_K1_FA23_OSG202_SU24', '2024-05-16 12:50:00', '2024-05-16 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S3', 'CS_K1_FA23_OSG202_SU24', '2024-05-23 12:50:00', '2024-05-23 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S4', 'CS_K1_FA23_OSG202_SU24', '2024-05-30 12:50:00', '2024-05-30 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S5', 'CS_K1_FA23_OSG202_SU24', '2024-06-06 12:50:00', '2024-06-06 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S6', 'CS_K1_FA23_OSG202_SU24', '2024-06-13 12:50:00', '2024-06-13 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S7', 'CS_K1_FA23_OSG202_SU24', '2024-06-20 12:50:00', '2024-06-20 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S8', 'CS_K1_FA23_OSG202_SU24', '2024-06-27 12:50:00', '2024-06-27 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S9', 'CS_K1_FA23_OSG202_SU24', '2024-07-04 12:50:00', '2024-07-04 15:10:00', N'R004', 3),
('CS_K1_FA23_OSG202_SU24_S10', 'CS_K1_FA23_OSG202_SU24', '2024-07-11 12:50:00', '2024-07-11 15:10:00', N'R004', 3);

-- ClassCourse: CS_K2_SP24_TOC201_SU24 (Thứ 6, Slot 3, Room R005)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K2_SP24_TOC201_SU24_S1', 'CS_K2_SP24_TOC201_SU24', '2024-05-10 12:50:00', '2024-05-10 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S2', 'CS_K2_SP24_TOC201_SU24', '2024-05-17 12:50:00', '2024-05-17 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S3', 'CS_K2_SP24_TOC201_SU24', '2024-05-24 12:50:00', '2024-05-24 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S4', 'CS_K2_SP24_TOC201_SU24', '2024-05-31 12:50:00', '2024-05-31 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S5', 'CS_K2_SP24_TOC201_SU24', '2024-06-07 12:50:00', '2024-06-07 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S6', 'CS_K2_SP24_TOC201_SU24', '2024-06-14 12:50:00', '2024-06-14 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S7', 'CS_K2_SP24_TOC201_SU24', '2024-06-21 12:50:00', '2024-06-21 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S8', 'CS_K2_SP24_TOC201_SU24', '2024-06-28 12:50:00', '2024-06-28 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S9', 'CS_K2_SP24_TOC201_SU24', '2024-07-05 12:50:00', '2024-07-05 15:10:00', N'R005', 3),
('CS_K2_SP24_TOC201_SU24_S10', 'CS_K2_SP24_TOC201_SU24', '2024-07-12 12:50:00', '2024-07-12 15:10:00', N'R005', 3);

-- ClassCourse: CS_K2_SP24_OSG202_SU24 (Thứ 2, Slot 4, Room R001)
INSERT INTO Schedules (schedule_id, class_course_id, start_time, end_time, room, slot) VALUES
('CS_K2_SP24_OSG202_SU24_S1', 'CS_K2_SP24_OSG202_SU24', '2024-05-06 15:30:00', '2024-05-06 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S2', 'CS_K2_SP24_OSG202_SU24', '2024-05-13 15:30:00', '2024-05-13 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S3', 'CS_K2_SP24_OSG202_SU24', '2024-05-20 15:30:00', '2024-05-20 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S4', 'CS_K2_SP24_OSG202_SU24', '2024-05-27 15:30:00', '2024-05-27 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S5', 'CS_K2_SP24_OSG202_SU24', '2024-06-03 15:30:00', '2024-06-03 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S6', 'CS_K2_SP24_OSG202_SU24', '2024-06-10 15:30:00', '2024-06-10 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S7', 'CS_K2_SP24_OSG202_SU24', '2024-06-17 15:30:00', '2024-06-17 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S8', 'CS_K2_SP24_OSG202_SU24', '2024-06-24 15:30:00', '2024-06-24 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S9', 'CS_K2_SP24_OSG202_SU24', '2024-07-01 15:30:00', '2024-07-01 17:50:00', N'R001', 4),
('CS_K2_SP24_OSG202_SU24_S10', 'CS_K2_SP24_OSG202_SU24', '2024-07-08 15:30:00', '2024-07-08 17:50:00', N'R001', 4);


-- Course: PRF192 (Programming Fundamentals) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('PRF192_Assignment_1', 'PRF192', N'Assignment 1', 0.20),
('PRF192_Lab_1', 'PRF192', N'Lab 1', 0.15),
('PRF192_Progress_Test_1', 'PRF192', N'Progress Test 1', 0.15),
('PRF192_Progress_Test_2', 'PRF192', N'Progress Test 2', 0.10),
('PRF192_Final_Exam', 'PRF192', N'Final Exam', 0.40),
('PRF192_Final_Resit', 'PRF192', N'Final Resit', 0.40);

-- Course: DBI202 (Database Systems) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('DBI202_Assignment_1', 'DBI202', N'Assignment 1', 0.20),
('DBI202_Lab_1', 'DBI202', N'Lab 1', 0.15),
('DBI202_Progress_Test_1', 'DBI202', N'Progress Test 1', 0.15),
('DBI202_Progress_Test_2', 'DBI202', N'Progress Test 2', 0.10),
('DBI202_Final_Exam', 'DBI202', N'Final Exam', 0.40),
('DBI202_Final_Resit', 'DBI202', N'Final Resit', 0.40);

-- Course: MAD101 (Mathematics for Developers) - Pattern B
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('MAD101_Assignment', 'MAD101', N'Assignment', 0.25),
('MAD101_Lab', 'MAD101', N'Lab', 0.15),
('MAD101_Progress_Test', 'MAD101', N'Progress Test', 0.20),
('MAD101_Final_Exam', 'MAD101', N'Final Exam', 0.40),
('MAD101_Final_Resit', 'MAD101', N'Final Resit', 0.40);

-- Course: CSD201 (Data Structures and Algorithms) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('CSD201_Assignment_1', 'CSD201', N'Assignment 1', 0.20),
('CSD201_Lab_1', 'CSD201', N'Lab 1', 0.15),
('CSD201_Progress_Test_1', 'CSD201', N'Progress Test 1', 0.15),
('CSD201_Progress_Test_2', 'CSD201', N'Progress Test 2', 0.10),
('CSD201_Final_Exam', 'CSD201', N'Final Exam', 0.40),
('CSD201_Final_Resit', 'CSD201', N'Final Resit', 0.40);

-- Course: AIL301 (Artificial Intelligence and Machine Learning) - Pattern C
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('AIL301_Assignment_1', 'AIL301', N'Assignment 1', 0.10),
('AIL301_Assignment_2', 'AIL301', N'Assignment 2', 0.10),
('AIL301_Lab_1', 'AIL301', N'Lab 1', 0.10),
('AIL301_Progress_Test_1', 'AIL301', N'Progress Test 1', 0.10),
('AIL301_Progress_Test_2', 'AIL301', N'Progress Test 2', 0.10),
('AIL301_Final_Exam', 'AIL301', N'Final Exam', 0.50),
('AIL301_Final_Resit', 'AIL301', N'Final Resit', 0.50);

-- Course: NLP302 (Natural Language Processing) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('NLP302_Assignment_1', 'NLP302', N'Assignment 1', 0.20),
('NLP302_Lab_1', 'NLP302', N'Lab 1', 0.15),
('NLP302_Progress_Test_1', 'NLP302', N'Progress Test 1', 0.15),
('NLP302_Progress_Test_2', 'NLP302', N'Progress Test 2', 0.10),
('NLP302_Final_Exam', 'NLP302', N'Final Exam', 0.40),
('NLP302_Final_Resit', 'NLP302', N'Final Resit', 0.40);

-- Course: AIE303 (AI Ethics and Society) - Pattern B
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('AIE303_Essay', 'AIE303', N'Essay', 0.30),
('AIE303_Presentation', 'AIE303', N'Presentation', 0.20),
('AIE303_Participation', 'AIE303', N'Participation', 0.10),
('AIE303_Final_Exam', 'AIE303', N'Final Exam', 0.40),
('AIE303_Final_Resit', 'AIE303', N'Final Resit', 0.40);

-- Course: AIV304 (AI in Vision) - Pattern C
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('AIV304_Project_Proposal', 'AIV304', N'Project Proposal', 0.10),
('AIV304_Project_Implementation', 'AIV304', N'Project Implementation', 0.25),
('AIV304_Lab_Exercises', 'AIV304', N'Lab Exercises', 0.15),
('AIV304_Quiz_1', 'AIV304', N'Quiz 1', 0.05),
('AIV304_Quiz_2', 'AIV304', N'Quiz 2', 0.05),
('AIV304_Final_Exam', 'AIV304', N'Final Exam', 0.40),
('AIV304_Final_Resit', 'AIV304', N'Final Resit', 0.40);

-- Course: IAS301 (Information Assurance and Security) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('IAS301_Assignment_1', 'IAS301', N'Assignment 1', 0.20),
('IAS301_Lab_Report', 'IAS301', N'Lab Report', 0.15),
('IAS301_Quiz_1', 'IAS301', N'Quiz 1', 0.15),
('IAS301_Quiz_2', 'IAS301', N'Quiz 2', 0.10),
('IAS301_Final_Exam', 'IAS301', N'Final Exam', 0.40),
('IAS301_Final_Resit', 'IAS301', N'Final Resit', 0.40);

-- Course: NET302 (Network Security) - Pattern C
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('NET302_Assignment_1', 'NET302', N'Assignment 1', 0.10),
('NET302_Lab_1', 'NET302', N'Lab 1', 0.10),
('NET302_Lab_2', 'NET302', N'Lab 2', 0.10),
('NET302_Progress_Test_1', 'NET302', N'Progress Test 1', 0.10),
('NET302_Case_Study', 'NET302', N'Case Study', 0.10),
('NET302_Final_Exam', 'NET302', N'Final Exam', 0.50),
('NET302_Final_Resit', 'NET302', N'Final Resit', 0.50);

-- Course: CRY303 (Cryptography) - Pattern B
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('CRY303_Problem_Set_1', 'CRY303', N'Problem Set 1', 0.25),
('CRY303_Problem_Set_2', 'CRY303', N'Problem Set 2', 0.25),
('CRY303_Quiz', 'CRY303', N'Quiz', 0.10),
('CRY303_Final_Exam', 'CRY303', N'Final Exam', 0.40),
('CRY303_Final_Resit', 'CRY303', N'Final Resit', 0.40);

-- Course: ISS304 (Information Security Systems) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('ISS304_Assignment_1', 'ISS304', N'Assignment 1', 0.15),
('ISS304_Project_Part_1', 'ISS304', N'Project Part 1', 0.20),
('ISS304_Project_Part_2', 'ISS304', N'Project Part 2', 0.15),
('ISS304_Quiz', 'ISS304', N'Quiz', 0.10),
('ISS304_Final_Exam', 'ISS304', N'Final Exam', 0.40),
('ISS304_Final_Resit', 'ISS304', N'Final Resit', 0.40);

-- Course: SWE301 (Software Engineering Principles) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('SWE301_Assignment_1', 'SWE301', N'Assignment 1', 0.20),
('SWE301_Team_Project_Report', 'SWE301', N'Team Project Report', 0.15),
('SWE301_Individual_Contribution', 'SWE301', N'Individual Contribution', 0.15),
('SWE301_Presentation', 'SWE301', N'Presentation', 0.10),
('SWE301_Final_Exam', 'SWE301', N'Final Exam', 0.40),
('SWE301_Final_Resit', 'SWE301', N'Final Resit', 0.40);

-- Course: PRJ302 (Software Project Management) - Pattern C
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('PRJ302_Assignment_1', 'PRJ302', N'Assignment 1', 0.10),
('PRJ302_Assignment_2', 'PRJ302', N'Assignment 2', 0.10),
('PRJ302_Project_Plan', 'PRJ302', N'Project Plan', 0.10),
('PRJ302_Progress_Report_1', 'PRJ302', N'Progress Report 1', 0.10),
('PRJ302_Progress_Report_2', 'PRJ302', N'Progress Report 2', 0.10),
('PRJ302_Final_Exam', 'PRJ302', N'Final Exam', 0.50),
('PRJ302_Final_Resit', 'PRJ302', N'Final Resit', 0.50);


-- Course: SDE303 (Software Design and Architecture) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('SDE303_Assignment_1', 'SDE303', N'Assignment 1', 0.20),
('SDE303_Design_Document', 'SDE303', N'Design Document', 0.15),
('SDE303_Lab_Exercises', 'SDE303', N'Lab Exercises', 0.15),
('SDE303_Quiz', 'SDE303', N'Quiz', 0.10),
('SDE303_Final_Exam', 'SDE303', N'Final Exam', 0.40),
('SDE303_Final_Resit', 'SDE303', N'Final Resit', 0.40);

-- Course: SWT304 (Software Testing and Quality Assurance) - Pattern B
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('SWT304_Test_Plan', 'SWT304', N'Test Plan', 0.25),
('SWT304_Test_Cases_Execution', 'SWT304', N'Test Cases & Execution', 0.25),
('SWT304_Bug_Report', 'SWT304', N'Bug Report', 0.10),
('SWT304_Final_Exam', 'SWT304', N'Final Exam', 0.40),
('SWT304_Final_Resit', 'SWT304', N'Final Resit', 0.40);

-- Course: TOC201 (Theory of Computation) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('TOC201_Assignment_1', 'TOC201', N'Assignment 1', 0.15),
('TOC201_Assignment_2', 'TOC201', N'Assignment 2', 0.15),
('TOC201_Quiz_1', 'TOC201', N'Quiz 1', 0.10),
('TOC201_Midterm_Exam', 'TOC201', N'Midterm Exam', 0.20),
('TOC201_Final_Exam', 'TOC201', N'Final Exam', 0.40),
('TOC201_Final_Resit', 'TOC201', N'Final Resit', 0.40);


-- Course: OSG202 (Operating Systems) - Pattern C
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('OSG202_Assignment_1', 'OSG202', N'Assignment 1', 0.10),
('OSG202_Lab_1', 'OSG202', N'Lab 1', 0.10),
('OSG202_Lab_2', 'OSG202', N'Lab 2', 0.10),
('OSG202_Lab_3', 'OSG202', N'Lab 3', 0.10),
('OSG202_Midterm_Test', 'OSG202', N'Midterm Test', 0.20),
('OSG202_Final_Exam', 'OSG202', N'Final Exam', 0.40),
('OSG202_Final_Resit', 'OSG202', N'Final Resit', 0.40);

-- Course: CNW203 (Computer Networks) - Pattern A
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('CNW203_Assignment_1', 'CNW203', N'Assignment 1', 0.20),
('CNW203_Lab_Exercises', 'CNW203', N'Lab Exercises', 0.15),
('CNW203_Packet_Tracer_Activity', 'CNW203', N'Packet Tracer Activity', 0.15),
('CNW203_Quiz', 'CNW203', N'Quiz', 0.10),
('CNW203_Final_Exam', 'CNW203', N'Final Exam', 0.40),
('CNW203_Final_Resit', 'CNW203', N'Final Resit', 0.40);

-- Course: PPL204 (Programming Paradigms) - Pattern B
INSERT INTO CourseGrade (course_grade_id, course_id, grade_name, grade_weight) VALUES
('PPL204_Assignment_1_Functional', 'PPL204', N'Assignment 1 (Functional)', 0.20),
('PPL204_Assignment_2_Logic', 'PPL204', N'Assignment 2 (Logic)', 0.20),
('PPL204_Assignment_3_OOP', 'PPL204', N'Assignment 3 (OOP)', 0.20),
('PPL204_Final_Exam', 'PPL204', N'Final Exam', 0.40),
('PPL204_Final_Resit', 'PPL204', N'Final Resit', 0.40);


INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00001_AI_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 8.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 7.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 7.5, N'Grade Recorded'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 7.5, N'Grade Recorded'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00001_AI_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 8.5, N'Grade Recorded'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 8.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 8.5, N'Grade Recorded'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 8.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_1', 9.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_2', 7.5, N'Grade Recorded'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Lab_1', 8.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00001_AI_K1_FA23_NLP302_SU24', 'NLP302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'NLP302_Lab_1', 7.0, N'Grade Recorded'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00002_AI_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 5.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 4.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 3.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 4.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 3.5, N'Grade Recorded'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 4.5, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00002_AI_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 7.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 6.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 5.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 6.8, N'Grade Recorded'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_1', 6.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_2', 5.5, N'Grade Recorded'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00002_AI_K1_FA23_NLP302_SU24', 'NLP302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'NLP302_Lab_1', 5.5, N'Grade Recorded'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00003_AI_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 8.5, N'Grade Recorded'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00003_AI_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 9.5, N'Grade Recorded'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 8.5, N'Grade Recorded'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 9.2, N'Grade Recorded'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_1', 8.5, N'Grade Recorded'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_2', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Lab_1', 8.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00003_AI_K1_FA23_NLP302_SU24', 'NLP302_Assignment_1', 9.0, N'Grade Recorded'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'NLP302_Lab_1', 8.5, N'Grade Recorded'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00004_AI_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 6.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 5.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 5.5, N'Grade Recorded'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 6.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 5.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00004_AI_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 4.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 3.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 4.5, N'Grade Recorded'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 3.5, N'Grade Recorded'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 3.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 4.0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_1', 5.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Assignment_2', 4.0, N'Grade Recorded'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00004_AI_K1_FA23_NLP302_SU24', 'NLP302_Assignment_1', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'NLP302_Lab_1', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00005_AI_K2_SP24_PRF192_SP24', 'PRF192_Assignment_1', 9.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'PRF192_Lab_1', 9.5, N'Grade Recorded'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 9.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 9.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Exam', 9.5, N'Grade Recorded'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00005_AI_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 8.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 9.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 8.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 8.5, N'Grade Recorded'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 8.8, N'Grade Recorded'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', 8.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', 7.5, N'Grade Recorded'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00005_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 6.5, N'Grade Recorded'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 7.0, N'Grade Recorded'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00006_AI_K2_SP24_PRF192_SP24', 'PRF192_Assignment_1', 7.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'PRF192_Lab_1', 6.5, N'Grade Recorded'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 6.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Exam', 7.2, N'Grade Recorded'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00006_AI_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 6.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 7.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 6.5, N'Grade Recorded'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 6.9, N'Grade Recorded'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 6.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00006_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 6.0, N'Grade Recorded'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00007_AI_K2_SP24_PRF192_SP24', 'PRF192_Assignment_1', 4.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'PRF192_Lab_1', 3.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 2.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 4.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Exam', 3.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Resit', 3.8, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00007_AI_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 5.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 6.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 4.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 5.2, N'Grade Recorded'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 5.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00007_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 4.0, N'Grade Recorded'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 3.5, N'Grade Recorded'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00008_AI_K2_SP24_PRF192_SP24', 'PRF192_Assignment_1', 8.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'PRF192_Lab_1', 7.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 7.5, N'Grade Recorded'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Exam', 7.8, N'Grade Recorded'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00008_AI_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 7.5, N'Grade Recorded'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 8.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 8.2, N'Grade Recorded'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 8.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00008_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 7.5, N'Grade Recorded'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00009_AI_K2_SP24_PRF192_SP24', 'PRF192_Assignment_1', 7.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'PRF192_Lab_1', 6.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 5.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Exam', 6.5, N'Grade Recorded'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00009_AI_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 4.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 5.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 3.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 4.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 4.2, N'Grade Recorded'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 5.0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 6.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', 5.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00009_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 5.0, N'Grade Recorded'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', 6.0, N'Grade Recorded'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', 7.5, N'Grade Recorded'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00010_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 6.0, N'Grade Recorded'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00011_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 7.5, N'Grade Recorded'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 8.0, N'Grade Recorded'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 8.0, N'Grade Recorded'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', 7.0, N'Grade Recorded'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', 6.5, N'Grade Recorded'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00012_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_1', 6.0, N'Grade Recorded'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Assignment_2', 5.0, N'Grade Recorded'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Lab_1', 5.5, N'Grade Recorded'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Progress_Test_2', NULL, N'Awaiting Grade'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AIL301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00013_AI_K2_SP24_NLP302_SU24', 'NLP302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'NLP302_Lab_1', 7.0, N'Grade Recorded'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_1', 6.0, N'Grade Recorded'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'NLP302_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'NLP302_Final_Resit', NULL, N'Awaiting Grade');


INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00014_IA_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 6.5, N'Grade Recorded'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 5.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 6.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 6.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00014_IA_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 7.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 7.5, N'Grade Recorded'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 6.5, N'Grade Recorded'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 7.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00014_IA_K1_FA23_IAS301_SU24', 'IAS301_Assignment_1', 8.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IAS301_Lab_Report', 7.0, N'Grade Recorded'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Assignment_1', 7.5, N'Grade Recorded'),
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Lab_1', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00014_IA_K1_FA23_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00015_IA_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 4.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 3.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 2.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 3.5, N'Grade Recorded'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 2.5, N'Grade Recorded'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 3.0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00015_IA_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 5.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 6.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 4.5, N'Grade Recorded'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 6.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00015_IA_K1_FA23_IAS301_SU24', 'IAS301_Assignment_1', 5.5, N'Grade Recorded'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IAS301_Lab_Report', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Assignment_1', 6.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Lab_1', 4.0, N'Grade Recorded'),
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00015_IA_K1_FA23_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00016_IA_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 8.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 9.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 8.5, N'Grade Recorded'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 8.8, N'Grade Recorded'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00016_IA_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 9.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 9.5, N'Grade Recorded'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 8.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 9.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 9.3, N'Grade Recorded'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00016_IA_K1_FA23_IAS301_SU24', 'IAS301_Assignment_1', 9.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IAS301_Lab_Report', 8.5, N'Grade Recorded'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Assignment_1', 8.5, N'Grade Recorded'),
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Lab_1', 9.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Lab_2', 8.0, N'Grade Recorded'),
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00016_IA_K1_FA23_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00017_IA_K1_FA23_PRF192_SP24', 'PRF192_Assignment_1', 7.0, N'Grade Recorded'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'PRF192_Lab_1', 8.0, N'Grade Recorded'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_1', 7.5, N'Grade Recorded'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'PRF192_Progress_Test_2', 8.5, N'Grade Recorded'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Exam', 7.9, N'Grade Recorded'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00017_IA_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 4.0, N'Grade Recorded'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 3.5, N'Grade Recorded'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 5.0, N'Grade Recorded'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 4.0, N'Grade Recorded'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 3.8, N'Grade Recorded'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 4.2, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00017_IA_K1_FA23_IAS301_SU24', 'IAS301_Assignment_1', 6.5, N'Grade Recorded'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IAS301_Lab_Report', 7.0, N'Grade Recorded'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Assignment_1', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Lab_1', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00017_IA_K1_FA23_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00018_IA_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 5.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 6.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 4.5, N'Grade Recorded'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 5.5, N'Grade Recorded'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00018_IA_K2_SU24_DBI202_SP24', 'DBI202_Assignment_1', 7.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'DBI202_Lab_1', 6.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_1', 7.5, N'Grade Recorded'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_2', 6.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Exam', 6.8, N'Grade Recorded'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00018_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', 6.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', 7.5, N'Grade Recorded'),
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00018_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00019_IA_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 9.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 8.5, N'Grade Recorded'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 9.5, N'Grade Recorded'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 9.2, N'Grade Recorded'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00019_IA_K2_SU24_DBI202_SP24', 'DBI202_Assignment_1', 8.5, N'Grade Recorded'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'DBI202_Lab_1', 9.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_1', 8.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_2', 9.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Exam', 9.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00019_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 8.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', 7.5, N'Grade Recorded'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', 8.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 9.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', 8.0, N'Grade Recorded'),
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00019_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00020_IA_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 4.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 5.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 3.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 4.8, N'Grade Recorded'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 4.0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00020_IA_K2_SU24_DBI202_SP24', 'DBI202_Assignment_1', 3.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'DBI202_Lab_1', 4.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_1', 2.5, N'Grade Recorded'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_2', 4.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Exam', 3.5, N'Grade Recorded'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Resit', 3.9, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00020_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 4.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 5.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', 3.0, N'Grade Recorded'),
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00020_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00021_IA_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 7.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 7.5, N'Grade Recorded'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 6.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 7.5, N'Grade Recorded'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00021_IA_K2_SU24_DBI202_SP24', 'DBI202_Assignment_1', 6.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'DBI202_Lab_1', 5.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'DBI202_Progress_Test_2', 5.5, N'Grade Recorded'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Exam', 6.5, N'Grade Recorded'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00021_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', 8.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 6.0, N'Grade Recorded'),
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00021_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00022_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 6.0, N'Grade Recorded'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', 5.0, N'Grade Recorded'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00022_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00023_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 7.5, N'Grade Recorded'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', 8.0, N'Grade Recorded'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00023_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00024_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', 6.5, N'Grade Recorded'),
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00024_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00025_IA_K2_SU24_IAS301_SU24', 'IAS301_Assignment_1', 8.5, N'Grade Recorded'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IAS301_Lab_Report', 9.0, N'Grade Recorded'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_1', 7.0, N'Grade Recorded'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IAS301_Quiz_2', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IAS301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Lab_1', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Lab_2', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Progress_Test_1', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Case_Study', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00025_IA_K2_SU24_NET302_SU24', 'NET302_Final_Resit', NULL, N'Awaiting Grade');


INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00026_SE_K1_SP24_PRF192_SP24', 'PRF192_Assignment_1', 8.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'PRF192_Lab_1', 7.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 8.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 7.5, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Exam', 8.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00026_SE_K1_SP24_MAD101_SP24', 'MAD101_Assignment', 8.5, N'Grade Recorded'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'MAD101_Lab', 8.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'MAD101_Progress_Test', 7.5, N'Grade Recorded'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Exam', 8.5, N'Grade Recorded'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00026_SE_K1_SP24_SWE301_SU24', 'SWE301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SWE301_Team_Project_Report', 8.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_2', 7.5, N'Grade Recorded'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00027_SE_K1_SP24_PRF192_SP24', 'PRF192_Assignment_1', 4.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'PRF192_Lab_1', 3.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 5.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 3.5, N'Grade Recorded'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Exam', 4.2, N'Grade Recorded'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Resit', 3.8, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00027_SE_K1_SP24_MAD101_SP24', 'MAD101_Assignment', 6.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'MAD101_Lab', 5.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'MAD101_Progress_Test', 7.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Exam', 6.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00027_SE_K1_SP24_SWE301_SU24', 'SWE301_Assignment_1', 5.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SWE301_Team_Project_Report', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_1', 6.0, N'Grade Recorded'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00028_SE_K1_SP24_PRF192_SP24', 'PRF192_Assignment_1', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'PRF192_Lab_1', 10.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 9.5, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Exam', 9.8, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00028_SE_K1_SP24_MAD101_SP24', 'MAD101_Assignment', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'MAD101_Lab', 8.5, N'Grade Recorded'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'MAD101_Progress_Test', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Exam', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00028_SE_K1_SP24_SWE301_SU24', 'SWE301_Assignment_1', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SWE301_Team_Project_Report', 8.5, N'Grade Recorded'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_2', 9.0, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Project_Plan', 8.5, N'Grade Recorded'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00029_SE_K1_SP24_PRF192_SP24', 'PRF192_Assignment_1', 5.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'PRF192_Lab_1', 4.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_1', 6.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'PRF192_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Exam', 5.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00029_SE_K1_SP24_MAD101_SP24', 'MAD101_Assignment', 4.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'MAD101_Lab', 3.5, N'Grade Recorded'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'MAD101_Progress_Test', 5.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Exam', 4.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'MAD101_Final_Resit', 4.5, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00029_SE_K1_SP24_SWE301_SU24', 'SWE301_Assignment_1', 6.0, N'Grade Recorded'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SWE301_Team_Project_Report', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_1', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00030_SE_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 8.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 7.5, N'Grade Recorded'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 8.5, N'Grade Recorded'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 8.2, N'Grade Recorded'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00030_SE_K2_SU24_MAD101_SP24', 'MAD101_Assignment', 7.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'MAD101_Lab', 8.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'MAD101_Progress_Test', 7.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Exam', 7.8, N'Grade Recorded'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00030_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', 8.0, N'Grade Recorded'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 6.5, N'Grade Recorded'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00031_SE_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 6.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 7.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 5.5, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 6.8, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00031_SE_K2_SU24_MAD101_SP24', 'MAD101_Assignment', 7.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'MAD101_Lab', 6.5, N'Grade Recorded'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'MAD101_Progress_Test', 7.5, N'Grade Recorded'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Exam', 7.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00031_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 7.5, N'Grade Recorded'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', 8.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', 7.0, N'Grade Recorded'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00032_SE_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 3.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 2.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 4.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 3.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 3.5, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 2.8, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00032_SE_K2_SU24_MAD101_SP24', 'MAD101_Assignment', 5.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'MAD101_Lab', 6.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'MAD101_Progress_Test', 5.5, N'Grade Recorded'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Exam', 6.2, N'Grade Recorded'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00032_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 4.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 5.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', 3.0, N'Grade Recorded'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00033_SE_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 9.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 8.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 9.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 8.5, N'Grade Recorded'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 9.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00033_SE_K2_SU24_MAD101_SP24', 'MAD101_Assignment', 9.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'MAD101_Lab', 9.5, N'Grade Recorded'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'MAD101_Progress_Test', 8.5, N'Grade Recorded'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Exam', 9.3, N'Grade Recorded'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00033_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 8.5, N'Grade Recorded'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', 9.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 9.0, N'Grade Recorded'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00034_SE_K2_SU24_PRF192_SP24', 'PRF192_Assignment_1', 6.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'PRF192_Lab_1', 5.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_1', 6.5, N'Grade Recorded'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'PRF192_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Exam', 6.2, N'Grade Recorded'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'PRF192_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00034_SE_K2_SU24_MAD101_SP24', 'MAD101_Assignment', 4.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'MAD101_Lab', 3.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'MAD101_Progress_Test', 4.5, N'Grade Recorded'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Exam', 3.8, N'Grade Recorded'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'MAD101_Final_Resit', 4.1, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00034_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 5.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', 6.0, N'Grade Recorded'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 4.5, N'Grade Recorded'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00035_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 7.0, N'Grade Recorded'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 8.0, N'Grade Recorded'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', 7.0, N'Grade Recorded'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00036_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 6.0, N'Grade Recorded'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00037_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 8.0, N'Grade Recorded'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', 7.0, N'Grade Recorded'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', NULL, N'Awaiting Grade'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', 7.0, N'Grade Recorded'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', 6.0, N'Grade Recorded'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', 5.0, N'Grade Recorded'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00038_SE_K2_SU24_SWE301_SU24', 'SWE301_Assignment_1', 9.0, N'Grade Recorded'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SWE301_Team_Project_Report', 8.0, N'Grade Recorded'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SWE301_Individual_Contribution', 7.0, N'Grade Recorded'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SWE301_Presentation', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Exam', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SWE301_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_1', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Assignment_2', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Project_Plan', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_1', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Progress_Report_2', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Exam', NULL, N'Awaiting Grade'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'PRJ302_Final_Resit', NULL, N'Awaiting Grade');


INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00039_CS_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 8.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 9.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 8.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 8.5, N'Grade Recorded'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 8.8, N'Grade Recorded'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00039_CS_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 7.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 6.5, N'Grade Recorded'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 7.5, N'Grade Recorded'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 7.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00039_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_1', 8.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_2', 7.0, N'Grade Recorded'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Assignment_1', 7.5, N'Grade Recorded'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_1', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00040_CS_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 5.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 4.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 5.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 4.5, N'Grade Recorded'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 4.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 4.9, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00040_CS_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 6.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 5.5, N'Grade Recorded'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 6.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 6.5, N'Grade Recorded'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00040_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_1', 5.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_2', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Assignment_1', 6.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_1', 4.0, N'Grade Recorded'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00041_CS_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 9.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 9.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 8.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 9.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 9.2, N'Grade Recorded'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00041_CS_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 9.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 9.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 9.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 9.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 9.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00041_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_1', 9.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_2', 8.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Assignment_1', 8.5, N'Grade Recorded'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_1', 9.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_2', 8.0, N'Grade Recorded'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00042_CS_K1_FA23_CSD201_SP24', 'CSD201_Assignment_1', 7.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CSD201_Lab_1', 6.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_1', 7.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CSD201_Progress_Test_2', 6.5, N'Grade Recorded'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Exam', 6.8, N'Grade Recorded'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00042_CS_K1_FA23_DBI202_SP24', 'DBI202_Assignment_1', 3.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'DBI202_Lab_1', 2.5, N'Grade Recorded'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_1', 4.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'DBI202_Progress_Test_2', 3.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Exam', 3.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'DBI202_Final_Resit', 3.5, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00042_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_1', 6.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'TOC201_Assignment_2', 5.0, N'Grade Recorded'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Assignment_1', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_1', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00043_CS_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 7.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 7.5, N'Grade Recorded'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 6.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 7.5, N'Grade Recorded'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00043_CS_K2_SP24_DBI202_SP24', 'DBI202_Assignment_1', 8.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'DBI202_Lab_1', 7.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_1', 8.5, N'Grade Recorded'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_2', 7.5, N'Grade Recorded'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Exam', 8.2, N'Grade Recorded'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00043_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 7.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', 8.0, N'Grade Recorded'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 6.5, N'Grade Recorded'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00044_CS_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 5.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 6.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 4.5, N'Grade Recorded'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 5.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 6.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00044_CS_K2_SP24_DBI202_SP24', 'DBI202_Assignment_1', 6.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'DBI202_Lab_1', 7.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_1', 5.5, N'Grade Recorded'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_2', 7.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Exam', 6.8, N'Grade Recorded'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00044_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 7.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 8.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', 7.0, N'Grade Recorded'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00045_CS_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 2.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 3.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 1.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 2.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 3.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 2.0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00045_CS_K2_SP24_DBI202_SP24', 'DBI202_Assignment_1', 5.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'DBI202_Lab_1', 4.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_1', 5.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_2', 4.5, N'Grade Recorded'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Exam', 4.8, N'Grade Recorded'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Resit', 5.0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00045_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 3.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 4.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', 2.0, N'Grade Recorded'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00046_CS_K2_SP24_CSD201_SP24', 'CSD201_Assignment_1', 10.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CSD201_Lab_1', 9.5, N'Grade Recorded'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_1', 9.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CSD201_Progress_Test_2', 10.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Exam', 10.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CSD201_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00046_CS_K2_SP24_DBI202_SP24', 'DBI202_Assignment_1', 8.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'DBI202_Lab_1', 9.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_1', 8.5, N'Grade Recorded'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'DBI202_Progress_Test_2', 8.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Exam', 9.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'DBI202_Final_Resit', 0, N'Grade Recorded');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00046_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 9.0, N'Grade Recorded'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', 8.5, N'Grade Recorded'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 9.5, N'Grade Recorded'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00047_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 7.0, N'Grade Recorded'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 8.0, N'Grade Recorded'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', 6.0, N'Grade Recorded'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00048_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 7.0, N'Grade Recorded'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00049_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 8.0, N'Grade Recorded'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', 7.5, N'Grade Recorded'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', NULL, N'Awaiting Grade'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', 7.0, N'Grade Recorded'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', 6.0, N'Grade Recorded'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', 5.0, N'Grade Recorded'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00050_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_1', 9.0, N'Grade Recorded'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'TOC201_Assignment_2', 8.0, N'Grade Recorded'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'TOC201_Quiz_1', 7.0, N'Grade Recorded'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'TOC201_Midterm_Exam', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Exam', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'TOC201_Final_Resit', NULL, N'Awaiting Grade');

INSERT INTO StudentGradeDetails (enrollment_id, course_grade_id, grade_value, comment) VALUES
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Assignment_1', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_1', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_2', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Lab_3', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Midterm_Test', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Exam', NULL, N'Awaiting Grade'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'OSG202_Final_Resit', NULL, N'Awaiting Grade');


-- Sinh viên: HE00001
-- Enrollment: HE00001_AI_K1_FA23_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S1', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S3', 'Absent'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S4', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S5', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S8', 'Absent'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00001_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00001_AI_K1_FA23_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S3', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S5', 'Absent'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00001_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00001_AI_K1_FA23_AIL301_SU24 (Môn AIL301, Kỳ SU24)
-- Schedule dates: S1:2024-05-06, S2:2024-05-13, S3:2024-05-20, S4:2024-05-27, S5:2024-06-03, S6:2024-06-10 (Past/Present)
-- Schedule dates: S7:2024-06-17, S8:2024-06-24, S9:2024-07-01, S10:2024-07-08 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S1', 'Present'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S2', 'Present'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S3', 'Present'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S4', 'Absent'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S5', 'Present'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S6', 'Present'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S7', 'Future'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S8', 'Future'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S9', 'Future'),
('HE00001_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00001_AI_K1_FA23_NLP302_SU24 (Môn NLP302, Kỳ SU24)
-- Schedule dates: S1:2024-05-07, S2:2024-05-14, S3:2024-05-21, S4:2024-05-28, S5:2024-06-04, S6:2024-06-11 (Past/Present)
-- Schedule dates: S7:2024-06-18, S8:2024-06-25, S9:2024-07-02, S10:2024-07-09 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S1', 'Present'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S2', 'Absent'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S3', 'Present'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S4', 'Present'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S5', 'Present'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S6', 'Present'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S7', 'Future'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S8', 'Future'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S9', 'Future'),
('HE00001_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00002
-- Enrollment: HE00002_AI_K1_FA23_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S1', 'Absent'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S3', 'Absent'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S4', 'Present'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S5', 'Absent'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S7', 'Absent'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S8', 'Absent'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00002_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00002_AI_K1_FA23_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S3', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S9', 'Absent'),
('HE00002_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00002_AI_K1_FA23_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S1', 'Present'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S2', 'Present'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S3', 'Absent'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S4', 'Present'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S5', 'Present'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S6', 'Absent'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S7', 'Future'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S8', 'Future'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S9', 'Future'),
('HE00002_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00002_AI_K1_FA23_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S1', 'Present'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S2', 'Present'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S3', 'Present'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S4', 'Present'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S5', 'Present'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S6', 'Present'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S7', 'Future'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S8', 'Future'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S9', 'Future'),
('HE00002_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00003
-- Enrollment: HE00003_AI_K1_FA23_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S1', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S3', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S4', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S5', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S8', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00003_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S10', 'Absent');

-- Enrollment: HE00003_AI_K1_FA23_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S3', 'Absent'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00003_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00003_AI_K1_FA23_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S1', 'Present'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S2', 'Present'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S3', 'Present'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S4', 'Present'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S5', 'Present'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S6', 'Present'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S7', 'Future'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S8', 'Future'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S9', 'Future'),
('HE00003_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00003_AI_K1_FA23_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S1', 'Present'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S2', 'Present'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S3', 'Present'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S4', 'Absent'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S5', 'Present'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S6', 'Absent'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S7', 'Future'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S8', 'Future'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S9', 'Future'),
('HE00003_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00004
-- Enrollment: HE00004_AI_K1_FA23_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S1', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S3', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S4', 'Absent'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S5', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S8', 'Present'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S9', 'Absent'),
('HE00004_AI_K1_FA23_PRF192_SP24', 'AI_K1_FA23_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00004_AI_K1_FA23_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S1', 'Absent'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S3', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S6', 'Absent'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00004_AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00004_AI_K1_FA23_AIL301_SU24 (Môn AIL301, Kỳ SU24)
-- Schedule dates: S1:2024-05-06 to S6:2024-06-10 (Past/Present)
-- Schedule dates: S7:2024-06-17 to S10:2024-07-08 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S1', 'Present'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S2', 'Present'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S3', 'Absent'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S4', 'Present'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S5', 'Present'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S6', 'Present'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S7', 'Future'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S8', 'Future'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S9', 'Future'),
('HE00004_AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00004_AI_K1_FA23_NLP302_SU24 (Môn NLP302, Kỳ SU24)
-- Schedule dates: S1:2024-05-07 to S6:2024-06-11 (Past/Present)
-- Schedule dates: S7:2024-06-18 to S10:2024-07-09 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S1', 'Present'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S2', 'Present'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S3', 'Present'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S4', 'Present'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S5', 'Absent'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S6', 'Present'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S7', 'Future'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S8', 'Future'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S9', 'Future'),
('HE00004_AI_K1_FA23_NLP302_SU24', 'AI_K1_FA23_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00005
-- Enrollment: HE00005_AI_K2_SP24_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S1', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S2', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S3', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S4', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S5', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S6', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S7', 'Absent'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S8', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S9', 'Present'),
('HE00005_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00005_AI_K2_SP24_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S4', 'Absent'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00005_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S10', 'Absent');

-- Enrollment: HE00005_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
-- Schedule dates: S1:2024-05-08 to S6:2024-06-12 (Past/Present)
-- Schedule dates: S7:2024-06-19 to S10:2024-07-10 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00005_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00005_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
-- Schedule dates: S1:2024-05-09 to S6:2024-06-13 (Past/Present)
-- Schedule dates: S7:2024-06-20 to S10:2024-07-11 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Absent'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Absent'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00005_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00006
-- Enrollment: HE00006_AI_K2_SP24_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S1', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S2', 'Absent'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S3', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S4', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S5', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S6', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S7', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S8', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S9', 'Present'),
('HE00006_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00006_AI_K2_SP24_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S8', 'Absent'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00006_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00006_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Absent'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00006_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00006_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Absent'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00006_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00007
-- Enrollment: HE00007_AI_K2_SP24_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S1', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S2', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S3', 'Absent'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S4', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S5', 'Absent'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S6', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S7', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S8', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S9', 'Present'),
('HE00007_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S10', 'Absent');

-- Enrollment: HE00007_AI_K2_SP24_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00007_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00007_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
-- Schedule dates: S1:2024-05-08 to S6:2024-06-12 (Past/Present)
-- Schedule dates: S7:2024-06-19 to S10:2024-07-10 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Absent'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00007_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00007_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
-- Schedule dates: S1:2024-05-09 to S6:2024-06-13 (Past/Present)
-- Schedule dates: S7:2024-06-20 to S10:2024-07-11 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Present'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00007_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00008
-- Enrollment: HE00008_AI_K2_SP24_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S1', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S2', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S3', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S4', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S5', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S6', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S7', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S8', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S9', 'Present'),
('HE00008_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00008_AI_K2_SP24_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S2', 'Absent'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S7', 'Absent'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00008_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00008_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Absent'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00008_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00008_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Absent'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Present'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00008_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00009
-- Enrollment: HE00009_AI_K2_SP24_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S1', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S2', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S3', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S4', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S5', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S6', 'Absent'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S7', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S8', 'Present'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S9', 'Absent'),
('HE00009_AI_K2_SP24_PRF192_SP24', 'AI_K2_SP24_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00009_AI_K2_SP24_CSD201_SP24 (Môn CSD201, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S3', 'Absent'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S4', 'Absent'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00009_AI_K2_SP24_CSD201_SP24', 'AI_K2_SP24_CSD201_SP24_S10', 'Present');

-- Enrollment: HE00009_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00009_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00009_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Absent'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Present'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00009_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');


INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Absent'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00010_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00010_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
-- Schedule dates: S1:2024-05-09, S2:2024-05-16, S3:2024-05-23, S4:2024-05-30, S5:2024-06-06, S6:2024-06-13 (Past/Present)
-- Schedule dates: S7:2024-06-20, S8:2024-06-27, S9:2024-07-04, S10:2024-07-11 (Future)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Absent'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00010_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00011
-- Enrollment: HE00011_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Absent'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00011_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00011_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Present'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00011_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00012
-- Enrollment: HE00012_AI_K2_SP24_AIL301_SU24 (Môn AIL301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Absent'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Present'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00012_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

-- Enrollment: HE00012_AI_K2_SP24_NLP302_SU24 (Môn NLP302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Present'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Absent'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Absent'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Present'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00012_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');


-- Bảng Attendance - Phần 5
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S1', 'Present'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S2', 'Present'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S3', 'Present'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S4', 'Present'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S5', 'Present'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S6', 'Absent'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S7', 'Future'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S8', 'Future'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S9', 'Future'),
('HE00013_AI_K2_SP24_AIL301_SU24', 'AI_K2_SP24_AIL301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S1', 'Present'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S2', 'Absent'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S3', 'Present'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S4', 'Present'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S5', 'Present'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S6', 'Present'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S7', 'Future'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S8', 'Future'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S9', 'Future'),
('HE00013_AI_K2_SP24_NLP302_SU24', 'AI_K2_SP24_NLP302_SU24_S10', 'Future');

-- Sinh viên: HE00014 (Lớp IA_K1_FA23 - Nhập học FA23)
-- Enrollment: HE00014_IA_K1_FA23_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S1', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S3', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S4', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S5', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S8', 'Absent'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00014_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00014_IA_K1_FA23_DBI202_SP24 (Môn DBI202, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S1', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S2', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S3', 'Absent'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00014_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S10', 'Absent');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S1', 'Present'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S2', 'Present'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S3', 'Present'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S4', 'Present'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S5', 'Present'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S6', 'Present'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S7', 'Future'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S8', 'Future'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S9', 'Future'),
('HE00014_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S10', 'Future');

-- Enrollment: HE00014_IA_K1_FA23_NET302_SU24 (Môn NET302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S1', 'Present'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S2', 'Present'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S3', 'Present'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S4', 'Present'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S5', 'Absent'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S6', 'Present'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S7', 'Future'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S8', 'Future'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S9', 'Future'),
('HE00014_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S10', 'Future');

-- Sinh viên: HE00015 (Lớp IA_K1_FA23 - Nhập học FA23)
-- Enrollment: HE00015_IA_K1_FA23_PRF192_SP24 (Môn PRF192, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S1', 'Absent'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S2', 'Absent'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S3', 'Present'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S4', 'Present'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S5', 'Absent'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S8', 'Present'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00015_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S10', 'Present');

-- Enrollment: HE00015_IA_K1_FA23_DBI202_SP24 (Môn DBI202, Kỳ SP24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S1', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S2', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S3', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00015_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S10', 'Present');

-- Enrollment: HE00015_IA_K1_FA23_IAS301_SU24 (Môn IAS301, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S1', 'Present'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S2', 'Present'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S3', 'Present'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S4', 'Present'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S5', 'Present'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S6', 'Present'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S7', 'Future'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S8', 'Future'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S9', 'Future'),
('HE00015_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S10', 'Future');

-- Enrollment: HE00015_IA_K1_FA23_NET302_SU24 (Môn NET302, Kỳ SU24)
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S1', 'Absent'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S2', 'Present'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S3', 'Present'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S4', 'Present'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S5', 'Present'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S6', 'Absent'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S7', 'Future'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S8', 'Future'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S9', 'Future'),
('HE00015_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S10', 'Future');

--part 6
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S1', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S3', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S4', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S5', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S8', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00016_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S1', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S2', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S3', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S5', 'Absent'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00016_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S1', 'Present'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S2', 'Present'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S3', 'Present'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S4', 'Present'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S5', 'Present'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S6', 'Absent'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S7', 'Future'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S8', 'Future'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S9', 'Future'),
('HE00016_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S1', 'Present'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S2', 'Present'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S3', 'Present'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S4', 'Present'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S5', 'Present'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S6', 'Present'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S7', 'Future'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S8', 'Future'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S9', 'Future'),
('HE00016_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S1', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S2', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S3', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S4', 'Absent'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S5', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S6', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S7', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S8', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S9', 'Present'),
('HE00017_IA_K1_FA23_PRF192_SP24', 'IA_K1_FA23_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S1', 'Absent'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S2', 'Absent'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S3', 'Present'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S9', 'Absent'),
('HE00017_IA_K1_FA23_DBI202_SP24', 'IA_K1_FA23_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S1', 'Present'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S2', 'Present'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S3', 'Present'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S4', 'Present'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S5', 'Present'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S6', 'Present'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S7', 'Future'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S8', 'Future'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S9', 'Future'),
('HE00017_IA_K1_FA23_IAS301_SU24', 'IA_K1_FA23_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S1', 'Present'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S2', 'Present'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S3', 'Absent'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S4', 'Present'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S5', 'Present'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S6', 'Present'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S7', 'Future'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S8', 'Future'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S9', 'Future'),
('HE00017_IA_K1_FA23_NET302_SU24', 'IA_K1_FA23_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00018_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S1', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S2', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S3', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S4', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S5', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S6', 'Absent'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S7', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S8', 'Present'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S9', 'Absent'),
('HE00018_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Present'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00018_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Absent'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00018_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

--part 7
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S9', 'Absent'),
('HE00019_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S1', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S2', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S3', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S4', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S5', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S6', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S7', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S8', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S9', 'Present'),
('HE00019_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Absent'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00019_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Present'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00019_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S1', 'Absent'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S2', 'Absent'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S3', 'Absent'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00020_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S1', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S2', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S3', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S4', 'Absent'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S5', 'Absent'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S6', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S7', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S8', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S9', 'Present'),
('HE00020_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Present'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00020_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Absent'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Absent'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Present'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00020_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00021_IA_K2_SU24_PRF192_SP24', 'IA_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S1', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S2', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S3', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S4', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S5', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S6', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S7', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S8', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S9', 'Present'),
('HE00021_IA_K2_SU24_DBI202_SP24', 'IA_K2_SU24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Present'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00021_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Present'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00021_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

--part 8
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Present'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Absent'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00022_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Present'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00022_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Absent'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Absent'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00023_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Present'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00023_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Present'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Present'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00024_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Absent'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Absent'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00024_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

--part 9
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S1', 'Present'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S2', 'Present'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S3', 'Present'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S4', 'Absent'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S5', 'Present'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S6', 'Present'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S7', 'Future'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S8', 'Future'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S9', 'Future'),
('HE00025_IA_K2_SU24_IAS301_SU24', 'IA_K2_SU24_IAS301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S1', 'Present'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S2', 'Present'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S3', 'Present'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S4', 'Present'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S5', 'Present'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S6', 'Present'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S7', 'Future'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S8', 'Future'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S9', 'Future'),
('HE00025_IA_K2_SU24_NET302_SU24', 'IA_K2_SU24_NET302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S1', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S2', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S3', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S4', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S5', 'Absent'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S6', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S7', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S8', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S9', 'Present'),
('HE00026_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S1', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S2', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S3', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S4', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S5', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S6', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S7', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S8', 'Present'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S9', 'Absent'),
('HE00026_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S1', 'Present'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S2', 'Present'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S3', 'Present'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S4', 'Present'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S5', 'Present'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S6', 'Present'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S7', 'Future'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S8', 'Future'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S9', 'Future'),
('HE00026_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S1', 'Present'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S2', 'Present'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S3', 'Present'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S4', 'Absent'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S5', 'Present'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S6', 'Present'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S7', 'Future'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S8', 'Future'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S9', 'Future'),
('HE00026_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S1', 'Absent'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S2', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S3', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S4', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S5', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S6', 'Absent'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S7', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S8', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S9', 'Present'),
('HE00027_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S1', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S2', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S3', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S4', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S5', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S6', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S7', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S8', 'Absent'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S9', 'Present'),
('HE00027_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S1', 'Present'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S2', 'Present'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S3', 'Present'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S4', 'Present'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S5', 'Present'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S6', 'Present'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S7', 'Future'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S8', 'Future'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S9', 'Future'),
('HE00027_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S1', 'Present'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S2', 'Present'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S3', 'Absent'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S4', 'Present'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S5', 'Present'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S6', 'Absent'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S7', 'Future'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S8', 'Future'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S9', 'Future'),
('HE00027_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S10', 'Future');

--part 10
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S1', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S2', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S3', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S4', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S5', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S6', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S7', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S8', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S9', 'Present'),
('HE00028_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S1', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S2', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S3', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S4', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S5', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S6', 'Absent'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S7', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S8', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S9', 'Present'),
('HE00028_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S1', 'Present'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S2', 'Present'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S3', 'Present'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S4', 'Present'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S5', 'Present'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S6', 'Present'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S7', 'Future'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S8', 'Future'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S9', 'Future'),
('HE00028_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S1', 'Present'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S2', 'Present'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S3', 'Present'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S4', 'Present'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S5', 'Present'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S6', 'Present'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S7', 'Future'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S8', 'Future'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S9', 'Future'),
('HE00028_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S1', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S2', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S3', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S4', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S5', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S6', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S7', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S8', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S9', 'Present'),
('HE00029_SE_K1_SP24_PRF192_SP24', 'SE_K1_SP24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S1', 'Absent'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S2', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S3', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S4', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S5', 'Absent'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S6', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S7', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S8', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S9', 'Present'),
('HE00029_SE_K1_SP24_MAD101_SP24', 'SE_K1_SP24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S1', 'Present'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S2', 'Present'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S3', 'Present'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S4', 'Present'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S5', 'Present'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S6', 'Present'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S7', 'Future'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S8', 'Future'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S9', 'Future'),
('HE00029_SE_K1_SP24_SWE301_SU24', 'SE_K1_SP24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S1', 'Present'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S2', 'Absent'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S3', 'Present'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S4', 'Present'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S5', 'Present'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S6', 'Present'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S7', 'Future'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S8', 'Future'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S9', 'Future'),
('HE00029_SE_K1_SP24_PRJ302_SU24', 'SE_K1_SP24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00030_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S1', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S2', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S3', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S4', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S5', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S6', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S7', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S8', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S9', 'Present'),
('HE00030_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00030_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Absent'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00030_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');


--part 11
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00031_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S1', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S2', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S3', 'Absent'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S4', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S5', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S6', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S7', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S8', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S9', 'Present'),
('HE00031_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S10', 'Absent');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00031_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Absent'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00031_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S1', 'Absent'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S2', 'Absent'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00032_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S1', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S2', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S3', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S4', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S5', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S6', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S7', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S8', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S9', 'Present'),
('HE00032_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Absent'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00032_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00032_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S9', 'Present'),
('HE00033_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S1', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S2', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S3', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S4', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S5', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S6', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S7', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S8', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S9', 'Present'),
('HE00033_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00033_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00033_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');


--part 12
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S1', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S2', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S3', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S4', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S5', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S6', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S7', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S8', 'Present'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S9', 'Absent'),
('HE00034_SE_K2_SU24_PRF192_SP24', 'SE_K2_SU24_PRF192_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S1', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S2', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S3', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S4', 'Absent'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S5', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S6', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S7', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S8', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S9', 'Present'),
('HE00034_SE_K2_SU24_MAD101_SP24', 'SE_K2_SU24_MAD101_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00034_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Absent'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00034_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00035_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Absent'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00035_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Absent'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00036_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00036_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');


--part 13
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Present'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00037_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Absent'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00037_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S1', 'Present'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S2', 'Present'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S3', 'Present'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S4', 'Present'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S5', 'Present'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S6', 'Absent'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S7', 'Future'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S8', 'Future'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S9', 'Future'),
('HE00038_SE_K2_SU24_SWE301_SU24', 'SE_K2_SU24_SWE301_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S1', 'Present'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S2', 'Present'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S3', 'Present'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S4', 'Present'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S5', 'Present'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S6', 'Present'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S7', 'Future'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S8', 'Future'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S9', 'Future'),
('HE00038_SE_K2_SU24_PRJ302_SU24', 'SE_K2_SU24_PRJ302_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S3', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00039_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S1', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S2', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S3', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S8', 'Absent'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00039_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S1', 'Present'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S2', 'Present'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S3', 'Present'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S4', 'Present'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S5', 'Present'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S6', 'Present'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S7', 'Future'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S8', 'Future'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S9', 'Future'),
('HE00039_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S1', 'Present'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S2', 'Present'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S3', 'Present'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S4', 'Present'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S5', 'Present'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S6', 'Absent'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S7', 'Future'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S8', 'Future'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S9', 'Future'),
('HE00039_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S10', 'Future');


--part 14
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S3', 'Absent'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S8', 'Absent'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00040_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S1', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S2', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S3', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00040_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S1', 'Present'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S2', 'Present'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S3', 'Present'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S4', 'Present'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S5', 'Present'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S6', 'Present'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S7', 'Future'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S8', 'Future'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S9', 'Future'),
('HE00040_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S1', 'Present'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S2', 'Absent'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S3', 'Present'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S4', 'Present'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S5', 'Present'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S6', 'Present'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S7', 'Future'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S8', 'Future'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S9', 'Future'),
('HE00040_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S3', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00041_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S1', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S2', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S3', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00041_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S1', 'Present'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S2', 'Present'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S3', 'Present'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S4', 'Present'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S5', 'Present'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S6', 'Absent'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S7', 'Future'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S8', 'Future'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S9', 'Future'),
('HE00041_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S1', 'Present'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S2', 'Present'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S3', 'Present'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S4', 'Present'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S5', 'Present'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S6', 'Present'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S7', 'Future'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S8', 'Future'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S9', 'Future'),
('HE00041_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S1', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S2', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S3', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S4', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S5', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S6', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S7', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S8', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S9', 'Present'),
('HE00042_CS_K1_FA23_CSD201_SP24', 'CS_K1_FA23_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S1', 'Absent'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S2', 'Absent'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S3', 'Absent'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S4', 'Present'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S5', 'Present'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S6', 'Present'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S7', 'Present'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S8', 'Present'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S9', 'Present'),
('HE00042_CS_K1_FA23_DBI202_SP24', 'CS_K1_FA23_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S1', 'Present'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S2', 'Present'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S3', 'Present'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S4', 'Present'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S5', 'Present'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S6', 'Present'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S7', 'Future'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S8', 'Future'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S9', 'Future'),
('HE00042_CS_K1_FA23_TOC201_SU24', 'CS_K1_FA23_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S1', 'Present'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S2', 'Present'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S3', 'Present'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S4', 'Present'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S5', 'Present'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S6', 'Present'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S7', 'Future'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S8', 'Future'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S9', 'Future'),
('HE00042_CS_K1_FA23_OSG202_SU24', 'CS_K1_FA23_OSG202_SU24_S10', 'Future');


--part 15
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00043_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S1', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S2', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S3', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S4', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S5', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S6', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S7', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S8', 'Present'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S9', 'Absent'),
('HE00043_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00043_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Present'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00043_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00044_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S1', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S2', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S3', 'Absent'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S4', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S5', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S6', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S7', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S8', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S9', 'Present'),
('HE00044_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Absent'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00044_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Present'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00044_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S1', 'Absent'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S2', 'Absent'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S3', 'Absent'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00045_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S1', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S2', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S3', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S4', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S5', 'Absent'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S6', 'Absent'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S7', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S8', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S9', 'Present'),
('HE00045_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00045_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Present'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00045_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');


--part 16
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S1', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S2', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S3', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S4', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S5', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S6', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S7', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S8', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S9', 'Present'),
('HE00046_CS_K2_SP24_CSD201_SP24', 'CS_K2_SP24_CSD201_SP24_S10', 'Present');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S1', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S2', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S3', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S4', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S5', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S6', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S7', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S8', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S9', 'Present'),
('HE00046_CS_K2_SP24_DBI202_SP24', 'CS_K2_SP24_DBI202_SP24_S10', 'Absent');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00046_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Present'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00046_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00047_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Absent'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Present'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00047_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00048_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Absent'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00048_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');


--part 17
INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Present'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00049_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Absent'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00049_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S1', 'Present'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S2', 'Present'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S3', 'Present'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S4', 'Present'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S5', 'Present'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S6', 'Absent'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S7', 'Future'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S8', 'Future'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S9', 'Future'),
('HE00050_CS_K2_SP24_TOC201_SU24', 'CS_K2_SP24_TOC201_SU24_S10', 'Future');

INSERT INTO Attendance (enrollment_id, schedule_id, status) VALUES
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S1', 'Present'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S2', 'Present'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S3', 'Present'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S4', 'Present'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S5', 'Present'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S6', 'Present'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S7', 'Future'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S8', 'Future'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S9', 'Future'),
('HE00050_CS_K2_SP24_OSG202_SU24', 'CS_K2_SP24_OSG202_SU24_S10', 'Future');


INSERT INTO Permissions (permission_id, permission_name) VALUES
('P001', N'View all majors'),
('P002', N'View courses in curriculums'),
('P003', N'View course details'),
('P004', N'View course grade structure'),
('P005', N'View own personal information'),
('P006', N'View own major information'),
('P007', N'View own enrolled class courses'),
('P008', N'View classmates in enrolled class courses'),
('P009', N'View own class course schedules'),
('P010', N'View own attendance status'),
('P011', N'View own grade details'),
('P012', N'View own enrollment average and status'),
('P013', N'View own lecturers basic information'),
('P014', N'View own lecturer department information'),
('P015', N'View assigned class courses (Lecturer)'),
('P016', N'View assigned class course schedules (Lecturer)'),
('P017', N'View student attendance in assigned classes'),
('P018', N'View student grade details in assigned classes'),
('P019', N'View student enrollment status in assigned classes'),
('P020', N'View students in assigned class courses'),
('P021', N'View student basic info in assigned classes'),
('P022', N'View all department information'),
('P023', N'View other lecturers basic information'),
('P024', N'View all system data except other peoples password(Training Manager)');

-- Permissions for Student (R001)
INSERT INTO RolePermission (role_id, permission_id) VALUES
('R001', 'P001'), -- View all majors [cite: 13]
('R001', 'P002'), -- View courses in curriculums [cite: 14]
('R001', 'P003'), -- View course details [cite: 15]
('R001', 'P004'), -- View course grade structure [cite: 16]
('R001', 'P005'), -- View own personal information [cite: 17]
('R001', 'P006'), -- View own major information [cite: 18]
('R001', 'P007'), -- View own enrolled class courses [cite: 19]
('R001', 'P008'), -- View classmates in enrolled class courses [cite: 20]
('R001', 'P009'), -- View own class course schedules [cite: 21]
('R001', 'P010'), -- View own attendance status [cite: 22]
('R001', 'P011'), -- View own grade details [cite: 23]
('R001', 'P012'), -- View own enrollment average and status [cite: 24]
('R001', 'P013'); -- View own lecturers basic information [cite: 25]

-- Permissions for Lecturer (R002)
INSERT INTO RolePermission (role_id, permission_id) VALUES
('R002', 'P001'), -- View all majors [cite: 13]
('R002', 'P002'), -- View courses in curriculums [cite: 14]
('R002', 'P003'), -- View course details [cite: 15]
('R002', 'P004'), -- View course grade structure [cite: 16]
('R002', 'P005'), -- View own personal information [cite: 26]
('R002', 'P014'), -- View own lecturer department information [cite: 27]
('R002', 'P015'), -- View assigned class courses (Lecturer) [cite: 28]
('R002', 'P016'), -- View assigned class course schedules (Lecturer) [cite: 29]
('R002', 'P017'), -- View student attendance in assigned classes [cite: 30]
('R002', 'P018'), -- View student grade details in assigned classes [cite: 31]
('R002', 'P019'), -- View student enrollment status in assigned classes [cite: 32]
('R002', 'P020'), -- View students in assigned class courses [cite: 33]
('R002', 'P021'), -- View student basic info in assigned classes [cite: 34]
('R002', 'P022'), -- View all department information [cite: 35]
('R002', 'P023'); -- View other lecturers basic information [cite: 36]

-- Permissions for Training Manager (R003)
INSERT INTO RolePermission (role_id, permission_id) VALUES
('R003', 'P024'); -- View all system data (Training Manager) [cite: 37]