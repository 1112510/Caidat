USE [master]
GO
/****** Object:  Database [ThuVien_Trail]    Script Date: 2014-11-30 6:27:23 PM ******/
CREATE DATABASE [ThuVien_Trail]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ThuVien_Trail', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ThuVien_Trail.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ThuVien_Trail_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ThuVien_Trail_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ThuVien_Trail] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ThuVien_Trail].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ThuVien_Trail] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET ARITHABORT OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ThuVien_Trail] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ThuVien_Trail] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ThuVien_Trail] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ThuVien_Trail] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ThuVien_Trail] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET RECOVERY FULL 
GO
ALTER DATABASE [ThuVien_Trail] SET  MULTI_USER 
GO
ALTER DATABASE [ThuVien_Trail] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ThuVien_Trail] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ThuVien_Trail] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ThuVien_Trail] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ThuVien_Trail', N'ON'
GO
USE [ThuVien_Trail]
GO
/****** Object:  StoredProcedure [dbo].[sp_Giahan]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Giahan](@idsach int)
as 
begin
if (select SolanGH from phieumuon where IDsach=@idsach)>=1
begin
update phieumuon set Ngayhethan=DATEADD(day,7,Ngayhethan),SolanGH=SolanGH-1 where IDsach=@idsach
end
else
begin
print 'Het lan gia han'
end
end

GO
/****** Object:  Table [dbo].[Answer]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[ID_a] [int] IDENTITY(1,1) NOT NULL,
	[Answer] [nvarchar](60) NULL,
	[Answer_choice] [bit] NULL,
	[ID_q] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_a] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[phieumuon]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[phieumuon](
	[IDdocgia] [char](8) NOT NULL,
	[IDsach] [int] NOT NULL,
	[Ngaymuon] [datetime] NOT NULL,
	[Ngayhethan] [datetime] NULL,
	[Ngaytra] [datetime] NULL,
	[SolanGH] [int] NULL,
	[Ghichu] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDdocgia] ASC,
	[IDsach] ASC,
	[Ngaymuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[ID_q] [int] IDENTITY(1,1) NOT NULL,
	[Questiontext] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_q] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sach]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sach](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Tensach] [nvarchar](40) NULL,
	[Theloai] [nvarchar](20) NULL,
	[Tacgia] [nvarchar](50) NULL,
	[NXB] [nvarchar](20) NULL,
	[Namsx] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_DocGia]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_DocGia](
	[ID] [char](8) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Email] [char](50) NULL,
	[SDT] [char](12) NULL,
	[CMND] [char](12) NULL,
	[MSSV] [char](8) NULL,
	[Khoa] [nvarchar](50) NULL,
	[NgaySinh] [datetime] NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[NgayCapNhat] [datetime] NULL,
	[NgayHetHan] [datetime] NULL,
	[User] [char](10) NOT NULL,
	[Pass] [char](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_DocGia_Tam]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_DocGia_Tam](
	[ID] [int] NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Email] [char](50) NULL,
	[SDT] [char](12) NULL,
	[CMND] [char](12) NULL,
	[MSSV] [char](8) NULL,
	[Khoa] [nvarchar](50) NULL,
	[NgaySinh] [datetime] NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[NgayCapNhat] [datetime] NULL,
	[NgayHetHan] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_LoaiNV]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_LoaiNV](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_NhanVien]    Script Date: 2014-11-30 6:27:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_NhanVien](
	[ID] [char](10) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [char](12) NULL,
	[Email] [nvarchar](50) NULL,
	[LoaiNV] [int] NOT NULL,
	[Luong] [float] NULL,
	[Password] [char](10) NULL,
	[CapBac] [nvarchar](50) NULL,
	[User] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tbl_DocGia] ADD  DEFAULT ('a') FOR [User]
GO
ALTER TABLE [dbo].[tbl_DocGia] ADD  DEFAULT ('a') FOR [Pass]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([ID_q])
REFERENCES [dbo].[Question] ([ID_q])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
ALTER TABLE [dbo].[phieumuon]  WITH CHECK ADD  CONSTRAINT [FK_phieumuon_docgia] FOREIGN KEY([IDdocgia])
REFERENCES [dbo].[tbl_DocGia] ([ID])
GO
ALTER TABLE [dbo].[phieumuon] CHECK CONSTRAINT [FK_phieumuon_docgia]
GO
ALTER TABLE [dbo].[phieumuon]  WITH CHECK ADD  CONSTRAINT [FK_phieumuon_sach] FOREIGN KEY([IDsach])
REFERENCES [dbo].[Sach] ([ID])
GO
ALTER TABLE [dbo].[phieumuon] CHECK CONSTRAINT [FK_phieumuon_sach]
GO
ALTER TABLE [dbo].[tbl_DocGia]  WITH CHECK ADD CHECK  (([GioiTinh]=N'Nữ' OR [GioiTinh]='Nam'))
GO
ALTER TABLE [dbo].[tbl_DocGia_Tam]  WITH CHECK ADD CHECK  (([GioiTinh]=N'Nữ' OR [GioiTinh]='Nam'))
GO
USE [master]
GO
ALTER DATABASE [ThuVien_Trail] SET  READ_WRITE 
GO
