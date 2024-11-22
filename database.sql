
CREATE TABLE Uprawnienia (
id int(10) NOT NULL AUTO_INCREMENT, 
nazwa varchar(255) NOT NULL, 
PRIMARY KEY (id), 
UNIQUE INDEX (id));

CREATE TABLE Pracownicy (
  id int(10) NOT NULL AUTO_INCREMENT,
  imie varchar(255) NOT NULL,
  nazwisko varchar(255) NOT NULL,
  email varchar(255) NOT NULL UNIQUE,
  id_uprawnienie int(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX (id_uprawnienie)
);

CREATE TABLE Pomieszczenia (
id int(10) NOT NULL AUTO_INCREMENT, 
PRIMARY KEY (id), 
UNIQUE INDEX (id));

CREATE TABLE Pomieszczenia_Pracownicy (
id_pracownik int(10) NOT NULL, 
id_pom int(10) NOT NULL, 
PRIMARY KEY (id_pracownik, id_pom), 
INDEX (id_pracownik), 
INDEX (id_pom));

CREATE TABLE Oceny_partii (
id int(10) NOT NULL AUTO_INCREMENT, 
id_partii int(10) NOT NULL, 
id_detale int(10) NOT NULL, 
id_pracownik int(10) NOT NULL, 
ocena int(10) NOT NULL, 
etap int(10) NOT NULL, 
data date NOT NULL, 
PRIMARY KEY (id), 
UNIQUE INDEX (id), 
INDEX (id_partii), 
INDEX (id_detale), 
INDEX (id_pracownik));

CREATE TABLE Detale_oceny (
id int(10) NOT NULL AUTO_INCREMENT, 
opis varchar(255) NOT NULL, 
PRIMARY KEY (id), 
UNIQUE INDEX (id));

CREATE TABLE Partie (
id int(10) NOT NULL AUTO_INCREMENT, 
id_zlecenia int(10) NOT NULL, 
id_gatunku int(10) NOT NULL, 
id_pom int(10) NOT NULL, 
etap int(10) NOT NULL, 
data date NOT NULL, 
PRIMARY KEY (id), 
UNIQUE INDEX (id), 
INDEX (id_zlecenia), 
INDEX (id_gatunku), 
INDEX (id_pom));

CREATE TABLE Gatunki (
  id int(10) NOT NULL AUTO_INCREMENT,
  nazwa varchar(255) NOT NULL,
  cena int(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX (id)
);

CREATE TABLE Detale_zlec (
id int(10) NOT NULL AUTO_INCREMENT, 
id_gatunek int(10) NOT NULL, 
id_zlecenie int(10) NOT NULL, 
ilosc int(10) NOT NULL, 
rodzaj int(10) NOT NULL, 
PRIMARY KEY (id), 
UNIQUE INDEX (id));

CREATE TABLE Zlecenia (
  id int(10) NOT NULL AUTO_INCREMENT,
  id_klient int(10) NOT NULL,
  data date NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX (id),
  INDEX (id_klient)
);

CREATE TABLE Klienci (
  id int(10) NOT NULL AUTO_INCREMENT,
  firma varchar(255) NOT NULL UNIQUE,
  imie varchar(255),
  nazwisko varchar(255),
  email varchar(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX (id)
);


CREATE TABLE Modyfikacje_pom (
id int(10) NOT NULL AUTO_INCREMENT, 
id_parti int(10) NOT NULL, 
pom_p int(10) NOT NULL, 
pom_d int(10) NOT NULL, 
data date NOT NULL, 
id_pracownik int(10) NOT NULL, 
etap int(10) NOT NULL, 
PRIMARY KEY (id), 
UNIQUE INDEX (id), 
INDEX (id_parti), 
INDEX (id_pracownik));

INSERT INTO Uprawnienia (id, nazwa) VALUES (1, 'Administrator');

INSERT INTO Pracownicy (id, imie, nazwisko, email, id_uprawnienie) VALUES (1, 'Jan', 'Kowalski', 'jan.kowalski@example.com', 1);

INSERT INTO Pomieszczenia (id) VALUES (1);

INSERT INTO Pomieszczenia_Pracownicy (id_pracownik, id_pom) VALUES (1, 1);

INSERT INTO Detale_oceny (id, opis) VALUES (1, 'Dobra jakość');

INSERT INTO Partie (id, id_zlecenia, id_gatunku, id_pom, etap, data) VALUES (1, 1, 1, 1, 1, '2023-11-21');

INSERT INTO Gatunki (id, nazwa, cena) VALUES (1, 'Gatunek A', 100);

INSERT INTO Detale_zlec (id, id_gatunek, id_zlecenie, ilosc, rodzaj) VALUES (1, 1, 1, 100, 1);

INSERT INTO Zlecenia (id, id_klient, data) VALUES (1, 1, '2023-11-21');

INSERT INTO Klienci (id, firma, imie, nazwisko, email) VALUES (1, 'Firma ABC', 'Anna', 'Nowak', 'anna.nowak@example.com');

INSERT INTO Oceny_partii (id, id_partii, id_detale, id_pracownik, ocena, etap, data) VALUES (1, 1, 1, 1, 5, 1, '2023-11-21');

INSERT INTO Modyfikacje_pom (id, id_parti, pom_p, pom_d, data, id_pracownik, etap) VALUES (1, 1, 1, 2, '2023-11-21', 1, 1);

