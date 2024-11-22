# Projekt Bazy Danych w MySQL do zarządzania pieczarkarnią

## Opis projektu
Celem projektu jest zaprojektowanie i utworzenie bazy danych w środowisku MySQL, która wspiera funkcjonalność systemu obsługującego procesy biznesowe (np. zarządzanie klientami, zamówieniami, produktami). Projekt obejmuje modelowanie struktury bazy danych, definiowanie relacji między tabelami oraz implementację odpowiednich mechanizmów w celu zapewnienia integralności danych.

Bazy Danych 2

Semestr V 

Informatyka Techniczna '22

## Struktura bazy danych
### Główne tabele:
#### Klienci:

Przechowuje dane klientów, takie jak imię, nazwisko, firma, adres e-mail.
Powiązania z tabelą Zlecenia.
#### Zlecenia:

Rejestruje zamówienia klientów, w tym daty, szczegóły zamówienia i powiązane partie.
Partie:

Obejmuje informacje o partiach produktów, w tym etap rozwoju, daty i lokalizacje.
#### Pracownicy:

Dane o pracownikach zarządzających systemem, w tym uprawnienia i przypisania do pomieszczeń.
#### Gatunki:

Przechowuje informacje o gatunkach produktów, takie jak nazwa i cena.
#### Pomieszczenia:

Lokalizacje przechowywania i przetwarzania partii.
