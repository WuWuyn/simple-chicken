USE [master]
GO
/****** Object:  Database [text_to_sql]    Script Date: 3/9/2025 2:56:56 AM ******/
CREATE DATABASE [text_to_sql]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'text_to_sql', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\text_to_sql.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'text_to_sql_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\text_to_sql_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [text_to_sql] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [text_to_sql].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [text_to_sql] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [text_to_sql] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [text_to_sql] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [text_to_sql] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [text_to_sql] SET ARITHABORT OFF 
GO
ALTER DATABASE [text_to_sql] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [text_to_sql] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [text_to_sql] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [text_to_sql] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [text_to_sql] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [text_to_sql] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [text_to_sql] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [text_to_sql] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [text_to_sql] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [text_to_sql] SET  ENABLE_BROKER 
GO
ALTER DATABASE [text_to_sql] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [text_to_sql] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [text_to_sql] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [text_to_sql] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [text_to_sql] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [text_to_sql] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [text_to_sql] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [text_to_sql] SET RECOVERY FULL 
GO
ALTER DATABASE [text_to_sql] SET  MULTI_USER 
GO
ALTER DATABASE [text_to_sql] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [text_to_sql] SET DB_CHAINING OFF 
GO
ALTER DATABASE [text_to_sql] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [text_to_sql] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [text_to_sql] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [text_to_sql] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'text_to_sql', N'ON'
GO
ALTER DATABASE [text_to_sql] SET QUERY_STORE = OFF
GO
USE [text_to_sql]
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
	[grade_value] [float] NOT NULL,
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
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_AIL', N'AI01_AIL_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_AIL', N'AI01_AIL_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_AIL', N'AI01_AIL_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_AIL', N'AI01_AIL_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_AIL', N'AI01_AIL_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_MAE', N'AI01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_MAE', N'AI01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_MAE', N'AI01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_MAE', N'AI01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_MAE', N'AI01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_NLP', N'AI01_NLP_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_NLP', N'AI01_NLP_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_NLP', N'AI01_NLP_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_NLP', N'AI01_NLP_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE001_AI01_NLP', N'AI01_NLP_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_AIL', N'AI01_AIL_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_AIL', N'AI01_AIL_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_AIL', N'AI01_AIL_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_AIL', N'AI01_AIL_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_AIL', N'AI01_AIL_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_MAE', N'AI01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_MAE', N'AI01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_MAE', N'AI01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_MAE', N'AI01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_MAE', N'AI01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_NLP', N'AI01_NLP_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_NLP', N'AI01_NLP_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_NLP', N'AI01_NLP_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_NLP', N'AI01_NLP_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE002_AI01_NLP', N'AI01_NLP_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_AIL', N'AI01_AIL_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_AIL', N'AI01_AIL_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_AIL', N'AI01_AIL_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_AIL', N'AI01_AIL_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_AIL', N'AI01_AIL_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_MAE', N'AI01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_MAE', N'AI01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_MAE', N'AI01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_MAE', N'AI01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_MAE', N'AI01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_NLP', N'AI01_NLP_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_NLP', N'AI01_NLP_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_NLP', N'AI01_NLP_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_NLP', N'AI01_NLP_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE003_AI01_NLP', N'AI01_NLP_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_AIL', N'AI01_AIL_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_AIL', N'AI01_AIL_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_AIL', N'AI01_AIL_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_AIL', N'AI01_AIL_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_AIL', N'AI01_AIL_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_MAE', N'AI01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_MAE', N'AI01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_MAE', N'AI01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_MAE', N'AI01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_MAE', N'AI01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_NLP', N'AI01_NLP_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_NLP', N'AI01_NLP_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_NLP', N'AI01_NLP_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_NLP', N'AI01_NLP_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE004_AI01_NLP', N'AI01_NLP_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_AIL', N'AI01_AIL_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_AIL', N'AI01_AIL_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_AIL', N'AI01_AIL_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_AIL', N'AI01_AIL_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_AIL', N'AI01_AIL_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_MAE', N'AI01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_MAE', N'AI01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_MAE', N'AI01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_MAE', N'AI01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_MAE', N'AI01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_NLP', N'AI01_NLP_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_NLP', N'AI01_NLP_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_NLP', N'AI01_NLP_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_NLP', N'AI01_NLP_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE005_AI01_NLP', N'AI01_NLP_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_IAM', N'IA01_IAM_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_IAM', N'IA01_IAM_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_IAM', N'IA01_IAM_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_IAM', N'IA01_IAM_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_IAM', N'IA01_IAM_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_MAE', N'IA01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_MAE', N'IA01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_MAE', N'IA01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_MAE', N'IA01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE011_IA01_MAE', N'IA01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_IAM', N'IA01_IAM_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_IAM', N'IA01_IAM_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_IAM', N'IA01_IAM_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_IAM', N'IA01_IAM_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_IAM', N'IA01_IAM_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_MAE', N'IA01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_MAE', N'IA01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_MAE', N'IA01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_MAE', N'IA01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE012_IA01_MAE', N'IA01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_IAM', N'IA01_IAM_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_IAM', N'IA01_IAM_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_IAM', N'IA01_IAM_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_IAM', N'IA01_IAM_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_IAM', N'IA01_IAM_5', N'Future')
GO
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_MAE', N'IA01_MAE_1', N'Absent')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_MAE', N'IA01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_MAE', N'IA01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_MAE', N'IA01_MAE_4', N'Absent')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE013_IA01_MAE', N'IA01_MAE_5', N'Absent')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_IAM', N'IA01_IAM_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_IAM', N'IA01_IAM_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_IAM', N'IA01_IAM_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_IAM', N'IA01_IAM_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_IAM', N'IA01_IAM_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_MAE', N'IA01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_MAE', N'IA01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_MAE', N'IA01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_MAE', N'IA01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE014_IA01_MAE', N'IA01_MAE_5', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_IAM', N'IA01_IAM_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_IAM', N'IA01_IAM_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_IAM', N'IA01_IAM_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_IAM', N'IA01_IAM_4', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_IAM', N'IA01_IAM_5', N'Future')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_MAE', N'IA01_MAE_1', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_MAE', N'IA01_MAE_2', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_MAE', N'IA01_MAE_3', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_MAE', N'IA01_MAE_4', N'Present')
INSERT [dbo].[Attendance] ([enrollment_id], [schedule_id], [status]) VALUES (N'HE015_IA01_MAE', N'IA01_MAE_5', N'Present')
GO
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_AIL', N'AI01', N'AIL', N'LEC01', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_MAE', N'AI01', N'MAE', N'LEC04', N'FA24')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'AI01_NLP', N'AI01', N'NLP', N'LEC05', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IA01_IAM', N'IA01', N'IAM', N'LEC05', N'SP25')
INSERT [dbo].[ClassCourse] ([class_course_id], [class_id], [course_id], [lecturer_id], [semester]) VALUES (N'IA01_MAE', N'IA01', N'MAE', N'LEC01', N'FA24')
GO
INSERT [dbo].[Classes] ([class_id]) VALUES (N'AI01')
INSERT [dbo].[Classes] ([class_id]) VALUES (N'IA01')
INSERT [dbo].[Classes] ([class_id]) VALUES (N'IS01')
INSERT [dbo].[Classes] ([class_id]) VALUES (N'SE01')
GO
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'AIL_Assignment', N'AIL', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'AIL_Final_Exam', N'AIL', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'AIL_Lab_1', N'AIL', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'AIL_Lab_2', N'AIL', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'AIL_Practical_Exam', N'AIL', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CEA_Assignment', N'CEA', N'Assignment', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CEA_Final_Exam', N'CEA', N'Final Exam', 0.4)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CEA_Progress_Test', N'CEA', N'Progress Test', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CPV_Assignment', N'CPV', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CPV_Final_Exam', N'CPV', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CPV_Lab_1', N'CPV', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CPV_Lab_2', N'CPV', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CPV_Practical_Exam', N'CPV', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CSI_Assignment', N'CSI', N'Assignment', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CSI_Final_Exam', N'CSI', N'Final Exam', 0.4)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'CSI_Progress_Test', N'CSI', N'Progress Test', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAA_Assignment', N'IAA', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAA_Final_Exam', N'IAA', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAA_Lab_1', N'IAA', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAA_Lab_2', N'IAA', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAA_Practical_Exam', N'IAA', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAM_Assignment', N'IAM', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAM_Final_Exam', N'IAM', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAM_Lab_1', N'IAM', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAM_Lab_2', N'IAM', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAM_Practical_Exam', N'IAM', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAP_Assignment', N'IAP', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAP_Final_Exam', N'IAP', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAP_Lab_1', N'IAP', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAP_Lab_2', N'IAP', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'IAP_Practical_Exam', N'IAP', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISM_Assignment', N'ISM', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISM_Final_Exam', N'ISM', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISM_Lab_1', N'ISM', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISM_Lab_2', N'ISM', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISM_Practical_Exam', N'ISM', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISP_Assignment', N'ISP', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISP_Final_Exam', N'ISP', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISP_Lab_1', N'ISP', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISP_Lab_2', N'ISP', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ISP_Practical_Exam', N'ISP', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ITA_Assignment', N'ITA', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ITA_Final_Exam', N'ITA', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ITA_Lab_1', N'ITA', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ITA_Lab_2', N'ITA', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'ITA_Practical_Exam', N'ITA', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'MAE_Assignment', N'MAE', N'Assignment', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'MAE_Final_Exam', N'MAE', N'Final Exam', 0.4)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'MAE_Progress_Test', N'MAE', N'Progress Test', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NLP_Assignment', N'NLP', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NLP_Final_Exam', N'NLP', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NLP_Lab_1', N'NLP', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NLP_Lab_2', N'NLP', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'NLP_Practical_Exam', N'NLP', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWD_Assignment', N'SWD', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWD_Final_Exam', N'SWD', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWD_Lab_1', N'SWD', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWD_Lab_2', N'SWD', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWD_Practical_Exam', N'SWD', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWP_Assignment', N'SWP', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWP_Final_Exam', N'SWP', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWP_Lab_1', N'SWP', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWP_Lab_2', N'SWP', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWP_Practical_Exam', N'SWP', N'Practical Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWR_Assignment', N'SWR', N'Assignment', 0.2)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWR_Final_Exam', N'SWR', N'Final Exam', 0.3)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWR_Lab_1', N'SWR', N'Lab 1', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWR_Lab_2', N'SWR', N'Lab 2', 0.1)
INSERT [dbo].[CourseGrade] ([course_grade_id], [course_id], [grade_name], [grade_weight]) VALUES (N'SWR_Practical_Exam', N'SWR', N'Practical Exam', 0.3)
GO
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'AIL', N'Machine Learning', 3, N'An introduction to machine learning algorithms and their applications in solving problems through data-driven insights and predictions.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'CEA', N'Computer Organization and Architecture', 3, N'Focuses on the internal structure of computers, including how hardware components interact and function together to execute software.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'CPV', N'Computer Vision', 3, N'Covers the field of computer vision, focusing on techniques to enable computers to interpret and understand visual information from the world.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'CSI', N'Introduction to Computer Science', 3, N'An introductory course to the fundamental principles of computer science, including algorithms, data structures, and programming languages.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'IAA', N'Risk Management in Information Systems', 3, N'Teaches how to identify, assess, and mitigate risks in information systems to ensure the security and integrity of data.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'IAM', N'Malware Analysis and Reverse Engineering', 3, N'Provides students with the skills to analyze malicious software and understand its behavior through reverse engineering techniques.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'IAP', N'Policy Development in Information Assurance', 3, N'Focuses on creating policies and strategies to ensure the confidentiality, integrity, and availability of information in organizations.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'ISM', N'Enterprise Resource Planning (ERP)', 3, N'Provides knowledge of ERP systems and their role in managing core business processes such as finance, supply chain, and human resources.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'ISP', N'Information System Programming Project', 3, N'A project-based course that involves programming and developing an information system, helping students apply theoretical knowledge to real-world applications.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'ITA', N'Information System Design & Analysis', 3, N'Covers methods for designing and analyzing information systems to meet business needs, ensuring system efficiency and effectiveness.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'MAE', N'Mathematics for Engineering', 3, N'This course will provide students with a solid foundation in essential mathematical concepts, including single-variable calculus, linear algebra, and vector spaces.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'NLP', N'Natural Language Processing', 3, N'Explores the techniques and algorithms used to process and analyze human language, enabling applications like text analysis, chatbots, and translation systems.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'SWD', N'Software Architecture and Design', 3, N'Focuses on designing robust and scalable software architectures, including the use of design patterns and best practices for system structuring.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'SWP', N'Software development project', 3, N'Provides students with hands-on experience in the entire software development lifecycle through the execution of a real-world project.')
INSERT [dbo].[Courses] ([course_id], [course_name], [no_credit], [description]) VALUES (N'SWR', N'Software Requirement', 3, N'Teaches the process of gathering, analyzing, and defining software requirements to ensure the development of effective software systems.')
GO
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'AIL')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'CEA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'CPV')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'CSI')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'MAE')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'AI', N'NLP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'CEA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'CSI')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'IAA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'IAM')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'IAP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IA', N'MAE')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'CEA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'CSI')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'ISM')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'ISP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'ITA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'IS', N'MAE')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'CEA')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'CSI')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'MAE')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'SWD')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'SWP')
INSERT [dbo].[Curriculums] ([major_id], [course_id]) VALUES (N'SE', N'SWR')
GO
INSERT [dbo].[Departments] ([dep_id], [dep_name]) VALUES (N'D01', N'Computing Fundamental')
INSERT [dbo].[Departments] ([dep_id], [dep_name]) VALUES (N'D02', N'Artificial Intelligence')
INSERT [dbo].[Departments] ([dep_id], [dep_name]) VALUES (N'D03', N'Information Assurance')
INSERT [dbo].[Departments] ([dep_id], [dep_name]) VALUES (N'D04', N'Software Engineering')
GO
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE001_AI01_AIL', N'HE001', N'AI01_AIL', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE001_AI01_MAE', N'HE001', N'AI01_MAE', 9.5, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE001_AI01_NLP', N'HE001', N'AI01_NLP', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE002_AI01_AIL', N'HE002', N'AI01_AIL', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE002_AI01_MAE', N'HE002', N'AI01_MAE', 3.96, N'Failed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE002_AI01_NLP', N'HE002', N'AI01_NLP', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE003_AI01_AIL', N'HE003', N'AI01_AIL', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE003_AI01_MAE', N'HE003', N'AI01_MAE', 8.18, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE003_AI01_NLP', N'HE003', N'AI01_NLP', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE004_AI01_AIL', N'HE004', N'AI01_AIL', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE004_AI01_MAE', N'HE004', N'AI01_MAE', 8.14, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE004_AI01_NLP', N'HE004', N'AI01_NLP', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE005_AI01_AIL', N'HE005', N'AI01_AIL', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE005_AI01_MAE', N'HE005', N'AI01_MAE', 9.16, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE005_AI01_NLP', N'HE005', N'AI01_NLP', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE011_IA01_IAM', N'HE011', N'IA01_IAM', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE011_IA01_MAE', N'HE011', N'IA01_MAE', 9.7, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE012_IA01_IAM', N'HE012', N'IA01_IAM', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE012_IA01_MAE', N'HE012', N'IA01_MAE', 6.87, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE013_IA01_IAM', N'HE013', N'IA01_IAM', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE013_IA01_MAE', N'HE013', N'IA01_MAE', 7, N'Attendance Failure')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE014_IA01_IAM', N'HE014', N'IA01_IAM', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE014_IA01_MAE', N'HE014', N'IA01_MAE', 6.33, N'Passed')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE015_IA01_IAM', N'HE015', N'IA01_IAM', 0, N'Studying')
INSERT [dbo].[Enrollments] ([enrollment_id], [student_id], [class_course_id], [average], [status]) VALUES (N'HE015_IA01_MAE', N'HE015', N'IA01_MAE', 8, N'Passed')
GO
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC01', N'D02')
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC02', N'D04')
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC03', N'D01')
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC04', N'D04')
INSERT [dbo].[Lecturers] ([lecturer_id], [dep_id]) VALUES (N'LEC05', N'D03')
GO
INSERT [dbo].[Majors] ([major_id], [major_name]) VALUES (N'AI', N'Artificial Intelligence')
INSERT [dbo].[Majors] ([major_id], [major_name]) VALUES (N'IA', N'Information Assurance')
INSERT [dbo].[Majors] ([major_id], [major_name]) VALUES (N'IS', N'Information System')
INSERT [dbo].[Majors] ([major_id], [major_name]) VALUES (N'SE', N'Software Engineering')
GO
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (N'R001', N'Training Manager')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (N'R002', N'Lecturer')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (N'R003', N'Student')
GO
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_AIL_1', N'AI01_AIL', CAST(N'2025-01-06T07:30:00.000' AS DateTime), CAST(N'2025-01-06T09:50:00.000' AS DateTime), N'R001', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_AIL_2', N'AI01_AIL', CAST(N'2025-01-08T10:00:00.000' AS DateTime), CAST(N'2025-01-08T12:20:00.000' AS DateTime), N'R001', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_AIL_3', N'AI01_AIL', CAST(N'2025-01-13T07:30:00.000' AS DateTime), CAST(N'2025-01-13T09:50:00.000' AS DateTime), N'R001', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_AIL_4', N'AI01_AIL', CAST(N'2025-01-15T10:00:00.000' AS DateTime), CAST(N'2025-01-15T12:20:00.000' AS DateTime), N'R001', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_AIL_5', N'AI01_AIL', CAST(N'2025-01-20T07:30:00.000' AS DateTime), CAST(N'2025-01-20T09:50:00.000' AS DateTime), N'R001', 5)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_MAE_1', N'AI01_MAE', CAST(N'2024-09-09T07:30:00.000' AS DateTime), CAST(N'2024-09-09T09:50:00.000' AS DateTime), N'R002', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_MAE_2', N'AI01_MAE', CAST(N'2024-09-11T10:00:00.000' AS DateTime), CAST(N'2024-09-11T12:20:00.000' AS DateTime), N'R002', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_MAE_3', N'AI01_MAE', CAST(N'2024-09-16T07:30:00.000' AS DateTime), CAST(N'2024-09-16T09:50:00.000' AS DateTime), N'R002', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_MAE_4', N'AI01_MAE', CAST(N'2024-09-18T10:00:00.000' AS DateTime), CAST(N'2024-09-18T12:20:00.000' AS DateTime), N'R002', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_MAE_5', N'AI01_MAE', CAST(N'2024-09-23T07:30:00.000' AS DateTime), CAST(N'2024-09-23T09:50:00.000' AS DateTime), N'R002', 5)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_NLP_1', N'AI01_NLP', CAST(N'2025-01-06T10:00:00.000' AS DateTime), CAST(N'2025-01-06T12:20:00.000' AS DateTime), N'R003', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_NLP_2', N'AI01_NLP', CAST(N'2025-01-08T07:30:00.000' AS DateTime), CAST(N'2025-01-08T09:50:00.000' AS DateTime), N'R003', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_NLP_3', N'AI01_NLP', CAST(N'2025-01-13T10:00:00.000' AS DateTime), CAST(N'2025-01-13T12:20:00.000' AS DateTime), N'R003', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_NLP_4', N'AI01_NLP', CAST(N'2025-01-15T07:30:00.000' AS DateTime), CAST(N'2025-01-15T09:50:00.000' AS DateTime), N'R003', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'AI01_NLP_5', N'AI01_NLP', CAST(N'2025-01-20T10:00:00.000' AS DateTime), CAST(N'2025-01-20T12:20:00.000' AS DateTime), N'R003', 5)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_IAM_1', N'IA01_IAM', CAST(N'2025-01-06T12:50:00.000' AS DateTime), CAST(N'2025-01-06T15:10:00.000' AS DateTime), N'R004', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_IAM_2', N'IA01_IAM', CAST(N'2025-01-08T15:20:00.000' AS DateTime), CAST(N'2025-01-08T17:40:00.000' AS DateTime), N'R004', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_IAM_3', N'IA01_IAM', CAST(N'2025-01-13T12:50:00.000' AS DateTime), CAST(N'2025-01-13T15:10:00.000' AS DateTime), N'R004', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_IAM_4', N'IA01_IAM', CAST(N'2025-01-15T15:20:00.000' AS DateTime), CAST(N'2025-01-15T17:40:00.000' AS DateTime), N'R004', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_IAM_5', N'IA01_IAM', CAST(N'2025-01-20T12:50:00.000' AS DateTime), CAST(N'2025-01-20T15:10:00.000' AS DateTime), N'R004', 5)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_MAE_1', N'IA01_MAE', CAST(N'2024-09-09T07:30:00.000' AS DateTime), CAST(N'2024-09-09T09:50:00.000' AS DateTime), N'R003', 1)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_MAE_2', N'IA01_MAE', CAST(N'2024-09-11T10:00:00.000' AS DateTime), CAST(N'2024-09-11T12:20:00.000' AS DateTime), N'R003', 2)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_MAE_3', N'IA01_MAE', CAST(N'2024-09-16T07:30:00.000' AS DateTime), CAST(N'2024-09-16T09:50:00.000' AS DateTime), N'R003', 3)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_MAE_4', N'IA01_MAE', CAST(N'2024-09-18T10:00:00.000' AS DateTime), CAST(N'2024-09-18T12:20:00.000' AS DateTime), N'R003', 4)
INSERT [dbo].[Schedules] ([schedule_id], [class_course_id], [start_time], [end_time], [room], [slot]) VALUES (N'IA01_MAE_5', N'IA01_MAE', CAST(N'2024-09-23T07:30:00.000' AS DateTime), CAST(N'2024-09-23T09:50:00.000' AS DateTime), N'R003', 5)
GO
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_AIL', N'AIL_Lab_1', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_AIL', N'AIL_Lab_2', 8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_MAE', N'MAE_Assignment', 9.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_MAE', N'MAE_Final_Exam', 9.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_MAE', N'MAE_Progress_Test', 9.4, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_NLP', N'NLP_Assignment', 10, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_NLP', N'NLP_Lab_1', 8.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE001_AI01_NLP', N'NLP_Lab_2', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_AIL', N'AIL_Lab_1', 6.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_AIL', N'AIL_Lab_2', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_MAE', N'MAE_Assignment', 5.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_MAE', N'MAE_Final_Exam', 3, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_MAE', N'MAE_Progress_Test', 4, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_NLP', N'NLP_Lab_1', 8.3, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE002_AI01_NLP', N'NLP_Lab_2', 6.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_AIL', N'AIL_Lab_1', 4, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_AIL', N'AIL_Lab_2', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_MAE', N'MAE_Assignment', 7.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_MAE', N'MAE_Final_Exam', 8.3, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_MAE', N'MAE_Progress_Test', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_NLP', N'NLP_Lab_1', 9.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE003_AI01_NLP', N'NLP_Lab_2', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_AIL', N'AIL_Lab_1', 6.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_AIL', N'AIL_Lab_2', 7.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_MAE', N'MAE_Assignment', 8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_MAE', N'MAE_Final_Exam', 7.6, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_MAE', N'MAE_Progress_Test', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_NLP', N'NLP_Lab_1', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE004_AI01_NLP', N'NLP_Lab_2', 6, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_AIL', N'AIL_Lab_1', 8.6, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_AIL', N'AIL_Lab_2', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_MAE', N'MAE_Assignment', 8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_MAE', N'MAE_Final_Exam', 10, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_MAE', N'MAE_Progress_Test', 9.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_NLP', N'NLP_Lab_1', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE005_AI01_NLP', N'NLP_Lab_2', 8.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_IAM', N'IAM_Assignment', 9, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_IAM', N'IAM_Lab_1', 10, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_IAM', N'IAM_Lab_2', 10, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_IAM', N'IAM_Practical_Exam', 9.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_MAE', N'MAE_Assignment', 9.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_MAE', N'MAE_Final_Exam', 10, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE011_IA01_MAE', N'MAE_Progress_Test', 9.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_IAM', N'IAM_Assignment', 8.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_IAM', N'IAM_Lab_1', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_IAM', N'IAM_Lab_2', 6.4, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_IAM', N'IAM_Practical_Exam', 7.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_MAE', N'MAE_Assignment', 6, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_MAE', N'MAE_Final_Exam', 7.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE012_IA01_MAE', N'MAE_Progress_Test', 6.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_IAM', N'IAM_Assignment', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_IAM', N'IAM_Lab_1', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_IAM', N'IAM_Lab_2', 7.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_IAM', N'IAM_Practical_Exam', 8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_MAE', N'MAE_Assignment', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_MAE', N'MAE_Final_Exam', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE013_IA01_MAE', N'MAE_Progress_Test', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_IAM', N'IAM_Assignment', 4, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_IAM', N'IAM_Lab_1', 5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_IAM', N'IAM_Lab_2', 4.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_IAM', N'IAM_Practical_Exam', 6, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_MAE', N'MAE_Assignment', 4.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_MAE', N'MAE_Final_Exam', 7.2, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE014_IA01_MAE', N'MAE_Progress_Test', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_IAM', N'IAM_Assignment', 8.8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_IAM', N'IAM_Lab_1', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_IAM', N'IAM_Lab_2', 6.5, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_IAM', N'IAM_Practical_Exam', 7, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_MAE', N'MAE_Assignment', 8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_MAE', N'MAE_Final_Exam', 8, N'Grade Recorded')
INSERT [dbo].[StudentGradeDetails] ([enrollment_id], [course_grade_id], [grade_value], [comment]) VALUES (N'HE015_IA01_MAE', N'MAE_Progress_Test', 8, N'Grade Recorded')
GO
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE001', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE002', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE003', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE004', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE005', N'AI', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE006', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE007', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE008', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE009', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE010', N'IS', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE011', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE012', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE013', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE014', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE015', N'IA', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE016', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE017', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE018', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE019', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
INSERT [dbo].[Students] ([student_id], [major_id], [start_date], [start_semester]) VALUES (N'HE020', N'SE', CAST(N'2024-09-01' AS Date), N'FA24')
GO
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE001', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE002', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE003', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE004', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE005', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE006', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE007', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE008', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE009', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE010', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE011', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE012', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE013', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE014', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE015', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE016', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE017', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE018', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE019', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'HE020', N'R003')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC01', N'R002')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC02', N'R002')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC03', N'R002')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC04', N'R002')
INSERT [dbo].[UserRole] ([user_id], [role_id]) VALUES (N'LEC05', N'R002')
GO
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'giangdt', N'123', N'LEC01', N'Giang', N'male', CAST(N'1986-11-12' AS Date), N'Hà Nội')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'hailt', N'123', N'LEC04', N'Hai', N'male', CAST(N'1980-01-01' AS Date), N'Hà Nội')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'phuongvtm', N'123', N'LEC05', N'Phuong', N'female', CAST(N'1995-01-01' AS Date), N'Hà Nội')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'trangbtt', N'123', N'LEC03', N'Trang', N'female', CAST(N'1990-01-03' AS Date), N'Nghệ An')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'tuanvm', N'123', N'LEC02', N'Tuan', N'male', CAST(N'1990-05-07' AS Date), N'Hà Nội')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'usera', N'123', N'HE001', N'Student A', N'male', CAST(N'2005-11-03' AS Date), N'Bắc Ninh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userb', N'123', N'HE002', N'Student B', N'female', CAST(N'2003-05-01' AS Date), N'Hà Nội')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userc', N'123', N'HE003', N'Student C', N'male', CAST(N'2004-02-15' AS Date), N'Hải Phòng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userd', N'123', N'HE004', N'Student D', N'female', CAST(N'2002-07-23' AS Date), N'Hồ Chí Minh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'usere', N'123', N'HE005', N'Student E', N'male', CAST(N'2001-09-10' AS Date), N'Đà Nẵng')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userf', N'123', N'HE006', N'Student F', N'female', CAST(N'2000-12-30' AS Date), N'Huế')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userg', N'123', N'HE007', N'Student G', N'male', CAST(N'2003-06-05' AS Date), N'Nha Trang')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userh', N'123', N'HE008', N'Student H', N'female', CAST(N'1999-11-17' AS Date), N'Cần Thơ')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'useri', N'123', N'HE009', N'Student I', N'male', CAST(N'2005-04-25' AS Date), N'Vinh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userj', N'123', N'HE010', N'Student J', N'female', CAST(N'2004-08-19' AS Date), N'Bắc Giang')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userk', N'123', N'HE011', N'Student K', N'male', CAST(N'2002-03-07' AS Date), N'Hải Dương')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userl', N'123', N'HE012', N'Student L', N'female', CAST(N'2001-10-12' AS Date), N'Quảng Ninh')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userm', N'123', N'HE013', N'Student M', N'male', CAST(N'2003-05-09' AS Date), N'Thanh Hóa')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'usern', N'123', N'HE014', N'Student N', N'female', CAST(N'2000-09-21' AS Date), N'Nam Định')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'usero', N'123', N'HE015', N'Student O', N'male', CAST(N'1998-12-01' AS Date), N'Phú Thọ')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userp', N'123', N'HE016', N'Student P', N'female', CAST(N'1997-07-14' AS Date), N'Thái Bình')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userq', N'123', N'HE017', N'Student Q', N'male', CAST(N'2006-01-28' AS Date), N'Bình Định')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'userr', N'123', N'HE018', N'Student R', N'female', CAST(N'2005-03-16' AS Date), N'Gia Lai')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'users', N'123', N'HE019', N'Student S', N'male', CAST(N'2004-06-24' AS Date), N'Lào Cai')
INSERT [dbo].[Users] ([username], [password], [user_id], [fullname], [user_gender], [user_dob], [user_address]) VALUES (N'usert', N'123', N'HE020', N'Student T', N'female', CAST(N'2003-11-11' AS Date), N'Điện Biên')
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
ALTER DATABASE [text_to_sql] SET  READ_WRITE 
GO
