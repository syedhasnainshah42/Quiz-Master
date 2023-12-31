USE [master]
GO
/****** Object:  Database [nMDCATPrepTest]    Script Date: 09-Nov-23 11:54:11 AM ******/
CREATE DATABASE [nMDCATPrepTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'nMDCATPrepTest', FILENAME = N'D:\SQL Server Installed\MSSQL14.SQLEXPRESS\MSSQL\DATA\nMDCATPrepTest.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'nMDCATPrepTest_log', FILENAME = N'D:\SQL Server Installed\MSSQL14.SQLEXPRESS\MSSQL\DATA\nMDCATPrepTest_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [nMDCATPrepTest] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [nMDCATPrepTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [nMDCATPrepTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [nMDCATPrepTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [nMDCATPrepTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [nMDCATPrepTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [nMDCATPrepTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET RECOVERY FULL 
GO
ALTER DATABASE [nMDCATPrepTest] SET  MULTI_USER 
GO
ALTER DATABASE [nMDCATPrepTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [nMDCATPrepTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [nMDCATPrepTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [nMDCATPrepTest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [nMDCATPrepTest] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [nMDCATPrepTest] SET QUERY_STORE = OFF
GO
USE [nMDCATPrepTest]
GO
/****** Object:  Table [dbo].[classDomain]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classDomain](
	[classid] [bigint] IDENTITY(1,1) NOT NULL,
	[classTitle] [varchar](50) NULL,
 CONSTRAINT [PK_classDomain] PRIMARY KEY CLUSTERED 
(
	[classid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[departmentRanking]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departmentRanking](
	[departmentRankingId] [bigint] IDENTITY(1,1) NOT NULL,
	[departmentName] [nvarchar](max) NULL,
 CONSTRAINT [PK_departmentRanking] PRIMARY KEY CLUSTERED 
(
	[departmentRankingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[employeeId] [bigint] IDENTITY(1,1) NOT NULL,
	[employeeName] [varchar](max) NULL,
	[employeeFName] [varchar](max) NULL,
	[DOB] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[Contact] [nvarchar](50) NULL,
	[userId] [bigint] NULL,
	[subjectId] [bigint] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[employeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privilege]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privilege](
	[privilegeId] [int] NOT NULL,
	[privilegeTitle] [nvarchar](100) NULL,
	[createdBy] [bigint] NOT NULL,
	[dateCreate] [datetime] NULL,
	[modifiedBy] [bigint] NOT NULL,
	[dateModified] [datetime] NULL,
 CONSTRAINT [PK_tblPrivilege] PRIMARY KEY CLUSTERED 
(
	[privilegeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[questionTypeDomain]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questionTypeDomain](
	[qType] [int] IDENTITY(1,1) NOT NULL,
	[typeTitle] [nvarchar](max) NULL,
 CONSTRAINT [PK_questionTypeDomain_1] PRIMARY KEY CLUSTERED 
(
	[qType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleId] [int] IDENTITY(1,1) NOT NULL,
	[mainRoleId] [int] NOT NULL,
	[roleTitle] [nvarchar](100) NULL,
	[createdBy] [bigint] NOT NULL,
	[dateCreate] [datetime] NULL,
	[modifiedBy] [bigint] NOT NULL,
	[dateModified] [datetime] NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[studentId] [bigint] IDENTITY(1,1) NOT NULL,
	[studentName] [nvarchar](max) NULL,
	[studentFName] [nvarchar](max) NULL,
	[gender] [tinyint] NULL,
	[DOB] [date] NULL,
	[email] [nvarchar](50) NULL,
	[contact] [nvarchar](50) NULL,
	[userName] [nvarchar](50) NULL,
	[password] [nvarchar](max) NULL,
	[studentPicture] [varchar](250) NULL,
	[universityName] [nvarchar](max) NULL,
	[departmentName] [nvarchar](max) NULL,
 CONSTRAINT [PK_student] PRIMARY KEY CLUSTERED 
(
	[studentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[studentAppearTest]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studentAppearTest](
	[studentAppearId] [bigint] IDENTITY(1,1) NOT NULL,
	[testId] [bigint] NULL,
	[studentId] [bigint] NULL,
	[questionId] [bigint] NULL,
	[correctChoice] [varchar](1) NULL,
 CONSTRAINT [PK_studentAppearTest] PRIMARY KEY CLUSTERED 
(
	[studentAppearId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[studentRegisterForTest]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studentRegisterForTest](
	[srTestId] [bigint] IDENTITY(1,1) NOT NULL,
	[studentId] [bigint] NULL,
	[testId] [bigint] NULL,
	[userName] [nvarchar](max) NULL,
	[password] [nvarchar](max) NULL,
	[testStatus] [bit] NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_studentRegisterForTest] PRIMARY KEY CLUSTERED 
(
	[srTestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject](
	[subjectid] [bigint] IDENTITY(1,1) NOT NULL,
	[subjectTitle] [varchar](max) NULL,
	[class] [varchar](50) NULL,
 CONSTRAINT [PK_subject] PRIMARY KEY CLUSTERED 
(
	[subjectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAppLlicense]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAppLlicense](
	[licenseId] [bigint] IDENTITY(1,1) NOT NULL,
	[dateTimeInitiated] [datetime] NULL,
	[uptoDate] [datetime] NULL,
	[timeStampPrevious] [time](7) NULL,
	[dateStampPrevious] [date] NULL,
	[timeSpan] [int] NULL,
	[machineKey] [nvarchar](max) NULL,
	[numberOfRecords] [int] NULL,
	[transectionsCount] [int] NULL,
	[numberOfStudent] [int] NULL,
	[dateTimeLicenseExpire] [datetime] NULL,
	[isActive] [bit] NULL,
	[licenseKey] [nvarchar](max) NULL,
	[gracePeriod] [int] NULL,
	[gracePeriodStart] [datetime] NULL,
	[gracePeriofEnd] [datetime] NULL,
 CONSTRAINT [PK_AppLlicense] PRIMARY KEY CLUSTERED 
(
	[licenseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[test]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[testId] [bigint] IDENTITY(1,1) NOT NULL,
	[testTitle] [varchar](max) NULL,
	[startTime] [nvarchar](50) NULL,
	[endTime] [nvarchar](50) NULL,
	[graceTime] [int] NULL,
	[testConductionDate] [datetime] NULL,
 CONSTRAINT [PK_test] PRIMARY KEY CLUSTERED 
(
	[testId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[testQuestion]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[testQuestion](
	[testQuestionId] [bigint] IDENTITY(1,1) NOT NULL,
	[questionId] [bigint] NULL,
	[testId] [bigint] NULL,
	[marks] [int] NULL,
 CONSTRAINT [PK_testQuestion_1] PRIMARY KEY CLUSTERED 
(
	[testQuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[testQuestionDatabank]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[testQuestionDatabank](
	[questionId] [bigint] IDENTITY(1,1) NOT NULL,
	[questionTitle] [varchar](max) NULL,
	[choiceA] [varchar](max) NULL,
	[choiceB] [varchar](max) NULL,
	[choiceC] [varchar](max) NULL,
	[choiceD] [varchar](max) NULL,
	[subjectId] [bigint] NULL,
	[questionClassId] [bigint] NULL,
	[correctChoice] [nvarchar](1) NULL,
	[description] [nvarchar](max) NULL,
	[chapter] [int] NULL,
	[qType] [int] NULL,
	[correctChoiceForAll] [nvarchar](max) NULL,
 CONSTRAINT [PK_testQuestion] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[universityRanking]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[universityRanking](
	[universityRankingId] [bigint] IDENTITY(1,1) NOT NULL,
	[universityName] [nvarchar](50) NULL,
 CONSTRAINT [PK_universityRanking] PRIMARY KEY CLUSTERED 
(
	[universityRankingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[userId] [bigint] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](max) NULL,
	[userPassword] [nvarchar](20) NULL,
	[ucontrol] [nvarchar](20) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userPower]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userPower](
	[userPowerId] [bigint] IDENTITY(1,1) NOT NULL,
	[userId] [bigint] NULL,
	[isPowerful] [bit] NULL,
 CONSTRAINT [PK_userPower] PRIMARY KEY CLUSTERED 
(
	[userPowerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRolePrivilege]    Script Date: 09-Nov-23 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRolePrivilege](
	[upvId] [bigint] IDENTITY(1,1) NOT NULL,
	[roleId] [int] NOT NULL,
	[privilegeId] [int] NOT NULL,
	[userId] [bigint] NOT NULL,
	[createdBy] [bigint] NOT NULL,
	[dateCreate] [datetime] NULL,
	[modifiedBy] [bigint] NOT NULL,
	[dateModified] [datetime] NULL,
 CONSTRAINT [PK_UserRolePrivilege] PRIMARY KEY CLUSTERED 
(
	[upvId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[classDomain] ON 

INSERT [dbo].[classDomain] ([classid], [classTitle]) VALUES (1, N'1st Sem')
INSERT [dbo].[classDomain] ([classid], [classTitle]) VALUES (2, N'2nd Sem')
INSERT [dbo].[classDomain] ([classid], [classTitle]) VALUES (3, N'3rd Sem')
SET IDENTITY_INSERT [dbo].[classDomain] OFF
GO
SET IDENTITY_INSERT [dbo].[departmentRanking] ON 

INSERT [dbo].[departmentRanking] ([departmentRankingId], [departmentName]) VALUES (1, N'Computer Science')
INSERT [dbo].[departmentRanking] ([departmentRankingId], [departmentName]) VALUES (2, N'Information Technology')
SET IDENTITY_INSERT [dbo].[departmentRanking] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([employeeId], [employeeName], [employeeFName], [DOB], [Email], [Contact], [userId], [subjectId]) VALUES (10014, N'Nizam khan', N'Khan', CAST(N'2023-01-08T00:00:00.000' AS DateTime), N'nizamkjhsf@gmail.com', N'0312456788', NULL, NULL)
INSERT [dbo].[Employee] ([employeeId], [employeeName], [employeeFName], [DOB], [Email], [Contact], [userId], [subjectId]) VALUES (10015, N'hasnain', N'shah', CAST(N'2000-03-31T00:00:00.000' AS DateTime), N'hasnain123@gmail.com', N'03409848086', NULL, NULL)
INSERT [dbo].[Employee] ([employeeId], [employeeName], [employeeFName], [DOB], [Email], [Contact], [userId], [subjectId]) VALUES (10016, N'Nizam khan', N'shah', CAST(N'2023-01-01T00:00:00.000' AS DateTime), N'nizam123@gmail.com', N'0312456788', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
INSERT [dbo].[Privilege] ([privilegeId], [privilegeTitle], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (1, N'R', 1, CAST(N'2018-02-02T00:00:00.000' AS DateTime), 1, CAST(N'2018-02-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Privilege] ([privilegeId], [privilegeTitle], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (2, N'W', 1, CAST(N'2018-02-02T00:00:00.000' AS DateTime), 1, CAST(N'2018-02-02T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[questionTypeDomain] ON 

INSERT [dbo].[questionTypeDomain] ([qType], [typeTitle]) VALUES (1, N'MCQS')
SET IDENTITY_INSERT [dbo].[questionTypeDomain] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([roleId], [mainRoleId], [roleTitle], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (1, 1, N'User', 1, CAST(N'2018-01-26T00:00:00.000' AS DateTime), 1, CAST(N'2018-01-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Role] ([roleId], [mainRoleId], [roleTitle], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (4, 2, N'Student', 1, CAST(N'2018-01-26T00:00:00.000' AS DateTime), 1, CAST(N'2018-01-26T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[student] ON 

INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (30049, N'Syed Hasnain Shah', N'Syed Ahmad Shah', 1, CAST(N'2023-07-08' AS Date), N'syedhasnainshah42@gmail.com', N'03409848086', N'wuOHuOoY', N'&$TK$', N'09102023124834_11430249_1627076270912565_6747601643361070817_n.jpg', N'University of swat', N'Computer Science')
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (30050, N'Nizam', N'khan', 1, CAST(N'2023-07-30' AS Date), N'nizam12345@gmail.com', N'03069881188', N'ZXIegUVJ', N'kgMqt', N'10082023161609_11430249_1627076270912565_6747601643361070817_n.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40046, N'abbas', N'riaz', 1, CAST(N'2000-01-03' AS Date), N'abbasriaz12@gmail.com', N'0312456789', N'vxTORbCg', N'kZDeV', N'03102023152712_abc.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40047, N'Syed Hasnain Shah', N'Syed Ahmad Shah', 1, CAST(N'2000-08-02' AS Date), N'abbasriaz12@gmail.com', N'0312456788', N'PUNFaDUZ', N'WdTIl', N'04102023121952_abc 2.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40048, N'Azan ', N'khan', 1, CAST(N'2000-01-03' AS Date), N'azankhan123@gmail.com', N'03365274253', N'EQqLafqg', N'FX8Pl', N'05102023133831_FB_IMG_1501351014732.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40056, N'Mazhar', N'Shah', 1, CAST(N'2000-08-02' AS Date), N'syed704422mazhar@gmail.com', N'03447044220', N'hDaXIcov', N'vFlgL', N'09102023135539_d40d4b6c-2cd6-4a46-a7a7-4d0849b69a16.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40057, N'abbas', N'riaz', 1, CAST(N'2023-10-01' AS Date), N'abbasriaz12@gmail.com', N'0312456777', N'atUGGeAP', N'l#cJJ', N'09102023135539_d40d4b6c-2cd6-4a46-a7a7-4d0849b69a16.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40058, N'Bilal Ghani', N'sheer ghani', 1, CAST(N'2000-06-21' AS Date), N'bilalghani45@gmail.com', N'0345678987', N'LkHiUvOx', N'QzKwd', N'12102023142716_11430249_1627076270912565_6747601643361070817_n.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40059, N'Bilal Ghani', N'sheer ghani', 1, CAST(N'2000-06-13' AS Date), N'bilalghani45@gmail.com', N'03069881187', N'TbVuGpKM', N'amd#J', N'12102023142917_11430249_1627076270912565_6747601643361070817_n.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40060, N'Bilal Ghani', N'sheer ghani', 1, CAST(N'2000-06-13' AS Date), N'bilalghani45@gmail.com', N'03069881187', N'drNuuJYN', N'p9T$$', N'12102023143047_11430249_1627076270912565_6747601643361070817_n.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40061, N'Hazrat bilal', N'khan', 1, CAST(N'2000-06-13' AS Date), N'syedhasnainshah42@gmail.com', N'0312456788', N'FVXVwuMs', N'Hege&', N'14102023125434_11430249_1627076270912565_6747601643361070817_n.jpg', NULL, NULL)
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40062, N'NAIN', N'KHAN', 1, CAST(N'2000-01-05' AS Date), N'knain9292@gmail.com', N'03072056915', N'RCNSQErO', N'YDTZX', N'25102023115806_20180223_154925.jpg', N'1', N'1')
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (40063, N'nizam ullah', N'khan', 1, CAST(N'2000-01-03' AS Date), N'syedhasnainshah42@gmail.com', N'0312456788', N'ZeSgMSLh', N'jrZtR', NULL, NULL, N'1')
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (50062, N'Talha', N'khan', 1, CAST(N'2001-02-06' AS Date), N'syedhasnainshah42@gmail.com', N'03465971812', N'MRCHGrRJ', N'RYDKI', N'02112023120101_1200px-Night_over_the_Village.jpg', NULL, N'2')
INSERT [dbo].[student] ([studentId], [studentName], [studentFName], [gender], [DOB], [email], [contact], [userName], [password], [studentPicture], [universityName], [departmentName]) VALUES (50063, N'Nizam', N'khan', 1, CAST(N'2000-02-01' AS Date), N'nizam12345@gmail.com', N'03069881188', N'khgIIlNK', N'zvtML', N'02112023122042_my pic.jpg', NULL, N'2')
SET IDENTITY_INSERT [dbo].[student] OFF
GO
SET IDENTITY_INSERT [dbo].[studentAppearTest] ON 

INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40142, 10026, 40057, 20047, N'D')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40151, 10030, 40062, 20047, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40152, 10030, 40062, 20049, N'B')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40153, 10030, 40062, 20050, N'B')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40154, 10031, 40062, 20047, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40155, 10031, 40062, 20049, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40156, 10031, 40062, 20050, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40157, 10031, 40063, 20047, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40158, 10031, 40063, 20049, N'C')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (40159, 10031, 40063, 20050, N'C')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (50151, 20029, 50063, 20047, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (50152, 20029, 50063, 20049, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (50153, 20029, 50063, 20050, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (50154, 20029, 50063, NULL, N'A')
INSERT [dbo].[studentAppearTest] ([studentAppearId], [testId], [studentId], [questionId], [correctChoice]) VALUES (50155, 20029, 50063, 30047, N'A')
SET IDENTITY_INSERT [dbo].[studentAppearTest] OFF
GO
SET IDENTITY_INSERT [dbo].[studentRegisterForTest] ON 

INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20031, 40057, 10026, N'atUGGeAP', N'l#cJJ', 1, NULL)
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20032, 40058, 10027, N'LkHiUvOx', N'QzKwd', 1, NULL)
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20033, 40059, 10027, N'TbVuGpKM', N'amd#J', 1, NULL)
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20034, 40060, 10027, N'drNuuJYN', N'p9T$$', 1, NULL)
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20035, 40061, 10028, N'FVXVwuMs', N'Hege&', 1, NULL)
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20036, 40062, 10031, N'RCNSQErO', N'YDTZX', 1, N'Submitted')
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (20037, 40063, 10031, N'ZeSgMSLh', N'jrZtR', 1, N'Submitted')
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (30037, 50062, 20029, N'MRCHGrRJ', N'RYDKI', 1, N'Submitted')
INSERT [dbo].[studentRegisterForTest] ([srTestId], [studentId], [testId], [userName], [password], [testStatus], [status]) VALUES (30038, 50063, 20029, N'khgIIlNK', N'zvtML', 1, N'Submitted')
SET IDENTITY_INSERT [dbo].[studentRegisterForTest] OFF
GO
SET IDENTITY_INSERT [dbo].[subject] ON 

INSERT [dbo].[subject] ([subjectid], [subjectTitle], [class]) VALUES (30011, N'Operating System', NULL)
INSERT [dbo].[subject] ([subjectid], [subjectTitle], [class]) VALUES (40009, N'Physics', NULL)
INSERT [dbo].[subject] ([subjectid], [subjectTitle], [class]) VALUES (40010, N'web', NULL)
INSERT [dbo].[subject] ([subjectid], [subjectTitle], [class]) VALUES (40011, N'HCI', N'3')
SET IDENTITY_INSERT [dbo].[subject] OFF
GO
SET IDENTITY_INSERT [dbo].[tblAppLlicense] ON 

INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (1, CAST(N'2022-12-13T00:00:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), NULL, CAST(N'2022-12-17' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (2, CAST(N'2022-12-13T00:00:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), NULL, CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (3, CAST(N'2022-12-13T00:00:00.000' AS DateTime), CAST(N'2022-12-13T00:00:00.000' AS DateTime), NULL, CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2022-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (4, CAST(N'2022-12-13T00:00:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), CAST(N'15:28:00' AS Time), CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (5, CAST(N'2022-12-19T00:00:00.000' AS DateTime), CAST(N'2023-12-19T00:00:00.000' AS DateTime), CAST(N'14:42:00' AS Time), CAST(N'2022-12-19' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-19T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (6, CAST(N'2022-12-19T00:00:00.000' AS DateTime), CAST(N'2023-12-19T00:00:00.000' AS DateTime), CAST(N'14:45:00' AS Time), CAST(N'2022-12-19' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-19T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (7, CAST(N'2022-12-13T00:00:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), CAST(N'15:30:00' AS Time), CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (8, CAST(N'2022-12-16T00:00:00.000' AS DateTime), CAST(N'2023-12-16T00:00:00.000' AS DateTime), CAST(N'16:04:00' AS Time), CAST(N'2022-12-16' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-16T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (9, CAST(N'2022-12-16T00:00:00.000' AS DateTime), CAST(N'2023-12-16T00:00:00.000' AS DateTime), CAST(N'16:04:00' AS Time), CAST(N'2022-12-16' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-16T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (10, CAST(N'2022-12-28T15:30:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), CAST(N'15:30:00' AS Time), CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (11, CAST(N'2023-01-02T15:30:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), CAST(N'15:30:00' AS Time), CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (12, CAST(N'2023-01-02T16:04:00.000' AS DateTime), CAST(N'2023-12-16T00:00:00.000' AS DateTime), CAST(N'16:04:00' AS Time), CAST(N'2022-12-16' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-16T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (13, CAST(N'2023-01-02T15:28:00.000' AS DateTime), CAST(N'2023-12-13T00:00:00.000' AS DateTime), CAST(N'15:28:00' AS Time), CAST(N'2022-12-13' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 0, NULL, 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (14, CAST(N'2023-01-03T14:23:00.000' AS DateTime), CAST(N'2024-01-03T00:00:00.000' AS DateTime), CAST(N'14:23:00' AS Time), CAST(N'2023-01-03' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-03T00:00:00.000' AS DateTime), 0, NULL, 50, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (15, CAST(N'2023-01-06T14:23:00.000' AS DateTime), CAST(N'2024-01-03T00:00:00.000' AS DateTime), CAST(N'14:23:00' AS Time), CAST(N'2023-01-03' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-03T00:00:00.000' AS DateTime), 0, N'MDMtSmFuLTIzIDEyOjAwOjAwIEFNIzE0OjIzIzAzLUphbi0yNCAxMjowMDowMCBBTSM0MCMwMy1KYW4tMjQgMTI6MDA6MDAgQU0j', 40, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (16, CAST(N'2023-01-06T15:01:00.000' AS DateTime), CAST(N'2024-01-06T00:00:00.000' AS DateTime), CAST(N'15:01:00' AS Time), CAST(N'2023-01-06' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-06T00:00:00.000' AS DateTime), 0, N'MDYtSmFuLTIzIDEyOjAwOjAwIEFNIzE1OjAxIzA2LUphbi0yNCAxMjowMDowMCBBTSMzMCMwNi1KYW4tMjQgMTI6MDA6MDAgQU0j', 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (17, CAST(N'2023-01-06T15:04:00.000' AS DateTime), CAST(N'2024-01-06T00:00:00.000' AS DateTime), CAST(N'15:04:00' AS Time), CAST(N'2023-01-06' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-06T00:00:00.000' AS DateTime), 0, N'MDYtSmFuLTIzIDEyOjAwOjAwIEFNIzE1OjA0IzA2LUphbi0yNCAxMjowMDowMCBBTSMzMCMwNi1KYW4tMjQgMTI6MDA6MDAgQU0j', 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (18, CAST(N'2023-01-06T15:04:00.000' AS DateTime), CAST(N'2024-01-06T00:00:00.000' AS DateTime), CAST(N'15:04:00' AS Time), CAST(N'2023-01-06' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-06T00:00:00.000' AS DateTime), 0, N'MDYtSmFuLTIzIDEyOjAwOjAwIEFNIzE1OjA0IzA2LUphbi0yNCAxMjowMDowMCBBTSMzMCMwNi1KYW4tMjQgMTI6MDA6MDAgQU0j', 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (19, CAST(N'2023-01-06T15:04:00.000' AS DateTime), CAST(N'2024-01-06T00:00:00.000' AS DateTime), CAST(N'15:04:00' AS Time), CAST(N'2023-01-06' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-06T00:00:00.000' AS DateTime), 0, N'MDYtSmFuLTIzIDEyOjAwOjAwIEFNIzE1OjA0IzA2LUphbi0yNCAxMjowMDowMCBBTSMzMCMwNi1KYW4tMjQgMTI6MDA6MDAgQU0j', 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (20, CAST(N'2023-01-06T00:12:00.000' AS DateTime), CAST(N'2024-01-06T00:00:00.000' AS DateTime), CAST(N'00:12:00' AS Time), CAST(N'2023-01-06' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-06T00:00:00.000' AS DateTime), 0, N'MDYtSmFuLTIzIDEyOjAwOjAwIEFNIzAwOjEyIzA2LUphbi0yNCAxMjowMDowMCBBTSM0MCMwNi1KYW4tMjQgMTI6MDA6MDAgQU0j', 40, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (21, CAST(N'2023-01-07T14:23:00.000' AS DateTime), CAST(N'2024-01-03T00:00:00.000' AS DateTime), CAST(N'14:23:00' AS Time), CAST(N'2023-01-03' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-03T00:00:00.000' AS DateTime), 0, N'MDMtSmFuLTIzIDEyOjAwOjAwIEFNIzE0OjIzIzAzLUphbi0yNCAxMjowMDowMCBBTSM0MCMwMy1KYW4tMjQgMTI6MDA6MDAgQU0j', 40, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (22, CAST(N'2023-01-07T00:11:00.000' AS DateTime), CAST(N'2024-01-07T00:00:00.000' AS DateTime), CAST(N'00:11:00' AS Time), CAST(N'2023-01-07' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-07T00:00:00.000' AS DateTime), 0, N'MDctSmFuLTIzIDEyOjAwOjAwIEFNIzAwOjExIzA3LUphbi0yNCAxMjowMDowMCBBTSMzMCMwNy1KYW4tMjQgMTI6MDA6MDAgQU0j', 30, NULL, NULL)
INSERT [dbo].[tblAppLlicense] ([licenseId], [dateTimeInitiated], [uptoDate], [timeStampPrevious], [dateStampPrevious], [timeSpan], [machineKey], [numberOfRecords], [transectionsCount], [numberOfStudent], [dateTimeLicenseExpire], [isActive], [licenseKey], [gracePeriod], [gracePeriodStart], [gracePeriofEnd]) VALUES (23, CAST(N'2023-01-07T14:11:00.000' AS DateTime), CAST(N'2024-01-07T00:00:00.000' AS DateTime), CAST(N'14:11:00' AS Time), CAST(N'2023-01-07' AS Date), NULL, NULL, NULL, NULL, NULL, CAST(N'2024-01-07T00:00:00.000' AS DateTime), 1, N'MDctSmFuLTIzIDEyOjAwOjAwIEFNIzE0OjExIzA3LUphbi0yNCAxMjowMDowMCBBTSM1MCMwNy1KYW4tMjQgMTI6MDA6MDAgQU0j', 50, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblAppLlicense] OFF
GO
SET IDENTITY_INSERT [dbo].[test] ON 

INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (10026, N'10octtest', N'16:20', N'20:18', 250, CAST(N'2023-10-10T00:00:00.000' AS DateTime))
INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (10027, N'12oct test', N'14:26', N'19:26', 250, CAST(N'2023-10-12T00:00:00.000' AS DateTime))
INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (10028, N'todayy test', N'12:50', N'13:48', 59, CAST(N'2023-10-14T00:00:00.000' AS DateTime))
INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (10029, N'19oct test', N'14:43', N'18:41', 250, CAST(N'2023-10-19T00:00:00.000' AS DateTime))
INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (10030, N'today testt24oct', N'12:11', N'14:00', 250, CAST(N'2023-10-24T00:00:00.000' AS DateTime))
INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (10031, N'25 oct test', N'11:58', N'14:56', 250, CAST(N'2023-10-25T00:00:00.000' AS DateTime))
INSERT [dbo].[test] ([testId], [testTitle], [startTime], [endTime], [graceTime], [testConductionDate]) VALUES (20029, N'02novtest', N'12:01', N'20:58', 560, CAST(N'2023-11-02T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[test] OFF
GO
SET IDENTITY_INSERT [dbo].[testQuestion] ON 

INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50093, 20047, 10026, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50094, 20049, 10026, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50095, 20050, 10026, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50096, 30047, 10026, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50097, 20047, 10027, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50098, 20049, 10027, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50099, 20050, 10027, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50100, 30047, 10027, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50101, 20047, 10028, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50102, 20049, 10028, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50103, 20050, 10028, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50104, 30047, 10028, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50105, 20047, 10030, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50106, 20049, 10030, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50107, 20050, 10030, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50108, 30047, 10030, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50109, 20047, 10031, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50110, 20049, 10031, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50111, 20050, 10031, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (50112, 30047, 10031, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (60105, 20047, 20029, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (60106, 20049, 20029, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (60107, 20050, 20029, 2)
INSERT [dbo].[testQuestion] ([testQuestionId], [questionId], [testId], [marks]) VALUES (60108, 30047, 20029, 2)
SET IDENTITY_INSERT [dbo].[testQuestion] OFF
GO
SET IDENTITY_INSERT [dbo].[testQuestionDatabank] ON 

INSERT [dbo].[testQuestionDatabank] ([questionId], [questionTitle], [choiceA], [choiceB], [choiceC], [choiceD], [subjectId], [questionClassId], [correctChoice], [description], [chapter], [qType], [correctChoiceForAll]) VALUES (20047, N'What is an operating system?', N' interface between the hardware and application programs', N'collection of programs that manages hardware resources', N'system service provider to the application programs', N'all of the mentioned', 30011, 1, N'D', N'What do you know about OS?', 1, 1, N'all of the mentioned')
INSERT [dbo].[testQuestionDatabank] ([questionId], [questionTitle], [choiceA], [choiceB], [choiceC], [choiceD], [subjectId], [questionClassId], [correctChoice], [description], [chapter], [qType], [correctChoiceForAll]) VALUES (20049, N'What is the main function of the command interpreter?
', N' to provide the interface between the API and application program', N' to handle the files in the operating system', N'to get and execute the next user-specified command', N' none of the mentioned', 30011, 1, N'C', N'What do you know about the interpreter?', 1, 1, N'to get and execute the next user-specified comman')
INSERT [dbo].[testQuestionDatabank] ([questionId], [questionTitle], [choiceA], [choiceB], [choiceC], [choiceD], [subjectId], [questionClassId], [correctChoice], [description], [chapter], [qType], [correctChoiceForAll]) VALUES (20050, N'Which one of the following is not a real time operating system?', N'RTLinux', N'Palm OS', N'QNX', N'VxWorks', 30011, 1, N'B', N'        Palm OS is developed for Personal Digital Assistants (PDAs).', 1, 1, N'Palm OS')
INSERT [dbo].[testQuestionDatabank] ([questionId], [questionTitle], [choiceA], [choiceB], [choiceC], [choiceD], [subjectId], [questionClassId], [correctChoice], [description], [chapter], [qType], [correctChoiceForAll]) VALUES (30047, N'What is operating system?', N'wndow', N'linux', N'software', N'hardware', 30011, 1, N'A', N'descriptiomm', 1, 1, N'wndow')
SET IDENTITY_INSERT [dbo].[testQuestionDatabank] OFF
GO
SET IDENTITY_INSERT [dbo].[universityRanking] ON 

INSERT [dbo].[universityRanking] ([universityRankingId], [universityName]) VALUES (1, N'University of swat')
INSERT [dbo].[universityRanking] ([universityRankingId], [universityName]) VALUES (2, N'University of malakand')
SET IDENTITY_INSERT [dbo].[universityRanking] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (1, N'ali', N'ali123', N'full')
INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (7, N'nizamkhan', N'nizam123', N'partial')
INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (8, N'nizamkhan', N'nizam123', N'full')
INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (10007, N'nizamkhan', N'nizam123', N'partial')
INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (10008, N'shahhasnain', N'shah12345', N'full')
INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (10009, N'ali', N'5678', N'partial')
INSERT [dbo].[User] ([userId], [userName], [userPassword], [ucontrol]) VALUES (10010, N'nizamkhan', N'hyGpI', N'partial')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[userPower] ON 

INSERT [dbo].[userPower] ([userPowerId], [userId], [isPowerful]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[userPower] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRolePrivilege] ON 

INSERT [dbo].[UserRolePrivilege] ([upvId], [roleId], [privilegeId], [userId], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (37, 1, 1, 1, 1, CAST(N'2018-03-26T11:55:59.590' AS DateTime), 1, CAST(N'2018-03-26T11:55:59.590' AS DateTime))
INSERT [dbo].[UserRolePrivilege] ([upvId], [roleId], [privilegeId], [userId], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (40, 4, 1, 2, 1, CAST(N'2018-03-26T11:55:59.590' AS DateTime), 1, CAST(N'2018-03-26T11:55:59.590' AS DateTime))
INSERT [dbo].[UserRolePrivilege] ([upvId], [roleId], [privilegeId], [userId], [createdBy], [dateCreate], [modifiedBy], [dateModified]) VALUES (46, 1, 1, 2, 1, CAST(N'2018-03-26T11:55:59.590' AS DateTime), 1, CAST(N'2018-03-26T11:55:59.590' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserRolePrivilege] OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_subject] FOREIGN KEY([subjectId])
REFERENCES [dbo].[subject] ([subjectid])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_subject]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_User]
GO
ALTER TABLE [dbo].[Privilege]  WITH CHECK ADD  CONSTRAINT [FK__tblPrivil__creat__5A054B78] FOREIGN KEY([createdBy])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Privilege] CHECK CONSTRAINT [FK__tblPrivil__creat__5A054B78]
GO
ALTER TABLE [dbo].[Privilege]  WITH CHECK ADD  CONSTRAINT [FK__tblPrivil__modif__5AF96FB1] FOREIGN KEY([modifiedBy])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Privilege] CHECK CONSTRAINT [FK__tblPrivil__modif__5AF96FB1]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK__tblRole__created__5DD5DC5C] FOREIGN KEY([createdBy])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK__tblRole__created__5DD5DC5C]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK__tblRole__modifie__5ECA0095] FOREIGN KEY([modifiedBy])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK__tblRole__modifie__5ECA0095]
GO
ALTER TABLE [dbo].[studentAppearTest]  WITH CHECK ADD  CONSTRAINT [FK_studentAppearTest_student] FOREIGN KEY([studentId])
REFERENCES [dbo].[student] ([studentId])
GO
ALTER TABLE [dbo].[studentAppearTest] CHECK CONSTRAINT [FK_studentAppearTest_student]
GO
ALTER TABLE [dbo].[studentAppearTest]  WITH CHECK ADD  CONSTRAINT [FK_studentAppearTest_test] FOREIGN KEY([testId])
REFERENCES [dbo].[test] ([testId])
GO
ALTER TABLE [dbo].[studentAppearTest] CHECK CONSTRAINT [FK_studentAppearTest_test]
GO
ALTER TABLE [dbo].[studentAppearTest]  WITH CHECK ADD  CONSTRAINT [FK_studentAppearTest_testQuestionDatabank] FOREIGN KEY([questionId])
REFERENCES [dbo].[testQuestionDatabank] ([questionId])
GO
ALTER TABLE [dbo].[studentAppearTest] CHECK CONSTRAINT [FK_studentAppearTest_testQuestionDatabank]
GO
ALTER TABLE [dbo].[studentRegisterForTest]  WITH CHECK ADD  CONSTRAINT [FK_studentRegisterForTest_student] FOREIGN KEY([studentId])
REFERENCES [dbo].[student] ([studentId])
GO
ALTER TABLE [dbo].[studentRegisterForTest] CHECK CONSTRAINT [FK_studentRegisterForTest_student]
GO
ALTER TABLE [dbo].[studentRegisterForTest]  WITH CHECK ADD  CONSTRAINT [FK_studentRegisterForTest_test] FOREIGN KEY([testId])
REFERENCES [dbo].[test] ([testId])
GO
ALTER TABLE [dbo].[studentRegisterForTest] CHECK CONSTRAINT [FK_studentRegisterForTest_test]
GO
ALTER TABLE [dbo].[testQuestion]  WITH CHECK ADD  CONSTRAINT [FK_testQuestion_test] FOREIGN KEY([testId])
REFERENCES [dbo].[test] ([testId])
GO
ALTER TABLE [dbo].[testQuestion] CHECK CONSTRAINT [FK_testQuestion_test]
GO
ALTER TABLE [dbo].[testQuestion]  WITH CHECK ADD  CONSTRAINT [FK_testQuestion_testQuestionDatabank] FOREIGN KEY([questionId])
REFERENCES [dbo].[testQuestionDatabank] ([questionId])
GO
ALTER TABLE [dbo].[testQuestion] CHECK CONSTRAINT [FK_testQuestion_testQuestionDatabank]
GO
ALTER TABLE [dbo].[testQuestionDatabank]  WITH CHECK ADD  CONSTRAINT [FK_testQuestionDatabank_classDomain] FOREIGN KEY([questionClassId])
REFERENCES [dbo].[classDomain] ([classid])
GO
ALTER TABLE [dbo].[testQuestionDatabank] CHECK CONSTRAINT [FK_testQuestionDatabank_classDomain]
GO
ALTER TABLE [dbo].[testQuestionDatabank]  WITH CHECK ADD  CONSTRAINT [FK_testQuestionDatabank_classDomain1] FOREIGN KEY([questionClassId])
REFERENCES [dbo].[classDomain] ([classid])
GO
ALTER TABLE [dbo].[testQuestionDatabank] CHECK CONSTRAINT [FK_testQuestionDatabank_classDomain1]
GO
ALTER TABLE [dbo].[testQuestionDatabank]  WITH CHECK ADD  CONSTRAINT [FK_testQuestionDatabank_questionTypeDomain] FOREIGN KEY([qType])
REFERENCES [dbo].[questionTypeDomain] ([qType])
GO
ALTER TABLE [dbo].[testQuestionDatabank] CHECK CONSTRAINT [FK_testQuestionDatabank_questionTypeDomain]
GO
ALTER TABLE [dbo].[testQuestionDatabank]  WITH CHECK ADD  CONSTRAINT [FK_testQuestionDatabank_subject] FOREIGN KEY([subjectId])
REFERENCES [dbo].[subject] ([subjectid])
GO
ALTER TABLE [dbo].[testQuestionDatabank] CHECK CONSTRAINT [FK_testQuestionDatabank_subject]
GO
ALTER TABLE [dbo].[userPower]  WITH CHECK ADD  CONSTRAINT [FK_userPower_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[userPower] CHECK CONSTRAINT [FK_userPower_User]
GO
ALTER TABLE [dbo].[UserRolePrivilege]  WITH CHECK ADD  CONSTRAINT [FK__tblRolePr__creat__5FBE24CE] FOREIGN KEY([createdBy])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[UserRolePrivilege] CHECK CONSTRAINT [FK__tblRolePr__creat__5FBE24CE]
GO
ALTER TABLE [dbo].[UserRolePrivilege]  WITH CHECK ADD  CONSTRAINT [FK__tblRolePr__modif__60B24907] FOREIGN KEY([modifiedBy])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[UserRolePrivilege] CHECK CONSTRAINT [FK__tblRolePr__modif__60B24907]
GO
ALTER TABLE [dbo].[UserRolePrivilege]  WITH CHECK ADD  CONSTRAINT [FK_tblRolePrivilege_tblPrivilege] FOREIGN KEY([privilegeId])
REFERENCES [dbo].[Privilege] ([privilegeId])
GO
ALTER TABLE [dbo].[UserRolePrivilege] CHECK CONSTRAINT [FK_tblRolePrivilege_tblPrivilege]
GO
ALTER TABLE [dbo].[UserRolePrivilege]  WITH CHECK ADD  CONSTRAINT [FK_tblRolePrivilege_tblRole] FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([roleId])
GO
ALTER TABLE [dbo].[UserRolePrivilege] CHECK CONSTRAINT [FK_tblRolePrivilege_tblRole]
GO
USE [master]
GO
ALTER DATABASE [nMDCATPrepTest] SET  READ_WRITE 
GO
