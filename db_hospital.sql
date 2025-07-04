USE [master]
GO
/****** Object:  Database [db_hospital]    Script Date: 5.06.2025 16:00:19 ******/
CREATE DATABASE [db_hospital]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_hospital', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\db_hospital.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'db_hospital_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\db_hospital_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [db_hospital] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_hospital].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_hospital] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_hospital] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_hospital] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_hospital] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_hospital] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_hospital] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [db_hospital] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_hospital] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_hospital] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_hospital] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_hospital] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_hospital] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_hospital] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_hospital] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_hospital] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db_hospital] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_hospital] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_hospital] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_hospital] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_hospital] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_hospital] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_hospital] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_hospital] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_hospital] SET  MULTI_USER 
GO
ALTER DATABASE [db_hospital] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_hospital] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_hospital] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_hospital] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [db_hospital] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [db_hospital] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [db_hospital] SET QUERY_STORE = ON
GO
ALTER DATABASE [db_hospital] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [db_hospital]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[DoctorId] [int] NULL,
	[AppointmentDate] [datetime] NULL,
	[Notes] [nvarchar](200) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Specialty] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[RoomNumber] [nvarchar](10) NULL,
	[PasswordH] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoktorHareketleri]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoktorHareketleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[GelisTarihi] [datetime] NULL,
	[GidisTarihi] [datetime] NULL,
	[HastaAdi] [nvarchar](50) NULL,
	[HastaSoyadi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GunlukHastaHareketleri]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GunlukHastaHareketleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[DoctorId] [int] NULL,
	[KayitDurumu] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabResults]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabResults](
	[ResultId] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[DoctorId] [int] NULL,
	[TestName] [nvarchar](100) NULL,
	[ResultValue] [nvarchar](100) NULL,
	[Unit] [nvarchar](20) NULL,
	[ResultDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalRecords]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalRecords](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[DoctorId] [int] NULL,
	[Diagnosis] [nvarchar](200) NULL,
	[Treatment] [nvarchar](200) NULL,
	[RecordDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[Address] [nvarchar](200) NULL,
	[Email] [nvarchar](100) NULL,
	[EmergencyContactName] [nvarchar](100) NULL,
	[EmergencyPhone] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescriptions](
	[PrescriptionId] [int] IDENTITY(1,1) NOT NULL,
	[RecordId] [int] NULL,
	[MedicineName] [nvarchar](100) NULL,
	[Dosage] [nvarchar](50) NULL,
	[DurationDays] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RadiologyImages]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RadiologyImages](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[DoctorId] [int] NULL,
	[ImageName] [nvarchar](100) NULL,
	[ImageType] [nvarchar](50) NULL,
	[ImagePath] [nvarchar](200) NULL,
	[CaptureDate] [datetime] NULL,
	[Description] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Secretaries]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Secretaries](
	[SecretaryId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[PasswordH] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Username] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[SecretaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[LabResults] ADD  DEFAULT (getdate()) FOR [ResultDate]
GO
ALTER TABLE [dbo].[MedicalRecords] ADD  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[RadiologyImages] ADD  DEFAULT (getdate()) FOR [CaptureDate]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([DoctorId])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([PatientId])
GO
ALTER TABLE [dbo].[GunlukHastaHareketleri]  WITH CHECK ADD FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([DoctorId])
GO
ALTER TABLE [dbo].[GunlukHastaHareketleri]  WITH CHECK ADD FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([PatientId])
GO
ALTER TABLE [dbo].[LabResults]  WITH CHECK ADD FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([DoctorId])
GO
ALTER TABLE [dbo].[LabResults]  WITH CHECK ADD FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([PatientId])
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([DoctorId])
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([PatientId])
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD FOREIGN KEY([RecordId])
REFERENCES [dbo].[MedicalRecords] ([RecordId])
GO
ALTER TABLE [dbo].[RadiologyImages]  WITH CHECK ADD FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([DoctorId])
GO
ALTER TABLE [dbo].[RadiologyImages]  WITH CHECK ADD FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([PatientId])
GO
/****** Object:  StoredProcedure [dbo].[AddMedicalRecord]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddMedicalRecord]
    @PatientId INT,
    @DoctorId INT,
    @RecordDate DATE,
    @Diagnosis NVARCHAR(255),
    @Treatment NVARCHAR(255)
AS
BEGIN
    INSERT INTO MedicalRecords (PatientId, DoctorId, RecordDate, Diagnosis, Treatment)
    VALUES (@PatientId, @DoctorId, @RecordDate, @Diagnosis, @Treatment);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddPrescription]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddPrescription]
    @RecordId INT,
    @MedicineName NVARCHAR(100),
    @Dosage NVARCHAR(50),
    @DurationDays INT
AS
BEGIN
    INSERT INTO Prescriptions (RecordId, MedicineName, Dosage, DurationDays)
    VALUES (@RecordId, @MedicineName, @Dosage, @DurationDays);
END;
GO
/****** Object:  StoredProcedure [dbo].[DoktorHareketleriEkle]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DoktorHareketleriEkle]
    @Ad NVARCHAR(50),
    @Soyad NVARCHAR(50),
    @GelisTarihi DATETIME,
    @GidisTarihi DATETIME
AS
BEGIN
    INSERT INTO DoktorHareketleri (Ad, Soyad, GelisTarihi, GidisTarihi)
    VALUES (@Ad, @Soyad, @GelisTarihi, @GidisTarihi)
END
GO
/****** Object:  StoredProcedure [dbo].[DoktorIsimListele]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DoktorIsimListele]
AS
BEGIN
    SELECT 
        DoctorId, 
        FirstName + ' ' + LastName AS FullName 
    FROM Doctors
END
GO
/****** Object:  StoredProcedure [dbo].[DoktorListele]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DoktorListele]
as
begin
select
DoctorId,
FirstName, 
LastName, 
Specialty, 
Email, 
PhoneNumber, 
RoomNumber
from Doctors
end
GO
/****** Object:  StoredProcedure [dbo].[GetAppointmentDetails]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetAppointmentDetails]
AS
BEGIN
    SELECT 
        a.AppointmentId,
        d.DoctorId,
        p.PatientId,
		d.Specialty,
        d.FirstName + ' ' + d.LastName AS DoctorName,
        p.FirstName + ' ' + p.LastName AS PatientName,
        a.AppointmentDate,
        a.CreatedAt,
        a.Notes
    FROM 
        Appointments AS a
    INNER JOIN
        Patients AS p ON p.PatientId = a.PatientId
    INNER JOIN 
        Doctors AS d ON d.DoctorId = a.DoctorId
END
GO
/****** Object:  StoredProcedure [dbo].[GetDoctorId]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDoctorId]
    @DoktorAdi NVARCHAR(50),
    @DoktorSoyadi NVARCHAR(50)
AS
BEGIN
    SELECT 
         d.DoctorId
       
    FROM Doctors  as d
    WHERE 
        d.FirstName = @DoktorAdi and
		d.LastName = @DoktorSoyadi
END
GO
/****** Object:  StoredProcedure [dbo].[GetDoctorNames]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDoctorNames]
AS
BEGIN
    SELECT 
        Ad,
        Soyad
    FROM DoktorHareketleri
END
GO
/****** Object:  StoredProcedure [dbo].[GetDoktorDurumu]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDoktorDurumu]
    @HastaAdi NVARCHAR(50),
    @HastaSoyadi NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM DoktorHareketleri
        WHERE 
            CAST(GETDATE() AS DATE) = CAST(GelisTarihi AS DATE)
            AND (GidisTarihi IS NULL OR GETDATE() <= GidisTarihi)
    )
    BEGIN
        SELECT 
            CONCAT('Dr. ', Ad, ' ', Soyad) AS DoktorIsmi,
            'Doktorunuz burada, muayene olabilirsiniz.' AS Mesaj
        FROM DoktorHareketleri
        WHERE 
            CAST(GETDATE() AS DATE) = CAST(GelisTarihi AS DATE)
            AND (GidisTarihi IS NULL OR GETDATE() <= GidisTarihi)
    END
    ELSE
    BEGIN
        SELECT 
            NULL AS DoktorIsmi,
            'Bugün doktorunuz yok.' AS Mesaj
    END
END
GO
/****** Object:  StoredProcedure [dbo].[GetDoktorDurumu1]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[GetDoktorDurumu1]
    @HastaAdi NVARCHAR(50),
    @HastaSoyadi NVARCHAR(50)
AS
BEGIN
    DECLARE @DoktorAd NVARCHAR(50)
    DECLARE @DoktorSoyad NVARCHAR(50)
    DECLARE @Mesaj NVARCHAR(200)

    -- Hastanın bugünkü randevusuna göre doktor bilgisi alınır
    SELECT TOP 1 
        @DoktorAd = d.FirstName,
        @DoktorSoyad = d.LastName
    FROM Patients p
    INNER JOIN Appointments a ON p.PatientId = a.PatientId
    INNER JOIN Doctors d ON a.DoctorId = d.DoctorId
    WHERE p.FirstName = @HastaAdi AND p.LastName = @HastaSoyadi
      AND CAST(GETDATE() AS DATE) = CAST(a.AppointmentDate AS DATE)

    -- Doktor bilgisi bulunduysa, hastanede olup olmadığı kontrol edilir
    IF @DoktorAd IS NOT NULL AND EXISTS (
        SELECT 1
        FROM DoktorHareketleri
        WHERE 
            Ad = @DoktorAd AND
            Soyad = @DoktorSoyad AND
            CAST(GETDATE() AS DATE) = CAST(GelisTarihi AS DATE) AND
            (GidisTarihi IS NULL OR GETDATE() <= GidisTarihi)
    )
    BEGIN
        SET @Mesaj = 'Doktorunuz ' + @DoktorAd + ' ' + @DoktorSoyad + ' burada, muayene olabilirsiniz.'
    END
    ELSE
    BEGIN
        SET @Mesaj = 'Bugün doktorunuz ' + ISNULL(@DoktorAd, '') + ' ' + ISNULL(@DoktorSoyad, '') + ' hastanede değil.'
    END

    SELECT 
        @DoktorAd AS DoktorAd,
        @DoktorSoyad AS DoktorSoyad,
        @Mesaj AS Mesaj
END
GO
/****** Object:  StoredProcedure [dbo].[GetDoktorDurumu111]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDoktorDurumu111]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.FirstName AS HastaAdi,
        p.LastName AS HastaSoyadi,
        d.FirstName AS DoktorAdi,
        d.LastName AS DoktorSoyadi
    FROM Appointments a
    INNER JOIN Patients p ON a.PatientId = p.PatientId
    INNER JOIN Doctors d ON a.DoctorId = d.DoctorId
    WHERE 
        CAST(a.AppointmentDate AS DATE) = CAST(GETDATE() AS DATE)
        AND NOT EXISTS (
            SELECT 1
            FROM DoktorHareketleri dh
            WHERE 
                dh.Ad = d.FirstName AND
                dh.Soyad = d.LastName AND
                CAST(dh.GelisTarihi AS DATE) = CAST(GETDATE() AS DATE) AND
                (dh.GidisTarihi IS NULL OR GETDATE() <= dh.GidisTarihi)
        )
END
GO
/****** Object:  StoredProcedure [dbo].[GetMedicalInfo]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetMedicalInfo]
as 
begin
SELECT 
	mr.RecordId,
	p.PatientId,
	d.DoctorId,
    p.FirstName AS HastaAdi,
    p.LastName AS HastaSoyadi,
    d.FirstName AS DoktorAdi,
    d.LastName AS DoktorSoyadi,
    mr.RecordDate AS Tarih,
    mr.Diagnosis AS Teshis,
    mr.Treatment AS Tedavi
FROM 
    MedicalRecords mr
JOIN 
    Patients p ON mr.PatientId = p.PatientId
JOIN 
    Doctors d ON mr.DoctorId = d.DoctorId;
end
GO
/****** Object:  StoredProcedure [dbo].[GetNameDoctorById]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[GetNameDoctorById]
@DoctorId int 
as
begin
select FirstName + ' ' + LastName as DoctorName
from Doctors
where @DoctorId = DoctorId
end
GO
/****** Object:  StoredProcedure [dbo].[GetNamePatientById]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetNamePatientById]
@PatientId int 
as 
begin
select FirstName + ' ' + LastName as PatientName 
from Patients
where PatientId = @PatientId
end
GO
/****** Object:  StoredProcedure [dbo].[GetPatientId]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPatientId]
    @HastaAdi NVARCHAR(50),
    @HastaSoyadi NVARCHAR(50)
AS
BEGIN
    SELECT 
        p.PatientId
       
    FROM Patients as p
    WHERE 
        p.FirstName = @HastaAdi and
        p.LastName = @HastaSoyadi 
END
GO
/****** Object:  StoredProcedure [dbo].[GetPatientLastRecords]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPatientLastRecords]
AS
BEGIN
    SELECT 
        P.PatientId,
        P.FirstName + ' ' + P.LastName AS PatientName,
        MAX(MR.RecordDate) AS LastDiagnosisDate,
        MAX(RI.CaptureDate) AS LastImageDate
    FROM 
        Patients P
    LEFT JOIN 
        MedicalRecords MR ON P.PatientId = MR.PatientId
    LEFT JOIN 
        RadiologyImages RI ON P.PatientId = RI.PatientId
    GROUP BY 
        P.PatientId, P.FirstName, P.LastName;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPatientRadiologyImages]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPatientRadiologyImages]
    @PatientId INT
AS
BEGIN
    SELECT 
        P.FirstName + ' ' + P.LastName AS PatientName,
        D.FirstName + ' ' + D.LastName AS DoctorName,
        RI.ImageType,
        RI.ImageName,
        RI.CaptureDate,
        RI.Description
    FROM 
        RadiologyImages RI
    JOIN 
        Patients P ON RI.PatientId = P.PatientId
    JOIN 
        Doctors D ON RI.DoctorId = D.DoctorId
    WHERE 
        P.PatientId = @PatientId;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPatientsOver65]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--hastaları  yaşlarına göre gruplandırıp yaşı 65 üstü olanlara evde tıbbi yardım mesajı gönderilmiştir mesajı ekrana basılır
CREATE PROCEDURE [dbo].[GetPatientsOver65]
AS
BEGIN
    SELECT 
        FirstName, 
        LastName, 
        Email,
        DATEDIFF(YEAR, DateOfBirth, GETDATE()) AS Age
    FROM Patients
    WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) > 65
    ORDER BY Age
END
GO
/****** Object:  StoredProcedure [dbo].[GetTodayAppointments]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTodayAppointments]

AS
BEGIN
    SELECT 
        p.PatientId,
        p.FirstName AS HastaAdi,
        p.LastName AS HastaSoyadi,
        d.FirstName AS DoktorAdi,
        d.LastName AS DoktorSoyadi,
        a.AppointmentDate,
        ISNULL(g.KayitDurumu, 'Hayır') AS KayitDurumu
    FROM Appointments a
    INNER JOIN Patients p ON a.PatientId = p.PatientId
    INNER JOIN Doctors d ON a.DoctorId = d.DoctorId
    LEFT JOIN GunlukHastaHareketleri g 
        ON p.PatientId = g.PatientId 
        AND a.DoctorId = g.DoctorId 
    WHERE CAST(a.AppointmentDate AS DATE) = CAST(GETDATE() AS DATE)
END
GO
/****** Object:  StoredProcedure [dbo].[GetTodayDoctorPatientList]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTodayDoctorPatientList]
AS
BEGIN
    SELECT 
        d.FirstName AS DoktorAdi,
        d.LastName AS DoktorSoyadi,
        p.FirstName AS HastaAdi,
        p.LastName AS HastaSoyadi,
        a.AppointmentDate
    FROM Appointments a
    INNER JOIN Patients p ON a.PatientId = p.PatientId
    INNER JOIN Doctors d ON a.DoctorId = d.DoctorId
    WHERE CAST(a.AppointmentDate AS DATE) = CAST(GETDATE() AS DATE)
END
GO
/****** Object:  StoredProcedure [dbo].[GetUnregisteredPatients]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUnregisteredPatients]
AS
BEGIN
    SELECT 
        p.PatientId,
        p.FirstName AS HastaAdi,
        p.LastName AS HastaSoyadi,
        d.FirstName AS DoktorAdi,
        d.LastName AS DoktorSoyadi,
        g.KayitDurumu
    FROM GunlukHastaHareketleri g
    INNER JOIN Patients p ON g.PatientId = p.PatientId
    INNER JOIN Doctors d ON g.DoctorId = d.DoctorId
    WHERE g.KayitDurumu = 'Hayır'
END
GO
/****** Object:  StoredProcedure [dbo].[ListPrescriptions]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListPrescriptions]
AS
BEGIN
    SELECT 
        --RecordId AS PrescriptionId,
		PrescriptionId,
        RecordId,
        MedicineName,
        Dosage,
        DurationDays
    FROM 
        Prescriptions;
END;
GO
/****** Object:  StoredProcedure [dbo].[SearchDiagnosisByTreatmentWord]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchDiagnosisByTreatmentWord]
    @word NVARCHAR(100)
AS
BEGIN
    SELECT Diagnosis
    FROM MedicalRecords
    WHERE Treatment LIKE '%' + @word + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddAppointment]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddAppointment]
    @PatientId INT,
    @DoctorId INT,
    @AppointmentDate DATETIME,
    @Notes NVARCHAR(200)
AS
BEGIN
    INSERT INTO Appointments (PatientId, DoctorId, AppointmentDate, Notes, CreatedAt)
    VALUES (@PatientId, @DoctorId, @AppointmentDate, @Notes, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddPatients]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_AddPatients]
@FirstName varchar(100),
@LastName varchar(100),
@DateOfBirth DATE,
@Address varchar(200),
@Email varchar(100),
@EmergencyContactName varchar(100),
@EmergencyPhone varchar(20)
as
begin
insert into Patients(FirstName,LastName,DateOfBirth, Address, Email, EmergencyContactName, EmergencyPhone ) values(@FirstName, @LastName, @DateOfBirth, @Address, @Email, @EmergencyContactName, @EmergencyPhone)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteAppointment]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DeleteAppointment]
@AppointmentId int
as
begin 
delete from Appointments
where @AppointmentId = AppointmentId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePatient]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Hasta Silme prosedürü
create proc [dbo].[sp_DeletePatient]
	@PatientId INT
as 
begin
     delete from Patients where PatientId = @PatientId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_DoktorEkle]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DoktorEkle]
@FirstName nvarchar(100),
@LastName nvarchar(100),
@Specialty nvarchar(100),
@Email nvarchar(100),
@PhoneNumber nvarchar(100),
@RoomNumber nvarchar(100)
as 
begin
insert into Doctors (FirstName, LastName, Specialty, Email, PhoneNumber, RoomNumber) values (@FirstName, @LastName, @Specialty, @Email, @PhoneNumber, @RoomNumber)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_DoktorGüncelle]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DoktorGüncelle]
@DoctorId int,
@FirstName nvarchar(100),
@LastName nvarchar(100),
@Specialty nvarchar(100),
@Email nvarchar(100),
@PhoneNumber nvarchar(100),
@RoomNumber nvarchar(100)
as 
begin
update Doctors set 
FirstName = @FirstName ,
LastName = @LastName,
Specialty = @Specialty,
Email = @Email,
PhoneNumber = @PhoneNumber,
RoomNumber = @RoomNumber
where DoctorId = @DoctorId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_DoktorSil]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DoktorSil]
@DoctorId int
as 
begin
delete from  Doctors where DoctorId = @DoctorId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllPatients]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_GetAllPatients]
as 
begin
select 
		PatientId,
        FirstName,
        LastName,
        DateOfBirth,
        Address,
        Email,
        EmergencyContactName,
        EmergencyPhone
    FROM Patients
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInfoDoctorByCredentials]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetInfoDoctorByCredentials]
	@Firstname NVARCHAR(50),
    @Lastname NVARCHAR(50),
    @PasswordH NVARCHAR(50)
as
begin
    select Firstname, Lastname, PasswordH
    from Doctors
    where Firstname = @Firstname and Lastname = @Lastname and PasswordH = @PasswordH
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInfoSecretary]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_GetInfoSecretary]
as 
begin 
select Firstname, Lastname, PasswordH
from Secretaries
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInfoSecretaryByCredentials]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetInfoSecretaryByCredentials]
    @Firstname NVARCHAR(50),
    @Lastname NVARCHAR(50),
    @PasswordH NVARCHAR(50)
AS
BEGIN
    SELECT Firstname, Lastname, PasswordH
    FROM Secretaries
    WHERE Firstname = @Firstname AND Lastname = @Lastname AND PasswordH = @PasswordH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLabResultsByTest]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetLabResultsByTest]
    @TestName NVARCHAR(100),
	@FirstName nvarchar(100),
	@LastName nvarchar(100)
AS
BEGIN
    SELECT 
        p.FirstName + ' ' + p.LastName AS PatientName,
        lr.TestName,
        lr.ResultValue,
        lr.ResultDate
    FROM LabResults lr
    INNER JOIN Patients p ON lr.PatientId = p.PatientId
    WHERE lr.TestName = @TestName
    ORDER BY lr.ResultDate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPatientCountByDoctorAndDate]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetPatientCountByDoctorAndDate]
    @DoctorFirstName NVARCHAR(100),
    @DoctorLastName NVARCHAR(100),
    @AppointmentDate DATE
AS
BEGIN
    SELECT 
        d.FirstName + ' ' + d.LastName AS DoctorName,
        COUNT(DISTINCT a.PatientId) AS PatientCount
    FROM 
        Appointments a
    INNER JOIN 
        Doctors d ON a.DoctorId = d.DoctorId
    INNER JOIN 
        Patients p ON a.PatientId = p.PatientId
    WHERE 
        d.FirstName = @DoctorFirstName
        AND d.LastName = @DoctorLastName
        AND CAST(a.AppointmentDate AS DATE) = @AppointmentDate
    GROUP BY 
        d.FirstName, d.LastName
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAppointment]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UpdateAppointment]
	@AppointmentId int,
	@PatientId INT,
    @DoctorId INT,
    @AppointmentDate DATETIME,
    @Notes NVARCHAR(200)
as
begin
update Appointments 
set
PatientId=@PatientId,
DoctorId=@DoctorId,
AppointmentDate=@AppointmentDate,
Notes = @Notes
where AppointmentId=@AppointmentId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePatient]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdatePatient]
    @PatientId INT,
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @DateOfBirth DATE,
    @Address NVARCHAR(200),
    @Email NVARCHAR(100),
    @EmergencyContactName NVARCHAR(100),
    @EmergencyPhone NVARCHAR(20)
AS
BEGIN
    UPDATE Patients
    SET 
        FirstName = @FirstName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        Address = @Address,
        Email = @Email,
        EmergencyContactName = @EmergencyContactName,
        EmergencyPhone = @EmergencyPhone
    WHERE PatientId = @PatientId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateKayitDurumu]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateKayitDurumu]
    @PatientId INT,
    @DoctorId INT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM GunlukHastaHareketleri 
        WHERE PatientId = @PatientId AND DoctorId = @DoctorId
    )
    BEGIN
        UPDATE GunlukHastaHareketleri
        SET KayitDurumu = 'Evet'
        WHERE PatientId = @PatientId AND DoctorId = @DoctorId
    END
    ELSE
    BEGIN
        INSERT INTO GunlukHastaHareketleri (PatientId, DoctorId, KayitDurumu)
        VALUES (@PatientId, @DoctorId, 'Evet')
    END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateMedicalRecord]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMedicalRecord]
    @RecordId INT,
	@PatientId INT,
    @DoctorId INT,
    @Diagnosis NVARCHAR(255),
    @Treatment NVARCHAR(255)
AS
BEGIN
    UPDATE MedicalRecords
    SET Diagnosis = @Diagnosis,
        Treatment = @Treatment,
		DoctorId = @DoctorId,
		PatientId = @PatientId
    WHERE RecordId = @RecordId
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePrescription]    Script Date: 5.06.2025 16:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePrescription]
    @PrescriptionId INT,
    @MedicineName NVARCHAR(100),
    @Dosage NVARCHAR(50),
    @DurationDays INT
AS
BEGIN
    UPDATE Prescriptions
    SET 
        MedicineName = @MedicineName,
        Dosage = @Dosage,
        DurationDays = @DurationDays
    WHERE PrescriptionId = @PrescriptionId;
END;
GO
USE [master]
GO
ALTER DATABASE [db_hospital] SET  READ_WRITE 
GO
