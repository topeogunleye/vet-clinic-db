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

-- Inside a transaction Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals SET  species = 'pokemon' WHERE species IS NULL;
-- UPDATE 4

-- Commit the transaction.
COMMIT;
-- COMMIT

-- Verify that change was made and persists after commit.
SELECT species FROM animals;

--  species 
-- ---------
--  digimon
--  digimon
--  digimon
--  digimon
--  digimon
--  digimon
--  pokemon
--  pokemon
--  pokemon
--  pokemon
-- (10 rows)

--  Inside a transaction delete all records in the animals table, then roll back the transaction

BEGIN;
-- BEGIN
TRUNCATE TABLE animals;
-- TRUNCATE TABLE
ROLLBACK;
-- ROLLBACK

-- After the roll back verify if all records in the animals table still exist
-- SELECT * FROM animals;
--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   6 | Plantmon   | 2022-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
-- (10 rows)

-- Inside a transaction: 
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
-- BEGIN

DELETE
FROM 
  animals
WHERE
  date_of_birth > '2022-01-01';
-- DELETE 1

SAVEPOINT my_savepoint;
-- SAVEPOINT

UPDATE animals
SET
  weight_kg = weight_kg * -1;
-- UPDATE 9

ROLLBACK TO SAVEPOINT my_savepoint;
-- ROLLBACK
UPDATE animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;
-- UPDATE 3

COMMIT;

-- Write queries to answer the following questions:

-- How many animals are there?
-- How many animals have never tried to escape?
-- What is the average weight of animals?
-- Who escapes the most, neutered or not neutered animals?
-- What is the minimum and maximum weight of each type of animal?
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT COUNT(*) FROM animals;
--  count 
-- -------
--      9
-- (1 row)

SELECT 
  COUNT(escape_attempts) 
FROM 
  animals
WHERE 
  escape_attempts = 0;
--  count 
-- -------
--      2
-- (1 row)

SELECT AVG(weight_kg) FROM animals;
--          avg         
-- ---------------------
--  16.6444444444444444
-- (1 row)

SELECT
    neutered, MAX(escape_attempts)
FROM
    animals
GROUP BY neutered
ORDER BY MAX(escape_attempts) DESC limit 1;
--  neutered | max 
-- ----------+-----
--  t        |   7
-- (1 row)

SELECT 
    MIN(weight_kg), MAX(weight_kg)
FROM 
    animals
GROUP BY species;
--  min | max 
-- -----+-----
--   11 |  17
--    8 |  45
-- (2 rows)

SELECT 
    AVG(escape_attempts)
FROM
    animals
WHERE
    date_of_birth < '2000-01-01' AND date_of_birth > '1990-01-01';
--------------------
--  3.0000000000000000

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?

-- What animals belong to Melody Pond
SELECT 
  animals.name
FROM
  animals
JOIN
  owners
ON
  animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
  animals.name
FROM
  animals
JOIN
  species
ON
  animals.species_id = species.id
WHERE
  species.name = 'pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
  name
FROM
  owners
  JOIN animals
  ON owners.id = animals.owner_id;

-- How many animals are there per species
SELECT
  species.name, COUNT(*)
FROM
  animals
JOIN
  species
ON
  animals.species_id = species.id
GROUP BY
  species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT 
  name
FROM
  animals
WHERE
  owner_id = 2 AND species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT
  animals.name 
FROM
  animals
JOIN
  owners
ON
  animals.owner_id = owners.id
WHERE
  owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals
SELECT
  owners.full_name, COUNT(*)
FROM
  owners
JOIN
  animals
ON
  owners.id = animals.owner_id
GROUP BY
  owners.full_name
ORDER BY
  COUNT(*) DESC LIMIT 1;


--  Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
-- How many different animals did Stephanie Mendez see?
-- List all vets and their specialties, including vets with no specialties.
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
-- What animal has the most visits to vets?
-- Who was Maisy Smith's first visit?
-- Details for most recent visit: animal information, vet information, and date of visit.
-- How many visits were with a vet that did not specialize in that animal's species?
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

-- Who was the last animal seen by William Tatcher?
SELECT 
  owners.full_name
FROM  
  owners 
JOIN
  animals 
ON
  owners.id = animals.owner_id
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
WHERE
  vets.name = 'Vet William Tatcher'
ORDER BY
  visits.date_of_visit DESC
LIMIT 1;  

-- How many different animals did Stephanie Mendez see?
SELECT 
  COUNT(DISTINCT animals.name) 
FROM
  animals 
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
WHERE
  vets.name = 'Vet Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties
SELECT
  vets.name, species.name AS specialty 
FROM
  vets
JOIN
  specializations 
ON
  vets.id = specializations.vet_id
JOIN
  species
ON
  specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020

SELECT 
  animals.name 
FROM
  animals
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
WHERE
  vets.name = 'Vet Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets
SELECT
  animals.name, COUNT(*)
FROM
  animals
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
GROUP BY
  animals.name
ORDER BY
  COUNT(*) DESC LIMIT 1;

  --  Who was Maisy Smith's first visit
SELECT 
  animals.name
FROM
  animals
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
WHERE
  vets.name = 'Vet Maisy Smith'
ORDER BY
  visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT 
  animals.name, vets.name, visits.date_of_visit
FROM
  animals
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
ORDER BY
  visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(*)
FROM
  visits
JOIN
  vets
ON
  visits.vet_id = vets.id
WHERE
  vets.id NOT IN (
    SELECT
      vets.id
    FROM
      vets
    JOIN
      specializations
    ON
      vets.id = specializations.vet_id
    JOIN
      animals
    ON
      specializations.species_id = animals.species_id
    WHERE
      animals.name = 'pokemon'
  );

--  What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
  species.name
FROM
  animals
JOIN
  visits
ON
  animals.id = visits.animal_id
JOIN
  vets
ON
  visits.vet_id = vets.id
JOIN
  specializations
ON
  vets.id = specializations.vet_id
JOIN
  species
ON
  specializations.species_id = species.id
WHERE
  vets.name = 'Vet Maisy Smith'
GROUP BY
  species.name
ORDER BY
  COUNT(*) DESC LIMIT 1;


EXPLAIN ANALYSE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYSE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYSE SELECT * FROM owners where email = 'owner_18327@mail.com';
