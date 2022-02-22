/*Queries that provide answers to the questions from all projects.*/
-- Vet_Clinic

SELECT * FROM animals WHERE name LIKE '%mon';
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (3 rows)


SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

--   name   
-- ---------
--  Gabumon
--  Devimon
-- (2 rows)

SELECT name FROM animals WHERE  neutered IS TRUE AND escape_attempts < 3;

--   name   
-- ---------
--  Agumon
--  Gabumon
-- (2 rows)

SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';

--  date_of_birth 
-- ---------------
--  2020-02-03
--  2021-01-07
-- (2 rows)

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--   name   | escape_attempts 
-- ---------+-----------------
--  Pikachu |               1
--  Devimon |               5
-- (2 rows)

SELECT * FROM animals WHERE neutered IS TRUE;

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (3 rows)

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (3 rows)

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (2 rows)

-- Inside a transaction update the animals table by setting the species column to unspecified
-- for all animals.
-- Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
-- UPDATE 10
SELECT species FROM animals;
--    species   
-- -------------
--  unspecified
--  unspecified
--  unspecified
--  unspecified
--  unspecified
--  unspecified
--  unspecified
--  unspecified
--  unspecified
--  unspecified
-- (10 rows)

ROLLBACK;
-- ROLLBACK
SELECT species FROM animals;
--  species 
-- ---------
 
 
 
 
 
 
 
 
-- (10 rows)

--  Inside a transaction Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.

BEGIN;
-- BEGIN

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
-- UPDATE 6


