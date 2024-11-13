USE [master]
GO
/****** Object:  Database [IndependenceDB]    Script Date: 20/05/2024 12:22:27 pm ******/
CREATE DATABASE [IndependenceDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IndependenceDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\IndependenceDB.mdf' , SIZE = 466944KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IndependenceDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\IndependenceDB_log.ldf' , SIZE = 2170880KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [IndependenceDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IndependenceDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IndependenceDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IndependenceDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IndependenceDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IndependenceDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IndependenceDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [IndependenceDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IndependenceDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IndependenceDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IndependenceDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IndependenceDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IndependenceDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IndependenceDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IndependenceDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IndependenceDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IndependenceDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IndependenceDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IndependenceDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IndependenceDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IndependenceDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IndependenceDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IndependenceDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IndependenceDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IndependenceDB] SET RECOVERY FULL 
GO
ALTER DATABASE [IndependenceDB] SET  MULTI_USER 
GO
ALTER DATABASE [IndependenceDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IndependenceDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IndependenceDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IndependenceDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [IndependenceDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [IndependenceDB] SET QUERY_STORE = OFF
GO
USE [IndependenceDB]
GO
/****** Object:  User [usrISRA]    Script Date: 20/05/2024 12:22:27 pm ******/
CREATE USER [usrISRA] FOR LOGIN [usrISRA] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetName]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnGetName] 
(
	@L_SUFFIX		VARCHAR(50),
	@FAMILY_NAME	VARCHAR(50),
	@GIVEN_NAMES	VARCHAR(50),
	@L_MIDDLE_NAME	VARCHAR(50)
)
RETURNS VARCHAR(35)
AS 
BEGIN
	DECLARE @NAME VARCHAR(100)

	--SET @Work = @Input

	--SET @Work = REPLACE(@Work, 'www.', '')
	--SET @Work = REPLACE(@Work, '.com', '')
	
	SET @NAME	=	(case when @L_SUFFIX = '' then
					@FAMILY_NAME + ', ' + @GIVEN_NAMES + @L_SUFFIX + ' ' + @L_MIDDLE_NAME
	else
		@FAMILY_NAME + ', ' + @GIVEN_NAMES + ' ' + @L_SUFFIX + ' ' + @L_MIDDLE_NAME
	end)

	if	len(@NAME)	>	35
	begin
		set	@NAME	=	LEFT(@NAME, 35)
	end


	RETURN @NAME
END
GO
/****** Object:  Table [dbo].[ACCOUNT_IM]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT_IM](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[INACTIV_MARKER] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT_IM_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT_IM_DME](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[INACTIV_MARKER] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT_IM_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT_IM_TRANSFORMED](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[INACTIV_MARKER] [varchar](50) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT_STAGING]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT_STAGING](
	[UPLOAD COMPANY] [varchar](100) NULL,
	[ID] [varchar](100) NULL,
	[CUSTOMER] [varchar](100) NULL,
	[CATEGORY] [varchar](100) NULL,
	[ACCOUNT TITLE 1] [varchar](100) NULL,
	[SHORT TITLE] [varchar](100) NULL,
	[CURRENCY] [varchar](100) NULL,
	[ACCOUNT OFFICER] [varchar](100) NULL,
	[POSTING RESTRICT] [varchar](100) NULL,
	[PASSBOOK] [varchar](100) NULL,
	[OPENING DATE] [varchar](100) NULL,
	[ALT ACCT TYPE 1] [varchar](100) NULL,
	[ALT ACCT ID 1] [varchar](100) NOT NULL,
	[ALLOW NETTING] [varchar](100) NULL,
	[HVT FLAG] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT1]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT1](
	[UPLOAD COMPANY] [varchar](100) NULL,
	[ID] [varchar](100) NULL,
	[CUSTOMER] [varchar](100) NULL,
	[CATEGORY] [varchar](100) NULL,
	[ACCOUNT TITLE 1] [varchar](100) NULL,
	[SHORT TITLE] [varchar](100) NULL,
	[CURRENCY] [varchar](100) NULL,
	[ACCOUNT OFFICER] [varchar](100) NULL,
	[POSTING RESTRICT] [varchar](100) NULL,
	[PASSBOOK] [varchar](100) NULL,
	[OPENING DATE] [varchar](100) NULL,
	[ALT ACCT TYPE 1] [varchar](100) NULL,
	[ALT ACCT ID 1] [varchar](100) NOT NULL,
	[ALLOW NETTING] [varchar](100) NULL,
	[HVT FLAG] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT2]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT2](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[INACTIVE MARKER] [varchar](50) NULL,
	[DATE_LAST_CR_CUST] [varchar](50) NULL,
	[DATE_LAST_DR_CUST] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT2_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT2_DME](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[DATE_LAST_CR_CUST] [varchar](50) NULL,
	[DATE_LAST_DR_CUST] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT2_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT2_TRANSFORMED](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[DATE_LAST_CR_CUST] [varchar](50) NULL,
	[DATE_LAST_DR_CUST] [varchar](50) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT3]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT3](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[POSTING_RESTRICT] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT3_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT3_DME](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[POSTING_RESTRICT] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNT3_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT3_TRANSFORMED](
	[UPLOAD_COMPANY] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[POSTING_RESTRICT] [varchar](50) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNTS_ARCHIVE]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNTS_ARCHIVE](
	[UPLOAD COMPANY] [varchar](100) NULL,
	[ID] [varchar](100) NULL,
	[CUSTOMER] [varchar](100) NULL,
	[CATEGORY] [varchar](100) NULL,
	[ACCOUNT TITLE 1] [varchar](100) NULL,
	[SHORT TITLE] [varchar](100) NULL,
	[CURRENCY] [varchar](100) NULL,
	[ACCOUNT OFFICER] [varchar](100) NULL,
	[POSTING RESTRICT] [varchar](100) NULL,
	[PASSBOOK] [varchar](100) NULL,
	[OPENING DATE] [varchar](100) NULL,
	[ALT ACCT TYPE 1] [varchar](100) NULL,
	[ALT ACCT ID 1] [varchar](100) NOT NULL,
	[ALLOW NETTING] [varchar](100) NULL,
	[HVT FLAG] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNTS_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNTS_DME](
	[UPLOAD COMPANY] [varchar](50) NULL,
	[ACCOUNT NUMBER] [varchar](50) NULL,
	[CUSTOMER] [varchar](50) NULL,
	[CATEGORY] [varchar](50) NULL,
	[ACCOUNT TITLE 1] [varchar](50) NULL,
	[SHORT TITLE] [varchar](50) NULL,
	[CURRENCY] [varchar](50) NULL,
	[ACCOUNT OFFICER] [varchar](50) NULL,
	[POSTING RESTRICT] [varchar](50) NULL,
	[PASSBOOK] [varchar](50) NULL,
	[OPENING DATE] [varchar](50) NULL,
	[ALT ACCT TYPE] [varchar](50) NULL,
	[ALT ACCT ID] [varchar](50) NULL,
	[ALLOW NETTING] [varchar](50) NULL,
	[HVT FLAG] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNTS_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNTS_TRANSFORMED](
	[UPLOAD COMPANY] [varchar](50) NULL,
	[ACCOUNT NUMBER] [varchar](50) NULL,
	[CUSTOMER] [varchar](50) NULL,
	[CATEGORY] [varchar](50) NULL,
	[ACCOUNT TITLE 1] [varchar](50) NULL,
	[SHORT TITLE] [varchar](50) NULL,
	[CURRENCY] [varchar](50) NULL,
	[ACCOUNT OFFICER] [varchar](50) NULL,
	[PASSBOOK] [varchar](50) NULL,
	[OPENING DATE] [varchar](50) NULL,
	[ALT ACCT TYPE] [varchar](50) NULL,
	[ALT ACCT ID] [varchar](50) NULL,
	[ALLOW NETTING] [varchar](50) NULL,
	[HVT FLAG] [varchar](50) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNTS_TRANSFORMED_HIST]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNTS_TRANSFORMED_HIST](
	[UPLOAD COMPANY] [varchar](50) NULL,
	[ACCOUNT NUMBER] [varchar](50) NULL,
	[CUSTOMER] [varchar](50) NULL,
	[CATEGORY] [varchar](50) NULL,
	[ACCOUNT TITLE 1] [varchar](50) NULL,
	[SHORT TITLE] [varchar](50) NULL,
	[CURRENCY] [varchar](50) NULL,
	[ACCOUNT OFFICER] [varchar](50) NULL,
	[PASSBOOK] [varchar](50) NULL,
	[OPENING DATE] [varchar](50) NULL,
	[ALT ACCT TYPE] [varchar](50) NULL,
	[ALT ACCT ID] [varchar](50) NULL,
	[ALLOW NETTING] [varchar](50) NULL,
	[HVT FLAG] [varchar](50) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCOUNTSUMMARY]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNTSUMMARY](
	[UPLOAD COMPANY] [varchar](100) NULL,
	[ACCOUNT NUMBER] [varchar](100) NULL,
	[CUSTOMER] [varchar](100) NULL,
	[CATEGORY] [varchar](100) NULL,
	[ACCOUNT TITLE 1] [varchar](100) NULL,
	[SHORT TITLE] [varchar](100) NULL,
	[CURRENCY] [varchar](100) NULL,
	[ACCOUNT OFFICER] [varchar](100) NULL,
	[POSTING RESTRICT] [varchar](100) NULL,
	[PASSBOOK] [varchar](100) NULL,
	[OPENING DATE] [varchar](100) NULL,
	[ALT ACCT TYPE] [varchar](100) NULL,
	[ALT ACCT ID] [varchar](100) NOT NULL,
	[ALLOW NETTING] [varchar](100) NULL,
	[HVT FLAG] [varchar](100) NULL,
	[INACTIV MARKER] [varchar](100) NULL,
	[DATE LAST CR CUST] [varchar](100) NULL,
	[DATE LAST DR CUST] [varchar](100) NULL,
	[ONLINE ACTUAL BAL] [varchar](100) NULL,
	[ONLINE CLEARED BAL] [varchar](100) NULL,
	[WORKING BALANCE] [varchar](100) NULL,
	[INPUTTER] [varchar](100) NULL,
	[DATE TIME] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCT_BALANCE]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCT_BALANCE](
	[UPLOAD_COMPANY] [varchar](max) NULL,
	[ID] [varchar](max) NULL,
	[ONLINE_ACTUAL_BAL] [varchar](max) NULL,
	[ONLINE_CLEARED_BAL] [varchar](max) NULL,
	[WORKING_BALANCE] [varchar](max) NULL,
	[OPEN_BALANCE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCT_BALANCE_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCT_BALANCE_DME](
	[UPLOAD COMPANY] [varchar](max) NULL,
	[ID] [varchar](max) NULL,
	[ACCOUNT NUMBER] [varchar](max) NULL,
	[AMOUNT LCY] [varchar](max) NULL,
	[SIGN] [varchar](max) NULL,
	[TRANSACTION CODE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCT_BALANCE_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCT_BALANCE_TRANSFORMED](
	[UPLOAD_COMPANY] [varchar](max) NULL,
	[ID] [varchar](max) NULL,
	[WORKING_BALANCE] [varchar](max) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCT_CLOSED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCT_CLOSED](
	[CUSTOMER ID] [varchar](max) NULL,
	[Account ID] [varchar](max) NULL,
	[AccountStatus] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACCT_VALIDATED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCT_VALIDATED](
	[CUSTOMER ID] [varchar](max) NULL,
	[Account ID] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[ID] [varchar](500) NULL,
	[MNEMONIC] [varchar](500) NULL,
	[SHORT NAME] [varchar](500) NULL,
	[ACCOUNT OFFICER] [varchar](500) NULL,
	[NATIONALITY] [varchar](500) NULL,
	[RESIDENCE] [varchar](500) NULL,
	[SECTOR] [varchar](500) NULL,
	[INDUSTRY] [varchar](500) NULL,
	[GIVEN NAMES] [varchar](500) NULL,
	[L MIDDLE NAME] [varchar](500) NULL,
	[FAMILY NAME] [varchar](500) NULL,
	[L SUFFIX] [varchar](500) NULL,
	[SMS 1] [varchar](500) NULL,
	[DATE OF BIRTH] [varchar](500) NULL,
	[L BIRTH PLACE] [varchar](500) NULL,
	[NAME 1] [varchar](500) NULL,
	[CUSTOMER STATUS] [varchar](500) NULL,
	[ADDRESS1] [varchar](500) NULL,
	[ADDRESS2] [varchar](500) NULL,
	[TOWN COUNTRY] [varchar](500) NULL,
	[POST CODE] [varchar](500) NULL,
	[L OCCUPATION] [varchar](500) NULL,
	[L SOURCE FUNDS] [varchar](500) NULL,
	[L CUSTOMER TYPE] [varchar](500) NULL,
	[L OFAC CHECK] [varchar](500) NULL,
	[TITLE] [varchar](500) NULL,
	[COUNTRY] [varchar](500) NULL,
	[TARGET] [varchar](500) NULL,
	[LANGUAGE] [varchar](500) NULL,
	[COMPANY BOOK] [varchar](500) NULL,
	[CLS CPARTY] [varchar](500) NULL,
	[GENDER] [varchar](500) NULL,
	[EMAIL 1] [varchar](500) NULL,
	[EMPLOYERS NAME] [varchar](500) NULL,
	[AML CHECK] [varchar](500) NULL,
	[AML RESULT] [varchar](500) NULL,
	[INTERNET BANKING SERVICE] [varchar](500) NULL,
	[MOBILE BANKING SERVICE] [varchar](500) NULL,
	[EXTERN SYS ID] [varchar](500) NULL,
	[EXTERN CUS ID] [varchar](500) NULL,
	[L DOCU TYPE] [varchar](500) NULL,
	[L LGL DOC NM 1] [varchar](500) NULL,
	[L TIN GSS] [varchar](500) NULL,
	[L LEGAL ID 1] [varchar](500) NULL,
	[L PA ST] [varchar](500) NULL,
	[L PA ADD] [varchar](500) NULL,
	[L PA TC] [varchar](500) NULL,
	[L PA PC] [varchar](500) NULL,
	[L PA CTRY 1] [varchar](500) NULL,
	[L SSS NO] [varchar](500) NULL,
	[L INSTRUCTION] [varchar](500) NULL,
	[cust_id] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_2]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_2](
	[ID] [varchar](50) NULL,
	[POSTING RESTRICT] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_2_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_2_DME](
	[ID] [varchar](50) NULL,
	[POSTING RESTRICT] [varchar](50) NULL,
	[CUSTOMER SINCE] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_2_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_2_TRANSFORMED](
	[ID] [varchar](50) NULL,
	[POSTING RESTRICT] [varchar](50) NULL,
	[ONBOARDING_DATE] [varchar](50) NULL,
	[DATE_TRANSFORMED] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_3]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_3](
	[R18_CUSTOMER_ID] [varchar](50) NULL,
	[ACCOUNT_NO] [varchar](50) NULL,
	[ONBOARDING_DATE] [varchar](50) NULL,
	[ONBOARDING STATUS] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_3_BAK]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_3_BAK](
	[R18_CUSTOMER_ID] [varchar](50) NULL,
	[ACCOUNT_NO] [varchar](50) NULL,
	[ONBOARDING_DATE] [varchar](50) NULL,
	[ONBOARDING STATUS] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_DME](
	[ID] [varchar](500) NULL,
	[MNEMONIC] [varchar](500) NULL,
	[SHORT NAME] [varchar](500) NULL,
	[ACCOUNT OFFICER] [varchar](500) NULL,
	[NATIONALITY] [varchar](500) NULL,
	[RESIDENCE] [varchar](500) NULL,
	[SECTOR] [varchar](500) NULL,
	[INDUSTRY] [varchar](500) NULL,
	[GIVEN NAMES] [varchar](500) NULL,
	[L MIDDLE NAME] [varchar](500) NULL,
	[FAMILY NAME] [varchar](500) NULL,
	[L SUFFIX] [varchar](500) NULL,
	[SMS 1] [varchar](500) NULL,
	[DATE OF BIRTH] [varchar](500) NULL,
	[L BIRTH PLACE] [varchar](500) NULL,
	[NAME 1] [varchar](500) NULL,
	[CUSTOMER STATUS] [varchar](500) NULL,
	[ADDRESS] [varchar](500) NULL,
	[TOWN COUNTRY] [varchar](500) NULL,
	[POST CODE] [varchar](500) NULL,
	[L OCCUPATION] [varchar](500) NULL,
	[L SOURCE FUNDS] [varchar](500) NULL,
	[L CUSTOMER TYPE] [varchar](500) NULL,
	[L OFAC CHECK] [varchar](500) NULL,
	[TITLE] [varchar](500) NULL,
	[COUNTRY] [varchar](500) NULL,
	[TARGET] [varchar](500) NULL,
	[LANGUAGE] [varchar](500) NULL,
	[COMPANY BOOK] [varchar](500) NULL,
	[CLS CPARTY] [varchar](500) NULL,
	[GENDER] [varchar](500) NULL,
	[EMAIL 1] [varchar](500) NULL,
	[EMPLOYERS NAME] [varchar](500) NULL,
	[AML CHECK] [varchar](500) NULL,
	[AML RESULT] [varchar](500) NULL,
	[INTERNET BANKING SERVICE] [varchar](500) NULL,
	[MOBILE BANKING SERVICE] [varchar](500) NULL,
	[EXTERN SYS ID] [varchar](500) NULL,
	[EXTERN CUS ID] [varchar](500) NULL,
	[L DOCU TYPE] [varchar](500) NULL,
	[L LGL DOC NM] [varchar](500) NULL,
	[L TIN GSS] [varchar](500) NULL,
	[L LEGAL ID] [varchar](500) NULL,
	[L PA ST] [varchar](500) NULL,
	[L PA ADD] [varchar](500) NULL,
	[L PA TC] [varchar](500) NULL,
	[L PA PC] [varchar](500) NULL,
	[L PA CTRY] [varchar](500) NULL,
	[L SSS NO] [varchar](500) NULL,
	[L CUST INSTRUCT] [nvarchar](max) NULL,
	[STREET] [varchar](500) NULL,
	[L HLD MAIL FLAG] [varchar](5) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_STAGING]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_STAGING](
	[ID] [varchar](500) NULL,
	[MNEMONIC] [varchar](500) NULL,
	[SHORT NAME] [varchar](500) NULL,
	[ACCOUNT OFFICER] [varchar](500) NULL,
	[NATIONALITY] [varchar](500) NULL,
	[RESIDENCE] [varchar](500) NULL,
	[SECTOR] [varchar](500) NULL,
	[INDUSTRY] [varchar](500) NULL,
	[GIVEN NAMES] [varchar](500) NULL,
	[L MIDDLE NAME] [varchar](500) NULL,
	[FAMILY NAME] [varchar](500) NULL,
	[L SUFFIX] [varchar](500) NULL,
	[SMS 1] [varchar](500) NULL,
	[DATE OF BIRTH] [varchar](500) NULL,
	[L BIRTH PLACE] [varchar](500) NULL,
	[NAME 1] [varchar](500) NULL,
	[CUSTOMER STATUS] [varchar](500) NULL,
	[ADDRESS1] [varchar](500) NULL,
	[ADDRESS2] [varchar](500) NULL,
	[TOWN COUNTRY] [varchar](500) NULL,
	[POST CODE] [varchar](500) NULL,
	[L OCCUPATION] [varchar](500) NULL,
	[L SOURCE FUNDS] [varchar](500) NULL,
	[L CUSTOMER TYPE] [varchar](500) NULL,
	[L OFAC CHECK] [varchar](500) NULL,
	[TITLE] [varchar](500) NULL,
	[COUNTRY] [varchar](500) NULL,
	[TARGET] [varchar](500) NULL,
	[LANGUAGE] [varchar](500) NULL,
	[COMPANY BOOK] [varchar](500) NULL,
	[CLS CPARTY] [varchar](500) NULL,
	[GENDER] [varchar](500) NULL,
	[EMAIL 1] [varchar](500) NULL,
	[EMPLOYERS NAME] [varchar](500) NULL,
	[AML CHECK] [varchar](500) NULL,
	[AML RESULT] [varchar](500) NULL,
	[INTERNET BANKING SERVICE] [varchar](500) NULL,
	[MOBILE BANKING SERVICE] [varchar](500) NULL,
	[EXTERN SYS ID] [varchar](500) NULL,
	[EXTERN CUS ID] [varchar](500) NULL,
	[L DOCU TYPE] [varchar](500) NULL,
	[L LGL DOC NM 1] [varchar](500) NULL,
	[L TIN GSS] [varchar](500) NULL,
	[L LEGAL ID 1] [varchar](500) NULL,
	[L PA ST] [varchar](500) NULL,
	[L PA ADD] [varchar](500) NULL,
	[L PA TC] [varchar](500) NULL,
	[L PA PC] [varchar](500) NULL,
	[L PA CTRY 1] [varchar](500) NULL,
	[L SSS NO] [varchar](500) NULL,
	[L INSTRUCTION] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_TRANSFORMED]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_TRANSFORMED](
	[ID] [varchar](500) NULL,
	[MNEMONIC] [varchar](500) NULL,
	[SHORT NAME] [varchar](500) NULL,
	[ACCOUNT OFFICER] [varchar](500) NULL,
	[NATIONALITY] [varchar](500) NULL,
	[RESIDENCE] [varchar](500) NULL,
	[SECTOR] [varchar](500) NULL,
	[INDUSTRY] [varchar](500) NULL,
	[GIVEN NAMES] [varchar](500) NULL,
	[L MIDDLE NAME] [varchar](500) NULL,
	[FAMILY NAME] [varchar](500) NULL,
	[L SUFFIX] [varchar](500) NULL,
	[SMS 1] [varchar](500) NULL,
	[DATE OF BIRTH] [varchar](500) NULL,
	[L BIRTH PLACE] [varchar](500) NULL,
	[NAME 1] [varchar](500) NULL,
	[CUSTOMER STATUS] [varchar](500) NULL,
	[ADDRESS] [varchar](500) NULL,
	[TOWN COUNTRY] [varchar](500) NULL,
	[POST CODE] [varchar](500) NULL,
	[L OCCUPATION] [varchar](500) NULL,
	[L SOURCE FUNDS] [varchar](500) NULL,
	[L CUSTOMER TYPE] [varchar](500) NULL,
	[L OFAC CHECK] [varchar](500) NULL,
	[TITLE] [varchar](500) NULL,
	[COUNTRY] [varchar](500) NULL,
	[TARGET] [varchar](500) NULL,
	[LANGUAGE] [varchar](500) NULL,
	[COMPANY BOOK] [varchar](500) NULL,
	[CLS CPARTY] [varchar](500) NULL,
	[GENDER] [varchar](500) NULL,
	[EMAIL 1] [varchar](500) NULL,
	[EMPLOYERS NAME] [varchar](500) NULL,
	[AML CHECK] [varchar](500) NULL,
	[AML RESULT] [varchar](500) NULL,
	[INTERNET BANKING SERVICE] [varchar](500) NULL,
	[MOBILE BANKING SERVICE] [varchar](500) NULL,
	[EXTERN SYS ID] [varchar](500) NULL,
	[EXTERN CUS ID] [varchar](500) NULL,
	[L DOCU TYPE] [varchar](500) NULL,
	[L LGL DOC NM] [varchar](500) NULL,
	[L TIN GSS] [varchar](500) NULL,
	[L LEGAL ID] [varchar](500) NULL,
	[L PA ST] [varchar](500) NULL,
	[L PA ADD] [varchar](500) NULL,
	[L PA TC] [varchar](500) NULL,
	[L PA PC] [varchar](500) NULL,
	[L PA CTRY] [varchar](500) NULL,
	[L SSS NO] [varchar](500) NULL,
	[L CUST INSTRUCT] [nvarchar](max) NULL,
	[STREET] [varchar](500) NULL,
	[L HLD MAIL FLAG] [varchar](5) NULL,
	[Date_Transformed] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_TRANSFORMED_BAK]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_TRANSFORMED_BAK](
	[ID] [varchar](500) NULL,
	[MNEMONIC] [varchar](500) NULL,
	[SHORT NAME] [varchar](500) NULL,
	[ACCOUNT OFFICER] [varchar](500) NULL,
	[NATIONALITY] [varchar](500) NULL,
	[RESIDENCE] [varchar](500) NULL,
	[SECTOR] [varchar](500) NULL,
	[INDUSTRY] [varchar](500) NULL,
	[GIVEN NAMES] [varchar](500) NULL,
	[L MIDDLE NAME] [varchar](500) NULL,
	[FAMILY NAME] [varchar](500) NULL,
	[L SUFFIX] [varchar](500) NULL,
	[SMS 1] [varchar](500) NULL,
	[DATE OF BIRTH] [varchar](500) NULL,
	[L BIRTH PLACE] [varchar](500) NULL,
	[NAME 1] [varchar](500) NULL,
	[CUSTOMER STATUS] [varchar](500) NULL,
	[ADDRESS] [varchar](500) NULL,
	[TOWN COUNTRY] [varchar](500) NULL,
	[POST CODE] [varchar](500) NULL,
	[L OCCUPATION] [varchar](500) NULL,
	[L SOURCE FUNDS] [varchar](500) NULL,
	[L CUSTOMER TYPE] [varchar](500) NULL,
	[L OFAC CHECK] [varchar](500) NULL,
	[TITLE] [varchar](500) NULL,
	[COUNTRY] [varchar](500) NULL,
	[TARGET] [varchar](500) NULL,
	[LANGUAGE] [varchar](500) NULL,
	[COMPANY BOOK] [varchar](500) NULL,
	[CLS CPARTY] [varchar](500) NULL,
	[GENDER] [varchar](500) NULL,
	[EMAIL 1] [varchar](500) NULL,
	[EMPLOYERS NAME] [varchar](500) NULL,
	[AML CHECK] [varchar](500) NULL,
	[AML RESULT] [varchar](500) NULL,
	[INTERNET BANKING SERVICE] [varchar](500) NULL,
	[MOBILE BANKING SERVICE] [varchar](500) NULL,
	[EXTERN SYS ID] [varchar](500) NULL,
	[EXTERN CUS ID] [varchar](500) NULL,
	[L DOCU TYPE] [varchar](500) NULL,
	[L LGL DOC NM] [varchar](500) NULL,
	[L TIN GSS] [varchar](500) NULL,
	[L LEGAL ID] [varchar](500) NULL,
	[L PA ST] [varchar](500) NULL,
	[L PA ADD] [varchar](500) NULL,
	[L PA TC] [varchar](500) NULL,
	[L PA PC] [varchar](500) NULL,
	[L PA CTRY] [varchar](500) NULL,
	[L SSS NO] [varchar](500) NULL,
	[L CUST INSTRUCT] [nvarchar](max) NULL,
	[STREET] [varchar](500) NULL,
	[L HLD MAIL FLAG] [varchar](5) NULL,
	[Date_Transformed] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMERSUMMARY]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMERSUMMARY](
	[ID] [varchar](500) NULL,
	[MNEMONIC] [varchar](500) NULL,
	[SHORT NAME] [varchar](500) NULL,
	[ACCOUNT OFFICER] [varchar](500) NULL,
	[NATIONALITY] [varchar](500) NULL,
	[RESIDENCE] [varchar](500) NULL,
	[SECTOR] [varchar](500) NULL,
	[INDUSTRY] [varchar](500) NULL,
	[GIVEN NAMES] [varchar](500) NULL,
	[L MIDDLE NAME] [varchar](500) NULL,
	[FAMILY NAME] [varchar](500) NULL,
	[L SUFFIX] [varchar](500) NULL,
	[SMS 1] [varchar](500) NULL,
	[DATE OF BIRTH] [varchar](500) NULL,
	[L BIRTH PLACE] [varchar](500) NULL,
	[NAME 1] [varchar](500) NULL,
	[CUSTOMER STATUS] [varchar](500) NULL,
	[ADDRESS] [varchar](500) NULL,
	[TOWN COUNTRY] [varchar](500) NULL,
	[POST CODE] [varchar](500) NULL,
	[L OCCUPATION] [varchar](500) NULL,
	[L SOURCE FUNDS] [varchar](500) NULL,
	[L CUSTOMER TYPE] [varchar](500) NULL,
	[L OFAC CHECK] [varchar](500) NULL,
	[TITLE] [varchar](500) NULL,
	[COUNTRY] [varchar](500) NULL,
	[TARGET] [varchar](500) NULL,
	[LANGUAGE] [varchar](500) NULL,
	[COMPANY BOOK] [varchar](500) NULL,
	[CLS CPARTY] [varchar](500) NULL,
	[GENDER] [varchar](500) NULL,
	[EMAIL 1] [varchar](500) NULL,
	[EMPLOYERS NAME] [varchar](500) NULL,
	[AML CHECK] [varchar](500) NULL,
	[AML RESULT] [varchar](500) NULL,
	[INTERNET BANKING SERVICE] [varchar](500) NULL,
	[MOBILE BANKING SERVICE] [varchar](500) NULL,
	[EXTERN SYS ID] [varchar](500) NULL,
	[EXTERN CUS ID] [varchar](500) NULL,
	[L DOCU TYPE] [varchar](500) NULL,
	[L LGL DOC NM 1] [varchar](500) NULL,
	[L TIN GSS] [varchar](500) NULL,
	[L LEGAL ID 1] [varchar](500) NULL,
	[L PA ST] [varchar](500) NULL,
	[L PA ADD] [varchar](500) NULL,
	[L PA TC] [varchar](500) NULL,
	[L PA PC] [varchar](500) NULL,
	[L PA CTRY 1] [varchar](500) NULL,
	[L SSS NO] [varchar](500) NULL,
	[L INSTRUCTION] [varchar](500) NULL,
	[STREET] [varchar](500) NULL,
	[L HLD MAIL FLAG] [varchar](500) NULL,
	[POSTING RESTRICT] [varchar](500) NULL,
	[INPUTTER] [varchar](500) NULL,
	[DATE TIME] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R12.PREGEN.AC]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R12.PREGEN.AC](
	[ACCOUNT NUMBER] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R12_DME_PRE_GEN]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R12_DME_PRE_GEN](
	[ACCOUNT NUMBER] [varchar](100) NULL,
	[OLD_ACCT_ID] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_acct_bal_write]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_acct_bal_write](
	[acct_bal_rec] [nvarchar](max) NULL,
	[batch] [int] NULL,
	[tran_type] [varchar](1) NULL,
	[UPLOAD COMPANY] [varchar](max) NULL,
	[ID] [varchar](max) NULL,
	[ACCOUNT NUMBER] [varchar](max) NULL,
	[AMOUNT LCY] [varchar](max) NULL,
	[TRANSACTION CODE] [varchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_acctbal_batch]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_acctbal_batch](
	[BATCH] [varchar](5) NULL,
	[UPLOAD_COMPANY] [varchar](max) NULL,
	[ID] [varchar](max) NULL,
	[ONLINE_ACTUAL_BAL] [varchar](max) NULL,
	[ONLINE_CLEARED_BAL] [varchar](max) NULL,
	[WORKING_BALANCE] [varchar](max) NULL,
	[OPEN_BALANCE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_acctbal_batch_ctr]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_acctbal_batch_ctr](
	[batch_no] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_acctbal_ref]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_acctbal_ref](
	[ID] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_cust_ctr]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cust_ctr](
	[cust_id_ctr] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Occupation]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Occupation](
	[Occupation_R18] [varchar](100) NULL,
	[Occupation_R12] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_ACCT_BALANCE]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_ACCT_BALANCE](
	[TId] [int] IDENTITY(1,1) NOT NULL,
	[UPLOAD_COMPANY] [varchar](max) NULL,
	[ID] [varchar](max) NULL,
	[ONLINE_ACTUAL_BAL] [varchar](max) NULL,
	[ONLINE_CLEARED_BAL] [varchar](max) NULL,
	[WORKING_BALANCE] [varchar](max) NULL,
	[OPEN_BALANCE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccount2]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccount2
-- Insert Account2 Raw File data to
-- Account2 table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccount2]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNT2 FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''650001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccount2DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccount2DME
-- Insert CustomerDME Raw File data to
-- Customer_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccount2DME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNT2_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccount3]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccount3
-- Insert Account3 Raw File data to
-- Account3 table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccount3]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNT3 FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''650001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccount3DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccount3DME
-- Insert Account3DME Raw File data to
-- Account3_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccount3DME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNT3_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccountBalance]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccountBalance
-- Insert AccountBalance Raw File data to
-- ACCT_BALANCE table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccountBalance]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCT_BALANCE FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''650001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccountBalDME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- [sp_BulkInsertAccountBalDME]
-- Insert AccountBalanceDME Raw File data to
-- ACCT_BALANCE_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccountBalDME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCT_BALANCE_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccountDME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccountDME
-- Insert CustomerDME Raw File data to
-- Customer_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccountDME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNTS_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccountIMDME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 11/05/2024
-- [sp_BulkInsertAccountIMDME]
-- Insert ACCOUNT_IM_DME Raw File data to
-- ACCOUNT_IM_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccountIMDME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNT_IM_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAccountStaging]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertAccountStaging
-- Insert Account Raw File data to
-- Account staging table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertAccountStaging]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	--DECLARE @errorFile NVARCHAR(MAX)

	--SET @errorFile = @filePath + '\error\' + @fileName

	SET @sql ='BULK INSERT ACCOUNT_STAGING FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''650001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertACCOUNTSUMMARY]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 11/05/2024
-- [sp_BulkInsertACCOUNTSUMMARY]
-- Insert ACCOUNTSUMMARY Raw File data to
-- CUSTOMERSUMMARY table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertACCOUNTSUMMARY]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT ACCOUNTSUMMARY FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertAcctValidate]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================  
-- Created By : JBacorro  
-- Created Date : 18/04/2024  
-- sp_BulkInsertAcctValidated  
-- Insert Account Validate Raw File data to  
-- acct_validate table  
--===========================================  
CREATE PROCEDURE [dbo].[sp_BulkInsertAcctValidate]  
(  
 @filePath NVARCHAR(100)  
 , @fileName NVARCHAR(100)  
)  
AS  
BEGIN   
  
 DECLARE @sql NVARCHAR(MAX)  
 DECLARE @errorFile NVARCHAR(MAX)  
  
  
 SET @sql ='BULK INSERT ACCT_VALIDATED FROM ''' + @filePath + @fileName + '''WITH (  
   FORMAT = ''CSV'',  
   FIRSTROW = 2,   
   MAXERRORS = 10,   
   FIELDTERMINATOR = '','',   
   ROWTERMINATOR = ''\n'',  
   codepage = ''650001''  
 )'  
  
  
 EXEC (@sql)  
  
END  
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCustomer]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertCustomer
-- Insert Customer Raw File data to
-- Customer table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCustomer]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMER FROM ''' + @filePath + '\' + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n''
			,codepage = ''65001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCustomer2]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertCustomer2
-- Insert Customer 2 Raw File data to
-- Customer_2 table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCustomer2]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMER_2 FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''650001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCUSTOMER2DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 11/05/2024
-- [sp_BulkInsertCUSTOMER2DME]
-- Insert CUSTOMER_2_DME Raw File data to
-- CUSTOMER_2_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCUSTOMER2DME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMER_2_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCustomer3]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertCustomer3
-- Insert Customer 3 Raw File data to
-- Customer_3 table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCustomer3]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMER_3 FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''65001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCUSTOMER3DME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 11/05/2024
-- [sp_BulkInsertCUSTOMER3DME]
-- Insert CUSTOMER_3_DME Raw File data to
-- CUSTOMER_3_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCUSTOMER3DME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMER_3_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCustomerDME]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertCustomerDME
-- Insert CustomerDME Raw File data to
-- Customer_DME table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCustomerDME]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMER_DME FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a'',
			codepage = ''65001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCustomerStaging]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertCustomerStaging
-- Insert Customer Raw File data to
-- Customer staging table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCustomerStaging]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	--DECLARE @errorFile NVARCHAR(MAX)

	--SET @errorFile = @filePath + '\error\' + @fileName

	SET @sql ='BULK INSERT CUSTOMER_STAGING FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''65001''
			,KEEPNULLS
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCustomerStagingSample]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertCustomerStaging
-- Insert Customer Raw File data to
-- Customer staging table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCustomerStagingSample]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	--DECLARE @errorFile NVARCHAR(MAX)

	--SET @errorFile = @filePath + '\error\' + @fileName

	SET @sql ='BULK INSERT CUSTOMER_STAGING_SAMPLE FROM ''' + @filePath + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''65001''
			,KEEPNULLS
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertCUSTOMERSUMMARY]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 11/05/2024
-- [sp_BulkInsertCUSTOMERSUMMARY]
-- Insert CUSTOMERSUMMARY Raw File data to
-- CUSTOMERSUMMARY table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertCUSTOMERSUMMARY]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)


	SET @sql ='BULK INSERT CUSTOMERSUMMARY FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = ''|'', 
			ROWTERMINATOR = ''0x0a''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertR12DME_PRE_GEN]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 18/04/2024
-- sp_BulkInsertR12DME_PRE_GEN
-- Insert R12 Pre Gen Raw File data to
-- R12 DME PRE GEN table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertR12DME_PRE_GEN]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)

	SET @sql ='BULK INSERT R12_DME_PRE_GEN FROM ''' + @filePath + '\' + @fileName + '''WITH (
			FORMAT = ''CSV'',
			FIRSTROW = 2, 
			MAXERRORS = 10, 
			FIELDTERMINATOR = '','', 
			ROWTERMINATOR = ''\n'',
			codepage = ''650001''
	)'


	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_BulkInsertR12PreGen]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 07/05/2024
-- sp_BulkInsertR12PreGen
-- Insert Pre_Gen_R12_Account Raw File data to
-- R12_DME_PRE_GEN table
--===========================================
CREATE PROCEDURE [dbo].[sp_BulkInsertR12PreGen]
(
	@filePath NVARCHAR(100)
	, @fileName NVARCHAR(100)
)
AS
BEGIN	

	DECLARE @sql NVARCHAR(MAX)
	DECLARE @errorFile NVARCHAR(MAX)

	CREATE TABLE TempTbl_DMEPreGen	(
		[ACCOUNTNUMBER] NVARCHAR(MAX)
	)

	SET @sql ='BULK INSERT TempTbl_DMEPreGen FROM ''' + @filePath + @fileName + '''WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ''\t'', 
			ROWTERMINATOR = ''\n'',
			codepage = ''65001''
	)'

	INSERT INTO R12_DME_PRE_GEN ([ACCOUNT NUMBER], OLD_ACCT_ID)
	SELECT ACCOUNTNUMBER, NULL FROM TempTbl_DMEPreGen

	DROP TABLE TempTbl_DMEPreGen

	SELECT COUNT(*) FROM R12_DME_PRE_GEN



	EXEC (@sql)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_acct_2_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE	procedure	[dbo].[sp_create_acct_2_file]
as
begin
	
	insert	into	ACCOUNT2_TRANSFORMED
	select	isnull(UPLOAD_COMPANY, ''), isnull([ACCOUNT NUMBER], ''), isnull(DATE_LAST_CR_CUST,''), isnull(DATE_LAST_DR_CUST, ''), GETDATE()
	from	Account2 a	with(nolock)
	inner	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
	on		a.[ID]	=	r.[ALT ACCT ID]

	select	isnull([ACCOUNT NUMBER],'') + '|' + isnull(UPLOAD_COMPANY, '') + '|' + isnull(DATE_LAST_CR_CUST,'') + '|' + isnull(DATE_LAST_DR_CUST, '')
	from	Account2 a	with(nolock)
	inner	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
	on		a.[ID]	=	r.[ALT ACCT ID]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_acct_3_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE	procedure	[dbo].[sp_create_acct_3_file]
as
begin

	insert	into	ACCOUNT3_TRANSFORMED
	select	isnull([UPLOAD_COMPANY], ''), isnull(r.[ACCOUNT NUMBER], ''), case when isnull([POSTING_RESTRICT], '') = '12' then '13' else  isnull([POSTING_RESTRICT], '') end , GETDATE()
	from	Account3 a	with(nolock)
	inner	join [ACCOUNTS_DME] r	with(nolock)
	on		a.[ID]	=	r.[ALT ACCT ID]

	select	isnull(r.[ACCOUNT NUMBER], '') + '|' + isnull([UPLOAD_COMPANY], '') + '|' + case when isnull([POSTING_RESTRICT], '') = '12' then '13' else  isnull([POSTING_RESTRICT], '') end 
	from	Account3 a	with(nolock)
	inner	join [ACCOUNTS_DME] r	with(nolock)
	on		a.[ID]	=	r.[ALT ACCT ID]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_acct_im_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE	procedure	[dbo].[sp_create_acct_im_file]
as
begin
	
	insert	into	ACCOUNT_IM
	select	UPLOAD_COMPANY, ID, [INACTIVE MARKER]
	from	ACCOUNT2	nolock
	where	isnull([INACTIVE MARKER], '')	<>	''

	insert	into	ACCOUNT_IM_TRANSFORMED
	select	UPLOAD_COMPANY, isnull([ACCOUNT NUMBER], ''), isnull(INACTIV_MARKER, ''), GETDATE()
	from	ACCOUNT_IM a	with(nolock)
	inner	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
	on		a.[ID]	=	r.[ALT ACCT ID]

	select	isnull([ACCOUNT NUMBER],'') + '|' + isnull(UPLOAD_COMPANY,'') + '|' + isnull(INACTIV_MARKER, '')
	from	ACCOUNT_IM a	with(nolock)
	inner	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
	on		a.[ID]	=	r.[ALT ACCT ID]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_acct_mstr_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE	procedure	 [dbo].[sp_create_acct_mstr_file]
as
begin

	--exec sp_prep_acct_mstr_file


	select	isnull(r.[ACCOUNT NUMBER], '') + '|' + isnull(c.[ID], '') + '|' + isnull([UPLOAD COMPANY], '') + '|' + isnull(a.[ID], '') + '|' + isnull([CUSTOMER], '') + '|' 
			+ case when isnull([CATEGORY], '') = '6001' then '6016' else '6017' end + '|' 
			+ dbo.fnGetName(isnull(d.[L SUFFIX], ''), isnull(d.[FAMILY NAME], ''), isnull(d.[GIVEN NAMES], ''), isnull(d.[L MIDDLE NAME], '')) + '|' 
			+ dbo.fnGetName(isnull(d.[L SUFFIX], ''), isnull(d.[FAMILY NAME], ''), isnull(d.[GIVEN NAMES], ''), isnull(d.[L MIDDLE NAME], ''))  + '|' 
			+ isnull([CURRENCY], '') + '|' + '801' + '|' + isnull([PASSBOOK], '') + '|' + isnull([OPENING DATE], '') + '|' + isnull([ALT ACCT TYPE 1], '') 
			+ '|' + isnull([ALT ACCT ID 1], '') + '|' + isnull([ALLOW NETTING], '') + '|' + isnull([HVT FLAG],'')
	from	Account1	a with(nolock)
	inner	join	R12_DME_PRE_GEN r with(nolock)
	on		a.[ALT ACCT ID 1]	=	r.[OLD_ACCT_ID]
	inner	join	[CUSTOMER_DME]	c with (nolock)
	on		a.[CUSTOMER]		=	c.[EXTERN CUS ID]
	inner	join	CUSTOMER d with(nolock)
	on		d.[EXTERN CUS ID]	=	a.[CUSTOMER]
	--from	Account1	a with(nolock)
	--inner	join	R12_DME_PRE_GEN r with(nolock)
	--on		a.[ALT ACCT ID 1]	=	r.[OLD_ACCT_ID]
	--inner	join	[CUSTOMER_DME]	c with (nolock)
	--on		a.[CUSTOMER]		=	c.[EXTERN CUS ID]
	--inner	join	CUSTOMER d with(nolock)
	--on		d.[EXTERN CUS ID]	=	a.[CUSTOMER]
	--where	r.[ACCOUNT NUMBER]	not	in	(select [ACCOUNT NUMBER] from ACCOUNTS_TRANSFORMED_hist nolock)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_acctbal_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure	 [dbo].[sp_create_acctbal_file]
--(
--	@loopctr	int
--)
as
begin

		select	acct_bal_rec
		from	tbl_acct_bal_write	nolock
		order	by	batch, tran_type

end
	
GO
/****** Object:  StoredProcedure [dbo].[sp_create_cust_acct_staglink]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create	procedure	[dbo].[sp_create_cust_acct_staglink]
as
SELECT	*
FROM	CUSTOMER_STAGING	c		with(nolock)
LEFT OUTER JOIN ACCOUNT_STAGING a	with(nolock)
on		c.[EXTERN CUS ID]	=	a.CUSTOMER
where	isnull(c.[EXTERN CUS ID], '')	<>	''
GO
/****** Object:  StoredProcedure [dbo].[sp_create_migration_mastr_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE	PROCEDURE	[dbo].[sp_create_migration_mastr_file]
(
	@rep_type	INT
)
as
begin
	if	@rep_type	=	1
	begin
		select	
				'"CIF NUMBER"',
				'"MNEMONIC"', 
				'"SHORT NAME"', 
				'"ACCOUNT OFFICER"', 
				'"NATIONALITY"',
				'"RESIDENCE"',
				'"SECTOR"', 
				'"INDUSTRY"',
				'"GIVEN NAMES"', 
				'"L MIDDLE NAME"', 
				'FAMILY NAME"', 
				'"L SUFFIX"',
				'"SMS 1"', 
				'"DATE OF BIRTH"', 
				'"L BIRTH PLACE"', 
				'"NAME 1"', 
				'"CUSTOMER STATUS"', 
				'"ADDRESS1"', '"ADDRESS2"', 
				'"TOWN COUNTRY"',
				'"POST CODE"', 
				'"L OCCUPATION"', 
				'"L SOURCE FUNDS"', 
				'"L CUSTOMER TYPE"', 
				'"L OFAC CHECK"', 
				'"TITLE"',
				'"COUNTRY"', 
				'"TARGET"', 
				'"LANGUAGE"', 
				'"COMPANY BOOK"',
				'"CLS CPARTY"',
				'"GENDER"',
				'"EMAIL 1"', 
				'"EMPLOYERS NAME"', 
				'"AML CHECK"', 
				'"AML RESULT"',
				'"INTERNET BANKING SERVICE"', 
				'"MOBILE BANKING SERVICE"', 
				'"EXTERN SYS ID"', 
				'"EXTERN CUS ID"',
				'"L DOCU TYPE"', 
				'"L LGL DOC NM 1"', 
				'"L TIN GSS"', 
				'"L LEGAL ID 1"',
				'"L PA ST"', 
				'"L PA ADD"',
				'"L PA TC"',
				'"L PA PC"', 
				'"L PA CTRY 1"', 
				'"L SSS NO"', 
				'"L INSTRUCTION"', 
				'"UPLOAD COMPANY"', 
				'"ACCOUNT NUMBER"',
				'"CUSTOMER"',
				'"CATEGORY"', 
				'"ACCOUNT TITLE 1"',
				'"SHORT TITLE"', 
				'"CURRENCY"', 
				'"ACCOUNT OFFICER"',
				'"PASSBOOK"', 
				'"OPENING DATE"',
				'"ALT ACCT TYPE"', 
				'"ALT ACCT ID"',
				'"ALLOW NETTING"',
				'"HVT FLAG"',
				'"ACCOUNT INACTIVE MARKER"',
				'"DATE_LAST_CR_CUST"', 
				'"DATE_LAST_DR_CUST"',
				'"ACCOUNT POSTING RESTRICT"', 
				'"CUSTOMER POSTING RESTRICT"',
				--'"ONBOARDING DATE"',
				'"ONLINE_ACTUAL_BAL"',
				'"ONLINE_CLEARED_BAL"',
				'"WORKING_BALANCE"',
				'"OPEN_BALANCE"'
		union	all
		select	'"' + cust.[ID] + '"' [ID], 
				'"' + cust.[MNEMONIC] + '"' [MNEMONIC],
				'"' + cust.[SHORT NAME] + '"' [SHORT NAME],
				'"' + cust.[ACCOUNT OFFICER] + '"' [ACCOUNT OFFICER],
				'"' + cust.[NATIONALITY] + '"' [NATIONALITY],
				'"' + cust.[RESIDENCE] + '"' [RESIDENCE],
				'"' + cust.[SECTOR] + '"' [SECTOR],
				'"' + cust.[INDUSTRY] + '"' [INDUSTRY],
				'"' + cust.[GIVEN NAMES] + '"' [GIVEN NAMES], 
				'"' + cust.[L MIDDLE NAME] + '"' [L MIDDLE NAME], 
				'"' + cust.[FAMILY NAME] + '"' [FAMILY NAME], 
				'"' + cust.[L SUFFIX] + '"' [L SUFFIX],
				'"' + cust.[SMS 1] + '"' [SMS 1], 
				'"' + cust.[DATE OF BIRTH] + '"' [DATE OF BIRTH], 
				'"' + cust.[L BIRTH PLACE] + '"' [L BIRTH PLACE], 
				'"' + cust.[NAME 1] + '"' [NAME 1],
				'"' + cust.[CUSTOMER STATUS] + '"' [CUSTOMER STATUS], 
				'"' + cust.[ADDRESS1] + '"' [ADDRESS1], '"' + cust.[ADDRESS2] + '"' [ADDRESS2],
				'"' + cust.[TOWN COUNTRY] + '"' [TOWN COUNTRY], 
				'"' + cust.[POST CODE] + '"' [POST CODE], 
				'"' + cust.[L OCCUPATION] + '"' [L OCCUPATION],  
				'"' + cust.[L SOURCE FUNDS] + '"' [L SOURCE FUNDS], 
				'"' + cust.[L CUSTOMER TYPE] + '"' [L CUSTOMER TYPE], 
				'"' + cust.[L OFAC CHECK] + '"' [L OFAC CHECK], 
				'"' + cust.[TITLE] + '"' [TITLE],
				'"' + cust.[COUNTRY] + '"' [COUNTRY], 
				'"' + cust.[TARGET] + '"' [TARGET],
				'"' + cust.[LANGUAGE] + '"' [LANGUAGE], 
				'"' + cust.[COMPANY BOOK] + '"' [COMPANY BOOK], 
				'"' + cust.[CLS CPARTY] + '"' [CLS CPARTY], 
				'"' + cust.[GENDER] + '"' [GENDER], 
				'"' + REPLACE(cust.[EMAIL 1], '''','') + '"' [EMAIL 1],
				'"' + cust.[EMPLOYERS NAME] + '"' [EMPLOYERS NAME],
				'"' + cust.[AML CHECK] + '"' [AML CHECK], 
				'"' + cust.[AML RESULT] + '"' [AML RESULT], 
				'"' + cust.[INTERNET BANKING SERVICE] + '"' [INTERNET BANKING SERVICE], 
				'"' + cust.[MOBILE BANKING SERVICE] + '"' [MOBILE BANKING SERVICE], 
				'"' + cust.[EXTERN SYS ID] + '"' [EXTERN SYS ID], 
				'"' + cust.[EXTERN CUS ID] + '"' [EXTERN CUS ID], 
				'"' + cust.[L DOCU TYPE] + '"' [L DOCU TYPE],
				'"' + cust.[L LGL DOC NM 1] + '"' [L LGL DOC NM 1],
				'"' + cust.[L TIN GSS] + '"' [L TIN GSS], 
				'"' + cust.[L LEGAL ID 1] + '"' [L LEGAL ID 1], 
				'"' + cust.[L PA ST] + '"' [L PA ST],
				'"' + cust.[L PA ADD] + '"' [L PA ADD],
				'"' + cust.[L PA TC] + '"' [L PA TC], 
				'"' + cust.[L PA PC] + '"' [L PA PC],
				'"' + cust.[L PA CTRY 1] + '"' [L PA CTRY 1], 
				'"' + cust.[L SSS NO] + '"' [L SSS NO],
				'"' + cust.[L INSTRUCTION] + '"' [L INSTRUCTION], 
				--'""'  as [STREET], 
				--'"Hold"' as [L HLD MAIL FLAG], 
				'"' + acct1.[UPLOAD COMPANY] + '"' [UPLOAD COMPANY],
				'"''' + acct1.[ALT ACCT ID 1] + '"' [ACCOUNT NUMBER],
				'"' + acct1.[CUSTOMER] + '"' [CUSTOMER],
				'"' + acct1.[CATEGORY] + '"' [CATEGORY],
				'"' + acct1.[ACCOUNT TITLE 1] + '"' [ACCOUNT TITLE 1], 
				'"' + acct1.[SHORT TITLE] + '"' [SHORT TITLE],  
				'"' + acct1.[CURRENCY] + '"' [CURRENCY],
				'"' + acct1.[ACCOUNT OFFICER] + '"' [ACCOUNT OFFICER], 
				'"' + acct1.[PASSBOOK] + '"' [PASSBOOK], 
				'"' + acct1.[OPENING DATE] + '"' [OPENING DATE],
				'"' + acct1.[ALT ACCT TYPE 1] + '"' [ALT ACCT TYPE 1], 
				'"''' + acct1.[ALT ACCT ID 1] + '"' [ALT ACCT ID 1], 
				'"' + acct1.[ALLOW NETTING] + '"' [ALLOW NETTING],
				'"' + acct1.[HVT FLAG] + '"' [HVT FLAG],
				'"' + acct_im.INACTIV_MARKER + '"' [ACCOUNT INACTIV MARKER],
				'"' + isnull(acct2.DATE_LAST_CR_CUST,'') + '"' [DATE_LAST_CR_CUST], 
				'"' + isnull(acct2.DATE_LAST_DR_CUST, '') + '"' [DATE_LAST_DR_CUST], 
				'"' + acct3.[POSTING_RESTRICT] + '"' [ACCOUNT POSTING_RESTRICT],
				'"' + cust2.[POSTING RESTRICT] + '"' [CUSTOMER POSTING RESTRICT],
				--'"' + cust3.[ONBOARDING_DATE] + '"' [ONBOARDING DATE],
				'"' + isnull(acctbal.[ONLINE_ACTUAL_BAL], '0.00') + '"' [ONLINE_ACTUAL_BAL],
				'"' + isnull(acctbal.[ONLINE_CLEARED_BAL], '0.00') + '"' [ONLINE_CLEARED_BAL],
				'"' + isnull(acctbal.[WORKING_BALANCE], '0.00') + '"' [WORKING_BALANCE],
				'"' + isnull(acctbal.[OPEN_BALANCE], '0.00') + '"' [OPEN_BALANCE]
		from	CUSTOMER_STAGING	cust	with(nolock)
		left	outer	join	ACCOUNT_STAGING	acct1	with(nolock)
		on		acct1.CUSTOMER	=	cust.[EXTERN CUS ID]
		left	outer	join	ACCOUNT2	acct2	with(nolock)
		on		acct2.ID	=	acct1.[ALT ACCT ID 1]
		left	outer	join	ACCOUNT3	acct3	with(nolock)
		on		acct3.ID	=	acct1.[ALT ACCT ID 1]
		left	outer	join	CUSTOMER_2	cust2	with(nolock)
		on		cust2.ID	=	cust.[EXTERN CUS ID]
		left	outer	join	ACCT_BALANCE	acctbal	with(nolock)
		on		acctbal.ID	=	acct1.[ALT ACCT ID 1]
		left	outer	join	ACCOUNT_IM	acct_im	with(nolock)
		on		acct_im.ID	=	acct1.[ALT ACCT ID 1]
		--left	outer	join	CUSTOMER_3	cust3	with(nolock)
		--on		cust3.R18_CUSTOMER_ID	=	acct1.[ALT ACCT ID 1]
	end
	else if	@rep_type	=	2
	begin
		select	
				'"UPLOAD COMPANY"', 
				'"''ACCOUNT NUMBER"',
				'"CUSTOMER"',
				'"CATEGORY"', 
				'"ACCOUNT TITLE 1"',
				'"SHORT TITLE"', 
				'"CURRENCY"', 
				'"ACCOUNT OFFICER"',
				'"PASSBOOK"', 
				'"OPENING DATE"',
				'"ALT ACCT TYPE"', 
				'"''ALT ACCT ID"',
				'"ALLOW NETTING"',
				'"HVT FLAG"',
				'"ONLINE_ACTUAL_BAL"',
				'"ONLINE_CLEARED_BAL"',
				'"WORKING_BALANCE"',
				'"OPEN_BALANCE"'
		union	all
		select	'"' + acct1.[UPLOAD COMPANY] + '"' [UPLOAD COMPANY],
				'"''' + acct1.[ALT ACCT ID 1] + '"' [ACCOUNT NUMBER],
				'"' + acct1.[CUSTOMER] + '"' [CUSTOMER],
				'"' + acct1.[CATEGORY] + '"' [CATEGORY],
				'"' + acct1.[ACCOUNT TITLE 1] + '"' [ACCOUNT TITLE 1], 
				'"' + acct1.[SHORT TITLE] + '"' [SHORT TITLE],  
				'"' + acct1.[CURRENCY] + '"' [CURRENCY],
				'"' + acct1.[ACCOUNT OFFICER] + '"' [ACCOUNT OFFICER], 
				'"' + acct1.[PASSBOOK] + '"' [PASSBOOK], 
				'"' + acct1.[OPENING DATE] + '"' [OPENING DATE],
				'"' + acct1.[ALT ACCT TYPE 1] + '"' [ALT ACCT TYPE 1], 
				'"''' + acct1.[ALT ACCT ID 1] + '"' [ALT ACCT ID 1], 
				'"' + acct1.[ALLOW NETTING] + '"' [ALLOW NETTING],
				'"' + acct1.[HVT FLAG] + '"' [HVT FLAG],
				'"' + isnull(acctbal.[ONLINE_ACTUAL_BAL], '0.00') + '"' [ONLINE_ACTUAL_BAL],
				'"' + isnull(acctbal.[ONLINE_CLEARED_BAL], '0.00') + '"' [ONLINE_CLEARED_BAL],
				'"' + isnull(acctbal.[WORKING_BALANCE], '0.00') + '"' [WORKING_BALANCE],
				'"' + isnull(acctbal.[OPEN_BALANCE], '0.00') + '"' [OPEN_BALANCE]
		from	CUSTOMER_STAGING	cust	with(nolock)
		left	outer	join	ACCOUNT_STAGING	acct1	with(nolock)
		on		acct1.CUSTOMER	=	cust.[EXTERN CUS ID]
		left	outer	join	ACCT_BALANCE	acctbal	with(nolock)
		on		acctbal.ID	=	acct1.[ALT ACCT ID 1]
	end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_migration_recon_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE	PROCEDURE	[dbo].[sp_create_migration_recon_file]
as
	select	'"ID"', '"NEW ID"', '"WITH CHANGES"',
			'"MNEMONIC"', '"NEW MNEMONIC"', '"WITH CHANGES"',
			'"SHORT NAME"', '"NEW SHORT NAME"', '"WITH CHANGES"',
			'"ACCOUNT OFFICER"', '"NEW ACCOUNT OFFICER"', '"WITH CHANGES"',
			'"NATIONALITY"', '"NEW NATIONALITY"', '"WITH CHANGES"',
			'"RESIDENCE"', '"NEW RESIDENCE"', '"WITH CHANGES"',
			'"SECTOR"', '"NEW SECTOR"', '"WITH CHANGES"',
			'"INDUSTRY"', '"NEW INDUSTRY"', '"WITH CHANGES"',
			'"GIVEN NAMES"', '"NEW GIVEN NAMES"', '"WITH CHANGES"',
			'"L MIDDLE NAME"', '"NEW L MIDDLE NAME"', '"WITH CHANGES"',
			'FAMILY NAME"', '"NEW FAMILY NAME"', '"WITH CHANGES"',
			'"L SUFFIX"', '"NEW L SUFFIX"', '"WITH CHANGES"',
			'"SMS 1"', '"NEW SMS 1"', '"WITH CHANGES"',
			'"DATE OF BIRTH"', '"NEW DATE OF BIRTH"', '"WITH CHANGES"',
			'"L BIRTH PLACE"', '"NEW L BIRTH PLACE"', '"WITH CHANGES"',
			'"NAME 1"', '"NEW NAME 1"', '"WITH CHANGES"',
			'"CUSTOMER STATUS"', '"NEW CUSTOMER STATUS"', '"WITH CHANGES"',
			'"ADDRESS"', '"New ADDRESS"', '"WITH CHANGES"',
			'"TOWN COUNTRY"', '"NEW TOWN COUNTRY"', '"WITH CHANGES"',
			'"POST CODE"', '"NEW POST CODE"', '"WITH CHANGES"',
			'"L OCCUPATION"', '"NEW L OCCUPATION"', '"WITH CHANGES"',
			'"L SOURCE FUNDS"', '"NEW L SOURCE FUNDS"', '"WITH CHANGES"',
			'"L CUSTOMER TYPE"', '"NEW L CUSTOMER TYPE"', '"WITH CHANGES"',
			'"L OFAC CHECK"', '"NEW L OFAC CHECK"', '"WITH CHANGES"',
			'"TITLE"', '"NEW TITLE"', '"WITH CHANGES"',
			'"COUNTRY"', '"NEW COUNTRY"', '"WITH CHANGES"',
			'"TARGET"', '"NEW TARGET"', '"WITH CHANGES"',
			'"LANGUAGE"', '"NEW LANGUAGE"', '"WITH CHANGES"',
			'"COMPANY BOOK"', '"NEW COMPANY BOOK"', '"WITH CHANGES"',
			'"CLS CPARTY"', '"NEW CLS CPARTY"', '"WITH CHANGES"',
			'"GENDER"', '"NEW GENDER"', '"WITH CHANGES"',
			'"EMAIL 1"', '"NEW EMAIL 1"', '"WITH CHANGES"',
			'"EMPLOYERS NAME"', '"NEW EMPLOYERS NAME"', '"WITH CHANGES"',
			'"AML CHECK"', '"NEW AML CHECK"', '"WITH CHANGES"',
			'"AML RESULT"', '"NEW AML RESULT"', '"WITH CHANGES"',
			'"INTERNET BANKING SERVICE"', '"NEW INTERNET BANKING SERVICE"', '"WITH CHANGES"',
			'"MOBILE BANKING SERVICE"', '"NEW MOBILE BANKING SERVICE"', '"WITH CHANGES"',
			'"EXTERN SYS ID"', '"NEW EXTERN SYS ID"', '"WITH CHANGES"',
			'"EXTERN CUS ID"', '"NEW EXTERN CUS ID"', '"WITH CHANGES"',
			'"L DOCU TYPE"', '"NEW L DOCU TYPE"', '"WITH CHANGES"',
			'"L LGL DOC NM 1"', '"NEW L LGL DOC NM"', '"WITH CHANGES"',
			'"L TIN GSS"', '"NEW L TIN GSS"', '"WITH CHANGES"',
			'"L LEGAL ID 1"', '"NEW L LEGAL ID"', '"WITH CHANGES"',
			'"L PA ST"', '"NEW L PA ST"', '"WITH CHANGES"', 
			'"L PA ADD"', '"NEW L PA ADD"', '"WITH CHANGES"',
			'"L PA TC"', '"NEW L PA TC"', '"WITH CHANGES"',
			'"L PA PC"', '"NEW L PA PC"', '"WITH CHANGES"',
			'"L PA CTRY 1"', '"NEW L PA CTRY"', '"WITH CHANGES"',
			'"L SSS NO"', '"NEW L SSS NO"', '"WITH CHANGES"',
			'"L INSTRUCTION"', '"NEW L CUST INSTRUCT"', '"WITH CHANGES"',
			'"STREET"', '"NEW STREET"', '"WITH CHANGES"',
			'"L HLD MAIL FLAG"', '"NEW L HLD MAIL FLAG"', '"WITH CHANGES"',

			'"UPLOAD COMPANY"', '"NEW UPLOAD COMPANY"', '"WITH CHANGES"',
			'"ACCOUNT NUMBER"', '"NEW ACCOUNT NUMBER"', '"WITH CHANGES"',
			'"CATEGORY"', '"NEW CATEGORY"', '"WITH CHANGES"',
			'"ACCOUNT TITLE 1"', '"NEW ACCOUNT TITLE 1"', '"WITH CHANGES"',
			'"SHORT TITLE"', '"NEW SHORT TITLE"', '"WITH CHANGES"',
			'"CURRENCY"', '"NEW CURRENCY"', '"WITH CHANGES"',
			'"ACCOUNT OFFICER"', '"NEW ACCOUNT OFFICER"', '"WITH CHANGES"',
			'"PASSBOOK"', '"NEW PASSBOOK"', '"WITH CHANGES"',
			'"OPENING DATE"', '"NEW OPENING DATE"', '"WITH CHANGES"',
			'"ALT ACCT TYPE"', '"NEW ALT ACCT TYPE"', '"WITH CHANGES"',
			'"ALLOW NETTING"', '"NEW ALLOW NETTING"', '"WITH CHANGES"',
			'"HVT FLAG"', '"NEW HVT FLAG"', '"WITH CHANGES"',

			'"ACCOUNT INACTIVE MARKER"', '"NEW ACCOUNT INACTIVE MARKER"', '"WITH CHANGES"',
			'"DATE_LAST_CR_CUST"', '"NEW DATE_LAST_CR_CUST"', '"WITH CHANGES"',
			'"DATE_LAST_DR_CUST"', '"NEW DATE_LAST_DR_CUST"', '"WITH CHANGES"',

			'"ACCOUNT POSTING RESTRICT"', '"NEW ACCOUNT POSTING RESTRICT"', '"WITH CHANGES"',

			'"POSTING RESTRICT"', '"NEW CUSTOMER POSTING RESTRICT"', '"WITH CHANGES"',

			--'"ONBOARDING DATE"', '"NEW ONBOARDING DATE"', '"WITH CHANGES"',

			'"WORKING BALANCE"', '"NEW WORKING BALANCE"', '"WITH CHANGES"'

	union	all
	select
			-- CUSTOMER RECON
			'"' + c.[ID] + '"', '"' + d.[ID] + '"' as [New ID], case when c.[ID] <> d.[ID] then '"YES"' else '"NO"' end,
			'"' + c.[MNEMONIC] + '"', '"' + d.[MNEMONIC] + '"' as [New MNEMONIC], case when c.[MNEMONIC] <> d.[MNEMONIC] then '"YES"' else '"NO"' end,
			'"' + c.[SHORT NAME] + '"', '"' + d.[SHORT NAME] + '"' as [New SHORT NAME], case when c.[SHORT NAME] <> d.[SHORT NAME] then '"YES"' else '"NO"' end,
			'"' + c.[ACCOUNT OFFICER] + '"', '"' + d.[ACCOUNT OFFICER] + '"' as [New ACCOUNT OFFICER], case when c.[ACCOUNT OFFICER] <> d.[ACCOUNT OFFICER] then '"YES"' else '"NO"' end,
			'"' + c.[NATIONALITY] + '"', '"' + d.[NATIONALITY] + '"' as [New NATIONALITY], case when c.[NATIONALITY] <> d.[NATIONALITY] then '"YES"' else '"NO"' end,
			'"' + c.[RESIDENCE] + '"', '"' + d.[RESIDENCE] + '"' as [New RESIDENCE], case when c.[RESIDENCE] <> d.[RESIDENCE] then '"YES"' else '"NO"' end,
			'"' + c.[SECTOR] + '"', '"' + d.[SECTOR] + '"' as [New SECTOR], case when c.[SECTOR] <> d.[SECTOR] then '"YES"' else '"NO"' end,
			'"' + c.[INDUSTRY] + '"', '"' + d.[INDUSTRY] + '"' as [New INDUSTRY], case when c.[INDUSTRY] <> d.[INDUSTRY] then '"YES"' else '"NO"' end,
			'"' + c.[GIVEN NAMES] + '"', '"' + d.[GIVEN NAMES] + '"' as [New GIVEN NAMES], case when c.[GIVEN NAMES] <> d.[GIVEN NAMES] then '"YES"' else '"NO"' end,
			'"' + c.[L MIDDLE NAME] + '"', '"' + d.[L MIDDLE NAME] + '"' as [New L MIDDLE NAME], case when c.[L MIDDLE NAME] <> d.[L MIDDLE NAME] then '"YES"' else '"NO"' end,
			'"' + c.[FAMILY NAME] + '"', '"' + d.[FAMILY NAME] + '"' as [New FAMILY NAME], case when c.[FAMILY NAME] <> d.[FAMILY NAME] then '"YES"' else '"NO"' end,
			'"' + c.[L SUFFIX] + '"', '"' + d.[L SUFFIX] + '"' as [New L SUFFIX], case when c.[L SUFFIX] <> d.[L SUFFIX] then '"YES"' else '"NO"' end,
			'"' + c.[SMS 1] + '"', '"' + d.[SMS 1] + '"' as [New SMS 1], case when c.[SMS 1] <> d.[SMS 1] then '"YES"' else '"NO"' end,
			'"' + c.[DATE OF BIRTH] + '"' , '"' + d.[DATE OF BIRTH] + '"' as [New DATE OF BIRTH], case when c.[DATE OF BIRTH] <> d.[DATE OF BIRTH] then '"YES"' else '"NO"' end,
			'"' + c.[L BIRTH PLACE] + '"', '"' + d.[L BIRTH PLACE] + '"' as [New L BIRTH PLACE], case when c.[L BIRTH PLACE] <> d.[L BIRTH PLACE] then '"YES"' else '"NO"' end,
			'"' + c.[NAME 1] + '"', '"' + d.[NAME 1] + '"' as [New NAME 1], case when c.[NAME 1] <> d.[NAME 1] then '"YES"' else '"NO"' end,
			'"' + c.[CUSTOMER STATUS] + '"', '"' + d.[CUSTOMER STATUS] + '"' as [New CUSTOMER STATUS], case when c.[CUSTOMER STATUS] <> d.[CUSTOMER STATUS] then '"YES"' else '"NO"' end,
			'"' + isnull(c.[ADDRESS1],'') + '::' + isnull(c.[ADDRESS2],'')  + '"', '"' + d.[ADDRESS] + '"' as [New ADDRESS], case when c.[ADDRESS1] + '::' + c.[ADDRESS2] <> d.[ADDRESS] then '"YES"' else '"NO"' end,
			'"' + c.[TOWN COUNTRY] + '"', '"' + d.[TOWN COUNTRY] + '"' as [New TOWN COUNTRY], case when c.[TOWN COUNTRY] <> d.[TOWN COUNTRY] then '"YES"' else '"NO"' end,
			'"' + c.[POST CODE] + '"', '"' + d.[POST CODE] + '"' as [New POST CODE], case when c.[POST CODE] <> d.[POST CODE] then '"YES"' else '"NO"' end,
			'"' + c.[L OCCUPATION] + '"', '"' + d.[L OCCUPATION] + '"' as [New L OCCUPATION], case when c.[L OCCUPATION] <> d.[L OCCUPATION] then '"YES"' else '"NO"' end,
			'"' + c.[L SOURCE FUNDS] + '"', '"' + d.[L SOURCE FUNDS] + '"' as [New L SOURCE FUNDS], case when c.[L SOURCE FUNDS] <> d.[L SOURCE FUNDS] then '"YES"' else '"NO"' end,
			'"' + c.[L CUSTOMER TYPE] + '"', '"' + d.[L CUSTOMER TYPE] + '"' as [New L CUSTOMER TYPE], case when c.[L CUSTOMER TYPE] <> d.[L CUSTOMER TYPE] then '"YES"' else '"NO"' end,
			'"' + c.[L OFAC CHECK] + '"', '"' + d.[L OFAC CHECK] + '"' as [New L OFAC CHECK], case when c.[L OFAC CHECK] <> d.[L OFAC CHECK] then '"YES"' else '"NO"' end,
			'"' + c.[TITLE] + '"', '"' + d.[TITLE] + '"' as [New TITLE], case when c.[TITLE] <> d.[TITLE] then '"YES"' else '"NO"' end,
			'"' + c.[COUNTRY] + '"', '"' + d.[COUNTRY] + '"' as [New COUNTRY], case when c.[COUNTRY] <> d.[COUNTRY] then '"YES"' else '"NO"' end,
			'"' + c.[TARGET] + '"', '"' + d.[TARGET] + '"' as [New TARGET], case when c.[TARGET] <> d.[TARGET] then '"YES"' else '"NO"' end,
			'"' + c.[LANGUAGE] + '"', '"' + d.[LANGUAGE] + '"' as [New LANGUAGE], case when c.[LANGUAGE] <> d.[LANGUAGE] then '"YES"' else '"NO"' end,
			'"' + c.[COMPANY BOOK] + '"', '"' + d.[COMPANY BOOK] + '"' as [New COMPANY BOOK], case when c.[COMPANY BOOK] <> d.[COMPANY BOOK] then '"YES"' else '"NO"' end,
			'"' + c.[CLS CPARTY] + '"', '"' + d.[CLS CPARTY] + '"' as [New CLS CPARTY], case when c.[CLS CPARTY] <> d.[CLS CPARTY] then '"YES"' else '"NO"' end,
			'"' + c.[GENDER] + '"', '"' + d.[GENDER] + '"' as [New GENDER], case when c.[GENDER] <> d.[GENDER] then '"YES"' else '"NO"' end,
			'"' + REPLACE(c.[EMAIL 1], '''','') + '"', '"' + d.[EMAIL 1] + '"' as [New EMAIL 1], case when c.[EMAIL 1] <> d.[EMAIL 1] then '"YES"' else '"NO"' end,
			'"' + c.[EMPLOYERS NAME] + '"', '"' + d.[EMPLOYERS NAME] + '"' as [New EMPLOYERS NAME], case when c.[EMPLOYERS NAME] <> d.[EMPLOYERS NAME] then '"YES"' else '"NO"' end,
			'"' + c.[AML CHECK] + '"', '"' + d.[AML CHECK] + '"' as [New AML CHECK], case when c.[AML CHECK] <> d.[AML CHECK] then '"YES"' else '"NO"' end,
			'"' + c.[AML RESULT] + '"', '"' + d.[AML RESULT] + '"' as [New AML RESULT], case when c.[AML RESULT] <> d.[AML RESULT] then '"YES"' else '"NO"' end,
			'"' + c.[INTERNET BANKING SERVICE] + '"', '"' + d.[INTERNET BANKING SERVICE] + '"' as [New INTERNET BANKING SERVICE], case when c.[INTERNET BANKING SERVICE] <> d.[INTERNET BANKING SERVICE] then '"YES"' else '"NO"' end,
			'"' + c.[MOBILE BANKING SERVICE] + '"', '"' + d.[MOBILE BANKING SERVICE] + '"' as [New MOBILE BANKING SERVICE], case when c.[MOBILE BANKING SERVICE] <> d.[MOBILE BANKING SERVICE] then '"YES"' else '"NO"' end,
			'"' + c.[EXTERN SYS ID] + '"', '"' + d.[EXTERN SYS ID] + '"' as [New EXTERN SYS ID], case when c.[EXTERN SYS ID] <> d.[EXTERN SYS ID] then '"YES"' else '"NO"' end,
			'"' + c.[EXTERN CUS ID] + '"', '"' + d.[EXTERN CUS ID] + '"' as [New EXTERN CUS ID], case when c.[EXTERN CUS ID] <> d.[EXTERN CUS ID] then '"YES"' else '"NO"' end,
			'"' + c.[L DOCU TYPE] + '"', '"' + d.[L DOCU TYPE] + '"' as [New L DOCU TYPE], case when c.[L DOCU TYPE] <> d.[L DOCU TYPE] then '"YES"' else '"NO"' end,
			'"' + c.[L LGL DOC NM 1] + '"', '"' + d.[L LGL DOC NM] + '"' as [New L LGL DOC NM], case when c.[L LGL DOC NM 1] <> d.[L LGL DOC NM] then '"YES"' else '"NO"' end,
			'"' + c.[L TIN GSS] + '"', '"' + d.[L TIN GSS] + '"' as [New L TIN GSS], case when c.[L TIN GSS] <> d.[L TIN GSS] then '"YES"' else '"NO"' end,
			'"' + c.[L LEGAL ID 1] + '"', '"' + d.[L LEGAL ID] + '"' as [New L LEGAL ID], case when c.[L LEGAL ID 1] <> d.[L LEGAL ID] then '"YES"' else '"NO"' end,
			'"' + c.[L PA ST] + '"', '"' + d.[L PA ST] + '"' as [New L PA ST], case when c.[L PA ST] <> d.[L PA ST] then '"YES"' else '"NO"' end,
			'"' + c.[L PA ADD] + '"', '"' + d.[L PA ADD] + '"' as [New L PA ADD], case when c.[L PA ADD] <> d.[L PA ADD] then '"YES"' else '"NO"' end,
			'"' + c.[L PA TC] + '"', '"' + d.[L PA TC] + '"' as [New L PA TC], case when c.[L PA TC] <> d.[L PA TC] then '"YES"' else '"NO"' end,
			'"' + c.[L PA PC] + '"', '"' + d.[L PA PC] + '"' as [New L PA PC], case when c.[L PA PC] <> d.[L PA PC] then '"YES"' else '"NO"' end,
			'"' + c.[L PA CTRY 1] + '"', '"' + d.[L PA CTRY] + '"' as [New L PA CTRY], case when c.[L PA CTRY 1] <> d.[L PA CTRY] then '"YES"' else '"NO"' end,
			'"' + c.[L SSS NO] + '"', '"' + d.[L SSS NO] + '"' as [New L SSS NO], case when c.[L SSS NO] <> d.[L SSS NO] then '"YES"' else '"NO"' end,
			'"' + c.[L INSTRUCTION] + '"', '"' + d.[L CUST INSTRUCT] + '"' as [New L CUST INSTRUCT], case when c.[L INSTRUCTION] <> d.[L CUST INSTRUCT] then '"YES"' else '"NO"' end,
			'""', '"' + d.[STREET] + '"' as [NEW STREET], case when '""' <> d.[STREET] then '"YES"' else '"NO"' end,
			'""', '"' + d.[L HLD MAIL FLAG] + '"' as [New L HLD MAIL FLAG], case when '""' <> d.[L HLD MAIL FLAG] then '"YES"' else '"NO"' end,
			-- ACCOUNT1 RECON
			'"' + acct1.[UPLOAD COMPANY] + '"',	'"' + act_dme.[UPLOAD COMPANY] + '"' as [NEW UPLOAD COMPANY], case when acct1.[UPLOAD COMPANY] <> act_dme.[UPLOAD COMPANY] then '"YES"' else '"NO"' end,
			'"''' + acct1.[ALT ACCT ID 1] + '"' as [ACCOUNT NUMBER],	'"''' + act_dme.[ACCOUNT NUMBER] + '"' as [NEW ACCOUNT NUMBER], case when acct1.[ALT ACCT ID 1] <> act_dme.[ACCOUNT NUMBER] then '"YES"' else '"NO"' end,
			'"' + acct1.[CATEGORY] + '"', '"' +	act_dme.[CATEGORY] + '"' as [NEW CATEGORY], case when acct1.[CATEGORY] <> act_dme.[CATEGORY] then '"YES"' else '"NO"' end,
			'"' + acct1.[ACCOUNT TITLE 1] + '"', '"' +	act_dme.[ACCOUNT TITLE 1] + '"' as [NEW ACCOUNT TITLE 1], case when acct1.[ACCOUNT TITLE 1] <> act_dme.[ACCOUNT TITLE 1] then '"YES"' else '"NO"' end,
			'"' + acct1.[SHORT TITLE] + '"', '"' +	act_dme.[SHORT TITLE] + '"' as [NEW SHORT TITLE], case when acct1.[SHORT TITLE] <> act_dme.[SHORT TITLE] then '"YES"' else '"NO"' end,
			'"' + acct1.[CURRENCY] + '"', '"' +	act_dme.[CURRENCY] + '"' as [NEW CURRENCY], case when acct1.[CURRENCY] <> act_dme.[CURRENCY] then '"YES"' else '"NO"' end,
			'"' + acct1.[ACCOUNT OFFICER] + '"', '"' +	act_dme.[ACCOUNT OFFICER] + '"' as [NEW ACCOUNT OFFICER], case when acct1.[ACCOUNT OFFICER] <> act_dme.[ACCOUNT OFFICER] then '"YES"' else '"NO"' end,
			'"' + acct1.[PASSBOOK] + '"', '"' +	act_dme.[PASSBOOK] + '"' as [NEW PASSBOOK], case when acct1.[PASSBOOK] <> act_dme.[PASSBOOK] then '"YES"' else '"NO"' end,
			'"' + acct1.[OPENING DATE] + '"', '"' +	act_dme.[OPENING DATE] + '"' as [NEW OPENING DATE], case when acct1.[OPENING DATE] <> act_dme.[OPENING DATE] then '"YES"' else '"NO"' end,
			'"''' + acct1.[ALT ACCT TYPE 1] + '"', '"''' +	act_dme.[ALT ACCT TYPE] + '"' as [NEW ALT ACCT TYPE], case when acct1.[ALT ACCT TYPE 1] <> act_dme.[ALT ACCT TYPE] then '"YES"' else '"NO"' end,
			'"' + acct1.[ALLOW NETTING] + '"', '"' + act_dme.[ALLOW NETTING] + '"' as [NEW ALLOW NETTING], case when acct1.[ALLOW NETTING] <> act_dme.[ALLOW NETTING] then '"YES"' else '"NO"' end,
			'"' + acct1.[HVT FLAG] + '"',	'"' + act_dme.[HVT FLAG] + '"' as [NEW HVT FLAG], case when acct1.[HVT FLAG] <> act_dme.[HVT FLAG] then '"YES"' else '"NO"' end,
			-- ACCOUNT2 RECON
			'"' + acct_im.[INACTIV_MARKER] + '"', '"' + acct_im_dme.[INACTIV_MARKER] + '"', case when acct_im.[INACTIV_MARKER] <> acct_im_dme.[INACTIV_MARKER] then '"YES"' else '"NO"' end,
			'"' + isnull(acct2.[DATE_LAST_CR_CUST],'') + '"', '"' + isnull(acct2_dme.[DATE_LAST_CR_CUST],'') + '"', case when acct2.[DATE_LAST_CR_CUST] <> acct2_dme.[DATE_LAST_CR_CUST] then '"YES"' else '"NO"' end,
			'"' + isnull(acct2.[DATE_LAST_DR_CUST], '') + '"', '"' + isnull(acct2_dme.[DATE_LAST_DR_CUST], '') + '"', case when acct2.[DATE_LAST_DR_CUST] <> acct2_dme.[DATE_LAST_DR_CUST] then '"YES"' else '"NO"' end,
			-- ACCOUNT3 RECON
			'"' + acct3.[POSTING_RESTRICT] + '"', '"' +  acct3_dme.[POSTING_RESTRICT] + '"', case when acct3.[POSTING_RESTRICT] <> acct3_dme.[POSTING_RESTRICT] then '"YES"' else '"NO"' end,	
			--CUSTOMER 2 RECON
			'"' + cust2.[POSTING RESTRICT] + '"', '"' + cust2_dme.[POSTING RESTRICT] + '"', case when cust2.[POSTING RESTRICT] <> cust2_dme.[POSTING RESTRICT] then '"YES"' else '"NO"' end,
			--CUSTOMER 3 RECON
			--'"' + cust3.ONBOARDING_DATE + '"', '"' + cust2_dme.[CUSTOMER SINCE] + '"', case when cust3.ONBOARDING_DATE <> cust2_dme.[CUSTOMER SINCE] then '"YES"' else '"NO"' end,
			-- ACCOUNT BALANCE RECON
			'"' + isnull(cast(cast( acctbal.[WORKING_BALANCE] as numeric(19,2)) as varchar), '0.00') + '"', '"' + isnull(cast(cast(acctbal_dme.[AMOUNT LCY] as numeric(19,2)) as varchar), '0.00') + '"', case when isnull(cast(cast( acctbal.[WORKING_BALANCE] as numeric(19,2)) as varchar), '0.00') <> isnull(cast(cast( acctbal_dme.[AMOUNT LCY] as numeric(19,2)) as varchar),'0.00') then '"YES"' else '"NO"' end
	from	CUSTOMER c	with(nolock)
	inner	join	CUSTOMER_DME d	with(nolock)
	on		c.[EXTERN CUS ID]	=	d.[EXTERN CUS ID]
	left	outer	join	ACCOUNT1	acct1	with(nolock)
	on		acct1.CUSTOMER	=	c.[EXTERN CUS ID]
	left	outer	join	ACCOUNTS_DME	act_dme	with(nolock)
	on		act_dme.[ALT ACCT ID]	=	acct1.[ALT ACCT ID 1]
	left	outer	join	ACCOUNT2	acct2	with(nolock)
	on		acct2.ID	=	acct1.[ALT ACCT ID 1]
	left	outer	join	ACCOUNT2_DME	acct2_dme	with(nolock)
	on		acct2_dme.ID	=	act_dme.[ACCOUNT NUMBER]
	left	outer	join	ACCOUNT3	acct3	with(nolock)
	on		acct3.ID	=	acct1.[ALT ACCT ID 1]
	left	outer	join	ACCOUNT3_DME	acct3_dme	with(nolock)
	on		acct3_dme.ID	=	act_dme.[ACCOUNT NUMBER]
	left	outer	join	CUSTOMER_2	cust2	with(nolock)
	on		cust2.ID	=	c.[EXTERN CUS ID]
	left	outer	join	CUSTOMER_2_DME	cust2_dme	with(nolock)
	on		cust2_dme.ID	=	d.ID
	left	outer	join	ACCT_BALANCE	acctbal	with(nolock)
	on		acctbal.ID	=	acct1.[ALT ACCT ID 1]
	left	outer	join	ACCT_BALANCE_DME	acctbal_dme	with(nolock)
	on		acctbal_dme.[ACCOUNT NUMBER]	=	act_dme.[ACCOUNT NUMBER]
	--left	outer	join	CUSTOMER_3	cust3	with(nolock)
	--on		cust3.R18_CUSTOMER_ID	=	c.[EXTERN CUS ID]
	left	outer	join	ACCOUNT_IM	acct_im	with(nolock)
	on		acct_im.ID	=	acct1.[ALT ACCT ID 1]
	left	outer	join	ACCOUNT_IM_DME	acct_im_dme	with(nolock)
	on		acct_im_dme.ID	=	act_dme.[ACCOUNT NUMBER]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateR12CustomerAccountSummaryReport]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================
-- Created By : JBacorro
-- Created Date : 23/04/2024
-- sp_CreateR12CustomerAccountSummaryReport
-- Create csv file that contains the summary
-- of Customer and Account Uploaded in R12
--===========================================
CREATE PROCEDURE [dbo].[sp_CreateR12CustomerAccountSummaryReport]
AS
BEGIN
		--HEADER
		SELECT
					'"ID"', 
					'"MNEMONIC"', 
					'"SHORT NAME"', 
					'"ACCOUNT OFFICER"', 
					'"NATIONALITY"', 
					'"RESIDENCE"',
					'"SECTOR"', 
					'"INDUSTRY"',
					'"GIVEN NAMES"',
					'"L MIDDLE NAME"', 
					'FAMILY NAME"', 
					'"L SUFFIX"', 
					'"SMS 1"', 
					'"DATE OF BIRTH"', 
					'"L BIRTH PLACE"', 
					'"NAME 1"', 
					'"CUSTOMER STATUS"', 
					'"ADDRESS"',
					'"TOWN COUNTRY"', 
					'"POST CODE"',
					'"L OCCUPATION"', 
					'"L SOURCE FUNDS"',
					'"L CUSTOMER TYPE"',
					'"L OFAC CHECK"',
					'"TITLE"', 
					'"COUNTRY"',
					'"TARGET"', 
					'"LANGUAGE"',
					'"COMPANY BOOK"', 
					'"CLS CPARTY"', 
					'"GENDER"', 
					'"EMAIL 1"',
					'"EMPLOYERS NAME"',
					'"AML CHECK"', 
					'"AML RESULT"',
					'"INTERNET BANKING SERVICE"', 
					'"MOBILE BANKING SERVICE"', 
					'"EXTERN SYS ID"', 
					'"EXTERN CUS ID"', 
					'"L DOCU TYPE"', 
					'"L LGL DOC NM 1"', 
					'"L TIN GSS"', 
					'"L LEGAL ID 1"', 
					'"L PA ST"', 
					'"L PA ADD"',
					'"L PA TC"', 
					'"L PA PC"',
					'"L PA CTRY 1"', 
					'"L SSS NO"',
					'"L INSTRUCTION"',
					'"STREET"',
					'"L HLD MAIL FLAG"',
					'"POSTING RESTRICT"',
					'"INPUTTER"',
					'"DATE TIME"',
					'"UPLOAD COMPANY"',
					'"ACCOUNT NUMBER"', 
					'"CUSTOMER"', 
					'"CATEGORY"', 
					'"ACCOUNT TITLE 1"', 
					'"SHORT TITLE"', 
					'"CURRENCY"', 
					'"ACCOUNT OFFICER"', 
					'"POSTING RESTRICT"',
					'"PASSBOOK"', 
					'"OPENING DATE"', 
					'"ALT ACCT TYPE"',
					'"ALT ACCT ID"',
					'"ALLOW NETTING"', 
					'"HVT FLAG"', 
					'"INACTIV MARKER"',
					'"DATE LAST CR CUST"',
					'"DATE LAST DR CUST"',
					'"ONLINE ACTUAL BAL"',
					'"ONLINE CLEARED BAL"',
					'"WORKINGB BALANCE"',
					'"INPUTTER"',
					'"DATE TIME"'
		UNION ALL
		SELECT
			'"' + cust.[ID] + '"'
			,'"' + cust.[MNEMONIC] + '"'
			,'"' + cust.[SHORT NAME] + '"'
			,'"' + cust.[ACCOUNT OFFICER] + '"'
			,'"' + cust.[NATIONALITY] + '"'
			,'"' + cust.[RESIDENCE] + '"'
			,'"' + cust.[SECTOR] + '"'
			,'"' + cust.[INDUSTRY] + '"'
			,'"' + cust.[GIVEN NAMES] + '"'
			,'"' + cust.[L MIDDLE NAME] + '"'
			,'"' + cust.[FAMILY NAME] + '"'
			,'"' + cust.[L SUFFIX] + '"'
			,'"' + cust.[SMS 1] + '"'
			,'"' + cust.[DATE OF BIRTH] + '"'
			,'"' + cust.[L BIRTH PLACE] + '"'
			,'"' + cust.[NAME 1] + '"'
			,'"' + cust.[CUSTOMER STATUS] + '"'
			,'"' + cust.[ADDRESS] + '"'
			,'"' + cust.[TOWN COUNTRY] + '"'
			,'"' + cust.[POST CODE] + '"'
			,'"' + cust.[L OCCUPATION] + '"'
			,'"' + cust.[L SOURCE FUNDS] + '"'
			,'"' + cust.[L CUSTOMER TYPE] + '"'
			,'"' + cust.[L OFAC CHECK] + '"'
			,'"' + cust.[TITLE] + '"'
			,'"' + cust.[COUNTRY] + '"'
			,'"' + cust.[TARGET] + '"'
			,'"' + cust.[LANGUAGE] + '"'
			,'"' + cust.[COMPANY BOOK] + '"'
			,'"' + cust.[CLS CPARTY] + '"'
			,'"' + cust.[GENDER] + '"'
			,'"' + cust.[EMAIL 1] + '"'
			,'"' + cust.[EMPLOYERS NAME] + '"'
			,'"' + cust.[AML CHECK] + '"'
			,'"' + cust.[AML RESULT] + '"'
			,'"' + cust.[INTERNET BANKING SERVICE] + '"'
			,'"' + cust.[MOBILE BANKING SERVICE] + '"'
			,'"' + cust.[EXTERN SYS ID] + '"'
			,'"' + cust.[EXTERN CUS ID] + '"'
			,'"' + cust.[L DOCU TYPE] + '"'
			,'"' + cust.[L LGL DOC NM 1] + '"'
			,'"' + cust.[L TIN GSS] + '"'
			,'"' + cust.[L LEGAL ID 1] + '"'
			,'"' + cust.[L PA ST] + '"'
			,'"' + cust.[L PA ADD] + '"'
			,'"' + cust.[L PA TC] + '"'
			,'"' + cust.[L PA PC] + '"'
			,'"' + cust.[L PA CTRY 1] + '"'
			,'"' + cust.[L SSS NO] + '"'
			,'"' + cust.[L INSTRUCTION] + '"'
			,'"' + cust.[STREET] + '"'
			,'"' + cust.[L HLD MAIL FLAG] + '"'
			,'"' + cust.[POSTING RESTRICT] + '"'
			,'"' + cust.[INPUTTER] + '"'
			,'"' + cust.[DATE TIME] + '"'
			,'"' + acct.[UPLOAD COMPANY] + '"'
			,'"' + acct.[ACCOUNT NUMBER] + '"'
			,'"' + acct.[CUSTOMER] + '"'
			,'"' + acct.[CATEGORY] + '"'
			,'"' + acct.[ACCOUNT TITLE 1] + '"'
			,'"' + acct.[SHORT TITLE] + '"'
			,'"' + acct.[CURRENCY] + '"'
			,'"' + acct.[ACCOUNT OFFICER] + '"'
			,'"' + acct.[POSTING RESTRICT] + '"'
			,'"' + acct.[PASSBOOK] + '"'
			,'"' + acct.[OPENING DATE] + '"'
			,'"' + acct.[ALT ACCT TYPE] + '"'
			,'"' + acct.[ALT ACCT ID] + '"'
			,'"' + acct.[ALLOW NETTING] + '"'
			,'"' + acct.[HVT FLAG] + '"'
			,'"' + acct.[INACTIV MARKER] + '"'
			,'"' + acct.[DATE LAST CR CUST] + '"'
			,'"' + acct.[DATE LAST DR CUST] + '"'
			,'"' + acct.[ONLINE ACTUAL BAL] + '"'
			,'"' + acct.[ONLINE CLEARED BAL] + '"'
			,'"' + acct.[WORKING BALANCE] + '"'
			,'"' + acct.[INPUTTER] + '"'
			,'"' + acct.[DATE TIME] + '"'
		FROM CUSTOMERSUMMARY cust
			INNER JOIN ACCOUNTSUMMARY acct
				ON cust.ID = acct.CUSTOMER
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DbMigrationRun]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============================================
-- Created By : JBacorro
-- Created Date : 05/04/2024
-- sp_RunDbMigration
-- Initial sp for Account (R18) linking to Pre
-- Generated accounts in R12
--===========================================
CREATE PROCEDURE [dbo].[sp_DbMigrationRun]
AS
BEGIN
	DECLARE @forRerun bit
	IF EXISTS (SELECT TOP 1 * FROM R12_DME_PRE_GEN WHERE OLD_ACCT_ID IS NOT NULL)
		BEGIN
			SET @forRerun = 1
		END
	ELSE
		BEGIN
			SET @forRerun = 0
		END

	IF(@forRerun = 1)
		BEGIN
			EXEC sp_RunDbMigrationReUpload
		END
	ELSE
		BEGIN
			EXEC sp_RunDbMigration
		END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_generate_CUSTOMER_Mstr_File]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_generate_CUSTOMER_Mstr_File]
as
begin

	DECLARE @id BIGINT 

	SET @id = (select cust_id_ctr from tbl_cust_ctr nolock)

	update	CUSTOMER
		set	[ID]=REPLACE([ID], '"', ''),
		[MNEMONIC]=REPLACE([MNEMONIC], '"', ''),
		[SHORT NAME]=REPLACE([SHORT NAME], '"', ''),
		[ACCOUNT OFFICER]=REPLACE([ACCOUNT OFFICER], '"', ''),
		[NATIONALITY]=REPLACE([NATIONALITY], '"', ''),
		[RESIDENCE]=REPLACE([RESIDENCE], '"', ''),
		[SECTOR]=REPLACE([SECTOR], '"', ''),
		[INDUSTRY]=REPLACE([INDUSTRY], '"', ''),
		[GIVEN NAMES]=REPLACE([GIVEN NAMES], '"', ''),
		[L MIDDLE NAME]=REPLACE([L MIDDLE NAME], '"', ''),
		[FAMILY NAME]=REPLACE([FAMILY NAME], '"', ''),
		[L SUFFIX]=REPLACE([L SUFFIX], '"', ''),
		[SMS 1]=REPLACE([SMS 1], '"', ''),
		[DATE OF BIRTH]=REPLACE([DATE OF BIRTH], '"', ''),
		[L BIRTH PLACE]=REPLACE([L BIRTH PLACE], '"', ''),
		[NAME 1]=REPLACE([NAME 1], '"', ''),
		[CUSTOMER STATUS]=REPLACE([CUSTOMER STATUS], '"', ''),
		[ADDRESS1]=REPLACE([ADDRESS1], '"', ''),
		[ADDRESS2]=REPLACE([ADDRESS2], '"', ''),
		[TOWN COUNTRY]=REPLACE([TOWN COUNTRY], '"', ''),
		[POST CODE]=REPLACE([POST CODE], '"', ''),
		[L OCCUPATION]=REPLACE([L OCCUPATION], '"', ''),
		[L SOURCE FUNDS]=REPLACE([L SOURCE FUNDS], '"', ''),
		[L CUSTOMER TYPE]=REPLACE([L CUSTOMER TYPE], '"', ''),
		[L OFAC CHECK]=REPLACE([L OFAC CHECK], '"', ''),
		[TITLE]=REPLACE([TITLE], '"', ''),
		[COUNTRY]=REPLACE([COUNTRY], '"', ''),
		[TARGET]=REPLACE([TARGET], '"', ''),
		[LANGUAGE]=REPLACE([LANGUAGE], '"', ''),
		[COMPANY BOOK]=REPLACE([COMPANY BOOK], '"', ''),
		[CLS CPARTY]=REPLACE([CLS CPARTY], '"', ''),
		[GENDER]=REPLACE([GENDER], '"', ''),
		[EMAIL 1]=REPLACE([EMAIL 1], '"', ''),
		[EMPLOYERS NAME]=REPLACE([EMPLOYERS NAME], '"', ''),
		[AML CHECK]=REPLACE([AML CHECK], '"', ''),
		[AML RESULT]=REPLACE([AML RESULT], '"', ''),
		[INTERNET BANKING SERVICE]=REPLACE([INTERNET BANKING SERVICE], '"', ''),
		[MOBILE BANKING SERVICE]=REPLACE([MOBILE BANKING SERVICE], '"', ''),
		[EXTERN SYS ID]=REPLACE([EXTERN SYS ID], '"', ''),
		[EXTERN CUS ID]=REPLACE([EXTERN CUS ID], '"', ''),
		[L DOCU TYPE]=REPLACE([L DOCU TYPE], '"', ''),
		[L LGL DOC NM 1]=REPLACE([L LGL DOC NM 1], '"', ''),
		[L TIN GSS]=REPLACE([L TIN GSS], '"', ''),
		[L LEGAL ID 1]=REPLACE([L LEGAL ID 1], '"', ''),
		[L PA ST]=REPLACE([L PA ST], '"', ''),
		[L PA ADD]=REPLACE([L PA ADD], '"', ''),
		[L PA TC]=REPLACE([L PA TC], '"', ''),
		[L PA PC]=REPLACE([L PA PC], '"', ''),
		[L PA CTRY 1]=REPLACE([L PA CTRY 1], '"', ''),
		[L SSS NO]=REPLACE([L SSS NO], '"', ''),
		[L INSTRUCTION]=REPLACE([L INSTRUCTION], '"', '')

	UPDATE CUSTOMER 
	SET @id = cust_id = @id + 1
	where isnull(CUST_ID, '') = ''
	AND	isnull([EXTERN CUS ID], '') <> ''

	update	tbl_cust_ctr
	set		cust_id_ctr = (select max(cust_id) from Customer where isnull([EXTERN CUS ID], '') <> '')	

	insert	into	CUSTOMER_TRANSFORMED
	select	convert( varchar,isnull([CUST_ID],'')) [ID],
			isnull([MNEMONIC],''),
			shortname = dbo.fnGetName(isnull([L SUFFIX],''), isnull([FAMILY NAME],''), isnull([GIVEN NAMES],''), isnull([L MIDDLE NAME], '')), 
			'801' [Account Officer],
			isnull([NATIONALITY],''),
			isnull([RESIDENCE],''),
			isnull([SECTOR],''),
			isnull([INDUSTRY],''),
			isnull([GIVEN NAMES] ,''), -- 9
			isnull([L MIDDLE NAME],''),
			isnull([FAMILY NAME], ''),
			isnull([L SUFFIX], '') [L SUFFIX] , 
			isnull([SMS 1],''), --13
			isnull([DATE OF BIRTH],''),
			isnull([L BIRTH PLACE], ''), 
			name1 = dbo.fnGetName(isnull([L SUFFIX], ''), isnull([FAMILY NAME], ''), isnull([GIVEN NAMES], ''), isnull([L MIDDLE NAME], '')),
			isnull([CUSTOMER STATUS], ''), -- 17
			isnull([ADDRESS1],'') + '::' + isnull([ADDRESS2], ''),
			isnull([TOWN COUNTRY], ''),
			isnull([POST CODE],''), 
			isnull(o.[Occupation_R12], isnull([L OCCUPATION], '')), -- 21
			isnull([L SOURCE FUNDS],''),
			isnull([L CUSTOMER TYPE],''),
			isnull([L OFAC CHECK],''),
			isnull([TITLE], '') [TITLE], -- 25
			isnull([COUNTRY],''),
			isnull([TARGET], ''),
			isnull([LANGUAGE],''),
			'PH0010101',
			isnull([CLS CPARTY],''), -- 30
			isnull([GENDER],''),
			replace(isnull([EMAIL 1],''), '_', '''_'''),
			isnull([EMPLOYERS NAME], ''),
			isnull([AML CHECK] ,''), --34 
			isnull([AML RESULT],''),
			isnull([INTERNET BANKING SERVICE],''),
			isnull([MOBILE BANKING SERVICE],''), -- 37
			isnull([EXTERN SYS ID],''),
			isnull([EXTERN CUS ID],''),
			isnull([L DOCU TYPE],''),
			isnull([L LGL DOC NM 1],''), -- 41
			isnull([L TIN GSS], ''),
			isnull([L LEGAL ID 1],''),
			isnull([L PA ST], ''),
			isnull([L PA ADD], ''),
			isnull([L PA TC], ''), -- 46 
			case when isnull([L PA PC],'') = '1417' then '' when isnull([L PA PC],'') = '0' then '' when isnull([L PA PC],'') = '0000' then '' when isnull([L PA PC],'') = '4135'  then '' else isnull([L PA PC],'') end,	-- 47
			isnull([L PA CTRY 1],''), 
			isnull([L SSS NO], ''), 
			isnull([L INSTRUCTION],'') ,
			isnull([ADDRESS1], '') , 
			'Hold' [L HLD MAIL FLAG], 
			GETDATE() -- 53
	from	Customer c	with(nolock)
	left	outer	join	tbl_Occupation o with(nolock)
 	on		c.[L OCCUPATION]	=	o.Occupation_R18
	where	isnull([EXTERN CUS ID], '') <> ''

	select	(convert( varchar,isnull([CUST_ID], '')) + '|' + isnull([MNEMONIC],'') + '|' + 
			dbo.fnGetName(isnull([L SUFFIX],''), isnull([FAMILY NAME], ''), isnull([GIVEN NAMES], ''), isnull([L MIDDLE NAME], '')) + '|' +  '801' + '|' 
			+ isnull([NATIONALITY],'') + '|' + isnull([RESIDENCE],'') + '|' + isnull([SECTOR], '') + '|' + isnull([INDUSTRY],'') + '|' + isnull([GIVEN NAMES], '') 
			+ '|' + isnull([L MIDDLE NAME],'') + '|' + isnull([FAMILY NAME],'') + '|' + isnull([L SUFFIX],'') + '|' +  isnull([SMS 1] ,'')+ '|' 
			+ isnull([DATE OF BIRTH],'')+ '|' + isnull([L BIRTH PLACE],'') + '|' + dbo.fnGetName(isnull([L SUFFIX], ''), isnull([FAMILY NAME],'') , isnull([GIVEN NAMES],'') , isnull([L MIDDLE NAME],''))  + '|' + isnull([CUSTOMER STATUS],'') + '|' 
			+ isnull([ADDRESS1],'') + '::' + isnull([ADDRESS2],'') + '|' + isnull([TOWN COUNTRY],'') + '|' + isnull([POST CODE],'') + '|' + isnull(o.[Occupation_R12], isnull([L OCCUPATION], ''))
			+ '|' + isnull([L SOURCE FUNDS],'') + '|' + isnull([L CUSTOMER TYPE],'') + '|' + isnull([L OFAC CHECK],'') + '|' + isnull([TITLE], '') + '|' 
			+ isnull([COUNTRY],'') + '|' + isnull([TARGET],'') + '|' + isnull([LANGUAGE],'') + '|' + 'PH0010101' + '|' + isnull([CLS CPARTY],'') + '|' 
			+ isnull([GENDER],'') + '|' + replace(isnull([EMAIL 1], '') , '_', '''_''') + '|' + isnull([EMPLOYERS NAME],'') + '|' + isnull([AML CHECK],'') 
			+ '|' + isnull([AML RESULT], '') + '|' + isnull([INTERNET BANKING SERVICE], '')  + '|' + isnull([MOBILE BANKING SERVICE], '')  + '|' 
			+ isnull([EXTERN SYS ID],'') + '|' + isnull([EXTERN CUS ID],'') + '|' + isnull([L DOCU TYPE],'') + '|' + isnull([L LGL DOC NM 1],'') + '|' 
			+  isnull([L TIN GSS], '') + '|' + isnull([L LEGAL ID 1],'') + '|' + isnull([L PA ST],'') + '|' + isnull([L PA ADD],'') + '|' + isnull([L PA TC],'')
			+ '|' + case when isnull([L PA PC],'') = '1417' then '' when isnull([L PA PC],'') = '0' then '' when isnull([L PA PC],'') = '0000' then '' when isnull([L PA PC],'') = '4135'  then '' else isnull([L PA PC],'') end 
			+ '|' + isnull([L PA CTRY 1],'') + '|' + isnull([L SSS NO],'') + '|' +  isnull(CAST( [L INSTRUCTION] as VARCHAR (MAX)),'') + '|' + isnull([ADDRESS1],'') + '|Hold') as CUSTOMER_DATA
	from	Customer c	with(nolock)
	left	outer	join	tbl_Occupation o with(nolock)
 	on		c.[L OCCUPATION]	=	o.Occupation_R18
	where	isnull([EXTERN CUS ID], '') <> ''

end

GO
/****** Object:  StoredProcedure [dbo].[sp_generate_CUSTOMER2]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE	procedure	[dbo].[sp_generate_CUSTOMER2]
as
begin
	
	INSERT INTO CUSTOMER_2_TRANSFORMED
	select	isnull(cast(a.ID as Varchar), ''), isnull(b.[POSTING RESTRICT], ''), isnull(c.[ONBOARDING_DATE], ''), GETDATE()
	from	CUSTOMER_2 b	with(nolock)
	inner	join	CUSTOMER_DME a	with(nolock)
	on		b.ID	=	a.[EXTERN CUS ID]
	left	outer	join	CUSTOMER_3 c	with(nolock)
	on		c.[R18_CUSTOMER_ID]	=	a.[EXTERN CUS ID]

	select	isnull(cast(a.ID as Varchar), '') + '|' + isnull(b.[POSTING RESTRICT], '')  + '|' +  isnull(c.[ONBOARDING_DATE], '') as Customer2_DATA
	from	CUSTOMER_2 b	with(nolock)
	inner	join	CUSTOMER_DME a	with(nolock)
	on		b.ID	=	a.[EXTERN CUS ID]
	left	outer	join	CUSTOMER_3 c	with(nolock)
	on		c.[R18_CUSTOMER_ID]	=	a.[EXTERN CUS ID]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_compare_report]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE	procedure	[dbo].[sp_get_compare_report]
(
	@rep_type	int
)
as
		if	@rep_type	=	1 -- COMPARE_CUSTOMER_RAW_TRANSFORMED_
		begin
			select	'"ID"', '"Transformed ID"',
					'"MNEMONIC"', '"Transformed MNEMONIC"',
					'"SHORT NAME"', '"Transformed SHORT NAME"',
					'"ACCOUNT OFFICER"', '"Transformed ACCOUNT OFFICER"',
					'"NATIONALITY"', '"Transformed NATIONALITY"',
					'"RESIDENCE"', '"Transformed RESIDENCE"',
					'"SECTOR"', '"Transformed SECTOR"',
					'"INDUSTRY"', '"Transformed INDUSTRY"',
					'"GIVEN NAMES"', '"Transformed GIVEN NAMES"',
					'"L MIDDLE NAME"', '"Transformed L MIDDLE NAME"',
					'FAMILY NAME"', '"Transformed FAMILY NAME"',
					'"L SUFFIX"', '"Transformed L SUFFIX"',
					'"SMS 1"', '"Transformed SMS 1"',
					'"DATE OF BIRTH"', '"Transformed DATE OF BIRTH"',
					'"L BIRTH PLACE"', '"Transformed L BIRTH PLACE"',
					'"NAME 1"', '"Transformed NAME 1"',
					'"CUSTOMER STATUS"', '"Transformed CUSTOMER STATUS"',
					'"ADDRESS1"', '"ADDRESS2"', '"Transformed ADDRESS"',
					'"TOWN COUNTRY"', '"Transformed TOWN COUNTRY"',
					'"POST CODE"', '"Transformed POST CODE"',
					'"L OCCUPATION"', '"Transformed L OCCUPATION"',
					'"L SOURCE FUNDS"', '"Transformed L SOURCE FUNDS"',
					'"L CUSTOMER TYPE"', '"Transformed L CUSTOMER TYPE"',
					'"L OFAC CHECK"', '"Transformed L OFAC CHECK"',
					'"TITLE"', '"Transformed TITLE"',
					'"COUNTRY"', '"Transformed COUNTRY"',
					'"TARGET"', '"Transformed TARGET"',
					'"LANGUAGE"', '"Transformed LANGUAGE"',
					'"COMPANY BOOK"', '"Transformed COMPANY BOOK"',
					'"CLS CPARTY"', '"Transformed CLS CPARTY"',
					'"GENDER"', '"Transformed GENDER"',
					'"EMAIL 1"', '"Transformed EMAIL 1"',
					'"EMPLOYERS NAME"', '"Transformed EMPLOYERS NAME"',
					'"AML CHECK"', '"Transformed AML CHECK"',
					'"AML RESULT"', '"Transformed AML RESULT"',
					'"INTERNET BANKING SERVICE"', '"Transformed INTERNET BANKING SERVICE"',
					'"MOBILE BANKING SERVICE"', '"Transformed MOBILE BANKING SERVICE"',
					'"EXTERN SYS ID"', '"Transformed EXTERN SYS ID"',
					'"EXTERN CUS ID"', '"Transformed EXTERN CUS ID"',
					'"L DOCU TYPE"', '"Transformed L DOCU TYPE"',
					'"L LGL DOC NM 1"', '"Transformed L LGL DOC NM"',
					'"L TIN GSS"', '"Transformed L TIN GSS"',
					'"L LEGAL ID 1"', '"Transformed L LEGAL ID"',
					'"L PA ST"', '"Transformed L PA ST"',
					'"L PA ADD"', '"Transformed L PA ADD"',
					'"L PA TC"', '"Transformed L PA TC"',
					'"L PA PC"', '"Transformed L PA PC"',
					'"L PA CTRY 1"', '"Transformed L PA CTRY"',
					'"L SSS NO"', '"Transformed L SSS NO"',
					'"L INSTRUCTION"', '"Transformed L CUST INSTRUCT"',
					'"STREET"', '"NEW STREET"',
					'"L HLD MAIL FLAG"', '"Transformed L HLD MAIL FLAG"'
			union	all
			select
					'"' + c.[ID] + '"', '"' + d.[ID] + '"' as [New ID],
					'"' + c.[MNEMONIC] + '"', '"' + d.[MNEMONIC] + '"' as [New MNEMONIC],
					'"' + c.[SHORT NAME] + '"', '"' + d.[SHORT NAME] + '"' as [New SHORT NAME],
					'"' + c.[ACCOUNT OFFICER] + '"', '"' + d.[ACCOUNT OFFICER] + '"' as [New ACCOUNT OFFICER],
					'"' + c.[NATIONALITY] + '"', '"' + d.[NATIONALITY] + '"' as [New NATIONALITY],
					'"' + c.[RESIDENCE] + '"', '"' + d.[RESIDENCE] + '"' as [New RESIDENCE],
					'"' + c.[SECTOR] + '"', '"' + d.[SECTOR] + '"' as [New SECTOR],
					'"' + c.[INDUSTRY] + '"', '"' + d.[INDUSTRY] + '"' as [New INDUSTRY],
					'"' + c.[GIVEN NAMES] + '"', '"' + d.[GIVEN NAMES] + '"' as [New GIVEN NAMES],
					'"' + c.[L MIDDLE NAME] + '"', '"' + d.[L MIDDLE NAME] + '"' as [New L MIDDLE NAME],
					'"' + c.[FAMILY NAME] + '"', '"' + d.[FAMILY NAME] + '"' as [New FAMILY NAME],
					'"' + c.[L SUFFIX] + '"', '"' + d.[L SUFFIX] + '"' as [New L SUFFIX],
					'"' + c.[SMS 1] + '"', '"' + d.[SMS 1] + '"' as [New SMS 1],
					'"' + c.[DATE OF BIRTH] + '"' , '"' + d.[DATE OF BIRTH] + '"' as [New DATE OF BIRTH],
					'"' + c.[L BIRTH PLACE] + '"', '"' + d.[L BIRTH PLACE] + '"' as [New L BIRTH PLACE],
					'"' + c.[NAME 1] + '"', '"' + d.[NAME 1] + '"' as [New NAME 1],
					'"' + c.[CUSTOMER STATUS] + '"', '"' + d.[CUSTOMER STATUS] + '"' as [New CUSTOMER STATUS],
					'"' + c.[ADDRESS1] + '"', '"' + c.[ADDRESS2], '"' + d.[ADDRESS] + '::' + '"' + c.[ADDRESS2] + '"' as [New ADDRESS],
					'"' + c.[TOWN COUNTRY] + '"', '"' + d.[TOWN COUNTRY] + '"' as [New TOWN COUNTRY],
					'"' + c.[POST CODE] + '"', '"' + d.[POST CODE] + '"' as [New POST CODE],
					'"' + c.[L OCCUPATION] + '"', '"' + d.[L OCCUPATION] + '"' as [New L OCCUPATION],
					'"' + c.[L SOURCE FUNDS] + '"', '"' + d.[L SOURCE FUNDS] + '"' as [New L SOURCE FUNDS],
					'"' + c.[L CUSTOMER TYPE] + '"', '"' + d.[L CUSTOMER TYPE] + '"' as [New L CUSTOMER TYPE],
					'"' + c.[L OFAC CHECK] + '"', '"' + d.[L OFAC CHECK] + '"' as [New L OFAC CHECK],
					'"' + c.[TITLE] + '"', '"' + d.[TITLE] + '"' as [New TITLE],
					'"' + c.[COUNTRY] + '"', '"' + d.[COUNTRY] + '"' as [New COUNTRY],
					'"' + c.[TARGET] + '"', '"' + d.[TARGET] + '"' as [New TARGET],
					'"' + c.[LANGUAGE] + '"', '"' + d.[LANGUAGE] + '"' as [New LANGUAGE],
					'"' + c.[COMPANY BOOK] + '"', '"' + d.[COMPANY BOOK] + '"' as [New COMPANY BOOK],
					'"' + c.[CLS CPARTY] + '"', '"' + d.[CLS CPARTY] + '"' as [New CLS CPARTY],
					'"' + c.[GENDER] + '"', '"' + d.[GENDER] + '"' as [New GENDER],
					'"' + REPLACE(c.[EMAIL 1], '''','') + '"', '"' + d.[EMAIL 1] + '"' as [New EMAIL 1],
					'"' + c.[EMPLOYERS NAME] + '"', '"' + d.[EMPLOYERS NAME] + '"' as [New EMPLOYERS NAME],
					'"' + c.[AML CHECK] + '"', '"' + d.[AML CHECK] + '"' as [New AML CHECK],
					'"' + c.[AML RESULT] + '"', '"' + d.[AML RESULT] + '"' as [New AML RESULT],
					'"' + c.[INTERNET BANKING SERVICE] + '"', '"' + d.[INTERNET BANKING SERVICE] + '"' as [New INTERNET BANKING SERVICE],
					'"' + c.[MOBILE BANKING SERVICE] + '"', '"' + d.[MOBILE BANKING SERVICE] + '"' as [New MOBILE BANKING SERVICE],
					'"' + c.[EXTERN SYS ID] + '"', '"' + d.[EXTERN SYS ID] + '"' as [New EXTERN SYS ID],
					'"' + c.[EXTERN CUS ID] + '"', '"' + d.[EXTERN CUS ID] + '"' as [New EXTERN CUS ID],
					'"' + c.[L DOCU TYPE] + '"', '"' + d.[L DOCU TYPE] + '"' as [New L DOCU TYPE],
					'"' + c.[L LGL DOC NM 1] + '"', '"' + d.[L LGL DOC NM] + '"' as [New L LGL DOC NM],
					'"' + c.[L TIN GSS] + '"', '"' + d.[L TIN GSS] + '"' as [New L TIN GSS],
					'"' + c.[L LEGAL ID 1] + '"', '"' + d.[L LEGAL ID] + '"' as [New L LEGAL ID],
					'"' + c.[L PA ST] + '"', '"' + d.[L PA ST] + '"' as [New L PA ST],
					'"' + c.[L PA ADD] + '"', '"' + d.[L PA ADD] + '"' as [New L PA ADD],
					'"' + c.[L PA TC] + '"', '"' + d.[L PA TC] + '"' as [New L PA TC],
					'"' + c.[L PA PC] + '"', '"' + d.[L PA PC] + '"' as [New L PA PC],
					'"' + c.[L PA CTRY 1] + '"', '"' + d.[L PA CTRY] + '"' as [New L PA CTRY],
					'"' + c.[L SSS NO] + '"', '"' + d.[L SSS NO] + '"' as [New L SSS NO],
					'"' + c.[L INSTRUCTION] + '"', '"' + d.[L CUST INSTRUCT] + '"' as [New L CUST INSTRUCT],
					'""'  as [STREET], '"' + d.[STREET] + '"' as [NEW STREET],
					'"Hold"' as [L HLD MAIL FLAG], '"' + d.[L HLD MAIL FLAG] + '"' as [New L HLD MAIL FLAG]
			from	CUSTOMER c
			inner	join	CUSTOMER_TRANSFORMED d
			on		c.[EXTERN CUS ID]	=	d.[EXTERN CUS ID]
			UNION ALL
			select	CAST(count(c.[EXTERN CUS ID]) as VARCHAR),
					'','', '', '', '', '', '', '', '', '', '',
					'', '', '', '','', '', '', '', '', '',
					'', '', '', '', '', '', '', '', '', '', '', '',
					'', '', '', '', '', '', '', '', '', '', '',
					'', '', '', '','', '', '', '', '', '',	'', '',
					'', '',	'', '','', '',	'', '', '', '',	'', '',
					'', '',	'', '', '', '',	'', '', '', '',	'', '',
					'', '',	'', '', '', '',	'', '', '', '',	'', '',
					'', '',	'', '','', '',	'', '', '', '',	'', ''
			from	CUSTOMER c
			inner	join	CUSTOMER_TRANSFORMED d
			on		c.[EXTERN CUS ID]	=	d.[EXTERN CUS ID]

		end
		else if	@rep_type	=	2 -- COMPARE_CUSTOMER_TRANSFORMED_DME
		begin

			select	'"ID"', '"Transformed ID"',
					'"MNEMONIC"', '"Transformed MNEMONIC"',
					'"SHORT NAME"', '"Transformed SHORT NAME"',
					'"ACCOUNT OFFICER"', '"Transformed ACCOUNT OFFICER"',
					'"NATIONALITY"', '"Transformed NATIONALITY"',
					'"RESIDENCE"', '"Transformed RESIDENCE"',
					'"SECTOR"', '"Transformed SECTOR"',
					'"INDUSTRY"', '"Transformed INDUSTRY"',
					'"GIVEN NAMES"', '"Transformed GIVEN NAMES"',
					'"L MIDDLE NAME"', '"Transformed L MIDDLE NAME"',
					'FAMILY NAME"', '"Transformed FAMILY NAME"',
					'"L SUFFIX"', '"Transformed L SUFFIX"',
					'"SMS 1"', '"Transformed SMS 1"',
					'"DATE OF BIRTH"', '"Transformed DATE OF BIRTH"',
					'"L BIRTH PLACE"', '"Transformed L BIRTH PLACE"',
					'"NAME 1"', '"Transformed NAME 1"',
					'"CUSTOMER STATUS"', '"Transformed CUSTOMER STATUS"',
					'"ADDRESS"', '"New ADDRESS"',
					'"TOWN COUNTRY"', '"Transformed TOWN COUNTRY"',
					'"POST CODE"', '"Transformed POST CODE"',
					'"L OCCUPATION"', '"Transformed L OCCUPATION"',
					'"L SOURCE FUNDS"', '"Transformed L SOURCE FUNDS"',
					'"L CUSTOMER TYPE"', '"Transformed L CUSTOMER TYPE"',
					'"L OFAC CHECK"', '"Transformed L OFAC CHECK"',
					'"TITLE"', '"Transformed TITLE"',
					'"COUNTRY"', '"Transformed COUNTRY"',
					'"TARGET"', '"Transformed TARGET"',
					'"LANGUAGE"', '"Transformed LANGUAGE"',
					'"COMPANY BOOK"', '"Transformed COMPANY BOOK"',
					'"CLS CPARTY"', '"Transformed CLS CPARTY"',
					'"GENDER"', '"Transformed GENDER"',
					'"EMAIL 1"', '"Transformed EMAIL 1"',
					'"EMPLOYERS NAME"', '"Transformed EMPLOYERS NAME"',
					'"AML CHECK"', '"Transformed AML CHECK"',
					'"AML RESULT"', '"Transformed AML RESULT"',
					'"INTERNET BANKING SERVICE"', '"Transformed INTERNET BANKING SERVICE"',
					'"MOBILE BANKING SERVICE"', '"Transformed MOBILE BANKING SERVICE"',
					'"EXTERN SYS ID"', '"Transformed EXTERN SYS ID"',
					'"EXTERN CUS ID"', '"Transformed EXTERN CUS ID"',
					'"L DOCU TYPE"', '"Transformed L DOCU TYPE"',
					'"L LGL DOC NM 1"', '"Transformed L LGL DOC NM"',
					'"L TIN GSS"', '"Transformed L TIN GSS"',
					'"L LEGAL ID 1"', '"Transformed L LEGAL ID"',
					'"L PA ST"', '"Transformed L PA ST"',
					'"L PA ADD"', '"Transformed L PA ADD"',
					'"L PA TC"', '"Transformed L PA TC"',
					'"L PA PC"', '"Transformed L PA PC"',
					'"L PA CTRY 1"', '"Transformed L PA CTRY"',
					'"L SSS NO"', '"Transformed L SSS NO"',
					'"L INSTRUCTION"', '"Transformed L CUST INSTRUCT"',
					'"STREET"', '"NEW STREET"',
					'"L HLD MAIL FLAG"', '"Transformed L HLD MAIL FLAG"'
			union	all
			select
					'"' + c.[ID] + '"', '"' + d.[ID] + '"' as [New ID],
					'"' + c.[MNEMONIC] + '"', '"' + d.[MNEMONIC] + '"' as [New MNEMONIC],
					'"' + c.[SHORT NAME] + '"', '"' + d.[SHORT NAME] + '"' as [New SHORT NAME],
					'"' + c.[ACCOUNT OFFICER] + '"', '"' + d.[ACCOUNT OFFICER] + '"' as [New ACCOUNT OFFICER],
					'"' + c.[NATIONALITY] + '"', '"' + d.[NATIONALITY] + '"' as [New NATIONALITY],
					'"' + c.[RESIDENCE] + '"', '"' + d.[RESIDENCE] + '"' as [New RESIDENCE],
					'"' + c.[SECTOR] + '"', '"' + d.[SECTOR] + '"' as [New SECTOR],
					'"' + c.[INDUSTRY] + '"', '"' + d.[INDUSTRY] + '"' as [New INDUSTRY],
					'"' + c.[GIVEN NAMES] + '"', '"' + d.[GIVEN NAMES] + '"' as [New GIVEN NAMES],
					'"' + c.[L MIDDLE NAME] + '"', '"' + d.[L MIDDLE NAME] + '"' as [New L MIDDLE NAME],
					'"' + c.[FAMILY NAME] + '"', '"' + d.[FAMILY NAME] + '"' as [New FAMILY NAME],
					'"' + c.[L SUFFIX] + '"', '"' + d.[L SUFFIX] + '"' as [New L SUFFIX],
					'"' + c.[SMS 1] + '"', '"' + d.[SMS 1] + '"' as [New SMS 1],
					'"' + c.[DATE OF BIRTH] + '"' , '"' + d.[DATE OF BIRTH] + '"' as [New DATE OF BIRTH],
					'"' + c.[L BIRTH PLACE] + '"', '"' + d.[L BIRTH PLACE] + '"' as [New L BIRTH PLACE],
					'"' + c.[NAME 1] + '"', '"' + d.[NAME 1] + '"' as [New NAME 1],
					'"' + c.[CUSTOMER STATUS] + '"', '"' + d.[CUSTOMER STATUS] + '"' as [New CUSTOMER STATUS],
					'"' + c.[ADDRESS] + '"', '"' + d.[ADDRESS] + '"' as [New ADDRESS],
					'"' + c.[TOWN COUNTRY] + '"', '"' + d.[TOWN COUNTRY] + '"' as [New TOWN COUNTRY],
					'"' + c.[POST CODE] + '"', '"' + d.[POST CODE] + '"' as [New POST CODE],
					'"' + c.[L OCCUPATION] + '"', '"' + d.[L OCCUPATION] + '"' as [New L OCCUPATION],
					'"' + c.[L SOURCE FUNDS] + '"', '"' + d.[L SOURCE FUNDS] + '"' as [New L SOURCE FUNDS],
					'"' + c.[L CUSTOMER TYPE] + '"', '"' + d.[L CUSTOMER TYPE] + '"' as [New L CUSTOMER TYPE],
					'"' + c.[L OFAC CHECK] + '"', '"' + d.[L OFAC CHECK] + '"' as [New L OFAC CHECK],
					'"' + c.[TITLE] + '"', '"' + d.[TITLE] + '"' as [New TITLE],
					'"' + c.[COUNTRY] + '"', '"' + d.[COUNTRY] + '"' as [New COUNTRY],
					'"' + c.[TARGET] + '"', '"' + d.[TARGET] + '"' as [New TARGET],
					'"' + c.[LANGUAGE] + '"', '"' + d.[LANGUAGE] + '"' as [New LANGUAGE],
					'"' + c.[COMPANY BOOK] + '"', '"' + d.[COMPANY BOOK] + '"' as [New COMPANY BOOK],
					'"' + c.[CLS CPARTY] + '"', '"' + d.[CLS CPARTY] + '"' as [New CLS CPARTY],
					'"' + c.[GENDER] + '"', '"' + d.[GENDER] + '"' as [New GENDER],
					'"' + REPLACE(c.[EMAIL 1], '''','') + '"', '"' + d.[EMAIL 1] + '"' as [New EMAIL 1],
					'"' + c.[EMPLOYERS NAME] + '"', '"' + d.[EMPLOYERS NAME] + '"' as [New EMPLOYERS NAME],
					'"' + c.[AML CHECK] + '"', '"' + d.[AML CHECK] + '"' as [New AML CHECK],
					'"' + c.[AML RESULT] + '"', '"' + d.[AML RESULT] + '"' as [New AML RESULT],
					'"' + c.[INTERNET BANKING SERVICE] + '"', '"' + d.[INTERNET BANKING SERVICE] + '"' as [New INTERNET BANKING SERVICE],
					'"' + c.[MOBILE BANKING SERVICE] + '"', '"' + d.[MOBILE BANKING SERVICE] + '"' as [New MOBILE BANKING SERVICE],
					'"' + c.[EXTERN SYS ID] + '"', '"' + d.[EXTERN SYS ID] + '"' as [New EXTERN SYS ID],
					'"' + c.[EXTERN CUS ID] + '"', '"' + d.[EXTERN CUS ID] + '"' as [New EXTERN CUS ID],
					'"' + c.[L DOCU TYPE] + '"', '"' + d.[L DOCU TYPE] + '"' as [New L DOCU TYPE],
					'"' + c.[L LGL DOC NM] + '"', '"' + d.[L LGL DOC NM] + '"' as [New L LGL DOC NM],
					'"' + c.[L TIN GSS] + '"', '"' + d.[L TIN GSS] + '"' as [New L TIN GSS],
					'"' + c.[L LEGAL ID] + '"', '"' + d.[L LEGAL ID] + '"' as [New L LEGAL ID],
					'"' + c.[L PA ST] + '"', '"' + d.[L PA ST] + '"' as [New L PA ST],
					'"' + c.[L PA ADD] + '"', '"' + d.[L PA ADD] + '"' as [New L PA ADD],
					'"' + c.[L PA TC] + '"', '"' + d.[L PA TC] + '"' as [New L PA TC],
					'"' + c.[L PA PC] + '"', '"' + d.[L PA PC] + '"' as [New L PA PC],
					'"' + c.[L PA CTRY] + '"', '"' + d.[L PA CTRY] + '"' as [New L PA CTRY],
					'"' + c.[L SSS NO] + '"', '"' + d.[L SSS NO] + '"' as [New L SSS NO],
					'"' + c.[L CUST INSTRUCT] + '"', '"' + d.[L CUST INSTRUCT] + '"' as [New L CUST INSTRUCT],
					'"' + c.[STREET] + '"', '"' + d.[STREET] + '"' as [NEW STREET],
					'"' + c.[L HLD MAIL FLAG] + '"', '"' + d.[L HLD MAIL FLAG] + '"' as [New L HLD MAIL FLAG]
			from	CUSTOMER_TRANSFORMED c
			inner	join	CUSTOMER_DME d
			on		c.[EXTERN CUS ID]	=	d.[EXTERN CUS ID]

		end
		else if	@rep_type	=	3 -- COMPARE_ACCOUNT_RAW_TRANSFORMED
		begin

			select
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"CUSTOMER"', '"TRANSFORMED CUSTOMER"',
					'"CATEGORY"', '"TRANSFORMED CATEGORY"',
					'"ACCOUNT TITLE 1"', '"TRANSFORMED ACCOUNT TITLE 1"',
					'"SHORT TITLE"', '"TRANSFORMED SHORT TITLE"',
					'"CURRENCY"', '"TRANSFORMED CURRENCY"',
					'"ACCOUNT OFFICER"', '"TRANSFORMED ACCOUNT OFFICER"',
					'"PASSBOOK"', '"TRANSFORMED PASSBOOK"',
					'"OPENING DATE"', '"TRANSFORMED OPENING DATE"',
					'"ALT ACCT TYPE"', '"TRANSFORMED ALT ACCT TYPE"',
					'"ALT ACCT ID"', '"TRANSFORMED ALT ACCT ID"',
					'"ALLOW NETTING"', '"TRANSFORMED ALLOW NETTING"',
					'"HVT FLAG"', '"TRANSFORMED HVT FLAG"'
			UNION ALL
			select	
					'"' + a.[UPLOAD COMPANY] + '"',	'"' + b.[UPLOAD COMPANY] + '"' as [NEW UPLOAD COMPANY],
					'"' + a.[ALT ACCT ID 1] + '"' as [ACCOUNT NUMBER],	'"' + b.[ACCOUNT NUMBER] + '"' as [NEW ACCOUNT NUMBER],
					'"' + a.[CUSTOMER] + '"', '"' + b.[CUSTOMER] + '"' as [NEW CUSTOMER],
					'"' + a.[CATEGORY] + '"', '"' +	b.[CATEGORY] + '"' as [NEW CATEGORY],
					'"' + a.[ACCOUNT TITLE 1] + '"', '"' +	b.[ACCOUNT TITLE 1] + '"' as [NEW ACCOUNT TITLE 1],
					'"' + a.[SHORT TITLE] + '"', '"' +	b.[SHORT TITLE] + '"' as [NEW SHORT TITLE],
					'"' + a.[CURRENCY] + '"', '"' +	b.[CURRENCY] + '"' as [NEW CURRENCY],
					'"' + a.[ACCOUNT OFFICER] + '"', '"' +	b.[ACCOUNT OFFICER] + '"' as [NEW ACCOUNT OFFICER],
					'"' + a.[PASSBOOK] + '"', '"' +	b.[PASSBOOK] + '"' as [NEW PASSBOOK],
					'"' + a.[OPENING DATE] + '"', '"' +	b.[OPENING DATE] + '"' as [NEW OPENING DATE],
					'"' + a.[ALT ACCT TYPE 1] + '"', '"' +	b.[ALT ACCT TYPE] + '"' as [NEW ALT ACCT TYPE],
					'"' + a.[ALT ACCT ID 1] + '"', '"' + b.[ALT ACCT ID] + '"' as [NEW ALT ACCT ID],
					'"' + a.[ALLOW NETTING] + '"', '"' + b.[ALLOW NETTING] + '"' as [NEW ALLOW NETTING],
					'"' + a.[HVT FLAG] + '"',	'"' + b.[HVT FLAG] + '"' as [NEW HVT FLAG]
			from	Account1	a	with(nolock)
			inner	join	ACCOUNTS_TRANSFORMED b	with(nolock)
			on		a.[ALT ACCT ID 1]	=	b.[ALT ACCT ID]
			UNION ALL
			select	
					CAST(count(a.[ALT ACCT ID 1]) as VARCHAR), '',
					'', '','', '','', '','', '', '', '', '', '', '', '',
					'', '', '', '', '', '', '', '', '', '', '',	''
			from	Account1	a	with(nolock)
			inner	join	ACCOUNTS_TRANSFORMED b	with(nolock)
			on		a.[ALT ACCT ID 1]	=	b.[ALT ACCT ID]

		end
		else if	@rep_type	=	4 -- COMPARE_ACCOUNTS_TRANSFORMED_DMREP
		begin

			select
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"CUSTOMER"', '"TRANSFORMED CUSTOMER"',
					'"CATEGORY"', '"TRANSFORMED CATEGORY"',
					'"ACCOUNT TITLE 1"', '"TRANSFORMED ACCOUNT TITLE 1"',
					'"SHORT TITLE"', '"TRANSFORMED SHORT TITLE"',
					'"CURRENCY"', '"TRANSFORMED CURRENCY"',
					'"ACCOUNT OFFICER"', '"TRANSFORMED ACCOUNT OFFICER"',
					'"PASSBOOK"', '"TRANSFORMED PASSBOOK"',
					'"OPENING DATE"', '"TRANSFORMED OPENING DATE"',
					'"ALT ACCT TYPE"', '"TRANSFORMED ALT ACCT TYPE"',
					'"ALT ACCT ID"', '"TRANSFORMED ALT ACCT ID"',
					'"ALLOW NETTING"', '"TRANSFORMED ALLOW NETTING"',
					'"HVT FLAG"', '"TRANSFORMED HVT FLAG"'
			UNION ALL
			select	
					'"' + a.[UPLOAD COMPANY] + '"',	'"' + b.[UPLOAD COMPANY] + '"' as [NEW UPLOAD COMPANY],
					'"' + a.[ALT ACCT ID] + '"' as [ACCOUNT NUMBER],	'"' + b.[ACCOUNT NUMBER] + '"' as [NEW ACCOUNT NUMBER],
					'"' + a.[CUSTOMER] + '"', '"' + b.[CUSTOMER] + '"' as [NEW CUSTOMER],
					'"' + a.[CATEGORY] + '"', '"' +	b.[CATEGORY] + '"' as [NEW CATEGORY],
					'"' + a.[ACCOUNT TITLE 1] + '"', '"' +	b.[ACCOUNT TITLE 1] + '"' as [NEW ACCOUNT TITLE 1],
					'"' + a.[SHORT TITLE] + '"', '"' +	b.[SHORT TITLE] + '"' as [NEW SHORT TITLE],
					'"' + a.[CURRENCY] + '"', '"' +	b.[CURRENCY] + '"' as [NEW CURRENCY],
					'"' + a.[ACCOUNT OFFICER] + '"', '"' +	b.[ACCOUNT OFFICER] + '"' as [NEW ACCOUNT OFFICER],
					'"' + a.[PASSBOOK] + '"', '"' +	b.[PASSBOOK] + '"' as [NEW PASSBOOK],
					'"' + a.[OPENING DATE] + '"', '"' +	b.[OPENING DATE] + '"' as [NEW OPENING DATE],
					'"' + a.[ALT ACCT TYPE] + '"', '"' +	b.[ALT ACCT TYPE] + '"' as [NEW ALT ACCT TYPE],
					'"' + a.[ALT ACCT ID] + '"', '"' + b.[ALT ACCT ID] + '"' as [NEW ALT ACCT ID],
					'"' + a.[ALLOW NETTING] + '"', '"' + b.[ALLOW NETTING] + '"' as [NEW ALLOW NETTING],
					'"' + a.[HVT FLAG] + '"', '"' + b.[HVT FLAG] + '"' as [NEW HVT FLAG]
			from	ACCOUNTS_TRANSFORMED	a	with(nolock)
			inner	join	ACCOUNTS_DME b	with(nolock)
			on		a.[ALT ACCT ID]	=	b.[ALT ACCT ID]


		end
		else if	@rep_type =	5 -- COMPARE_ACCOUNT2_RAW_TRANSFORMED
		begin

			select
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"DATE_LAST_CR_CUST"', '"TRANSFORMED DATE_LAST_CR_CUST"',
					'"DATE_LAST_DR_CUST"', '"DATE_LAST_DR_CUST"'
			UNION ALL
			select	'"' + r.[ALT ACCT ID] + '"', '"' + b.[ID] + '"',
					'"' + a.UPLOAD_COMPANY + '"', '"' + b.UPLOAD_COMPANY + '"', 
					'"' + isnull(a.DATE_LAST_CR_CUST,'') + '"', '"' + isnull(b.DATE_LAST_CR_CUST,'') + '"', 
					'"' + isnull(a.DATE_LAST_DR_CUST, '') + '"', '"' + isnull(b.DATE_LAST_DR_CUST, '') + '"'
			from	Account2 a	with(nolock)
			inner	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
			on		a.[ID]	=	r.[ALT ACCT ID]
			inner	join	[dbo].[ACCOUNT2_TRANSFORMED] b	with(nolock)
			on		b.[ID]	=	r.[ACCOUNT NUMBER]
			UNION ALL
			select	CAST(count(r.[ALT ACCT ID]) as VARCHAR), CAST(count(b.[ID]) as VARCHAR),
					CAST(count(a.UPLOAD_COMPANY) as VARCHAR), CAST(count(b.UPLOAD_COMPANY) as VARCHAR), 
					CAST(count(a.DATE_LAST_CR_CUST) as VARCHAR), CAST(count(b.DATE_LAST_CR_CUST) as VARCHAR), 
					CAST(count(a.DATE_LAST_DR_CUST) as VARCHAR), CAST(count(b.DATE_LAST_DR_CUST) as VARCHAR)
			from	Account2 a	with(nolock)
			inner	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
			on		a.[ID]	=	r.[ALT ACCT ID]
			inner	join	[dbo].[ACCOUNT2_TRANSFORMED] b	with(nolock)
			on		b.[ID]	=	r.[ACCOUNT NUMBER]

		end	
		else if	@rep_type =	6 -- COMPARE_ACCOUNT2_TRANSFORMED_DMREP
		begin

			select
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"DATE_LAST_CR_CUST"', '"TRANSFORMED DATE_LAST_CR_CUST"',
					'"DATE_LAST_DR_CUST"', '"TRANSFORMED DATE_LAST_DR_CUST"'
			UNION ALL
			select	'"' + a.[ID] + '"', '"' + b.[ID] + '"',
					'"' + a.UPLOAD_COMPANY + '"', '"' + b.UPLOAD_COMPANY + '"', 
					'"' + isnull(a.DATE_LAST_CR_CUST,'') + '"', '"' + isnull(b.DATE_LAST_CR_CUST,'') + '"', 
					'"' + isnull(a.DATE_LAST_DR_CUST, '') + '"', '"' + isnull(b.DATE_LAST_DR_CUST, '') + '"'
			from	[ACCOUNT2_TRANSFORMED] a	with(nolock)
			inner	join	[dbo].[ACCOUNT2_TRANSFORMED] b	with(nolock)
			on		b.[ID]	=	a.[ID]

		end
		else if	@rep_type =	7 -- COMPARE_ACCOUNTBALANCE_RAW_TRANSFORMED
		begin

			select
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"WORKING BALANCE"', '"TRANSFORMED WORKING BALANCE"'
			UNION ALL
			select	'"' + b.[UPLOAD_COMPANY] + '"', '"' + b.[UPLOAD_COMPANY] + '"' as [NEW UPLOAD COMPANY],
					'"' + b.[ID] + '"', '"' + r.[ACCOUNT NUMBER] + '"' as [NEW ACCOUNT NUMBER],
					'"' + b.WORKING_BALANCE + '"', '"' + b.[WORKING_BALANCE] + '"' as [NEW WORKING BALANCE] 
			from	[dbo].[ACCT_BALANCE]	b
			left outer	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
			on		b.[ID]	=	r.[ALT ACCT ID]
			UNION ALL
			select	CAST(count(b.[UPLOAD_COMPANY]) as VARCHAR), CAST(count(b.[UPLOAD_COMPANY]) as VARCHAR) as [NEW UPLOAD COMPANY],
					CAST(count(b.[ID]) as VARCHAR), CAST(count(r.[ACCOUNT NUMBER]) as VARCHAR) as [NEW ACCOUNT NUMBER],
					CAST(sum(cast(b.WORKING_BALANCE as numeric(19,2))) as VARCHAR), CAST(sum(cast(b.[WORKING_BALANCE] as numeric(19,2))) as VARCHAR) as [NEW WORKING BALANCE] 
			from	[dbo].[ACCT_BALANCE]	b
			left outer	join	[dbo].[ACCOUNTS_DME] r	with(nolock)
			on		b.[ID]	=	r.[ALT ACCT ID]
		end
		else if	@rep_type =	8 -- COMPARE_ACCOUNTBALANCE_TRANSFORMED_DME
		begin

			-- Modified error on Account number select 
			--select
			--		'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
			--		'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
			--		'"WORKING BALANCE"', '"TRANSFORMED WORKING BALANCE"'
			--UNION ALL
			--select	'"' + b.[UPLOAD COMPANY] + '"', '"' + b.[UPLOAD COMPANY] + '"' as [NEW UPLOAD COMPANY],
			--		'"' + b.[ID] + '"', '"' + a.[ID] + '"' as [NEW ACCOUNT NUMBER],
			--		'"' + b.[AMOUNT LCY] + '"', '"' + b.[AMOUNT LCY] + '"' as [NEW WORKING BALANCE] 
			--from	[dbo].[tbl_acct_bal_write]	b
			--left	outer	join	[ACCT_BALANCE_DME]	a
			--on		b.[ID]	=	a.[ID]
			select
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"WORKING BALANCE"', '"TRANSFORMED WORKING BALANCE"'
			UNION ALL
			select	'"' + b.[UPLOAD COMPANY] + '"', '"' + b.[UPLOAD COMPANY] + '"' as [NEW UPLOAD COMPANY],
					'"' + b.[ACCOUNT NUMBER] + '"', '"' + a.[ACCOUNT NUMBER] + '"' as [NEW ACCOUNT NUMBER],
					'"' + b.[AMOUNT LCY] + '"', '"' + b.[AMOUNT LCY] + '"' as [NEW WORKING BALANCE] 
			from	[dbo].[tbl_acct_bal_write]	b
			left	outer	join	[ACCT_BALANCE_DME]	a
			on		b.[ID]	=	a.[ID]

		end
		else if	@rep_type =	9 -- COMPARE_ACCOUNT3_RAW_TRANSFORMED
		begin

			--Issue on extract file link of transformed and account dme, double quoute missiong on extract
			--select
			--'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
			--'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
			--'"POSTING RESTRICT"', '"TRANSFORMED POSTING RESTRICT"'
			--UNION ALL
			--select	'"' + b.[ID] + '"', '"' r.[ACCOUNT NUMBER] + '"', 
			--		'"' + b.[UPLOAD_COMPANY] + '"', '"'   t.[UPLOAD_COMPANY] + '"', 
			--		'"' + b.[POSTING_RESTRICT] + '"' t.[POSTING_RESTRICT] + '"'
			--from	[dbo].[ACCOUNT3]	b
			--left outer	join	[dbo].[ACCOUNT3_TRANSFORMED] t	with(nolock)
			--on		b.[ID]	=	t.[ID]
			--inner	join [ACCOUNTS_DME] r	with(nolock)
			--on		b.[ID]	=	r.[ALT ACCT ID]
			select
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"POSTING RESTRICT"', '"TRANSFORMED POSTING RESTRICT"'
			UNION ALL
			select	'"' + b.[ID] + '"', '"' + r.[ACCOUNT NUMBER] + '"', 
					'"' + b.[UPLOAD_COMPANY] + '"', '"' +  t.[UPLOAD_COMPANY] + '"', 
					'"' + b.[POSTING_RESTRICT] + '"', '"' +  t.[POSTING_RESTRICT] + '"'
			from	[dbo].[ACCOUNT3]	b
				inner	join [ACCOUNTS_DME] r
			on		b.[ID]	=	r.[ALT ACCT ID]
				left outer	join	[dbo].[ACCOUNT3_TRANSFORMED] t
			on		r.[ACCOUNT NUMBER]	=	t.[ID]
			UNION ALL
			select	CAST(count(b.[ID]) as VARCHAR), CAST(count(r.[ACCOUNT NUMBER]) as VARCHAR), 
					CAST(count(b.[UPLOAD_COMPANY]) as VARCHAR), CAST(count(t.[UPLOAD_COMPANY]) as VARCHAR), 
					CAST(count(b.[POSTING_RESTRICT]) as VARCHAR), CAST(count(t.[POSTING_RESTRICT]) as VARCHAR)
			from	[dbo].[ACCOUNT3]	b
				inner	join [ACCOUNTS_DME] r
			on		b.[ID]	=	r.[ALT ACCT ID]
				left outer	join	[dbo].[ACCOUNT3_TRANSFORMED] t
			on		r.[ACCOUNT NUMBER]	=	t.[ID]


		end
		else if	@rep_type =	10 -- COMPARE_ACCOUNT3_TRANSFORMED_DME
		begin

			select
					'"ACCOUNT NUMBER"', '"TRANSFORMED ACCOUNT NUMBER"',
					'"UPLOAD COMPANY"', '"TRANSFORMED UPLOAD COMPANY"',
					'"POSTING RESTRICT"', '"TRANSFORMED POSTING RESTRICT"'
			UNION ALL
			select	'"' + b.[ID] + '"', '"' + r.[ACCOUNT NUMBER] + '"', 
					'"' + b.[UPLOAD_COMPANY] + '"', '"' +  t.[UPLOAD_COMPANY] + '"', 
					'"' + b.[POSTING_RESTRICT] + '"', '"' + t.[POSTING_RESTRICT] + '"'
			from	[dbo].[ACCOUNT3_TRANSFORMED]	b
			left outer	join	[dbo].[ACCOUNT3_DME] t	with(nolock)
			on		b.[ID]	=	t.[ID]
			inner	join [ACCOUNTS_DME] r	with(nolock)
			on		b.[ID]	=	r.[ACCOUNT NUMBER]

		end
		else if	@rep_type =	11 -- COMPARE_CUSTOMER2_RAW_TRANSFORMED
		begin

			select
					'"CIF NUMBER"', '"TRANSFORMED CIF NUMBER"',
					'"POSTING RESTRICT"', '"TRANSFORMED POSTING RESTRICT"',
					'"CUSTOMER SINCE"', '"TRANSFORMED CUSTOMER SINCE"'
			UNION ALL
			select	'"' + a.[ID] + '"', '"' +  b.ID + '"', 
					'"' + a.[POSTING RESTRICT] + '"', '"' + c.[POSTING RESTRICT] + '"',
					'"' + c.[ONBOARDING_DATE] + '"', '"' + c.[ONBOARDING_DATE] + '"'
			from	[dbo].[CUSTOMER_2]	a
			inner	join	[dbo].[CUSTOMER_DME] b	with(nolock)
			on		a.[ID]	=	b.[EXTERN CUS ID]
			left outer	join	[dbo].[CUSTOMER_2_TRANSFORMED] c	with(nolock)
			on		b.[ID]	=	c.[ID]
			left outer	join	[dbo].[CUSTOMER_3] d	with(nolock)
			on		d.[R18_CUSTOMER_ID]	=	a.[ID]
			UNION ALL
			select	CAST(count( a.[ID]) as VARCHAR), CAST(count(b.ID) as VARCHAR),
					CAST(count( a.[POSTING RESTRICT]) as VARCHAR), CAST(count(c.[POSTING RESTRICT]) as VARCHAR),
					CAST(count( d.[ONBOARDING_DATE]) as VARCHAR), CAST(count(c.[ONBOARDING_DATE]) as VARCHAR)
			from	[dbo].[CUSTOMER_2]	a
			inner	join	[dbo].[CUSTOMER_DME] b	with(nolock)
			on		a.[ID]	=	b.[EXTERN CUS ID]
			left outer	join	[dbo].[CUSTOMER_2_TRANSFORMED] c	with(nolock)
			on		b.[ID]	=	c.[ID]
			left outer	join	[dbo].[CUSTOMER_3] d	with(nolock)
			on		d.[R18_CUSTOMER_ID]	=	a.[ID]
		end
		else if	@rep_type =	12 -- COMPARE_CUSTOMER2_TRANSFORMED_DME
		begin

			select
					'"CIF NUMBER"', '"TRANSFORMED CIF NUMBER"',
					'"POSTING RESTRICT"', '"TRANSFORMED POSTING RESTRICT"',
					'"CUSTOMER SINCE"', '"TRANSFORMED CUSTOMER SINCE"'
			UNION ALL
			select	'"' + a.[ID] + '"', '"' + b.[ID] + '"', 
					'"' + a.[POSTING RESTRICT] + '"', '"' + b.[POSTING RESTRICT] + '"',
					'"' + a.[ONBOARDING_DATE] + '"', '"' + b.[CUSTOMER SINCE] + '"'
			from	[dbo].[CUSTOMER_2_TRANSFORMED]	a
			left outer	join	[dbo].[CUSTOMER_2_DME] b	with(nolock)
			on		a.[ID]	=	b.[ID]

		end
		else if	@rep_type =	13 -- R18 CIF Archivng
		begin

			select
					'ARCHIVED CIF (RETIRING CIF)', 'SURVIVING CIF', 'BATCH'
			UNION ALL
			select	c.[ID] [OLD CIF NUMBER], d.[ID] [NEW CIF NUMBER], ''
			from	CUSTOMER	c
			inner	join	CUSTOMER_DME	d
			on		c.[EXTERN CUS ID]	=	d.[EXTERN CUS ID]
		end
		else if	@rep_type =	14 -- ACCOUNT IM RAW vs Transformed
		begin

			select
					'UPLOAD COMPANY', 'TRANSFORMED UPLOAD COMPANY',
					'ACCOUNT NUMBER', 'TRANSFORMED ACCOUNT NUMBER',
					'INACTIVE MARKER', 'TRANSFORMED INACTIVE MARKER'
			UNION ALL
			select	a.[UPLOAD_COMPANY], b.[UPLOAD_COMPANY],
					a.[ID], b.[ID],
					a.[INACTIV_MARKER], b.[INACTIV_MARKER]
			from	ACCOUNT_IM	a
			inner	join	ACCOUNTS_DME	c
			on		c.[ALT ACCT ID]	=	a.[ID]
			inner	join	ACCOUNT_IM_TRANSFORMED	b
			on		b.[ID]	=	c.[ACCOUNT NUMBER]
			UNION ALL
			select	CAST(count( a.[UPLOAD_COMPANY]) as VARCHAR), CAST(count( b.[UPLOAD_COMPANY]) as VARCHAR), 
					CAST(count( a.[ID]) as VARCHAR), CAST(count( a.[ID]) as VARCHAR),
					CAST(count( a.[INACTIV_MARKER]) as VARCHAR), CAST(count( b.[INACTIV_MARKER]) as VARCHAR)
			from	ACCOUNT_IM	a
			inner	join	ACCOUNTS_DME	c
			on		c.[ALT ACCT ID]	=	a.[ID]
			inner	join	ACCOUNT_IM_TRANSFORMED	b
			on		b.[ID]	=	c.[ACCOUNT NUMBER]

		end
GO
/****** Object:  StoredProcedure [dbo].[sp_get_CT_Report]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure	[dbo].[sp_get_CT_Report]
as
begin

	select	
		'"TAG"',
		'"R18 CIF"', -- OLD ACCOUNT
		'"R18 Account No"', -- OLD ACCOUNT
		'"R12 CIF"',	-- NEW CUSTOMER NO
		'"R12 Account No"', -- NEW ACCOUNT NUMBER
		'"R12 Account Product"',
		'"Update Date/Time"',
		'"R12 CIF Branch Code"' -- COMPANY BRANCH
	union	all
	select	
		'"R12"',
		'"' + c.[EXTERN CUS ID] + '"', -- OLD ACCOUNT
		'"' + a.[ALT ACCT ID] + '"', -- OLD ACCOUNT
		'"' + c.[ID] + '"',	-- NEW CUSTOMER NO
		'"' + a.[ACCOUNT NUMBER] + '"', -- NEW ACCOUNT NUMBER
		'"' + a.[CATEGORY] + '"',
		'"' + FORMAT(GETDATE(), 'M/dd/yyyy hh:mm:ss tt' ) + '"',
		'"' + c.[COMPANY BOOK] + '"' -- COMPANY BRANCH
	from	CUSTOMER_DME c	with(nolock)
	inner	join	ACCOUNTS_DME	a	with(nolock)
	on		c.[ID]	=	a.[CUSTOMER]
end
GO
/****** Object:  StoredProcedure [dbo].[sp_prep_acct_mstr_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure	 [dbo].[sp_prep_acct_mstr_file]
as
begin

	update	Account1
	set	[UPLOAD COMPANY] = Replace([UPLOAD COMPANY], '"', ''),
		[ID] = Replace([ID], '"', ''),
		[CUSTOMER] = Replace([CUSTOMER], '"', ''),
		[CATEGORY] = Replace([CATEGORY], '"', ''),
		[ACCOUNT TITLE 1] = Replace([ACCOUNT TITLE 1], '"', ''),			
		[SHORT TITLE] = Replace([SHORT TITLE], '"', ''),
		[CURRENCY] = Replace([CURRENCY], '"', ''),
		[ACCOUNT OFFICER] = Replace([ACCOUNT OFFICER], '"', ''),
		[PASSBOOK] = Replace([PASSBOOK], '"', ''),
		[OPENING DATE] = Replace([OPENING DATE], '"', ''),
		[ALT ACCT TYPE 1] = Replace([ALT ACCT TYPE 1], '"', ''),
		[ALT ACCT ID 1] = Replace([ALT ACCT ID 1], '"', ''),
		[ALLOW NETTING] = Replace([ALLOW NETTING], '"', ''),
		[HVT FLAG] = Replace([HVT FLAG], '"', '')

	exec sp_DbMigrationRun

	insert	into	ACCOUNTS_TRANSFORMED
	select	isnull([UPLOAD COMPANY], ''), isnull(r.[ACCOUNT NUMBER], ''), isnull(c.[ID], '')
			,case when isnull([CATEGORY], '') = '6001' then '6016' else '6017' end
			,dbo.fnGetName(isnull(d.[L SUFFIX], ''), isnull(d.[FAMILY NAME], ''), isnull(d.[GIVEN NAMES], ''), isnull(d.[L MIDDLE NAME], ''))
			,dbo.fnGetName(isnull(d.[L SUFFIX], ''), isnull(d.[FAMILY NAME], ''), isnull(d.[GIVEN NAMES], ''), isnull(d.[L MIDDLE NAME], ''))
			,isnull([CURRENCY], ''), '801' [ACCOUNT OFFICER], isnull([PASSBOOK], ''), isnull([OPENING DATE], ''), isnull([ALT ACCT TYPE 1], '') 
			,isnull([ALT ACCT ID 1], ''), isnull([ALLOW NETTING], ''), isnull([HVT FLAG], ''), GETDATE()
	from	Account1	a with(nolock)
	inner	join	R12_DME_PRE_GEN r with(nolock)
	on		a.[ALT ACCT ID 1]	=	r.[OLD_ACCT_ID]
	inner	join	[CUSTOMER_DME]	c with (nolock)
	on		a.[CUSTOMER]		=	c.[EXTERN CUS ID]
	inner	join	CUSTOMER d with(nolock)
	on		d.[EXTERN CUS ID]	=	a.[CUSTOMER]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_prep_acctbal_file]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE procedure	 [dbo].[sp_prep_acctbal_file]
--(
--	@loopctr	int
--)
as
begin

	update	ACCT_BALANCE
	set		UPLOAD_COMPANY	=	REPLACE(UPLOAD_COMPANY, '"',''),
			ID	=	REPLACE(ID, '"', ''),
			ONLINE_ACTUAL_BAL = REPLACE(ONLINE_ACTUAL_BAL, '"', ''),
			ONLINE_CLEARED_BAL = REPLACE(ONLINE_CLEARED_BAL, '"', ''),
			WORKING_BALANCE = REPLACE(WORKING_BALANCE, '"', ''),
			OPEN_BALANCE = REPLACE(OPEN_BALANCE, '"', '')

	--DC = Static
	--2404 = Julian Date  
	--00001 = static
	--016 = Batch Number
	--008 = item number (max of 997)

	declare	@batch INT
	declare	@batch_start INT
	declare @ctr INT
	declare	@tranct INT
	declare @loopctr INT

	set @batch = (select batch_no from tbl_acctbal_batch_ctr)
	set	@batch_start = @batch
	set @ctr = 1
	set @tranct  = 997
	set @loopctr = (select count(1) / 997 from ACCT_BALANCE a with(nolock) 
					inner join [ACCOUNTS_DME]	d
					on		a.ID	=	d.[ALT ACCT ID])
	set @loopctr = @loopctr + @batch_start

	truncate	table	temp_ACCT_BALANCE
	truncate	table	tbl_acctbal_batch
	
	while @batch < @loopctr + 1 -- begin loop
	begin 

		insert into temp_ACCT_BALANCE
		select  a.*
		from	ACCT_BALANCE a	with(nolock)
		inner	join	[ACCOUNTS_DME]	d
		on		a.ID	=	d.[ALT ACCT ID]
		where	cast(WORKING_BALANCE as numeric(19,2))	>	0

		insert into [tbl_acctbal_batch]
		select	top 997 replicate('0', 3 - len(@batch)) +  cast(@batch as varchar(5)) [batch_num], 
				isnull([UPLOAD_COMPANY], ''),isnull([ID], ''), isnull([ONLINE_ACTUAL_BAL], ''), isnull([ONLINE_CLEARED_BAL], ''),
				isnull([WORKING_BALANCE], ''), isnull([OPEN_BALANCE], '')
		from	temp_ACCT_BALANCE	a
		where	Tid between @ctr and @ctr + @tranct
		
		PRINT 'Batch Count:' 
		PRINT @batch

		PRINT @ctr

		set @ctr = @ctr + @tranct
		set @batch = @batch + 1

		
		update	tbl_acctbal_batch_ctr
		set		batch_no	=	@batch

		truncate	table		temp_ACCT_BALANCE

	end -- end loop

	declare @exist int
	declare @ID_CTR varchar(10)
	
	set	@ID_CTR = (select ID from [tbl_acctbal_ref] nolock)

	while @batch_start < @batch + 1
	begin
		
		set @exist = (select COUNT(1)
		from [tbl_acctbal_batch] a with(nolock) 
		inner join [ACCOUNTS_DME] r on a.ID = r.[ALT ACCT ID]
		where BATCH = replicate('0', 3 - len(@batch_start)) +  cast(@batch_start as varchar(5)))
		
		if @exist >= 1
		begin

			insert	into	[dbo].[ACCT_BALANCE_TRANSFORMED]
			select	isnull([UPLOAD_COMPANY], ''), isnull([ID], ''), isnull([WORKING_BALANCE], ''), GETDATE()
			from	[tbl_acctbal_batch]	a with(nolock)
			inner	join	[ACCOUNTS_DME] r
			on		a.ID = r.[ALT ACCT ID]
			where	BATCH	=	replicate('0', 3 - len(@batch_start)) +  cast(@batch_start as varchar(5))			
			
			insert	into	[tbl_acct_bal_write]
			select	isnull([UPLOAD_COMPANY], '') + '|' +
					'DC' + @ID_CTR + '0001' + BATCH + 
					replicate('0', 3 - len(ROW_NUMBER() OVER (ORDER BY (SELECT 1)))) + 
					CAST( ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as varchar (5)) + '|' + isnull(r.[ACCOUNT NUMBER], '') + '|' + isnull([WORKING_BALANCE], '') + '|' + 'C' + '|' + '904',
					@batch_start, 'C', isnull([UPLOAD_COMPANY], ''), 'DC' + @ID_CTR + '0001' + BATCH + replicate('0', 3 - len(ROW_NUMBER() OVER (ORDER BY (SELECT 1)))) + CAST( ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as varchar (5)),
					isnull(r.[ACCOUNT NUMBER], ''), isnull([WORKING_BALANCE], ''), '904' 
			from	[tbl_acctbal_batch]	a with(nolock)
			inner	join	[ACCOUNTS_DME] r
			on		a.ID = r.[ALT ACCT ID]
			where	BATCH	=	replicate('0', 3 - len(@batch_start)) +  cast(@batch_start as varchar(5))
			Union all
			select	isnull([UPLOAD_COMPANY], '') + '|' + 
					'DC' + @ID_CTR + '0001' + BATCH + 
					replicate('0', 3 - len(count(1))) +  cast(count(1) + 1 as varchar(5)) + '|' + 'PHP1499900050101' + '|' 
					+ CAST(SUM(cast(isnull([WORKING_BALANCE], '0.00') as numeric(19,2))) as varchar) + '|' + 'D' + '|' + '903',
					@batch_start, 'D', isnull([UPLOAD_COMPANY], ''), 'DC' + @ID_CTR + '0001' + BATCH + replicate('0', 3 - len(count(1))) +  cast(count(1) + 1 as varchar(5)),
					'PHP1499900050101', CAST(SUM(cast(isnull([WORKING_BALANCE], '0.00') as numeric(19,2))) as varchar), '903' 
			from	[tbl_acctbal_batch] a with(nolock)
			inner	join	[ACCOUNTS_DME] r
			on		a.ID = r.[ALT ACCT ID]
			where	BATCH	=	replicate('0', 3 - len(@batch_start)) +  cast(@batch_start as varchar(5))
			Group BY	[UPLOAD_COMPANY], BATCH

		end

		set @batch_start = @batch_start + 1

	end

end
	
GO
/****** Object:  StoredProcedure [dbo].[sp_prepare_cust_acct_records]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create	procedure	[dbo].[sp_prepare_cust_acct_records]
as
begin
	INSERT INTO ACCOUNT1
	select	*
	from	ACCOUNT_STAGING	nolock
	where	[ALT ACCT ID 1]	in	(select	[Account ID] from ACCT_VALIDATED)

	INSERT INTO CUSTOMER
	select	*, null
	from	CUSTOMER_STAGING	nolock
	where	[EXTERN CUS ID]	in	(select	[CUSTOMER ID] from ACCT_VALIDATED)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_regenerate_CUSTOMER]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE	procedure	[dbo].[sp_regenerate_CUSTOMER]
as
begin
	--delete	from	CUSTOMER_TRANSFORMED
	--where	[EXTERN CUS ID]	not	in	(select [EXTERN CUS ID] from CUSTOMER_DME nolock)

	--insert	into	CUSTOMER_TRANSFORMED
	--select	convert( varchar,isnull([CUST_ID],'')) [ID],
	--		isnull([MNEMONIC],''),
	--		shortname = dbo.fnGetName(isnull([L SUFFIX],''), isnull([FAMILY NAME],''), isnull([GIVEN NAMES],''), isnull([L MIDDLE NAME], '')), 
	--		'801' [Account Officer],
	--		isnull([NATIONALITY],''),
	--		isnull([RESIDENCE],''),
	--		isnull([SECTOR],''),
	--		isnull([INDUSTRY],''),
	--		isnull([GIVEN NAMES] ,''), -- 9
	--		isnull([L MIDDLE NAME],''),
	--		isnull([FAMILY NAME], ''),
	--		isnull([L SUFFIX], '') [L SUFFIX] , 
	--		isnull([SMS 1],''), --13
	--		isnull([DATE OF BIRTH],''),
	--		isnull([L BIRTH PLACE], ''), 
	--		name1 = dbo.fnGetName(isnull([L SUFFIX], ''), isnull([FAMILY NAME], ''), isnull([GIVEN NAMES], ''), isnull([L MIDDLE NAME], '')),
	--		isnull([CUSTOMER STATUS], ''), -- 17
	--		isnull([ADDRESS1],'') + '::' + isnull([ADDRESS2], ''),
	--		isnull([TOWN COUNTRY], ''),
	--		isnull([POST CODE],''), 
	--		isnull(o.[Occupation_R12], isnull([L OCCUPATION], '')), -- 21
	--		isnull([L SOURCE FUNDS],''),
	--		isnull([L CUSTOMER TYPE],''),
	--		isnull([L OFAC CHECK],''),
	--		isnull([TITLE], '') [TITLE], -- 25
	--		isnull([COUNTRY],''),
	--		isnull([TARGET], ''),
	--		isnull([LANGUAGE],''),
	--		'PH0010101',
	--		isnull([CLS CPARTY],''), -- 30
	--		isnull([GENDER],''),
	--		replace(isnull([EMAIL 1],''), '_', '''_'''),
	--		isnull([EMPLOYERS NAME], ''),
	--		isnull([AML CHECK] ,''), --34 
	--		isnull([AML RESULT],''),
	--		isnull([INTERNET BANKING SERVICE],''),
	--		isnull([MOBILE BANKING SERVICE],''), -- 37
	--		isnull([EXTERN SYS ID],''),
	--		isnull([EXTERN CUS ID],''),
	--		isnull([L DOCU TYPE],''),
	--		isnull([L LGL DOC NM 1],''), -- 41
	--		isnull([L TIN GSS], ''),
	--		isnull([L LEGAL ID 1],''),
	--		isnull([L PA ST], ''),
	--		isnull([L PA ADD], ''),
	--		isnull([L PA TC], ''), -- 46 
	--		case when isnull([L PA PC],'') = '1417' then '' when isnull([L PA PC],'') = '0' then '' when isnull([L PA PC],'') = '0000' then '' when isnull([L PA PC],'') = '4135'  then '' else isnull([L PA PC],'') end,	-- 47
	--		isnull([L PA CTRY 1],''), 
	--		isnull([L SSS NO], ''), 
	--		isnull([L INSTRUCTION],'') ,
	--		isnull([ADDRESS1], '') , 
	--		'Hold' [L HLD MAIL FLAG], 
	--		GETDATE() -- 53
	--from	Customer c	with(nolock)
	--left	outer	join	tbl_Occupation o with(nolock)
 --	on		c.[L OCCUPATION]	=	o.Occupation_R18
	--where	isnull([EXTERN CUS ID], '') <> ''
	--and		[EXTERN CUS ID]	not	in	(select [EXTERN CUS ID] from CUSTOMER_DME nolock)

	select	(convert( varchar,isnull([CUST_ID], '')) + '|' + isnull([MNEMONIC],'') + '|' + 
			dbo.fnGetName(isnull([L SUFFIX],''), isnull([FAMILY NAME], ''), isnull([GIVEN NAMES], ''), isnull([L MIDDLE NAME], '')) + '|' +  '801' + '|' 
			+ isnull([NATIONALITY],'') + '|' + isnull([RESIDENCE],'') + '|' + isnull([SECTOR], '') + '|' + isnull([INDUSTRY],'') + '|' + isnull([GIVEN NAMES], '') 
			+ '|' + isnull([L MIDDLE NAME],'') + '|' + isnull([FAMILY NAME],'') + '|' + isnull([L SUFFIX],'') + '|' +  isnull([SMS 1] ,'')+ '|' 
			+ isnull([DATE OF BIRTH],'')+ '|' + isnull([L BIRTH PLACE],'') + '|' + dbo.fnGetName(isnull([L SUFFIX], ''), isnull([FAMILY NAME],'') , isnull([GIVEN NAMES],'') , isnull([L MIDDLE NAME],''))  + '|' + isnull([CUSTOMER STATUS],'') + '|' 
			+ isnull([ADDRESS1],'') + '::' + isnull([ADDRESS2],'') + '|' + isnull([TOWN COUNTRY],'') + '|' + isnull([POST CODE],'') + '|' + isnull(o.[Occupation_R12], isnull([L OCCUPATION], ''))
			+ '|' + isnull([L SOURCE FUNDS],'') + '|' + isnull([L CUSTOMER TYPE],'') + '|' + isnull([L OFAC CHECK],'') + '|' + isnull([TITLE], '') + '|' 
			+ isnull([COUNTRY],'') + '|' + isnull([TARGET],'') + '|' + isnull([LANGUAGE],'') + '|' + 'PH0010101' + '|' + isnull([CLS CPARTY],'') + '|' 
			+ isnull([GENDER],'') + '|' + replace(isnull([EMAIL 1], '') , '_', '''_''') + '|' + isnull([EMPLOYERS NAME],'') + '|' + isnull([AML CHECK],'') 
			+ '|' + isnull([AML RESULT], '') + '|' + isnull([INTERNET BANKING SERVICE], '')  + '|' + isnull([MOBILE BANKING SERVICE], '')  + '|' 
			+ isnull([EXTERN SYS ID],'') + '|' + isnull([EXTERN CUS ID],'') + '|' + isnull([L DOCU TYPE],'') + '|' + isnull([L LGL DOC NM 1],'') + '|' 
			+  isnull([L TIN GSS], '') + '|' + isnull([L LEGAL ID 1],'') + '|' + isnull([L PA ST],'') + '|' + isnull([L PA ADD],'') + '|' + isnull([L PA TC],'')
			+ '|' + case when isnull([L PA PC],'') = '1417' then '' when isnull([L PA PC],'') = '0' then '' when isnull([L PA PC],'') = '0000' then '' when isnull([L PA PC],'') = '4135'  then '' else isnull([L PA PC],'') end 
			+ '|' + isnull([L PA CTRY 1],'') + '|' + isnull([L SSS NO],'') + '|' +  isnull(CAST( [L INSTRUCTION] as VARCHAR (MAX)),'') + '|' + isnull([ADDRESS1],'') + '|Hold') as CUSTOMER_DATA
	from	Customer c	with(nolock)
	left	outer	join	tbl_Occupation o with(nolock)
 	on		c.[L OCCUPATION]	=	o.Occupation_R18
	where	isnull([EXTERN CUS ID], '') <> ''
	--and		[EXTERN CUS ID]	in	('10000002','10047295', '10000007')

end
GO
/****** Object:  StoredProcedure [dbo].[sp_RunDbMigration]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============================================
-- Created By : JBacorro
-- Created Date : 05/04/2024
-- sp_RunDbMigration
-- Initial sp for Account (R18) linking to Pre
-- Generated accounts in R12
--===========================================

CREATE PROCEDURE [dbo].[sp_RunDbMigration]
AS
	--Create Temp Tables
	CREATE table #Tbl_TempAccount
	(
		tAccountId BIGINT
		, [UPLOAD COMPANY] VARCHAR
		, ID VARCHAR
		, CUSTOMER VARCHAR
		, CATEGORY VARCHAR
		, [ACCOUNT TITLE 1] VARCHAR
		, [SHORT TITLE] VARCHAR
		, CURRENCY VARCHAR
		, [ACCOUNT OFFICER] VARCHAR
		, [POSTING RESTRICT] VARCHAR
		, PASSBOOK VARCHAR
		, [ALT ACCT TYPE 1] VARCHAR
		, [ALT ACCT ID 1] VARCHAR
		, [ALLOW NETTING] VARCHAR
		, [HVT FLAG] VARCHAR
	)

	CREATE TABLE #Tbl_TempPreGen
	(
	  tPreGenId BIGINT
	  , [ACCOUNT NUMBER] VARCHAR
	  , [OLD_ACCT_ID] VARCHAR
	)

	CREATE TABLE #Tbl_MergedTable
	(
		tMergeId BIGINT
		,[UPLOAD COMPANY] VARCHAR
		, ID VARCHAR
		, CUSTOMER VARCHAR
		, CATEGORY VARCHAR
		, [ACCOUNT TITLE 1] VARCHAR
		, [SHORT TITLE] VARCHAR
		, CURRENCY VARCHAR
		, [ACCOUNT OFFICER] VARCHAR
		, [POSTING RESTRICT] VARCHAR
		, PASSBOOK VARCHAR
		, [ALT ACCT TYPE 1] VARCHAR
		, [ALT ACCT ID 1] VARCHAR
		, [ALLOW NETTING] VARCHAR
		, [HVT FLAG] VARCHAR
		, [ACCOUNT NUMBER] VARCHAR
		, [OLD_ACCT_ID] VARCHAR
	)

	/*SELECT Accounts into tempAccounts Table*/
	SELECT 
		IDENTITY(bigint) as tAccountId
		, acct1.[UPLOAD COMPANY] 
		, acct1.ID 
		, acct1.CUSTOMER 
		, acct1.CATEGORY 
		, acct1.[ACCOUNT TITLE 1] 
		, acct1.[SHORT TITLE] 
		, acct1.CURRENCY 
		, acct1.[ACCOUNT OFFICER] 
		, acct1.[POSTING RESTRICT] 
		, acct1.PASSBOOK 
		, acct1.[ALT ACCT TYPE 1] 
		, acct1.[ALT ACCT ID 1] 
		, acct1.[ALLOW NETTING] 
		, acct1.[HVT FLAG] 
		INTO Tbl_TempAccount
	FROM Account1 acct1
			INNER JOIN CUSTOMER_DME cd
		ON acct1.CUSTOMER = cd.[EXTERN CUS ID]


	/*SELECT PreGren into tempPreGen Table*/
	SELECT 
		IDENTITY(bigint) as tPreGenId
		, *
		INTO Tbl_TempPreGen
	FROM
		R12_DME_PRE_GEN

    /*Merge Temp tables*/
	SELECT
		IDENTITY(bigint) as tMergeId
		, tAccount.[UPLOAD COMPANY] 
		, tAccount.ID 
		, tAccount.CUSTOMER 
		, tAccount.CATEGORY 
		, tAccount.[ACCOUNT TITLE 1] 
		, tAccount.[SHORT TITLE] 
		, tAccount.CURRENCY 
		, tAccount.[ACCOUNT OFFICER] 
		, tAccount.[POSTING RESTRICT] 
		, tAccount.PASSBOOK 
		, tAccount.[ALT ACCT TYPE 1] 
		, tAccount.[ALT ACCT ID 1] 
		, tAccount.[ALLOW NETTING] 
		, tAccount.[HVT FLAG] 
		, tPreGen.[ACCOUNT NUMBER] 
		, tPreGen.[OLD_ACCT_ID] 
		INTO Tbl_MergedTable
	FROM Tbl_TempAccount tAccount
	INNER JOIN Tbl_TempPreGen tPreGen
		ON tAccount.tAccountId = tPreGen.tPreGenId

	--Update R12 Pre-Generated Accounts Table
	UPDATE 
		R12_DME_PRE_GEN
	SET
		OLD_ACCT_ID = tMerged.[ALT ACCT ID 1]
	FROM Tbl_MergedTable tMerged
	INNER JOIN R12_DME_PRE_GEN preGenMain
	ON tMerged.[ACCOUNT NUMBER] = preGenMain.[ACCOUNT NUMBER]


	SELECT 
	 preGen.[ACCOUNT NUMBER]
	 , preGen.OLD_ACCT_ID as PREGEN_OLD_ACCOUNT
	 , acct.[ALT ACCT ID 1] as ACCTS_ACCTID
	 , acct.CUSTOMER	 
	 FROM R12_DME_PRE_GEN preGen
	INNER JOIN Account1 acct
	ON preGen.OLD_ACCT_ID = acct.[ALT ACCT ID 1]

	DROP TABLE Tbl_TempAccount
	DROP TABLE Tbl_TempPreGen
	DROP TABLE Tbl_MergedTable

GO
/****** Object:  StoredProcedure [dbo].[sp_RunDbMigrationReUpload]    Script Date: 20/05/2024 12:22:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============================================
-- Created By : JBacorro
-- Created Date : 05/04/2024
-- sp_RunDbMigrationReUpload
-- For reupload table for Account (R18) linking to Pre
-- Generated accounts in R12
--===========================================
CREATE PROCEDURE [dbo].[sp_RunDbMigrationReUpload]
AS

	--CREATE TEMP TABLE
	CREATE table #Tbl_TempAccountReUpload
	(
		tAccountId BIGINT
		, [UPLOAD COMPANY] VARCHAR
		, ID VARCHAR
		, CUSTOMER VARCHAR
		, CATEGORY VARCHAR
		, [ACCOUNT TITLE 1] VARCHAR
		, [SHORT TITLE] VARCHAR
		, CURRENCY VARCHAR
		, [ACCOUNT OFFICER] VARCHAR
		, [POSTING RESTRICT] VARCHAR
		, PASSBOOK VARCHAR
		, [ALT ACCT TYPE 1] VARCHAR
		, [ALT ACCT ID 1] VARCHAR
		, [ALLOW NETTING] VARCHAR
		, [HVT FLAG] VARCHAR
	)

	CREATE TABLE #Tbl_TempPreGenReUpload
	(
	  tPreGenId BIGINT
	  , [ACCOUNT NUMBER] VARCHAR
	  , [OLD_ACCT_ID] VARCHAR
	)

	CREATE TABLE #Tbl_MergedTableReupload
	(
		tMergeId BIGINT
		,[UPLOAD COMPANY] VARCHAR
		, ID VARCHAR
		, CUSTOMER VARCHAR
		, CATEGORY VARCHAR
		, [ACCOUNT TITLE 1] VARCHAR
		, [SHORT TITLE] VARCHAR
		, CURRENCY VARCHAR
		, [ACCOUNT OFFICER] VARCHAR
		, [POSTING RESTRICT] VARCHAR
		, PASSBOOK VARCHAR
		, [ALT ACCT TYPE 1] VARCHAR
		, [ALT ACCT ID 1] VARCHAR
		, [ALLOW NETTING] VARCHAR
		, [HVT FLAG] VARCHAR
		, [ACCOUNT NUMBER] VARCHAR
		, [OLD_ACCT_ID] VARCHAR
	)


	--INSERT to temp tables Reupload data
	-- ACCOUNT
	SELECT 
		IDENTITY(bigint) as tAccountId
		, acct1.[UPLOAD COMPANY] 
		, acct1.ID 
		, acct1.CUSTOMER 
		, acct1.CATEGORY 
		, acct1.[ACCOUNT TITLE 1] 
		, acct1.[SHORT TITLE] 
		, acct1.CURRENCY 
		, acct1.[ACCOUNT OFFICER] 
		, acct1.[POSTING RESTRICT] 
		, acct1.PASSBOOK 
		, acct1.[ALT ACCT TYPE 1] 
		, acct1.[ALT ACCT ID 1] 
		, acct1.[ALLOW NETTING] 
		, acct1.[HVT FLAG] 
		INTO Tbl_TempAccountReUpload
	FROM 
		Account1 acct1
			INNER JOIN CUSTOMER_DME cd
				ON acct1.CUSTOMER = cd.[EXTERN CUS ID]
	WHERE
		acct1.[ALT ACCT ID 1] NOT IN (SELECT OLD_ACCT_ID FROM R12_DME_PRE_GEN WHERE OLD_ACCT_ID != '' OR OLD_ACCT_ID != NULL)
	
	-- PRE GEN
	SELECT
		IDENTITY(bigint) as tPreGenId
		, *
		INTO Tbl_TempPreGenReUpload
	FROM
		R12_DME_PRE_GEN
	WHERE OLD_ACCT_ID IS NULL

	SELECT
		IDENTITY(bigint) as tMergeId
		, tAccount.[UPLOAD COMPANY] 
		, tAccount.ID 
		, tAccount.CUSTOMER 
		, tAccount.CATEGORY 
		, tAccount.[ACCOUNT TITLE 1] 
		, tAccount.[SHORT TITLE] 
		, tAccount.CURRENCY 
		, tAccount.[ACCOUNT OFFICER] 
		, tAccount.[POSTING RESTRICT] 
		, tAccount.PASSBOOK 
		, tAccount.[ALT ACCT TYPE 1] 
		, tAccount.[ALT ACCT ID 1] 
		, tAccount.[ALLOW NETTING] 
		, tAccount.[HVT FLAG] 
		, tPreGen.[ACCOUNT NUMBER] 
		, tPreGen.[OLD_ACCT_ID] 
		INTO Tbl_MergedTableReUpload
	FROM Tbl_TempAccountReUpload tAccount
	INNER JOIN Tbl_TempPreGenReUpload tPreGen
	ON tAccount.tAccountId = tPreGen.tPreGenId

	--UPDATE PRE GEN
		--Update R12 Pre-Generated Accounts Table
	UPDATE 
		R12_DME_PRE_GEN
	SET
		OLD_ACCT_ID = tMerged.[ALT ACCT ID 1]
	FROM Tbl_MergedTableReupload tMerged
	INNER JOIN R12_DME_PRE_GEN preGenMain
	ON tMerged.[ACCOUNT NUMBER] = preGenMain.[ACCOUNT NUMBER]

	SELECT 
		preGenMain.[ACCOUNT NUMBER]
		, preGenMain.OLD_ACCT_ID as PREGEN_OLD_ACCOUNT
		, acct.[ALT ACCT ID 1] as ACCTS_ACCTID
		, acct.CUSTOMER	 
	FROM R12_DME_PRE_GEN preGenMain
		INNER JOIN Account1 acct
			ON preGenMain.OLD_ACCT_ID = acct.[ALT ACCT ID 1]
		INNER JOIN Tbl_MergedTableReupload tMerged
			ON tMerged.[ACCOUNT NUMBER] = preGenMain.[ACCOUNT NUMBER]

	DROP TABLE Tbl_TempAccountReUpload
	DROP TABLE Tbl_TempPreGenReUpload
	DROP TABLE Tbl_MergedTableReupload
GO
USE [master]
GO
ALTER DATABASE [IndependenceDB] SET  READ_WRITE 
GO

USE IndependenceDB
GO

Insert into tbl_Occupation values ('Nurse/Doctor/Medical Personnel','Prof Lawyer,Doctor,Nurse,Architect')

Insert into tbl_Occupation values ('Jewels/Stones/Metals Dealer','Jewels/Gems/Precious Metals Experts')

Insert into tbl_Occupation values ('Executive / Manager','Execu Or Seniorlevel Officl and Mgr')

Insert into tbl_Occupation values ('Police / Military','Military Personnel')

Insert into tbl_Occupation values ('Farming / Fishing','Farmer or Forestry or Fisherman')

Insert into tbl_Occupation values ('Retired / Pensioner','Retiree')

Insert into tbl_Occupation values ('Real Estate Broker and Sales Agent','Real Estate Broker')

Insert into tbl_Occupation values ('Lawyer','Lawyer')

Insert into tbl_Occupation values ('Non-office Employee','Non-office Employee')

Insert into tbl_Occupation values ('Licensed Real Estate Broker','Licensed Real Estate Broker')

Insert into tbl_Occupation values ('Self-Employed','Self-Employed')

Insert into tbl_Occupation values ('Housewife/House husband','Housewife or House husband')
