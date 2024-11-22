
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



-- Wyzwalacze i automatyzacje


-- Wyzwalacz: Blokowanie zmian przez osoby inne niż 'Menedżer'
CREATE TRIGGER restrict_permissions_modifications 
BEFORE INSERT ON Uprawnienia
FOR EACH ROW
BEGIN
    IF CURRENT_USER() NOT LIKE '%menedzer%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tylko Menedżer może modyfikować uprawnienia.';
    END IF;
END;

CREATE TRIGGER restrict_permissions_modifications_update
BEFORE UPDATE ON Uprawnienia
FOR EACH ROW
BEGIN
    IF CURRENT_USER() NOT LIKE '%menedzer%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tylko Menedżer może modyfikować uprawnienia.';
    END IF;
END;

CREATE TRIGGER restrict_permissions_modifications_delete
BEFORE DELETE ON Uprawnienia
FOR EACH ROW
BEGIN
    IF CURRENT_USER() NOT LIKE '%menedzer%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tylko Menedżer może modyfikować uprawnienia.';
    END IF;
END;

-- Wyzwalacz: Rejestrowanie modyfikacji
CREATE TRIGGER log_room_modifications 
AFTER UPDATE ON Pomieszczenia
FOR EACH ROW
BEGIN
    INSERT INTO Modyfikacje_pom (pom_p, pom_d, data, id_pracownik, etap)
    VALUES (OLD.id, NEW.id, NOW(), OLD.id_pracownik, OLD.etap);
END;

-- Wyzwalacz: Automatyczna walidacja dat
CREATE TRIGGER validate_batch_dates 
BEFORE INSERT ON Partie
FOR EACH ROW
BEGIN
    IF NEW.data > NEW.data THEN  -- Proszę upewnić się, że porównywana data jest poprawna
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data ważności nie może być wcześniejsza niż data produkcji.';
    END IF;
END;

CREATE TRIGGER validate_batch_dates_update
BEFORE UPDATE ON Partie
FOR EACH ROW
BEGIN
    IF NEW.data > NEW.data THEN  -- Proszę upewnić się, że porównywana data jest poprawna
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data ważności nie może być wcześniejsza niż data produkcji.';
    END IF;
END;

-- Wyzwalacz: Blokowanie usuwania ocen
CREATE TRIGGER prevent_ratings_deletion 
BEFORE DELETE ON Oceny_partii
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Usuwanie ocen jest niedozwolone.';
END;

-- Wyzwalacz: Walidacja ceny
CREATE TRIGGER validate_species_price 
BEFORE INSERT ON Gatunki
FOR EACH ROW
BEGIN
    IF NEW.cena < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cena gatunku nie może być ujemna.';
    END IF;
END;

CREATE TRIGGER validate_species_price_update
BEFORE UPDATE ON Gatunki
FOR EACH ROW
BEGIN
    IF NEW.cena < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cena gatunku nie może być ujemna.';
    END IF;
END;

-- Wyzwalacz: Automatyczne ustawianie statusu nowego zlecenia
CREATE TRIGGER set_default_order_status 
BEFORE INSERT ON Zlecenia
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL THEN
        SET NEW.status = 'Nowe';
    END IF;
END;

-- Wyzwalacz: Zapobieganie usuwaniu klientów
CREATE TRIGGER prevent_client_deletion 
BEFORE DELETE ON Klienci
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Nie można usunąć klienta. Historia musi zostać zachowana.';
END;

-- Wyzwalacz: Zapobieganie zmianie ilości na nieprawidłową wartość
CREATE TRIGGER validate_order_details_quantity 
BEFORE INSERT ON Detale_zlec
FOR EACH ROW
BEGIN
    IF NEW.ilosc <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ilość w szczegółach zlecenia musi być większa od zera.';
    END IF;
END;

CREATE TRIGGER validate_order_details_quantity_update
BEFORE UPDATE ON Detale_zlec
FOR EACH ROW
BEGIN
    IF NEW.ilosc <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ilość w szczegółach zlecenia musi być większa od zera.';
    END IF;
END;

-- Automatyzacja: Tylko dodawanie nowych rekordów
CREATE TRIGGER restrict_modification_changes 
BEFORE UPDATE ON Modyfikacje_pom
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Zmiana logów modyfikacji pomieszczeń jest zabroniona.';
END;

CREATE TRIGGER restrict_modification_changes_delete 
BEFORE DELETE ON Modyfikacje_pom
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Usuwanie logów modyfikacji pomieszczeń jest zabronione.';
END;