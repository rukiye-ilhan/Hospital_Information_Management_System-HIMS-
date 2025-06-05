create database db_hospital

CREATE TABLE Patients (
    PatientId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    DateOfBirth DATE,
    Address NVARCHAR(200),
    Email NVARCHAR(100),
    EmergencyContactName NVARCHAR(100),
    EmergencyPhone NVARCHAR(20)
);
CREATE TABLE Secretaries (
    SecretaryId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    PasswordH NVARCHAR(100), -- Şifre hashlenmiş olarak saklanmalı
    PhoneNumber NVARCHAR(20)
);


CREATE TABLE Doctors (
    DoctorId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Specialty NVARCHAR(100),
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    RoomNumber NVARCHAR(10)
);
--Sekreter taadından Doktor işlemlerine tıklanılır Doktor kayıt silme güncellem işlemlerinin stored procedurle yapılması için sorgular
create proc DoktorListele
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
exec DoktorListele

create proc sp_DoktorEkle
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

create proc sp_DoktorGüncelle
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

create proc sp_DoktorSil
@DoctorId int
as 
begin
delete from  Doctors where DoctorId = @DoctorId
end


















alter table Doctors
add PasswordH nvarchar(100);

CREATE TABLE Appointments (
    AppointmentId INT PRIMARY KEY IDENTITY(1,1),
    PatientId INT FOREIGN KEY REFERENCES Patients(PatientId),
    DoctorId INT FOREIGN KEY REFERENCES Doctors(DoctorId),
    AppointmentDate DATETIME,
    Notes NVARCHAR(200),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME
);
-- Hasta randevu oluşturma silme güncelleme işlemleri öncellikle randevu hasta doktor isimlerini joinle biraraya getiricem ve stored proc sorguşarımı bu tablo üzerinden yapıcam
select * from Patients
select * from Doctors
select * from Appointments

create proc GetAppointmentDetails
as
begin
select 
a.AppointmentId,
d.DoctorId,
p.PatientId,
d.FirstName + ' ' + d.LastName as DoctorName,
d.Specialty,
p.FirstName + ' ' + p.LastName as PatientName,
a.AppointmentDate,
a.CreatedAt,
a.Notes
from 
Appointments as  a
inner join
Patients as  p
on p.PatientId = a.PatientId
inner join 
Doctors as d
on d.DoctorId = a.DoctorId
end
exec GetAppointmentDetails

--hastaıd ve doktorıd bilgileri alınıcak procedurede bunların isim soyismini vericek
create proc GetNamePatientById
@PatientId int 
as 
begin
select FirstName + ' ' + LastName as PatientName 
from Patients
where PatientId = @PatientId
end

create proc GetNameDoctorById
@DoctorId int 
as
begin
select FirstName + ' ' + LastName as DoctorName
from Doctors
where @DoctorId = DoctorId
end








CREATE TABLE MedicalRecords (
    RecordId INT PRIMARY KEY IDENTITY(1,1),
    PatientId INT FOREIGN KEY REFERENCES Patients(PatientId),
    DoctorId INT FOREIGN KEY REFERENCES Doctors(DoctorId),
    Diagnosis NVARCHAR(200),
    Treatment NVARCHAR(200),
    RecordDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Prescriptions (
    PrescriptionId INT PRIMARY KEY IDENTITY(1,1),
    RecordId INT FOREIGN KEY REFERENCES MedicalRecords(RecordId),
    MedicineName NVARCHAR(100),
    Dosage NVARCHAR(50),
    DurationDays INT
);

CREATE TABLE LabResults (
    ResultId INT PRIMARY KEY IDENTITY(1,1),
    PatientId INT FOREIGN KEY REFERENCES Patients(PatientId),
    DoctorId INT FOREIGN KEY REFERENCES Doctors(DoctorId),
    TestName NVARCHAR(100),
    ResultValue NVARCHAR(100),
    Unit NVARCHAR(20),
    ResultDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE RadiologyImages (
    ImageId INT PRIMARY KEY IDENTITY(1,1),
    PatientId INT FOREIGN KEY REFERENCES Patients(PatientId),
    DoctorId INT FOREIGN KEY REFERENCES Doctors(DoctorId),
    ImageName NVARCHAR(100),
    ImageType NVARCHAR(50),         -- Örn: X-ray, MRI, CT
    ImagePath NVARCHAR(200),        -- Görüntü dosyasının yolu
    CaptureDate DATETIME DEFAULT GETDATE(), -- Çekim tarihi
    Description NVARCHAR(200)       -- Açıklama
);



INSERT INTO Doctors (FirstName, LastName, Specialty, Email, PhoneNumber, RoomNumber)
VALUES 
('Halil İbrahim', 'İlhan', 'Nöroşuriji', 'halil.ibrahim@hastane.com', '05320000000', 'A101'),
('Evin', 'İlhan', 'Kardiyoloji', 'evin.ilhan@hastane.com', '05321111111', 'B202');

UPDATE Doctors
SET PasswordH = '1234'
WHERE DoctorId = 1;

UPDATE Doctors
SET PasswordH = '5678'
WHERE DoctorId = 2;


select * from Doctors




INSERT INTO Patients (FirstName, LastName, DateOfBirth, Address, Email, EmergencyContactName, EmergencyPhone)
VALUES 
('Necla', 'İlhan', '1982-05-7', 'İstanbul, Sultanbeyli', 'necla.ilhan@gmail.com', 'Rukiye İlhan', '05440000000'),
('Rabia ', 'İlhan', '2003-03-2', 'İstanbul, Kadıköy', 'rabia.ilhan@gmail.com', 'Ayşe İlhan', '05441111111');

INSERT INTO Appointments (PatientId, DoctorId, AppointmentDate, Notes)
VALUES 
(1, 1, '2025-06-01 10:00', 'Baş ağrısı şikayeti '),
(2, 2, '2025-06-02 14:00', 'Rutin kontrol');

SELECT DISTINCT CAST(AppointmentDate AS DATE) AS RandevuTarihi
FROM Appointments
ORDER BY RandevuTarihi DESC;


INSERT INTO MedicalRecords (PatientId, DoctorId, Diagnosis, Treatment)
VALUES 
(1, 1, 'Amaliyat sonrası beyinde sıvı birikimi', 'İlaç tedavisi'),
(2, 2, 'Devam eden göğüs ağrısı şikayeti', 'Dinlenme ve ilaç');

INSERT INTO Prescriptions (RecordId, MedicineName, Dosage, DurationDays)
VALUES 
(1, 'Merhem', '1 tablet/gün', 30),
(2, 'Astım ilacı', '2 tablet/gün', 5);

INSERT INTO LabResults (PatientId, DoctorId, TestName, ResultValue, Unit)
VALUES 
(1, 1, 'MR Sonucu', 'Normal', ''),
(2, 2, 'Tansiyon ', '140/90', 'mmHg');
create proc get
select  p.FirstName, p.LastName, lr.ResultValue,lr.TestName from Patients as p inner join LabResults lr on p.PatientId = lr.PatientId

INSERT INTO RadiologyImages (PatientId, DoctorId, ImageName, ImageType, ImagePath, CaptureDate, Description)
VALUES
(1, 1, 'Neclailhan_BT.jpg', 'BT X-ray', 'C:\\Images\\Neclailhan_BT.jpg', '2025-05-20', 'Amaliyat sonrası kontrol'),
(2, 2, 'Rabiaİlhan.png', 'X-ray', 'C:\\Images\\Rabiaİlhan_.png', '2025-05-25', 'Devam eden gçğüs ağrısı şikayeti');



select * from RadiologyImages
SELECT * FROM dbo.RadiologyImages;

SELECT TOP 1 PatientId FROM Patients ORDER BY PatientId DESC;
SELECT TOP 1 DoctorId FROM Doctors ORDER BY DoctorId DESC;


INSERT INTO Secretaries (FirstName, LastName, Email, PasswordH, PhoneNumber)
VALUES 
('Zeynep', 'Demir', 'zeynep.demir@hastane.com', '1234', '05550000000');

alter table Secretaries 
add Username nvarchar(200);

update Secretaries 
set Username = concat(FirstName,'_',LastName)
Where Username is null
select * from Secretaries

--STORED PROCEDURS
create procedure sp_GetInfoSecretary
as 
begin 
select Firstname, Lastname, PasswordH
from Secretaries
end

create procedure sp_GetInfoSecretaryByCredentials
    @Firstname NVARCHAR(50),
    @Lastname NVARCHAR(50),
    @PasswordH NVARCHAR(50)
as
begin
    select Firstname, Lastname, PasswordH
    from Secretaries
    where Firstname = @Firstname and Lastname = @Lastname and PasswordH = @PasswordH
end

create proc sp_GetInfoDoctorByCredentials
	@Firstname NVARCHAR(50),
    @Lastname NVARCHAR(50),
    @PasswordH NVARCHAR(50)
as
begin
    select Firstname, Lastname, PasswordH
    from Doctors
    where Firstname = @Firstname and Lastname = @Lastname and PasswordH = @PasswordH
end

insert into Doctors(FirstName, LastName, Specialty, Email, PhoneNumber, RoomNumber,PasswordH)
VALUES 
('Ömer', 'İlhan', 'Dermotoloji', 'omer.ılhan@hastane.com', '05320000011', 'A103','5346')

exec sp_GetInfoDoctorByCredentials
@Firstname = 'Ömer',
@LastName = 'İlhan',
@PasswordH = '5346'



--Hastaları listeleme prosedürü
create proc sp_GetAllPatients
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

--hastaları silme prosedürü
CREATE PROCEDURE sp_UpdatePatient
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


EXEC sp_UpdatePatient
    @PatientId = 1,
    @FirstName = 'Ali Can',
    @LastName = 'Yılmaz',
    @DateOfBirth = '1990-05-01',
    @Address = 'Yeni Mahalle',
    @Email = 'ali@example.com',
    @EmergencyContactName = 'Veli',
    @EmergencyPhone = '555-1234'

select * from Patients

-- Hasta Silme prosedürü
create proc sp_DeletePatient
	@PatientId INT
as 
begin
     delete from Patients where PatientId = @PatientId
end

create proc sp_AddPatients
@PatiendId INT,
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
---Hasta randevusunu oluşturma ve appoıintmnet veri tabanına eklem procedue'si
CREATE PROCEDURE sp_AddAppointment
    @PatientId INT,
    @DoctorId INT,
    @AppointmentDate DATETIME,
    @Notes NVARCHAR(200)
AS
BEGIN
    INSERT INTO Appointments (PatientId, DoctorId, AppointmentDate, Notes, CreatedAt)
    VALUES (@PatientId, @DoctorId, @AppointmentDate, @Notes, GETDATE());
END

create proc sp_UpdateAppointment
	@AppointmentId int,
	@PatientId INT,
    @DoctorId INT,
    @AppointmentDate DATETIME,
    @Notes NVARCHAR(200)
as
begin
update Appointments 
set
@PatientId=PatientId,
@DoctorId=DoctorId,
@AppointmentDate=AppointmentDate,
@Notes = Notes
where @AppointmentId = AppointmentId
end

create proc sp_DeleteAppointment
@AppointmentId int
as
begin 
delete from Appointments
where @AppointmentId = AppointmentId
end

--doktor ismi seçilir tarih seçilir ve o gün her bir doktorun hasta sayısı sıralanır
CREATE PROCEDURE sp_GetPatientCountByDoctorAndDate
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

CREATE PROCEDURE DoktorIsimListele
AS
BEGIN
    SELECT 
        DoctorId, 
        FirstName + ' ' + LastName AS FullName 
    FROM Doctors
END

--hastaları  yaşlarına göre gruplandırıp yaşı 65 üstü olanlara evde tıbbi yardım mesajı gönderilmiştir mesajı ekrana basılır
CREATE PROCEDURE GetPatientsOver65
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

---
CREATE PROCEDURE sp_GetLabResultsByTest
    @TestName NVARCHAR(100)
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

--
CREATE PROCEDURE GetPatientLastRecords
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
EXEC GetPatientLastRecords


CREATE PROCEDURE GetPatientRadiologyImages
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

EXEC GetPatientRadiologyImages @PatientId = 1;
SELECT * FROM Doctors WHERE DoctorId = 1;

SELECT * FROM RadiologyImages WHERE PatientId = 1;

SELECT * FROM Patients WHERE PatientId = 1;

INSERT INTO Secretaries (FirstName, LastName, Email, PasswordH, PhoneNumber, Username)
VALUES
('Zeynep', 'Demir', 'zeynep.demir@hastane.com', '1234', '05550000000', 'Zeynep_Demir'),
('Ahmet', 'Kaya', 'ahmet.kaya@hastane.com', '2345', '05551111111', 'Ahmet_Kaya'),
('Ayşe', 'Yılmaz', 'ayse.yilmaz@hastane.com', '3456', '05552222222', 'Ayşe_Yılmaz'),
('Mehmet', 'Çelik', 'mehmet.celik@hastane.com', '4567', '05553333333', 'Mehmet_Çelik'),
('Fatma', 'Şahin', 'fatma.sahin@hastane.com', '5678', '05554444444', 'Fatma_Şahin'),
('Ali', 'Demir', 'ali.demir@hastane.com', '6789', '05555555555', 'Ali_Demir'),
('Elif', 'Kurt', 'elif.kurt@hastane.com', '7890', '05556666666', 'Elif_Kurt'),
('Mustafa', 'Aydın', 'mustafa.aydin@hastane.com', '8901', '05557777777', 'Mustafa_Aydın'),
('Emine', 'Koç', 'emine.koc@hastane.com', '9012', '05558888888', 'Emine_Koç'),
('Hasan', 'Polat', 'hasan.polat@hastane.com', '0123', '05559999999', 'Hasan_Polat'),
('Sevgi', 'Güneş', 'sevgi.gunes@hastane.com', '1235', '05550011111', 'Sevgi_Güneş'),
('Yusuf', 'Arslan', 'yusuf.arslan@hastane.com', '2346', '05550112222', 'Yusuf_Arslan'),
('Merve', 'Kılıç', 'merve.kilic@hastane.com', '3457', '05550223333', 'Merve_Kılıç'),
('Burak', 'Öztürk', 'burak.ozturk@hastane.com', '4568', '05550334444', 'Burak_Öztürk'),
('Seda', 'Çetin', 'seda.cetin@hastane.com', '5679', '05550445555', 'Seda_Çetin');


INSERT INTO Patients (FirstName, LastName, DateOfBirth, Address, Email, EmergencyContactName, EmergencyPhone)
VALUES
('Ahmet', 'Yılmaz', '1980-01-15', 'Ankara, Çankaya', 'ahmet.yilmaz@example.com', 'Mehmet Yılmaz', '05430000001'),
('Ayşe', 'Demir', '1975-03-22', 'İzmir, Karşıyaka', 'ayse.demir@example.com', 'Fatma Demir', '05430000002'),
('Mehmet', 'Kaya', '1990-07-10', 'Bursa, Nilüfer', 'mehmet.kaya@example.com', 'Ali Kaya', '05430000003'),
('Fatma', 'Çelik', '1985-11-30', 'Adana, Seyhan', 'fatma.celik@example.com', 'Zeynep Çelik', '05430000004'),
('Ali', 'Şahin', '1970-05-05', 'Antalya, Muratpaşa', 'ali.sahin@example.com', 'Hasan Şahin', '05430000005'),
('Elif', 'Aydın', '1995-09-18', 'Konya, Selçuklu', 'elif.aydin@example.com', 'Emine Aydın', '05430000006'),
('Mustafa', 'Koç', '1988-12-25', 'Gaziantep, Şahinbey', 'mustafa.koc@example.com', 'Yusuf Koç', '05430000007'),
('Emine', 'Polat', '1978-06-14', 'Mersin, Yenişehir', 'emine.polat@example.com', 'Sevgi Polat', '05430000008'),
('Hasan', 'Güneş', '1965-08-09', 'Kayseri, Melikgazi', 'hasan.gunes@example.com', 'Burak Güneş', '05430000009'),
('Sevgi', 'Arslan', '1992-04-27', 'Eskişehir, Tepebaşı', 'sevgi.arslan@example.com', 'Seda Arslan', '05430000010'),
('Yusuf', 'Kılıç', '1983-02-13', 'Samsun, İlkadım', 'yusuf.kilic@example.com', 'Merve Kılıç', '05430000011'),
('Merve', 'Öztürk', '1998-10-05', 'Trabzon, Ortahisar', 'merve.ozturk@example.com', 'Burak Öztürk', '05430000012'),
('Burak', 'Çetin', '1973-07-19', 'Malatya, Battalgazi', 'burak.cetin@example.com', 'Seda Çetin', '05430000013'),
('Seda', 'Yıldız', '1986-12-01', 'Erzurum, Yakutiye', 'seda.yildiz@example.com', 'Ahmet Yıldız', '05430000014'),
('Ahmet', 'Kurt', '1991-03-08', 'Denizli, Pamukkale', 'ahmet.kurt@example.com', 'Ayşe Kurt', '05430000015');

select * from Appointments
UPDATE Appointments
SET AppointmentDate = '2025-06-04 00:00'
WHERE DoctorId IN (16, 17)
  AND CAST(AppointmentDate AS DATE) <> '2025-06-04';

INSERT INTO Appointments (PatientId, DoctorId, AppointmentDate, Notes)
VALUES
(16, 16, '2025-06-04 09:00', 'Genel kontrol'),
(4, 4, '2025-06-04 10:30', 'Kan tahlili sonuçları değerlendirme'),
(17, 17, '2025-06-04 11:00', 'Rutin muayene'),
(18, 18, '2025-06-06 14:00', 'Baş ağrısı şikayeti'),
(7, 7, '2025-06-07 15:30', 'Mide bulantısı ve kusma'),
(8, 8, '2025-06-08 16:00', 'Diyabet kontrolü'),
(9, 9, '2025-06-09 09:30', 'Tansiyon ölçümü'),
(10, 10, '2025-06-10 10:00', 'Alerji testi'),
(11, 11, '2025-06-11 11:30', 'Cilt döküntüsü'),
(12, 12, '2025-06-12 13:00', 'Böbrek fonksiyon testi'),
(13, 13, '2025-06-13 14:30', 'Röntgen kontrolü'),
(14, 14, '2025-06-14 15:00', 'Anestezi ön değerlendirme'),
(15, 15, '2025-06-15 16:30', 'Uyku bozukluğu şikayeti');

select * from Patients
select * from Doctors
select * from MedicalRecords
INSERT INTO Doctors (FirstName, LastName, Specialty, Email, PhoneNumber, RoomNumber, PasswordH)
VALUES
('Behiza', 'Şener', 'Göz Hastalıkları', 'doktor6@mail.com', '+907340797034', 'B100', '2000'),
('Eflâtun', 'Öcalan', 'Psikiyatri', 'doktor7@mail.com', '08926717386', 'B101', '2001'),
('Murat', 'Yıldız', 'Ortopedi', 'murat.yildiz@mail.com', '05321234567', 'C201', '2002'),
('Ayşe', 'Kara', 'Dahiliye', 'ayse.kara@mail.com', '05327654321', 'C202', '2003'),
('Mehmet', 'Demir', 'Kardiyoloji', 'mehmet.demir@mail.com', '05329876543', 'C203', '2004'),
('Elif', 'Çelik', 'Nöroloji', 'elif.celik@mail.com', '05325432109', 'C204', '2005'),
('Ahmet', 'Şahin', 'Üroloji', 'ahmet.sahin@mail.com', '05322345678', 'C205', '2006'),
('Fatma', 'Aydın', 'Gastroenteroloji', 'fatma.aydin@mail.com', '05321239876', 'C206', '2007'),
('Ali', 'Yılmaz', 'Endokrinoloji', 'ali.yilmaz@mail.com', '05324567890', 'C207', '2008'),
('Zeynep', 'Koç', 'Hematoloji', 'zeynep.koc@mail.com', '05326789012', 'C208', '2009'),
('Can', 'Güneş', 'Onkoloji', 'can.gunes@mail.com', '05327890123', 'C209', '2010'),
('Emine', 'Polat', 'Dermatoloji', 'emine.polat@mail.com', '05328901234', 'C210', '2011'),
('Hakan', 'Öztürk', 'Nefroloji', 'hakan.ozturk@mail.com', '05329012345', 'C211', '2012'),
('Sevgi', 'Arslan', 'Radyoloji', 'sevgi.arslan@mail.com', '05320123456', 'C212', '2013'),
('Yusuf', 'Kılıç', 'Anesteziyoloji', 'yusuf.kilic@mail.com', '05321234567', 'C213', '2014');


INSERT INTO MedicalRecords (PatientId, DoctorId, RecordDate, Diagnosis, Treatment)
VALUES
(1, 3, '2025-06-01', 'Hipertansiyon', 'Tansiyon ilacı reçete edildi'),
(2, 4, '2025-06-02', 'Şeker hastalığı', 'Diyet ve ilaç tedavisi başlatıldı'),
(19, 5, '2025-06-03', 'Migren', 'Ağrı kesici tedavi verildi'),
(4, 6, '2025-06-04', 'Anemi', 'Demir takviyesi önerildi'),
(18, 7, '2025-06-05', 'Gastrit', 'Antiasit ilaç başlandı'),
(17, 8, '2025-06-06', 'Kolesterol yüksekliği', 'Diyet ve statin verildi'),
(7, 9, '2025-06-07', 'Alerjik rinit', 'Antihistaminik yazıldı'),
(8, 10, '2025-06-08', 'Cilt enfeksiyonu', 'Antibiyotik tedavisi uygulandı'),
(9, 11, '2025-06-09', 'Böbrek taşı', 'İdrar söktürücü önerildi'),
(10, 12, '2025-06-10', 'Kırık şüphesi', 'Röntgen istendi'),
(11, 13, '2025-06-11', 'Kansızlık', 'Kan tahlili sonucu değerlendirildi'),
(12, 14, '2025-06-12', 'Sırt ağrısı', 'Fizik tedaviye yönlendirildi'),
(13, 15, '2025-06-13', 'Depresyon', 'Psikiyatri kontrolü önerildi'),
(14, 3, '2025-06-14', 'Bronşit', 'Nebulizatör tedavisi başlandı'),
(15, 4, '2025-06-15', 'Hipotiroidi', 'Levotiroksin başlandı');

SELECT * FROM Prescriptions 

select * from MedicalRecords

INSERT INTO Prescriptions (RecordId, MedicineName, Dosage, DurationDays)
VALUES
(1005, 'Norvasc', '5mg', '30'),
(1006, 'Glucophage', '850mg', '90'),
(1007, 'Parol', '500mg', '10'),
(1008, 'Ferrum', '100mg', '60'),
(1009, 'Nexium', '20mg','14'),
(1010, 'Lipitor', '10mg', '30'),
(1011, 'Aerius', '5mg', '20'),
(1012, 'Augmentin', '625mg',  '7'),
(1013, 'Biteral', '250mg',  '10'),
(1014, 'Muscoril', '4mg', '5'),
(1015, 'Ferrosanol', '100mg', '60'),
(1016, 'Nimes', '100mg' ,'5'),
(1017, 'Prozac', '20mg',  '60'),
(1018, 'Ventolin', 'İnhalasyon',  '10'),
(1019, 'Euthyrox', '50mcg','30');

INSERT INTO LabResults (PatientId, DoctorId, TestName, ResultValue, Unit) VALUES
(19, 3, 'MR Sonucu', 'Normal', ''),
(2, 2, 'Tansiyon', '140/90', 'mmHg'),
(18, 18, 'Kan Şekeri', '105', 'mg/dL'),
(4, 4, 'Hemoglobin', '13.5', 'g/dL'),
(17, 17, 'CRP', '1.2', 'mg/L'),
(16, 16, 'Kan Grubu', 'A+', ''),
(7, 7, 'Tiroid TSH', '2.5', 'uIU/mL'),
(8, 8, 'B12 Vitamini', '350', 'pg/mL'),
(9, 9, 'D Vitamini', '25', 'ng/mL'),
(10, 10, 'Tam Kan', 'Normal', ''),
(11, 11, 'Sedimantasyon', '15', 'mm/saat'),
(12, 12, 'Lipid Panel', 'Yüksek', ''),
(13, 13, 'Glukoz', '110', 'mg/dL'),
(14, 14, 'Üre', '35', 'mg/dL'),
(15, 15, 'ALT', '45', 'U/L');
select * from Patients
select * from Doctors
select * from Appointments

INSERT INTO RadiologyImages (PatientId, DoctorId, ImageName, ImageType, ImagePath, CaptureDate, Description) VALUES
(19, 1, 'Neclailhan_BT.jpg', 'BT X-ray', 'C:\\Images\\Neclailhan_BT.jpg', '2025-05-20', 'Ameliyat sonrası kontrol'),
(2, 2, 'Rabiaİlhan.png', 'X-ray', 'C:\\Images\\Rabiaİlhan.png', '2025-05-25', 'Devam eden göğüs ağrısı şikayeti'),
(17, 3, 'AhmetCan_MRI.jpg', 'MRI', 'C:\\Images\\AhmetCan_MRI.jpg', '2025-04-10', 'Baş ağrısı değerlendirmesi'),
(4, 4, 'FatmaDemir_CT.png', 'CT', 'C:\\Images\\FatmaDemir_CT.png', '2025-03-15', 'Karın bölgesi ağrısı'),
(16, 5, 'AliVeli_Xray.jpg', 'X-ray', 'C:\\Images\\AliVeli_Xray.jpg', '2025-05-01', 'Kırık şüphesi'),
(18, 6, 'ZeynepYıldız_Mammo.png', 'Mammografi', 'C:\\Images\\ZeynepYıldız_Mammo.png', '2025-01-25', 'Rutin kontrol'),
(7, 7, 'MuratKaya_USG.jpg', 'Ultrason', 'C:\\Images\\MuratKaya_USG.jpg', '2025-02-10', 'Karaciğer kontrolü'),
(8, 8, 'ElifÇelik_CT.png', 'CT', 'C:\\Images\\ElifÇelik_CT.png', '2025-03-20', 'Karın tomografisi'),
(9, 9, 'OsmanYılmaz_Xray.jpg', 'X-ray', 'C:\\Images\\OsmanYılmaz_Xray.jpg', '2025-04-05', 'Diz incinmesi'),
(10, 10, 'AyşeKurt_BT.jpg', 'BT X-ray', 'C:\\Images\\AyşeKurt_BT.jpg', '2025-04-28', 'Omuz ağrısı'),
(11, 11, 'SedaArslan_MRI.jpg', 'MRI', 'C:\\Images\\SedaArslan_MRI.jpg', '2025-03-03', 'Boyun ağrısı'),
(12, 12, 'EmreUçar_MRI.jpg', 'MRI', 'C:\\Images\\EmreUçar_MRI.jpg', '2025-05-13', 'Bel ağrısı'),
(13, 13, 'NuranÖz_Xray.jpg', 'X-ray', 'C:\\Images\\NuranÖz_Xray.jpg', '2025-02-22', 'Solunum problemi'),
(14, 14, 'HüseyinÇetin_USG.png', 'Ultrason', 'C:\\Images\\HüseyinÇetin_USG.png', '2025-03-14', 'Safra kesesi kontrolü'),
(15, 15, 'BurcuAydın_Mammo.jpg', 'Mammografi', 'C:\\Images\\BurcuAydın_Mammo.jpg', '2025-04-01', 'Rutin tarama');

--Sonradan Eklentiler
CREATE TABLE DoktorHareketleri (
    ID INT IDENTITY(1,1) PRIMARY KEY,

    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    GelisTarihi DATETIME,
    GidisTarihi DATETIME
);

CREATE PROCEDURE DoktorHareketleriEkle
    @Ad NVARCHAR(50),
    @Soyad NVARCHAR(50),
    @GelisTarihi DATETIME,
    @GidisTarihi DATETIME
AS
BEGIN
    INSERT INTO DoktorHareketleri (Ad, Soyad, GelisTarihi, GidisTarihi)
    VALUES (@Ad, @Soyad, @GelisTarihi, @GidisTarihi)
END

CREATE PROCEDURE GetDoctorNames
AS
BEGIN
    SELECT 
        Ad,
        Soyad
    FROM DoktorHareketleri
END


ALTER TABLE DoktorHareketleri
ADD HastaAdi NVARCHAR(50),
    HastaSoyadi NVARCHAR(50);





CREATE PROCEDURE GetTodayAppointments
AS
BEGIN
    SELECT 
        p.PatientId,
        p.FirstName,
        p.LastName,
        a.AppointmentDate,
        ISNULL(g.KayitDurumu, 'Hayır') AS KayitDurumu
    FROM Appointments a
    INNER JOIN Patients p ON a.PatientId = p.PatientId
    LEFT JOIN GunlukHastaHareketleri g ON p.PatientId = g.PatientId AND a.DoctorId = g.DoctorId
    WHERE CAST(a.AppointmentDate AS DATE) = CAST(GETDATE() AS DATE)
END
exec GetTodayAppointments
select * from Gunluk

CREATE PROCEDURE UpdateKayitDurumu
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




CREATE PROCEDURE GetTodayDoctorPatientList
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
--Kayıt durumu hayır olan hastaları veren procedure
CREATE PROCEDURE GetUnregisteredPatients
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
    WHERE p.KayitDurumu = 'Hayır'
END
exec GetUnregisteredPatients

-- hatsa ıd ve doktor ıd geiren procları yazıcam
CREATE PROCEDURE GetPatientId
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
CREATE PROCEDURE GetDoctorId
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

--@DoktorAdi NVARCHAR(50),
    --@DoktorSoyadi NVARCHAR(50)
	-- d.FirstName = @DoktorAdi AND
      --  d.LastName = @DoktorSoyadi
	--


	CREATE PROCEDURE GetDoktorDurumu1
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

CREATE PROCEDURE GetDoktorDurumu111
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




--hasta ismi ve soyismine göre doktor adı soyadı geiren procedure bunla beraber günlük doktor bilgisi olan tablodan doktor isimlerini çekicem 
--bir listede toplucam sorgumdan gelelen doktor ismi soyismi bilgisi .contains'midicem evetse dpoktor burda haoyrsa messaj gönder dicem
create table GunlukHastaHareketleri(
ID INT IDENTITY(1,1) PRIMARY KEY,
PatientId INT FOREIGN KEY REFERENCES Patients(PatientId),
DoctorId INT FOREIGN KEY REFERENCES Doctors(DoctorId),
KayitDurumu nvarchar(50)
)

insert into GunlukHastaHareketleri (PatientId, DoctorId, KayitDurumu) values(4,4,'Evet')
insert into GunlukHastaHareketleri (PatientId, DoctorId, KayitDurumu) values(16,16,'Hayır')
insert into GunlukHastaHareketleri (PatientId, DoctorId, KayitDurumu) values(17,17,'Hayır')
select * from GunlukHastaHareketleri
select * from Patients
select * from Doctors
---------------------------------------------
---------------------------------------------
---------------------------------------------
create proc GetMedicalInfo
as 
begin
SELECT 
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


CREATE PROCEDURE AddMedicalRecord
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

select * from MedicalRecords

CREATE PROCEDURE UpdateMedicalRecord
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
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
CREATE PROCEDURE ListPrescriptions
AS
BEGIN
    SELECT 
        RecordId AS PrescriptionId,--unutma 
        RecordId,
        MedicineName,
        Dosage,
        DurationDays
    FROM 
        Prescriptions;
END;

CREATE PROCEDURE AddPrescription
    @RecordId INT,
    @MedicineName NVARCHAR(100),
    @Dosage NVARCHAR(50),
    @DurationDays INT
AS
BEGIN
    INSERT INTO Prescriptions (RecordId, MedicineName, Dosage, DurationDays)
    VALUES (@RecordId, @MedicineName, @Dosage, @DurationDays);
END;


CREATE PROCEDURE UpdatePrescription
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


CREATE PROCEDURE SearchDiagnosisByTreatmentWord
    @word NVARCHAR(100)
AS
BEGIN
    SELECT Diagnosis
    FROM MedicalRecords
    WHERE Treatment LIKE '%' + @word + '%'
END
