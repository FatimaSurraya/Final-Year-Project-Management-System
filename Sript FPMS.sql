USE [master]
GO
/****** Object:  Database [FYP_MS]    Script Date: 16/03/2024 06:11:13 AM ******/
CREATE DATABASE [FYP_MS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FYP_MS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\FYP_MS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FYP_MS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\FYP_MS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FYP_MS] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FYP_MS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FYP_MS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FYP_MS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FYP_MS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FYP_MS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FYP_MS] SET ARITHABORT OFF 
GO
ALTER DATABASE [FYP_MS] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [FYP_MS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FYP_MS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FYP_MS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FYP_MS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FYP_MS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FYP_MS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FYP_MS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FYP_MS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FYP_MS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FYP_MS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FYP_MS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FYP_MS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FYP_MS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FYP_MS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FYP_MS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FYP_MS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FYP_MS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FYP_MS] SET  MULTI_USER 
GO
ALTER DATABASE [FYP_MS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FYP_MS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FYP_MS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FYP_MS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FYP_MS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FYP_MS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [FYP_MS] SET QUERY_STORE = ON
GO
ALTER DATABASE [FYP_MS] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FYP_MS]
GO
USE [FYP_MS]
GO
/****** Object:  Sequence [dbo].[ChannelIdSequence]    Script Date: 16/03/2024 06:11:14 AM ******/
CREATE SEQUENCE [dbo].[ChannelIdSequence] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  Table [dbo].[Group]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[GroupName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[group_users]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[group_users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[role] [nvarchar](50) NOT NULL,
	[isApproved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invitations]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invitations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sender_id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Meetings]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meetings](
	[MeetingId] [int] IDENTITY(1,1) NOT NULL,
	[MeetingType] [nvarchar](50) NOT NULL,
	[ScheduledDate] [datetime] NOT NULL,
	[SupervisorID] [int] NOT NULL,
	[StudentID] [int] NULL,
	[channelId] [int] NULL,
 CONSTRAINT [PK_Meetings] PRIMARY KEY CLUSTERED 
(
	[MeetingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[SenderId] [int] NOT NULL,
	[ReceiverId] [int] NOT NULL,
	[MessageText] [nvarchar](1000) NOT NULL,
	[MessageDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectDetails]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectDetails](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Skills] [nvarchar](500) NULL,
	[Domain] [nvarchar](500) NULL,
	[Tools] [nvarchar](500) NULL,
	[StudentsAllowed] [nvarchar](50) NULL,
	[SupervisorID] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ProjectDetail] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectDocuments]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectDocuments](
	[DocumentId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[DocumentName] [nvarchar](500) NOT NULL,
	[DocumentPath] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_ProjectDocuments] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectList]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectList](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ProjectDescription] [nvarchar](max) NULL,
	[TotalMarks] [int] NULL,
	[StudentsAllowed] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Results]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Results](
	[ResultId] [int] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[SupervisorID] [int] NOT NULL,
	[Score] [int] NOT NULL,
 CONSTRAINT [PK_Results] PRIMARY KEY CLUSTERED 
(
	[ResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentProjectRequest]    Script Date: 16/03/2024 06:11:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentProjectRequest](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[UserId] [int] NULL,
	[RequestTime] [datetime] NULL,
	[IsApproved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 16/03/2024 06:11:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[AssignedTo] [int] NOT NULL,
	[TaskName] [nvarchar](500) NOT NULL,
	[TaskDescription] [nvarchar](500) NOT NULL,
	[DueDate] [datetime] NULL,
	[TaskStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timetables]    Script Date: 16/03/2024 06:11:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timetables](
	[TimetableId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Timetable] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_Timetables] PRIMARY KEY CLUSTERED 
(
	[TimetableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 16/03/2024 06:11:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Password] [nvarchar](500) NULL,
	[UserTypeId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CustomId] [nvarchar](100) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 16/03/2024 06:11:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[UserTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[UserTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Meetings] ON 

INSERT [dbo].[Meetings] ([MeetingId], [MeetingType], [ScheduledDate], [SupervisorID], [StudentID], [channelId]) VALUES (5, N'Online', CAST(N'2023-10-09T00:00:00.000' AS DateTime), 24, 20, NULL)
INSERT [dbo].[Meetings] ([MeetingId], [MeetingType], [ScheduledDate], [SupervisorID], [StudentID], [channelId]) VALUES (6, N'Online', CAST(N'2023-10-09T00:00:00.000' AS DateTime), 24, 20, NULL)
INSERT [dbo].[Meetings] ([MeetingId], [MeetingType], [ScheduledDate], [SupervisorID], [StudentID], [channelId]) VALUES (10, N'Physical', CAST(N'2024-01-27T00:00:00.000' AS DateTime), 24, 1026, NULL)
INSERT [dbo].[Meetings] ([MeetingId], [MeetingType], [ScheduledDate], [SupervisorID], [StudentID], [channelId]) VALUES (12, N'Physical', CAST(N'2024-02-24T00:00:00.000' AS DateTime), 24, 1026, 1)
INSERT [dbo].[Meetings] ([MeetingId], [MeetingType], [ScheduledDate], [SupervisorID], [StudentID], [channelId]) VALUES (13, N'Online', CAST(N'2024-03-14T00:00:00.000' AS DateTime), 24, 1026, 2)
SET IDENTITY_INSERT [dbo].[Meetings] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (18, 24, 20, N'Project Assigned.', CAST(N'2023-10-08T21:23:06.640' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (19, 24, 20, N'Your result for FYPMS has been uploaded, please check your result dashboard.', CAST(N'2023-10-08T21:24:07.237' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (20, 20, 24, N'student 1 requested for the FYPMS project.', CAST(N'2023-10-08T21:25:10.437' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (21, 20, 24, N'student 1 requested for the 123 project.', CAST(N'2023-10-08T21:51:16.343' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (34, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-19T21:54:47.993' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (35, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-19T21:54:48.473' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (36, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-19T21:56:24.023' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (37, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-19T21:56:24.533' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (38, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T01:23:11.847' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (39, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T01:23:12.910' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (40, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T01:58:20.203' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (41, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T01:58:21.173' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (42, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T02:26:41.020' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (43, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T02:26:42.537' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (44, 1026, 24, N'Hira Mughal requested for the fpms1 project.', CAST(N'2024-01-20T02:32:51.700' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (45, 1026, 24, N'Hira Mughal requested for the fpms1 project.', CAST(N'2024-01-20T02:32:52.697' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (46, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T02:54:58.190' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (47, 1026, 24, N'Hira Mughal requested for the FYPMS project.', CAST(N'2024-01-20T02:54:59.227' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (48, 1026, 24, N'Hira Mughal requested for the FYP management project.', CAST(N'2024-01-20T02:58:37.373' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (49, 1026, 24, N'Hira Mughal requested for the FYP management project.', CAST(N'2024-01-20T02:58:38.323' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (50, 1026, 24, N'Hira Mughal requested for the FYP management project.', CAST(N'2024-01-20T03:12:41.417' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (51, 1026, 24, N'Hira Mughal requested for the FYP management project.', CAST(N'2024-01-20T03:12:42.413' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (71, 24, 1026, N'Your result for Automobiles has been uploaded, please check your result dashboard.', CAST(N'2024-01-25T15:44:44.527' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (72, 24, 20, N'Your result for fpms1 has been uploaded, please check your result dashboard.', CAST(N'2024-01-25T21:54:21.023' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (73, 24, 20, N'Your result for fpms1 has been uploaded, please check your result dashboard.', CAST(N'2024-02-06T22:37:51.367' AS DateTime))
INSERT [dbo].[Messages] ([MessageId], [SenderId], [ReceiverId], [MessageText], [MessageDate]) VALUES (74, 24, 1026, N'Your result for FYPMS has been uploaded, please check your result dashboard.', CAST(N'2024-03-13T22:10:10.903' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[ProjectDetails] ON 

INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (7, N'FYPMS', N'.Net', N'Programming', N'Web Application', N'Visual Studio', N'7', 24, CAST(N'2023-10-08T21:22:08.317' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (8, N'FYPMS part 2', N'Web Development', N'2', N'Networking', N'new', N'20', 24, CAST(N'2023-10-08T21:49:17.340' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (9, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:37:54.167' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (10, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:37:57.130' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (11, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:37:58.157' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (12, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:38:23.920' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (13, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:38:24.987' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (14, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:41:09.240' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (15, N'FYP management', N'.Net', N'programming', N'Web Application', N'VS', N'10', 24, CAST(N'2024-01-08T16:43:08.330' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (16, N'Fyp', N'dotnet', N'programming', N'Web Application', N'VS', N'30', 24, CAST(N'2024-01-08T16:52:43.033' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (17, N'Automobiles', N'Development', N'Programming', N'Web Application', N'sql', N'9', 24, CAST(N'2024-01-17T18:36:37.753' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (1018, N'Sup2 ', N'New', N'Programming', N'Mobile Application', N'Java IDE', N'13', 1027, CAST(N'2024-01-25T15:53:36.013' AS DateTime))
INSERT [dbo].[ProjectDetails] ([ProjectId], [Title], [Description], [Skills], [Domain], [Tools], [StudentsAllowed], [SupervisorID], [CreatedDate]) VALUES (1027, N'New Project', N'Web Development', N'Programming', N'Web Application', N'VS Code', N'20', 24, CAST(N'2024-02-06T19:23:02.727' AS DateTime))
SET IDENTITY_INSERT [dbo].[ProjectDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[ProjectDocuments] ON 

INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (8, 16, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (9, 1018, N'2f984865-f943-49be-b716-e8a6e023bd5a_CS403DBMSasFavoriteSubject (1).pdf', N'C:\Users\engrs\OneDrive\Desktop\FYPM2\FYPM\Uploads\2f984865-f943-49be-b716-e8a6e023bd5a_CS403DBMSasFavoriteSubject (1).pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (12, 9, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (13, 10, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (14, 11, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (15, 12, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (16, 13, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (17, 14, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (18, 15, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (19, 17, N'Bio Data.pdf', N'D:\Users\dell\Source\Repos\FYPM\Uploads\Bio Data.pdf')
INSERT [dbo].[ProjectDocuments] ([DocumentId], [ProjectId], [DocumentName], [DocumentPath]) VALUES (24, 1027, N'589e70d4-e781-47ee-b282-e2fdca223f59_Proposal.docx', N'C:\Users\engrs\OneDrive\Desktop\FYPM2\FYPM\Uploads\589e70d4-e781-47ee-b282-e2fdca223f59_Proposal.docx')
SET IDENTITY_INSERT [dbo].[ProjectDocuments] OFF
GO
SET IDENTITY_INSERT [dbo].[Results] ON 

INSERT [dbo].[Results] ([ResultId], [TaskID], [StudentID], [SupervisorID], [Score]) VALUES (31, 20, 1026, 24, 40)
INSERT [dbo].[Results] ([ResultId], [TaskID], [StudentID], [SupervisorID], [Score]) VALUES (33, 28, 20, 24, 10)
INSERT [dbo].[Results] ([ResultId], [TaskID], [StudentID], [SupervisorID], [Score]) VALUES (34, 21, 1026, 24, 80)
SET IDENTITY_INSERT [dbo].[Results] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentProjectRequest] ON 

INSERT [dbo].[StudentProjectRequest] ([RequestId], [ProjectId], [UserId], [RequestTime], [IsApproved]) VALUES (5, 9, 1026, CAST(N'2024-01-22T23:13:53.713' AS DateTime), 1)
INSERT [dbo].[StudentProjectRequest] ([RequestId], [ProjectId], [UserId], [RequestTime], [IsApproved]) VALUES (6, 15, 20, CAST(N'2024-01-26T10:20:02.233' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[StudentProjectRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Tasks] ON 

INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (20, 17, 1026, N'Automobiles', N'Development', CAST(N'2024-01-20T00:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (21, 7, 1026, N'FYPMS', N'.Net', CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (22, 1018, 1026, N'Sup2 ', N'New', CAST(N'2024-01-15T00:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (23, 10, 1026, N'FYP management', N'.Net', CAST(N'2024-01-25T00:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (27, 7, 1026, N'FYPMS', N'.Net', CAST(N'2024-01-27T00:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (28, 8, 20, N'fpms1', N'124', CAST(N'2024-01-27T00:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (29, 1027, 1026, N'New Project', N'Web Development', CAST(N'2024-02-17T00:00:00.000' AS DateTime), N'In Progress')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (30, 15, 1026, N'FYP management', N'.Net', CAST(N'2024-02-16T00:00:00.000' AS DateTime), N'In Progress')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (31, 17, 1026, N'Automobiles', N'Development', CAST(N'2024-02-29T00:00:00.000' AS DateTime), N'In Progress')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (32, 9, 1026, N'FYP management', N'.Net', CAST(N'2024-03-10T00:00:00.000' AS DateTime), N'Not Started')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (33, 11, 20, N'FYP management', N'.Net', CAST(N'2024-03-10T00:00:00.000' AS DateTime), N'Not Started')
INSERT [dbo].[Tasks] ([TaskId], [ProjectId], [AssignedTo], [TaskName], [TaskDescription], [DueDate], [TaskStatus]) VALUES (34, 7, 1026, N'FYPMS', N'.Net', CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'Not Started')
SET IDENTITY_INSERT [dbo].[Tasks] OFF
GO
SET IDENTITY_INSERT [dbo].[Timetables] ON 

INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (4, 20, N'10/18/2023|Tuesday|07:55:00|OOPs|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (5, 24, N'10/10/2023|Monday|09:24:00|Event Scheduling|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (7, 1026, N'01/22/2024|Monday|23:31:00|REVIT|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (8, 1026, N'01/24/2024|Wednesday|01:32:00|AGORA|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (9, 24, N'01/18/2024|Thursday|04:02:00|Supervisor Timetable|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (10, 1026, N'01/19/2024|Friday|03:02:00|StudentTimeTable|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (11, 1027, N'01/27/2024|Saturday|05:14:00|Sup2|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (12, 24, N'01/28/2024|Sunday|17:35:00|Events|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (14, 24, N'03/01/2024|Friday|02:27:00|TimeTable|')
INSERT [dbo].[Timetables] ([TimetableId], [UserId], [Timetable]) VALUES (15, 1026, N'03/02/2024|Saturday|04:54:00|New TimeTable|')
SET IDENTITY_INSERT [dbo].[Timetables] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (20, N'student', N'1', N'student1@gmail.com', N'9Dec????', 3, CAST(N'2023-10-08T11:55:16.560' AS DateTime), N'SD10001')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (22, N'admin', N'1', N'admin1@gmail.com', N'9Dec????', 1, CAST(N'2023-10-08T19:56:04.970' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (23, N'Supervisor', N'2', N'supervisor2@gmail.com', N'9Dec????', 2, CAST(N'2023-10-08T19:57:49.183' AS DateTime), N'SV10001')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (24, N'Supervisor', N'one', N'supone@gmail.com', N'9Dec????', 2, CAST(N'2023-10-08T21:19:21.113' AS DateTime), N'SV10002')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (25, N'admin', N'one', N'adminone@gmail.com', N'9Dec????', 1, CAST(N'2023-10-08T21:20:22.190' AS DateTime), N'AD10001')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (26, N'new', N'user', N'new@gmail.com', N'9Dec????', 1, CAST(N'2024-01-17T18:30:51.057' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (27, N'new', N'user', N'new@gmail.com', N'9Dec????', 1, CAST(N'2024-01-17T18:30:51.523' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (1026, N'Hira', N'Mughal', N'hira@gmail.com', N'9Dec????', 3, CAST(N'2024-01-19T21:54:29.507' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (1027, N'Supervisor ', N'Two', N'sup2@gmail.com', N'9Dec????', 2, CAST(N'2024-01-25T00:13:18.153' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (1028, N'2', N'3', N'1@gmail.com', N'9Dec????', 1, CAST(N'2024-03-14T16:11:18.743' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (1029, N'123', N'456', N'234@gmail.com', N'9Dec????', 1, CAST(N'2024-03-14T17:02:33.823' AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [Email], [Password], [UserTypeId], [CreatedDate], [CustomId]) VALUES (1030, N'345', N'654', N'45@gmail.com', N'9Dec????', 1, CAST(N'2024-03-14T17:03:43.380' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON 

INSERT [dbo].[UserTypes] ([UserTypeId], [TypeName]) VALUES (1, N'Admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [TypeName]) VALUES (2, N'Supervisor')
INSERT [dbo].[UserTypes] ([UserTypeId], [TypeName]) VALUES (3, N'Student')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
GO
ALTER TABLE [dbo].[Invitations] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Meetings] ADD  DEFAULT (NEXT VALUE FOR [ChannelIdSequence]) FOR [channelId]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[ProjectDetails] ([ProjectId])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_ProjectId]
GO
ALTER TABLE [dbo].[group_users]  WITH CHECK ADD  CONSTRAINT [FK_group_users_group_id] FOREIGN KEY([group_id])
REFERENCES [dbo].[Group] ([GroupId])
GO
ALTER TABLE [dbo].[group_users] CHECK CONSTRAINT [FK_group_users_group_id]
GO
ALTER TABLE [dbo].[group_users]  WITH CHECK ADD  CONSTRAINT [FK_group_users_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[group_users] CHECK CONSTRAINT [FK_group_users_user_id]
GO
ALTER TABLE [dbo].[Invitations]  WITH CHECK ADD  CONSTRAINT [FK_invitation_group_id] FOREIGN KEY([group_id])
REFERENCES [dbo].[Group] ([GroupId])
GO
ALTER TABLE [dbo].[Invitations] CHECK CONSTRAINT [FK_invitation_group_id]
GO
ALTER TABLE [dbo].[Invitations]  WITH CHECK ADD  CONSTRAINT [FK_invitation_sender_id] FOREIGN KEY([sender_id])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Invitations] CHECK CONSTRAINT [FK_invitation_sender_id]
GO
ALTER TABLE [dbo].[Meetings]  WITH CHECK ADD  CONSTRAINT [FK_Meetings_Users_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Meetings] CHECK CONSTRAINT [FK_Meetings_Users_Student]
GO
ALTER TABLE [dbo].[Meetings]  WITH CHECK ADD  CONSTRAINT [FK_Meetings_Users_Supervisor] FOREIGN KEY([SupervisorID])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Meetings] CHECK CONSTRAINT [FK_Meetings_Users_Supervisor]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users_Receiver] FOREIGN KEY([ReceiverId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users_Receiver]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users_Sender] FOREIGN KEY([SenderId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users_Sender]
GO
ALTER TABLE [dbo].[ProjectDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProjectDetail_Users] FOREIGN KEY([SupervisorID])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectDetails] CHECK CONSTRAINT [FK_ProjectDetail_Users]
GO
ALTER TABLE [dbo].[ProjectDocuments]  WITH CHECK ADD  CONSTRAINT [FK_ProjectDocuments_ProjectDetails] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[ProjectDetails] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectDocuments] CHECK CONSTRAINT [FK_ProjectDocuments_ProjectDetails]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Tasks] FOREIGN KEY([TaskID])
REFERENCES [dbo].[Tasks] ([TaskId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Tasks]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Users_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Users_Student]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Users_Supervisor] FOREIGN KEY([SupervisorID])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Users_Supervisor]
GO
ALTER TABLE [dbo].[StudentProjectRequest]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[ProjectDetails] ([ProjectId])
GO
ALTER TABLE [dbo].[StudentProjectRequest]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_ProjectDetails] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[ProjectDetails] ([ProjectId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_ProjectDetails]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Users] FOREIGN KEY([AssignedTo])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Users]
GO
ALTER TABLE [dbo].[Timetables]  WITH CHECK ADD  CONSTRAINT [FK_Timetables_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Timetables] CHECK CONSTRAINT [FK_Timetables_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserTypes] FOREIGN KEY([UserTypeId])
REFERENCES [dbo].[UserTypes] ([UserTypeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserTypes]
GO
USE [master]
GO
ALTER DATABASE [FYP_MS] SET  READ_WRITE 
GO
