-- INSERT SCRIPT PRE SEMESTRÁLKU
-- smazání všech záznamů z tabulek
CREATE or replace FUNCTION clean_tables() RETURNS void AS $$
declare
  l_stmt text;
begin
  select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename) , ',')
    into l_stmt
  from pg_tables
  where schemaname in ('public');

  execute l_stmt || ' cascade';
end;
$$ LANGUAGE plpgsql;
select clean_tables();

-- reset sekvenci
CREATE or replace FUNCTION restart_sequences() RETURNS void AS $$
DECLARE
i TEXT;
BEGIN
 FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
  LOOP
         EXECUTE 'ALTER SEQUENCE'||' ' || substring(substring(i from '''[a-z_]*')from '[a-z_]+') || ' '||' RESTART 1;';
  END LOOP;
END $$ LANGUAGE plpgsql;
select restart_sequences();

-- KRAJINY
INSERT INTO Krajina VALUES (1, 'Anglicko', 'Europa');
INSERT INTO Krajina VALUES (2, 'Nemecko', 'Europa');
INSERT INTO Krajina VALUES (3, 'Taliansko', 'Europa');
INSERT INTO Krajina VALUES (4, 'Spanielsko', 'Europa');
INSERT INTO Krajina VALUES (5, 'Japonsko', 'Azia');
INSERT INTO Krajina VALUES (6, 'Holandsko', 'Europa' );
INSERT INTO Krajina VALUES (7, 'Mexiko',  'Severna Amerika');
INSERT INTO Krajina VALUES (8, 'Monako', 'Europa');
INSERT INTO Krajina VALUES (9, 'Australia', 'Australia');
INSERT INTO Krajina VALUES (10, 'Francuzsko', 'Europa');
INSERT INTO Krajina VALUES (11, 'Kanada', 'Severna Amerika');
INSERT INTO Krajina VALUES (12, 'Thajsko', 'Azia');
INSERT INTO Krajina VALUES (13, 'Finsko', 'Europa');
INSERT INTO Krajina VALUES (14, 'Cina', 'Azia');
INSERT INTO Krajina VALUES (15, 'Dansko', 'Europa');
INSERT INTO Krajina VALUES (16, 'Brazilia', 'Juzna Amerika');
INSERT INTO Krajina VALUES (17, 'Bahrain', 'Azia');
INSERT INTO Krajina VALUES (18, 'Azerbaijan', 'Europa');
INSERT INTO Krajina VALUES (19, 'Belgicko', 'Europa');
INSERT INTO Krajina VALUES (20, 'Spojene staty', 'Severna Amerika');
INSERT INTO Krajina VALUES (21, 'Madarsko', 'Europa');
INSERT INTO Krajina VALUES (22, 'Saudska Arabia', 'Azia');
INSERT INTO Krajina VALUES (23, 'Singapur', 'Azia');
INSERT INTO Krajina VALUES (24, 'Rakusko', 'Europa');
INSERT INTO Krajina VALUES (25, 'Spojene Arabske Emiraty', 'Azia');
INSERT INTO Krajina VALUES (26, 'Portugalsko', 'Europa');
INSERT INTO Krajina VALUES (27, 'Rusko', 'Europa');
INSERT INTO Krajina VALUES (28, 'Turecko', 'Europa');
INSERT INTO Krajina VALUES (29, 'Katar', 'Azia');
INSERT INTO Krajina VALUES (30, 'Svajciarsko', 'Europa');

-- PRINCIPALI
INSERT INTO principal VALUES (1, 'Otmar Szafnauer');
INSERT INTO principal VALUES (2, 'Mattia Binotto');
INSERT INTO principal VALUES (3, 'Andreas Seidl');
INSERT INTO principal VALUES (4, 'Christian Horner');
INSERT INTO principal VALUES (5, 'Mike Krack');
INSERT INTO principal VALUES (6, 'Guenther Steiner');
INSERT INTO principal VALUES (7, 'Franz Tost');
INSERT INTO principal VALUES (8, 'Frederic Vasseur');
INSERT INTO principal VALUES (9, 'Jost Capito');
INSERT INTO principal VALUES (10, 'Toto Wolff');

-- OKRUHY
INSERT INTO okruh VALUES (1,  'Autodromo Enzo e Dino Ferrari',          'Imola',        4909, 1922,  3 );
INSERT INTO okruh VALUES (2,  'Autodromo Hermanos Regriguez',           'Mexico',       4304, 1959,  7 );
INSERT INTO okruh VALUES (3,  'Autodromo Jose Carlos Pace',             'Sao Paulo',    4309, 1940, 16 );
INSERT INTO okruh VALUES (4,  'Autodromo Nazionale di Monza',           'Monza',        5793, 1922,  3 );
INSERT INTO okruh VALUES (5,  'Bahrain International Circuit',          'Bahrain',      5412, 2004, 17 );
INSERT INTO okruh VALUES (6,  'Baku City Circuit',                      'Baku',         6003, 2016, 18 );
INSERT INTO okruh VALUES (7,  'Circuit de Barcelona-Catalunya',         'Montmelo',     4675, 1991,  4 );
INSERT INTO okruh VALUES (8,  'Circuit de Monaco',                      'Monaco',       3337, 1929,  8 );
INSERT INTO okruh VALUES (9,  'Circuit de Spa-Francorchamps',           'Spa',          7004, 1925, 19 );
INSERT INTO okruh VALUES (10, 'Circuit Gilles-Villeneuve',              'Montreal',     4361, 1978, 11 );
INSERT INTO okruh VALUES (11, 'Circuit of the Americas',                'Austin',       5513, 2010, 20 );
INSERT INTO okruh VALUES (12, 'Circuit Paul Richard',                   'Le Castellet', 5842, 1969, 10 );
INSERT INTO okruh VALUES (13, 'Circuit Zaandvoort',                     'Zaandvort',    4259, 1948,  6 );
INSERT INTO okruh VALUES (14, 'Hungaroring',                            'Mogyorod',     4381, 1986, 21 );
INSERT INTO okruh VALUES (15, 'Jeddah Corniche Circuit',                'Jeddah',       6174, 2021, 22 );
INSERT INTO okruh VALUES (16, 'Las Vegas Street Circuit',               'Las Vegas',    6120, 2022, 20 );
INSERT INTO okruh VALUES (17, 'Marina Bay Street Circuit',              'Marina Bay',   5063, 2007, 23 );
INSERT INTO okruh VALUES (18, 'Melbourne Grand Prix Circuit',           'Melbourne',    5303, 1953,  9 );
INSERT INTO okruh VALUES (19, 'Miami International Autodrome',          'Miami',        5410, 2022, 20 );
INSERT INTO okruh VALUES (20, 'Red Bull Ring',                          'Spielberg',    4318, 1969, 24 );
INSERT INTO okruh VALUES (21, 'Shanghai International Circuit',         'Shanghai',     5451, 2002, 14 );
INSERT INTO okruh VALUES (22, 'Silverstone Circuit',                    'Silverstone',  5891, 1950,  1 );
INSERT INTO okruh VALUES (23, 'Suzuka International Racing Course',     'Suzuka',       5807, 1962,  5 );
INSERT INTO okruh VALUES (24, 'Yas Marina Circuit',                     'Abu Dhabi',    5281, 2007, 25 );
INSERT INTO okruh VALUES (25, 'Algarve International Circuit',          'Poritmao',     4653, 2008, 26 );
INSERT INTO okruh VALUES (26, 'Sochi Autodrom',                         'Sochi',        5848, 2011, 27);
INSERT INTO okruh VALUES (27, 'Intercity Istanbul Park',                'Istanbul',     5338, 2003, 28);
INSERT INTO okruh VALUES (28, 'Losail International Circuit',           'Lusail',       5380, 2004, 29);


-- REZISERI
INSERT INTO reziser VALUES (1, 'Michael Masi');
INSERT INTO reziser VALUES (2, 'Charlie Whiting');
INSERT INTO reziser VALUES (3, 'Niels Wittich');
INSERT INTO reziser VALUES (4, 'Eduardo Freitas');

-- TIMY
--                      id | meno   | zalozeny | krajiny | vitazstva | principal
INSERT INTO Tim VALUES (1, 'Red Bull Racing',   2005, 24,  4,   4 );
INSERT INTO Tim VALUES (2, 'Mercedes',          2010,  2,  8, 10 );
INSERT INTO Tim VALUES (3, 'Ferrari',           1950,  3, 16,  2 );
INSERT INTO Tim VALUES (4, 'McLaren',           1966,  1,  8,  3 );
INSERT INTO Tim VALUES (5, 'Alpine',            2021, 10, 10,  1 );
INSERT INTO Tim VALUES (6, 'AlphaTauri',        2020,  3,  0,  7 );
INSERT INTO Tim VALUES (7, 'Aston Martin',      2021,  1,  0,  5 );
INSERT INTO Tim VALUES (8, 'Williams',          1978,  1,  7,  9 );
INSERT INTO Tim VALUES (9, 'Alfa Romeo',        2019, 30,  0,  8 );
INSERT INTO Tim VALUES (10,'Haas',              2016, 20,  0,  6 );

-- JAZDCI
INSERT INTO Jazdec VALUES (1,  'Max Verstappen',    'VER', 24, 6);
INSERT INTO Jazdec VALUES (2,  'Sergio Perez',      'PER', 32, 7);
INSERT INTO Jazdec VALUES (3,  'Lewis Hamilton',    'HAM', 37, 1);
INSERT INTO Jazdec VALUES (4,  'George Russell',    'RUS', 24, 1);
INSERT INTO Jazdec VALUES (5,  'Daniel Ricciardo',  'RIC', 32, 9);
INSERT INTO Jazdec VALUES (6,  'Lando Norris',      'NOR', 22, 1);
INSERT INTO Jazdec VALUES (7,  'Sebastian Vettel',  'VET', 34, 2);
INSERT INTO Jazdec VALUES (8,  'Lance Stroll',      'STR', 23, 11);
INSERT INTO Jazdec VALUES (9,  'Charles Leclerc',   'LEC', 24, 8);
INSERT INTO Jazdec VALUES (10, 'Carlos Sainz',      'SAI', 27, 4);
INSERT INTO Jazdec VALUES (11, 'Fernando Alonso',   'ALO', 40, 4);
INSERT INTO Jazdec VALUES (12, 'Esteban Ocon',      'OCO', 25, 10);
INSERT INTO Jazdec VALUES (13, 'Pierre Gasly',      'GAS', 26, 10);
INSERT INTO Jazdec VALUES (14, 'Yuki Tsunoda',      'YUK', 21, 5);
INSERT INTO Jazdec VALUES (15, 'Mick Schumacher',   'MSC', 22, 2);
INSERT INTO Jazdec VALUES (16, 'Kevin Magnussen',   'MAG', 29, 15);
INSERT INTO Jazdec VALUES (17, 'Valterri Bottas',   'BOT', 32, 13);
INSERT INTO Jazdec VALUES (18, 'Guanyu Zhou',       'ZHO', 22, 14);
INSERT INTO Jazdec VALUES (19, 'Alex Albon',        'ALB', 25, 12);
INSERT INTO Jazdec VALUES (20, 'Nicholas Latifi',   'LAT', 26, 11);
INSERT INTO Jazdec VALUES (21, 'Kimi Raikonnen',    'RAI', 42, 13);
INSERT INTO Jazdec VALUES (22, 'Nikita Mazepin',    'MAZ', 23, NULL);
INSERT INTO Jazdec VALUES (23, 'Robert Kubica',     'KUB', 37, NULL);


-- SEZONA
INSERT INTO sezona VALUES (2021, 2, 1);
INSERT INTO sezona VALUES (2020, 2, 2);
INSERT INTO sezona VALUES (2019, 2, 2);
INSERT INTO sezona VALUES (2018, 2, 2);
INSERT INTO sezona VALUES (2017, 2, 2);
INSERT INTO sezona VALUES (2016, 2, 2);
INSERT INTO sezona VALUES (2015, 2, 2);
INSERT INTO sezona VALUES (2014, 2, 2);
INSERT INTO sezona VALUES (2013, 1, 1);
INSERT INTO sezona VALUES (2012, 1, 1);
INSERT INTO sezona VALUES (2011, 1, 1);
INSERT INTO sezona VALUES (2010, 1, 1);


-- KONTRAKTY
-- (Roky aj platy semi-fiktivne)
INSERT INTO Kontrakt VALUES (1, 1,  1,  2016, NULL, 42000000);
INSERT INTO Kontrakt VALUES (2, 2,  1,  2020, NULL, 18000000);
INSERT INTO Kontrakt VALUES (3, 3,  2,  2013, NULL, 62000000);
INSERT INTO Kontrakt VALUES (4, 4,  2,  2022, NULL,  5000000);
INSERT INTO Kontrakt VALUES (5, 9,  3,  2019, NULL, 12000000);
INSERT INTO Kontrakt VALUES (6, 10, 3,  2020, NULL, 10000000);
INSERT INTO Kontrakt VALUES (7, 5,  4,  2021, NULL, 10000000);
INSERT INTO Kontrakt VALUES (8, 6,  4,  2018, NULL,  9000000);
INSERT INTO Kontrakt VALUES (9, 11, 5,  2021, NULL, 25000000);
INSERT INTO Kontrakt VALUES (10, 12, 5,  2020, NULL,  5000000);
INSERT INTO Kontrakt VALUES (11, 13, 6,  2017, NULL,  5000000);
INSERT INTO Kontrakt VALUES (12, 14, 6,  2021, NULL,   500000);
INSERT INTO Kontrakt VALUES (13, 7,  7,  2021, NULL, 15000000);
INSERT INTO Kontrakt VALUES (14, 8,  7,  2019, NULL,  1915000);
INSERT INTO Kontrakt VALUES (15, 19, 8,  2022, NULL,  2000000);
INSERT INTO Kontrakt VALUES (16, 20, 8,  2020, NULL,  1000000);
INSERT INTO Kontrakt VALUES (17, 17, 9,  2022, NULL, 10000000);
INSERT INTO Kontrakt VALUES (18, 18, 9,  2022, NULL,  1000000);
INSERT INTO Kontrakt VALUES (19, 16, 10, 2021, NULL,  6000000);
INSERT INTO Kontrakt VALUES (20, 15, 10, 2022, NULL,  1000000);
INSERT INTO Kontrakt VALUES (21, 22, 10, 2021, 2021,  1000000);
INSERT INTO Kontrakt VALUES (22,  7,  3, 2018, 2020, 57000000);

-- MOTOR VYROBCA
INSERT INTO motor_vyrobca VALUES (1, 'Mercedes',                2);
INSERT INTO motor_vyrobca VALUES (2, 'Red Bull Powertrains',    1);
INSERT INTO motor_vyrobca VALUES (3, 'Honda',                NULL);
INSERT INTO motor_vyrobca VALUES (4, 'Renault',                 5);
INSERT INTO motor_vyrobca VALUES (5, 'Ferrari',                 3);

-- AUTO
INSERT INTO Auto VALUES ('W12',     2,  1);
INSERT INTO Auto VALUES ('RB16B',   1,  2);
INSERT INTO Auto VALUES ('SF21',    3,  5   );
INSERT INTO Auto VALUES ('MCL35M',  4,  1);
INSERT INTO Auto VALUES ('A521',    5,  4);
INSERT INTO Auto VALUES ('AMR22',   7,  1);
INSERT INTO Auto VALUES ('AT02',    6,  2);
INSERT INTO Auto VALUES ('C41',     9,  5);
INSERT INTO Auto VALUES ('VF21',   10,  5);
INSERT INTO Auto VALUES ('FW43B',   8,  1);

-- PRETEK
INSERT INTO Pretek VALUES ( 1, 'Gulf Air Bahrain Grand Prix',                                   true,  2021, 1,  5,  3);
INSERT INTO Pretek VALUES ( 2, 'Pirelli Gran Premo Del Made In Italy E Dell''Emilia Romagna',   true,  2021, 1,  1,  1);
INSERT INTO Pretek VALUES ( 3, 'Heineken Grande Premio De Portugal',                            true,  2021, 1, 25,  3);
INSERT INTO Pretek VALUES ( 4, 'Aramco Gran Premio De Espana',                                  true,  2021, 1,  7,  3);
INSERT INTO Pretek VALUES ( 5, 'Grand Prix de Monaco',                                          false, 2021, 1,  8,  1);
INSERT INTO Pretek VALUES ( 6, 'Azerbaijan Grand Prix',                                         true,  2021, 1,  6,  2);
INSERT INTO Pretek VALUES ( 7, 'Emirates Grand Prix de France',                                 false, 2021, 1, 12,  1);
INSERT INTO Pretek VALUES ( 8, 'BWT Grosser Preis der Steiermark',                              false, 2021, 1, 20,  1);
INSERT INTO Pretek VALUES ( 9, 'BWT Grosser Preis von Osterreich',                              true,  2021, 1, 20,  1);
INSERT INTO Pretek VALUES (10, 'Pirelli British Grand Prix',                                    false, 2021, 1, 22,  3);
INSERT INTO Pretek VALUES (11, 'Rolex Magyar Nagydij',                                          true,  2021, 1, 14, 12);
INSERT INTO Pretek VALUES (12, 'Rolex Belgian Grand Prix',                                      true,  2021, 1,  9,  1);
INSERT INTO Pretek VALUES (13, 'Heineken Dutch Grand Prix',                                     false, 2021, 1, 13,  1);
INSERT INTO Pretek VALUES (14, 'Heineken Gran Premio D''Italia',                                true,  2021, 1,  4,  5);
INSERT INTO Pretek VALUES (15, 'VTB Russian Grand Prix',                                        false, 2021, 1, 26,  3);
INSERT INTO Pretek VALUES (16, 'Rolex Turkish Grand Prix',                                      false, 2021, 1, 27,  17);
INSERT INTO Pretek VALUES (17, 'Aramco United States Grand Prix',                               false, 2021, 1, 11,  1);
INSERT INTO Pretek VALUES (18, 'Gran Premio De La Ciudad De Mexico',                            true,  2021, 1,  2,  1);
INSERT INTO Pretek VALUES (19, 'Heineken Grande Premio De Sao Paulo',                           true,  2021, 1,  3,  3);
INSERT INTO Pretek VALUES (20, 'Ooredoo Qatar Grand Prix',                                      false, 2021, 1, 28,  3);
INSERT INTO Pretek VALUES (21, 'STC Saudi Arabian Grand Prix',                                  true,  2021, 1, 15,  2);
INSERT INTO Pretek VALUES (22, 'Etihad Airways Abu Dhabi Grand Prix',                           true,  2021, 1, 24,  1);

-- TREST
INSERT INTO trest VALUES ( 1, 0,     0, 0, 0, 13, 22 );
INSERT INTO trest VALUES ( 2, 0,     5, 0, 2, 14, 22 );
INSERT INTO trest VALUES ( 3, 0,     5, 0, 2,  1, 22 );
INSERT INTO trest VALUES ( 4, 200,   0, 0, 0,  7, 22 );
INSERT INTO trest VALUES ( 5, 200,   0, 0, 0,  7, 22 );
INSERT INTO trest VALUES ( 6, 10000, 0, 0, 0, 12, 22 );
INSERT INTO trest VALUES ( 7, 0,     5, 0, 2, 14, 21 );
INSERT INTO trest VALUES ( 8, 0,     0, 0, 0, 13, 21 );
INSERT INTO trest VALUES ( 9, 25000, 0, 0, 0,  3, 21 );
INSERT INTO trest VALUES (10, 0,     0, 5, 2,  1, 20 );
INSERT INTO trest VALUES (11, 0,     0, 3, 1, 17, 20 );
INSERT INTO trest VALUES (12, 0,     5, 0, 1,  1, 20 );
INSERT INTO trest VALUES (13, 0,    10, 0, 2,  1, 21 );
INSERT INTO trest VALUES (14, 25000, 0, 0, 0,  3, 19 );
INSERT INTO trest VALUES (15, 0,    10, 0, 2, 14, 19);
INSERT INTO trest VALUES (16, 50000, 0, 0, 0,  1, 19);
INSERT INTO trest VALUES (17, 0,     0, 5, 0,  3, 19);
INSERT INTO trest VALUES (18, 1000,  0, 0, 0, 21, 18);
INSERT INTO trest VALUES (19, 0,     0, 5, 0, 8,  18);
INSERT INTO trest VALUES (20, 0,    0, 0, 0, 21, 18);
INSERT INTO trest VALUES (21, 0,    0, 20, 0, 12, 18);
INSERT INTO trest VALUES (22, 0,     0, 20, 0, 6, 18);
INSERT INTO trest VALUES (23, 0,    0, 5, 0, 4, 18);
INSERT INTO trest VALUES (24, 0,    0, 0, 0, 22, 18);
INSERT INTO trest VALUES (25, 0,    0, 20, 0, 8, 18);
INSERT INTO trest VALUES (26, 0,    0, 20, 0, 14, 18);
INSERT INTO trest VALUES (27, 0,    0, 0, 0, 21, 18);
INSERT INTO trest VALUES (28, 0,    0, 0, 0, 3, 18);
INSERT INTO trest VALUES (29, 0,    0, 20, 0, 11, 17);
INSERT INTO trest VALUES (30, 0,    0, 5, 0, 17, 17);
INSERT INTO trest VALUES (31, 0,    0, 20, 0, 4, 17);
INSERT INTO trest VALUES (32, 0,    0, 20, 0, 7, 17);
INSERT INTO trest VALUES (33, 0,    5, 0, 2, 13, 16);
INSERT INTO trest VALUES (34, 0,    5, 0, 2, 11, 16);
INSERT INTO trest VALUES (35, 0,    0, 20, 0, 5, 16);
INSERT INTO trest VALUES (36, 0,    0, 20, 0, 10, 16);
INSERT INTO trest VALUES (37, 0,    0, 10, 0, 3, 16);