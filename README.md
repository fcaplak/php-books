# Knižnica (PHP)

Autor: [Filip Čaplák](https://github.com/fcaplak)

## Zadanie
Úlohou bolo pripraviť jednoduchý projekt v jazyku PHP na zakladanie a vylistovanie kníh použitím databázy a JSON API na listovanie. 

## Splnené požiadavky
- PHP, Bootstrap
- Povinné polia, ich validácia na strane servera
- Sortovanie výsledkov podľa ceny vzostupne kliknutím na stĺpec *Cena*
- Autocomplete v poli *Autor* (použité JQuery UI)

## Adresárová štruktúra
```
.
+-- api
|   +-- api_include.php
|   +-- create_book.php
|   +-- database_config.php
|   +-- read_authors.php
|   +-- read_books.php
|   +-- read_categories.php
+-- js
|   +-- api.js
|   +-- utils.js
+-- tables.sql
+-- index.html
 ```
 
## Riešenie
Na vypracovanie backendovej časti som použil čistý PHP (vanilla) a na frontendovú časť mi poslúžil Bootstrap a JavaScript (JQuery, Ajax).

### API
Požiadavky a odpovede API sú vo formáte JSON. 

Spracovávajú ich skripty:
- *read_categories.php* - slúži jednorázovo po načítaní stránky vytiahnuť zoznam kategórií a populovať ním selection menu
- *read_books.php* - požiadavka príde vždy po načítaní stránky alebo pridaním novej knihy
- *read_authors.php* - vytiahne zoznam autorov, vyvoláva sa vždy použitím požiadavky *GET* parametrom *term* a vrátia sa autori, v ktorých menách sa vyskytuje *term*
- *create_book.php* - vloží nový záznam do tabuľky 'knihy' s prichádzajúcimi *POST* dátami (name, isbn, price, category, author)

#### Príklad

Máme dostupných autorov:
```
{
    "Peter Prvý",
    "Filip The Second",
    "J. J. Roland"
}
```

Volanie */read_authors.php?term=Rol* nám vráti:
```
{
    "Roland"
}
```

Tento príklad volania sa používa pri autocomplete.

### Databáza
Použitý databázový server je MariaDB. Tabuľky sú exportované v *tables.sql*.

#### Kofigurácia
Konfigurácia prístupu do databázy sa nachádza v *database_config.php*. Príklad:
```php
    $servername = "localhost";
    $username = "root";
    $password = "1234";
    $dbname = "library";
```

#### Štruktúra tabuliek

*knihy*
```
+----------+---------+------+-----+---------+----------------+
| Field    | Type    | Null | Key | Default | Extra          |
+----------+---------+------+-----+---------+----------------+
| id       | int(11) | NO   | PRI | NULL    | auto_increment |
| name     | text    | NO   |     | NULL    |                |
| isbn     | text    | NO   |     | NULL    |                |
| price    | double  | NO   |     | NULL    |                |
| category | int(11) | NO   | MUL | NULL    |                |
| author   | int(11) | NO   |     | NULL    |                |
+----------+---------+------+-----+---------+----------------+
```

*autori*, *kategorie*
```
+-------+---------+------+-----+---------+----------------+
| Field | Type    | Null | Key | Default | Extra          |
+-------+---------+------+-----+---------+----------------+
| id    | int(11) | NO   | PRI | NULL    | auto_increment |
| name  | text    | NO   |     | NULL    |                |
+-------+---------+------+-----+---------+----------------+
```

V tabuľke *knihy* sú stĺpce *category*, *author* cudzie kľúče priradené k stĺpcu *id* a tabuľkách *autori*, *kategorie*






