-- 1 -- Jazdec, ktorý vyhral pretek na každom okruhu v Severnej Amerike počas sezóny 2021.
    -- 1.1
    with
    pretekari       AS (SELECT id_jazdec FROM jazdec),
    preteky         AS (SELECT id_pretek, vitaz FROM pretek
                        JOIN okruh o on o.id_okruh = pretek.prebieha_na
                        JOIN krajina k on o.lezi_v = k.id_krajina
                        WHERE sezona = 2021 and kontinent = 'Severna Amerika' ),
    mozneVyhry      AS (SELECT id_pretek, id_jazdec FROM preteky CROSS JOIN jazdec),
    nastaleVyhry    AS (SELECT id_pretek, id_jazdec FROM preteky
                        JOIN jazdec on preteky.vitaz = jazdec.id_jazdec),
    nenastaleVyhry  AS (SELECT * FROM mozneVyhry EXCEPT (Select * FROM nastaleVyhry) ),
    jazdciNevyhrali AS (SELECT id_jazdec FROM nenastaleVyhry),
    jazdciVyhrali   AS (SELECT id_jazdec FROM pretekari EXCEPT (SELECT * FROM jazdciNevyhrali))
    SELECT meno FROM jazdciVyhrali
        JOIN jazdec USING (id_jazdec);

    -- 1.2
    SELECT meno FROM pretek
        join jazdec j on j.id_jazdec = pretek.vitaz
        join okruh o on o.id_okruh = pretek.prebieha_na
        join krajina k on k.id_krajina = o.lezi_v
        WHERE sezona = 2021 AND kontinent = 'Severna Amerika'
        GROUP BY j.meno
        HAVING count(meno) = (
            SELECT count(pretek.nazov) FROM pretek
                join okruh o on o.id_okruh = pretek.prebieha_na
                join krajina k on k.id_krajina = o.lezi_v
                where kontinent = 'Severna Amerika' );

    -- 1.3
    SELECT meno FROM jazdec AS x
    WHERE id_jazdec NOT IN (
        SELECT id_jazdec FROM jazdec AS y
        EXCEPT
            (SELECT id_jazdec FROM pretek
                JOIN jazdec j on pretek.vitaz = j.id_jazdec
                JOIN okruh o on pretek.prebieha_na = o.id_okruh
                JOIN krajina k on k.id_krajina = o.lezi_v
                WHERE sezona = 2021 AND kontinent = 'Severna Amerika'
                AND x.id_jazdec = pretek.vitaz
            )
        );

-- 2 -- Jazdci, ktorí mali uzavreté kontrakty len s Ferrari a s nikým iným
    SELECT DISTINCT jazdec.meno FROM Kontrakt
            JOIN jazdec     ON kontrakt.id_jazdec = jazdec.id_jazdec
            JOIN tim        ON kontrakt.id_tim = tim.id_tim
        WHERE tim.meno = 'Ferrari'
        EXCEPT (
        SELECT DISTINCT jazdec.meno FROM Kontrakt
            JOIN jazdec     ON kontrakt.id_jazdec = jazdec.id_jazdec
            JOIN tim        ON kontrakt.id_tim = tim.id_tim
        WHERE tim.meno != 'Ferrari');

-- 3 -- Jazdec,  ktorý vyhral 'domáci' pretek, teda pretek v krajine kde sa narodil.
SELECT DISTINCT jazdec.meno FROM pretek
    JOIN jazdec on pretek.vitaz = jazdec.id_jazdec
    JOIN krajina povod on jazdec.povod = povod.id_krajina
    JOIN okruh on pretek.prebieha_na = okruh.id_okruh
    JOIN krajina lokacia on okruh.lezi_v = lokacia.id_krajina
    WHERE povod.nazov = lokacia.nazov;

-- 4 -- Tímy, ktoré si konštruujú vlastný motor.
SELECT DISTINCT tim.meno AS tim
    FROM motor_vyrobca
    JOIN tim on motor_vyrobca.vlastnik_tim = tim.id_tim;

-- 5 -- Režisér, ktorý mal na starosti každý pretek konajúci sa v Ázii
SELECT reziser.meno FROM reziser
    JOIN pretek p ON reziser.id_reziser = p.reziser
    JOIN okruh o on p.prebieha_na = o.id_okruh
    JOIN krajina k on o.lezi_v = k.id_krajina
    WHERE kontinent = 'Azia'
    GROUP BY reziser.meno
    HAVING  count(p.nazov) = (SELECT count(pretek.nazov) FROM pretek
            JOIN okruh o on o.id_okruh = pretek.prebieha_na
            JOIN krajina k on k.id_krajina = o.lezi_v
            WHERE kontinent = 'Azia');

-- 6 -- Jazdec s najlepšie plateným, už ukončeným kontraktom.
SELECT meno AS jazdec, plat  FROM jazdec
    JOIN (SELECT * FROM Kontrakt
            WHERE koniec IS NOT NULL
            ORDER BY plat DESC
            LIMIT 1 ) najKontrakt USING (id_jazdec);

-- 7 -- Kontrolný dotaz pre 1: Všetky preteky v Severnej Amerike v sezóne
-- 2021 mínus preteky ktoré vyhral Max Verstappen (očakávaná prázdna množina)
SELECT DISTINCT pretek.nazov AS pretek FROM Pretek
    JOIN okruh ON prebieha_na = id_okruh
    JOIN krajina ON lezi_v = id_krajina
    WHERE sezona = 2021 AND kontinent = 'Severna Amerika'
EXCEPT
SELECT DISTINCT pretek.nazov AS pretek FROM Pretek
    JOIN okruh ON pretek.prebieha_na = okruh.id_okruh
    JOIN krajina ON okruh.lezi_v = krajina.id_krajina
    JOIN Jazdec ON pretek.vitaz = jazdec.id_jazdec
    WHERE jazdec.meno = 'Max Verstappen';

-- 8 -- Jazdci, ktorí mali alebo majú uzavreté kontrakty s talianskymi tímami
SELECT DISTINCT jazdec.meno AS jazdec FROM KONTRAKT
    JOIN Jazdec  USING (id_jazdec)
    JOIN Tim     USING (id_tim)
    JOIN Krajina USING (id_krajina)
    WHERE nazov = 'Taliansko';

-- 9 -- Preteky, ktoré sa konajú na okruhu kratšom ako 5 kilometrov.
SELECT DISTINCT pretek.nazov AS pretek, dlzka FROM
    Pretek LEFT OUTER JOIN okruh ON prebieha_na = id_okruh
    WHERE dlzka < 5000;

-- 10 -- Výčet evidovaných jazdcov a krajín z ktorých pochádzajú,
--         vrátane jazdcov bez krajiny a krajín bez jazdcov
SELECT DISTINCT meno, nazov AS krajina FROM Krajina
    FULL OUTER JOIN Jazdec
    ON povod = id_krajina
    ORDER BY meno;

-- 11 -- Zoznam pretekárov spolu s počtom pretekov, ktoré vyhrali za sezónu 2021.
SELECT meno AS jazdec, ( SELECT Count(*) FROM pretek
                WHERE id_jazdec = vitaz AND sezona = 2021) AS pocet_vyhier
    FROM jazdec
    ORDER BY pocet_vyhier DESC;

-- 12 -- Jazdec, pre ktorého neevidujeme žiaden trest.
SELECT DISTINCT meno FROM jazdec
WHERE NOT EXISTS  (
    SELECT DISTINCT * FROM trest
    WHERE jazdec.id_jazdec = trest.previneny);

-- 13 -- Krajiny, ktoré vyprodukovali buď výherných jazdcov alebo výherné tímy.
SELECT DISTINCT krajina.nazov AS krajina FROM krajina
    LEFT JOIN tim USING (id_krajina)
    WHERE pocet_vitazstiev > 0
UNION
SELECT DISTINCT krajina.nazov as krajina FROM pretek
    LEFT JOIN jazdec ON vitaz = id_jazdec
    LEFT JOIN krajina ON povod = id_krajina;

-- 14 -- Tímy, ktoré si vyrábajú vlastný motor a nevyhrali ani jeden pretek v sezóne 2021
SELECT tim.meno AS Tim FROM motor_vyrobca
    JOIN tim ON vlastnik_tim = id_tim
INTERSECT
  ( SELECT DISTINCT meno FROM tim
    EXCEPT
        SELECT DISTINCT tim.meno as tim  FROM tim
        JOIN kontrakt USING (id_tim)
        JOIN jazdec   USING (id_jazdec)
        RIGHT JOIN pretek ON vitaz = id_jazdec
        WHERE sezona = 2021 );

-- 15 -- Jazdci, ktorí dostali počas sezóny 2021 v súčte
--        tresty za vyše 1000€, zoradení podľa veľkosti trestu.
SELECT meno, SUM(penazny_trest) AS sum_trest FROM trest
        JOIN Jazdec ON previneny = id_jazdec
        JOIN pretek ON id_pretek = pocas
    WHERE sezona = 2021
    GROUP BY meno
    HAVING sum(penazny_trest) > 1000
    ORDER BY sum(penazny_trest) DESC;

-- 16 -- Pohľad, v ktorom budú všetci jazdci, počet výhier a počet trestných bodov.
DROP VIEW IF EXISTS vitazi;

CREATE VIEW vitazi AS
    SELECT meno,
        COALESCE (( SELECT SUM (trestne_body)
            FROM trest
            WHERE previneny = id_jazdec ), 0)
                AS trestne_body,
        ( SELECT COUNT (*)
            FROM Pretek
            WHERE pretek.vitaz = jazdec.id_jazdec )
                AS pocet_vyhier
    FROM jazdec
    ORDER BY pocet_vyhier DESC;

SELECT * FROM vitazi;

-- 17 -- Ktorý pretekár má najviac výhier a nedostal ani jeden trestný bod? (použi pohľad `vitazi`)
SELECT meno FROM vitazi
    WHERE trestne_body = 0
    ORDER BY pocet_vyhier DESC
    LIMIT 1;

-- 18 -- Po oneskorenom prešetrení bol udelený víťazovi 13. preteku sezóny 2022 časový trest piatich sekúnd a 10 000€.
INSERT INTO Trest( id_trest, casovy_trest, penazny_trest, previneny, pocas )
    SELECT
        MAX(id_trest)+1,
        5,
        10000,
        (SELECT id_jazdec FROM Pretek
            JOIN jazdec ON pretek.vitaz = jazdec.id_jazdec
            WHERE id_pretek = 13 AND sezona = 2021),
        13
    FROM Trest;

-- 19 -- Kvôli časovej penalte z oneskoreného trestu z  `D19` sa zmenil víťaz preteku,
--          keďže druhý jazdec bol pozadu oproti víťazovi len tri sekundy.
--          Novým víťazom trinásteho preteku sa stal Daniel Ricciardo,
--          záznam o preteku musí byť upravený.

UPDATE Pretek
    SET vitaz = (SELECT id_jazdec FROM Jazdec WHERE meno = 'Daniel Ricciardo')
    WHERE id_pretek = (SELECT id_pretek FROM Pretek
                            WHERE nazov = 'Heineken Dutch Grand Prix' AND sezona = 2021)
        AND sezona = 2021;

-- 20 -- Následkom nových regulácií prešli tímy na vyrábanie vlastných motorov / kupovanie od iných tímov,
--          takže niektorí dodávatelia motorov už nemajú v športe zákazníkov.
--          Odstráň všetkých výrobcov motorov ktorí už nikomu nedodávajú motor.

DELETE FROM motor_vyrobca
    WHERE id_dodavatel = (
        SELECT id_dodavatel FROM motor_vyrobca
            EXCEPT SELECT motor_od FROM auto );

-- 21 -- Formula 1 je vraj šport pre mladých. Aké percento jazdcov bolo narodených pred rokom 1990?
SELECT (
      (SELECT COUNT(id_jazdec)
           FROM jazdec
           WHERE vek > (2022 - 1990) ) * 100
              /( SELECT COUNT(id_jazdec) FROM jazdec)
  ) AS "% jazdcov narodenych pred 1990";

-- 22 -- Kto z jazdcov dostal najviac trestov?
--          Zobraz so súčtom všetkých trestov vo všetkých troch
--          kategóriách - Peňažné, časové, bodové a pozičné.
SELECT meno,
       COUNT(*)           AS pocet_trestov,
       SUM(penazny_trest) AS total_eur,
       SUM(casovy_trest)  AS total_second,
       SUM(pozicny_trest) AS total_pozicie,
       SUM(trestne_body)  AS total_body
FROM (
    SELECT previneny, COUNT(previneny) AS pocet_trestov FROM trest
        GROUP BY previneny
        ORDER BY pocet_trestov DESC
        LIMIT 1 ) najvinnejsi
    JOIN trest USING (previneny)
    JOIN jazdec j on trest.previneny = j.id_jazdec
    GROUP BY meno;

-- 23 -- Vypíš všetky "nudné" preteky sezóny 2021. Ako nudný pretek si zadefinujeme akýkoľvek pretek, počas ktorého:
-- 			1. neevidujeme žiadne tresty
-- 			2.  na trať nebol vyslaný žiaden safety car
-- 			3.  víťazom bol ten jazdec, ktorý neskôr vyhral šampionát
SELECT nazov AS nudne_preteky FROM pretek
    WHERE sezona = 2021
    AND nazov NOT IN
      ( SELECT nazov FROM pretek WHERE mal_safety_car = true AND sezona = 2021
    UNION
        SELECT nazov FROM trest JOIN pretek on pretek.id_pretek = trest.pocas WHERE sezona = 2021
    UNION
        SELECT nazov FROM pretek WHERE pretek.vitaz != (SELECT vitaz_jazdec FROM sezona WHERE rok = 2021)
    );

-- 24 -- Formula 1 sa snaží expandovať mimo hranice Európy -
--          vypíš všetky kontinenty a počet pretekov ktoré
--          sa na nich konali v roku 2021
SELECT kontinent, COUNT(*) AS pocet_pretekov FROM pretek
    JOIN okruh ON pretek.prebieha_na = okruh.id_okruh
    JOIN krajina ON okruh.lezi_v = krajina.id_krajina
    WHERE sezona = 2021
    GROUP BY kontinent
    ORDER BY count(*) DESC;

-- 25 -- Grafický tím si musí pripraviť vizuálne efekty pre prípad výhry
--          ktoréhokoľvek pretekára na ktoromkoľvek okruhu, čo je veľa práce.
--          Uľahčime im to vytvorením zoznamu všetkých možných okruhov a výhercov,
--          usporiadané podľa mena jazdca.
SELECT DISTINCT jazdec.meno AS Jazdec, okruh.nazov AS Okruh FROM Okruh
    CROSS JOIN Jazdec;