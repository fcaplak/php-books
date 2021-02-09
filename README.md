# Knižnica (PHP)

## Zadanie
Úlohou je pripraviť jednoduchý projekt v jazyku PHP na zakladanie a vylistovanie kníh použitím databázy a JSON API na listovanie. Bude sa tu nachádzať formulár s poľami pre názov knihy, ISBN, cenu, kategóriu a autora. 
Všetky tieto polia budú povinné a typu text, okrem ceny, ktorá bude *double* a kategórie, ktorá bude selection.
Pole autora bude s možnosťou autocomplete a tauľka sa zoradí vzosupne po kliknutí na stĺpec *Cena*.

## Splnené požiadavky
- PHP, Bootstrap
- Povinné polia, ich validácia na strane servera
- Sortovanie výsledkov podľa ceny vzostupne kliknutím na stĺpec *Cena*
- Autocomplete v poli *Autor* (použité JQuery UI)

## Adresárová štruktúra
```
.
+-- backend
|   +-- src
|   |   +-- api
|   |   |   +-- api_include.php
|   |   |   +-- create_book.php
|   |   |   +-- config.php
|   |   |   +-- read_authors.php
|   |   |   +-- read_books.php
|   |   |   +-- read_categories.php
|   +-- tables.sql
+-- frontend
|   +-- src
|   |   +-- js
|   |   |   +-- api.js
|   |   |   +-- utils.js
|   |   |   +-- tables.sql
|   |   +-- index.html
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
Použitý databázový server je MariaDB.

#### Štruktúra tabuliek

*knihy* :
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

*autori*, *kategorie* :
```
+-------+---------+------+-----+---------+----------------+
| Field | Type    | Null | Key | Default | Extra          |
+-------+---------+------+-----+---------+----------------+
| id    | int(11) | NO   | PRI | NULL    | auto_increment |
| name  | text    | NO   |     | NULL    |                |
+-------+---------+------+-----+---------+----------------+
```

V tabuľke *knihy* sú stĺpce *category*, *author* cudzie kľúče priradené k stĺpcu *id* v tabuľkách *autori*, *kategorie*

### Validácia

Všetky vstupy sú validované na strane servera skriptom *create_book.php*.



## Inštalácia
1. Vytvoriť tabuľky v DB (vykonať *tables.sql*)
2. Nastaviť prístupové údaje k DB (*/backend/src/api/config.php*)
    Príklad:
    ```php
    $servername = "localhost";
    $username = "root";
    $password = "1234";
    $dbname = "library";
    ```
3. Nastaviť API URL (*/frontend/src/js/config.js*)
    Príklad:
    ```js
    var api_url = http://localhost/backend/src/api/;
    ```


todo:
moznosti formatov inputov - validacia 
testy
