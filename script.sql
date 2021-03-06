USE [master]
GO
/****** Object:  Database [dbGTGeneration]    Script Date: 5/4/2017 10:44:16 AM ******/
CREATE DATABASE [dbGTGeneration]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbGTGeneration', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbGTGeneration.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbGTGeneration_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbGTGeneration_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbGTGeneration] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbGTGeneration].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbGTGeneration] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbGTGeneration] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbGTGeneration] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbGTGeneration] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbGTGeneration] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbGTGeneration] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbGTGeneration] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [dbGTGeneration] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbGTGeneration] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbGTGeneration] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbGTGeneration] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbGTGeneration] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbGTGeneration] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbGTGeneration] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbGTGeneration] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbGTGeneration] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbGTGeneration] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbGTGeneration] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbGTGeneration] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbGTGeneration] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbGTGeneration] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbGTGeneration] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbGTGeneration] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbGTGeneration] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbGTGeneration] SET  MULTI_USER 
GO
ALTER DATABASE [dbGTGeneration] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbGTGeneration] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbGTGeneration] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbGTGeneration] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [dbGTGeneration]
GO
/****** Object:  Rule [dbo].[range_rule]    Script Date: 5/4/2017 10:44:16 AM ******/
CREATE RULE [dbo].[range_rule] 
AS
@range>= '3/20/1950' AND @range <'3/20/2005'; 
GO
/****** Object:  StoredProcedure [dbo].[prcFetchAdmin]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcFetchAdmin]
(
@userid varchar(25),
@password varchar(25)
)
as
select * from tblAdmin where vUserId=@userid and vPassword=@password
GO
/****** Object:  StoredProcedure [dbo].[prcFetchDataFromRoute1]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcFetchDataFromRoute1]
(
@cSourceStation char(25),
@cDestinationStation char(25)
)
as
begin 
select * from Route1 where cSourceStation=@cSourceStation and cDestinationStation=@cDestinationStation
end
GO
/****** Object:  StoredProcedure [dbo].[prcFetchDataFromRoute2]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcFetchDataFromRoute2]
(
@SourceStation char(25),
@DestinationStation char(25)
)
as
begin 
select * from Route2 where cSourceStation=@SourceStation and cDestinationStation=@DestinationStation
end
GO
/****** Object:  StoredProcedure [dbo].[prcFetchPass]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ---creating procedure for fetching password on basis of id----procedure no:2
 
 create proc [dbo].[prcFetchPass]
 (
 @userid int,
 @password varchar(25)
 )
 as
 select* from tblUser where iUserId=@userid and vPassword=@password
 
GO
/****** Object:  StoredProcedure [dbo].[prcInsert_User]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcInsert_User]
(
@cFirst_Name char(25),
@cLast_Name char(25),
@vPassword varchar(25),
@cGender char(10),
@vEmail varchar(30),
@vMobile_No varchar(10),
@dDate_Of_Birth date,
@cCity char(25),
@cState char(25),
@cCountry char(25),
@iPin_Code int)
AS
BEGIN
   SET NOCOUNT ON;
	  IF Exists(Select iUserId from tblUser where vEmail=@vEmail)
	  BEGIN
	       select -1 -- Email exists.
	  END
	  ELSE IF EXISTS(select iUserId from tblUser where vMobile_No=@vMobile_No)
	  BEGIN
	        select -2 ---Mobile No Exists.
      End
	  ELSE
	  BEGIN
	   
	        insert into [tblUser]
			([cFirst_Name],[cLast_Name],[vPassword],[cGender],[vEmail],[vMobile_No],[dDate_Of_Birth],[cCity],[cState],[cCountry],[iPin_Code])
			values(@cFirst_Name,
                   @cLast_Name,
                   @vPassword,
                   @cGender,
                   @vEmail ,
                   @vMobile_No,
                   @dDate_Of_Birth ,
                   @cCity,
                   @cState,
                   @cCountry,
                   @iPin_Code)
				   select SCOPE_IDENTITY() ----iUserId
		END
 END
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateDistanceRoute1]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcUpdateDistanceRoute1]
(
@dDistance decimal(38),
   @serial_no int
)
as
begin
update Route1 Set dDistance=@dDistance
    where serial_no=@serial_no
    end
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateDistanceRoute2]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcUpdateDistanceRoute2]
(
@dDistance decimal(38),
   @serial_no int
)
as
begin
update Route2 Set dDistance=@dDistance
    where serial_no=@serial_no
    end
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateFairRoute1]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcUpdateFairRoute1]
(
@dPrice decimal(38),
   @serial_no int
)
as
begin
update Route1 Set dPrice=@dPrice
    where serial_no=@serial_no
    end
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateFairRoute2]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcUpdateFairRoute2]
(
@dPrice decimal(38),
   @serial_no int
)
as
begin
update Route2 Set dPrice=@dPrice
    where serial_no=@serial_no
    end
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateSourceandDestinationRoute1]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcUpdateSourceandDestinationRoute1]
(
@cSourceStation char(25),
   @cDestinationStation char(25),
   @serial_no int
)
as
begin
update Route1 Set cSourceStation=@cSourceStation  ,
   cDestinationStation= @cDestinationStation 
    where serial_no=@serial_no
    end
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateSourceandDestinationRoute2]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcUpdateSourceandDestinationRoute2]
(
@cSourceStation char(25),
   @cDestinationStation char(25),
   @serial_no int
)
as
begin
update Route2 Set cSourceStation=@cSourceStation  ,
   cDestinationStation= @cDestinationStation 
    where serial_no=@serial_no
    end
GO
/****** Object:  Table [dbo].[dtTicketDetailsOfRoute1]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dtTicketDetailsOfRoute1](
	[iticketSerialNo] [int] IDENTITY(1,1) NOT NULL,
	[cSourceStation] [char](25) NULL,
	[cDestinationStation] [char](25) NULL,
	[dPrice] [decimal](38, 0) NULL,
	[dDistance] [decimal](38, 0) NULL,
	[serial_no] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dtTicketDetailsOfRoute2]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dtTicketDetailsOfRoute2](
	[iticketSerialNo] [int] IDENTITY(1,1) NOT NULL,
	[cSourceStation] [char](25) NULL,
	[cDestinationStation] [char](25) NULL,
	[dPrice] [decimal](38, 0) NULL,
	[dDistance] [decimal](38, 0) NULL,
	[ticketserial_no] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Route1]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Route1](
	[cSourceStation] [char](25) NULL,
	[cDestinationStation] [char](25) NULL,
	[dPrice] [decimal](38, 0) NULL,
	[dDistance] [decimal](38, 0) NULL,
	[serial_no] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Route2]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Route2](
	[cSourceStation] [char](25) NULL,
	[cDestinationStation] [char](25) NULL,
	[dPrice] [decimal](38, 0) NULL,
	[dDistance] [decimal](38, 0) NULL,
	[serial_no] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAdmin]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAdmin](
	[vUserId] [varchar](25) NOT NULL,
	[vPassword] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[vUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[cFirst_Name] [char](25) NOT NULL,
	[cLast_Name] [char](25) NULL,
	[vPassword] [varchar](25) NOT NULL,
	[cGender] [char](10) NOT NULL,
	[vEmail] [varchar](30) NOT NULL,
	[vMobile_No] [varchar](10) NOT NULL,
	[dDate_Of_Birth] [date] NOT NULL,
	[cCity] [char](25) NOT NULL,
	[cState] [char](25) NOT NULL,
	[cCountry] [char](25) NOT NULL,
	[iPin_Code] [int] NOT NULL,
	[iUserId] [int] IDENTITY(10000,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[vMobile_No] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainRoute12]    Script Date: 5/4/2017 10:44:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainRoute12](
	[iTrainNo] [int] IDENTITY(10801,1) NOT NULL,
	[cTrainName] [char](25) NULL,
	[iRouteNo] [int] NULL,
	[cSourceStation] [char](25) NULL,
	[cStopStation] [char](25) NULL,
	[cDestinationStation] [char](25) NULL,
	[tSourceTime] [time](7) NULL,
	[tStopTime] [time](7) NULL,
	[tDestinationTime] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[iTrainNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [dbGTGeneration] SET  READ_WRITE 
GO
