# Hastane Yönetim Sistemi (C# - Windows Forms)

Bu proje, bir hastane ortamında doktor, hasta, randevu, tıbbi kayıt, laboratuvar ve radyoloji işlemlerini yönetmek amacıyla geliştirilmiş kapsamlı bir masaüstü uygulamadır. Projede **Windows Forms**, **Entity Framework (DB-First Yaklaşımı)**, **Stored Procedure’ler** ve **SQL Server** teknolojileri kullanılmıştır.

## 📌 Proje Özellikleri

- Doktor, hasta ve sekreter modülleri
- Randevu planlama ve geçmiş randevuların görüntülenmesi
- Reçete oluşturma ve tedavi kaydı
- Laboratuvar ve radyoloji sonuçlarının yönetimi
- Doktorlara özel filtreli sorgular (JOIN, GROUP BY, HAVING içeren)
- SqlDataAdapter ve SqlCommand ile veritabanı işlemleri
- Stored Procedure kullanımı
- Entity Framework ile model oluşturma (DB-First)

## 🛠️ Kullanılan Teknolojiler

| Katman | Teknolojiler |
|--------|--------------|
| **Arayüz** | C# Windows Forms |
| **Veri Erişimi** | Entity Framework (DB-First), SqlDataAdapter, SqlCommand |
| **Veritabanı** | Microsoft SQL Server |
| **Veri İşlemleri** | Stored Procedures, Parametreli SQL sorguları |

## 📁 Veritabanı Yapısı

### Ana Tablolar:
- `Patients`
- `Doctors`
- `Secretaries`
- `Appointments`
- `MedicalRecords`
- `Prescriptions`
- `LabResults`
- `RadiologyImages`
- 'GunlukHastaHareketleri'
-'DoktorHareketleri'

### İlişkiler:
-Patients – MedicalRecords: 1 hasta, birden fazla tıbbi kayda sahip olabilir. (1:N)
-Doctors – MedicalRecords: 1 doktor, birden fazla tıbbi kayıt girebilir. (1:N)
-MedicalRecords – Prescriptions: 1 tıbbi kayıttan birden fazla reçete üretilebilir. (1:N)
-Patients & Doctors – LabResults / RadiologyImages: Her test ve görsel bir hastaya ve bir doktora aittir. (N:1)

## 📊 Sorgular

Uygulamada, kullanıcının ComboBox üzerinden seçerek çalıştırabildiği çeşitli analiz ve raporlama amaçlı 10'dan fazla SQL sorgusu yer almaktadır. Bunlardan bazıları şunlardır:

Doktor Hasta Sayısı
Her doktorun kaç farklı hastaya baktığını listeler.

En Sık Yazılan İlaçlar
Reçetelerde en çok geçen ilaçları sıralar.

Hasta Başına Ortalama Reçete
Her hastanın ortalama kaç reçete aldığını gösterir.

Günlük Hasta Kaydı
Gün bazında sisteme giriş yapan hasta sayılarını listeler.

Radyoloji Görüntü Tipleri
MR, X-Ray, Tomografi gibi görüntü türlerine göre gruplama yapar.

Doktorların Tedavi Sayısı
Her doktorun kaç farklı tedavi uyguladığını gösterir.

Lab Test Raporları
Yapılan laboratuvar testlerini ve sonuçlarını listeler.

En Aktif Doktorlar
En fazla tıbbi kayıt veya hasta girişine sahip doktorları sıralar.

Hasta Acil Durum Bilgileri
Hastaların acil iletişim kişi ve telefon bilgilerini getirir.

Yaşa Göre Hasta Grupları
Hastaları yaş aralıklarına göre gruplar: 0–18, 19–35, 36–60, 60+ gibi.

Bu sorgular, arka planda Stored Procedure, JOIN, GROUP BY, HAVING gibi SQL yapılarıyla hazırlanmıştır. Form üzerinden seçim yapıldığında, ilgili sorgunun sonucu DataGridView kontrolünde kullanıcıya sunulur.

> Aynı zamanda veritabanı tarafında (Stored Procedure) hem de C# arayüzde filtrelenerek kullanıcıya sunulmaktadır.

## 👨‍⚕️ Modül Özeti

- **Doktor Modülü**: Hasta geçmişi görüntüleme, yeni tanı ve reçete ekleme
- **Sekreter Modülü**: Randevu ve kayıt işlemleri

## 🧪 Test ve Kullanım

- Proje yerel bir SQL Server bağlantısı gerektirir.
- `App.config` veya `Settings.settings` dosyasındaki bağlantı dizesi güncellenmelidir.
- Giriş ekranı üzerinden kullanıcı rolleri seçilerek test edilebilir.

## 📸 Ekran Görüntüleri

> Projenin kullanımına dair birkaç ekran görüntüsü aşağıya eklenebilir:
- Giriş Ekranı ![image](https://github.com/user-attachments/assets/ab3146ff-04f4-47d9-b473-d28cbd698340)
-Sekreter İşlemleri ![image](https://github.com/user-attachments/assets/33e8ff61-e50d-4cc7-a9ac-4cc6ada2b911)
-Hasta Tıbbi Takip ![image](https://github.com/user-attachments/assets/af363f25-f627-4cc1-b4f5-4b0d3c2e7b92)
-Doktorlar ![image](https://github.com/user-attachments/assets/39ebc120-41ed-44d8-8bc7-1f7536ebf468)
-Hastalar ![image](https://github.com/user-attachments/assets/718f4144-5d65-4b2d-b474-100a7650fb2d)
- Randevu Formu ![image](https://github.com/user-attachments/assets/5031f35e-8adc-4c18-ba65-e96b16ccf582)
- Doktor İşlmeleri ![image](https://github.com/user-attachments/assets/c465b8cc-c16e-4fad-b090-303f04708a18)
-Teşhis Tedavi Reçete İşlemleri ![image](https://github.com/user-attachments/assets/841518e9-1694-4e14-af12-55693c6c00c1)

## ✍️ Geliştirici

- **Ad Soyad**: [Rukiye İlhan]
- **Email**: [ilhanxrukiye@gmail.com]
- **Tarih**: 7 Haziran 2025

## ⚠️ Notlar

- Proje eğitim ve gösterim amaçlıdır.
- Veritabanı yapısı ve kodlar genişletilebilir.

---

