-- Modul 1: Lingkungan Kerja MariaDB dan Git
-- NIM: 007

CREATE DATABASE IF NOT EXISTS kopma_007 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_007'@'localhost' IDENTIFIED BY 'Kanade1212';

GRANT ALL PRIVILEGES ON kopma_007.* TO 'mhs_077'@'localhost';

FLUSH PRIVILEGES;


CREATE USER IF NOT EXISTS 'tamu_007'@'localhost' IDENTIFIED BY 'Kanade1212';

GRANT ALL PRIVILEGES ON kopma_007.* TO 'tamu_007'@'localhost';

FLUSH PRIVILEGES;