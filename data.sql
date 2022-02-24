/* Populate database with sample data. */
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Agumon','2020-02-03',0,true,'10.23'),
('Gabumon','2018-11-15',2,true,'8'),
('Pikachu', '2021-01-07',1,false, '15.04'),
('Devimon', '2017-05-12', 5, true, '11');

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Charmander','2020-02-08',0,false,'-11'),
('Plantmon','2022-11-15',2,true,'-5.7'),
('Squirtle', '1993-04-02',3,false, '-12.13'),
('Angemon', '2005-06-12', 1, true, '-45'),
('Boarmon', '2005-06-07', 7, true, '20.4'),
('Blossom', '1998-10-13', 3, true, '17');

-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
-- Jennifer Orwell 19 years old.
-- Bob 45 years old.
-- Melody Pond 77 years old.
-- Dean Winchester 14 years old.
-- Jodie Whittaker 38 years old.

INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert the following data into the species table:
-- Pokemon
-- Digimon

INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon

BEGIN;
UPDATE animals
SET species_id = 'Digimon'
WHERE name LIKE '%mon';


-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.

ALTER TABLE animals
ADD COLUMN owner_id INTEGER
SET owner_id = 'Sam-Smith';
WHERE name LIKE 'Agumon'
SET owner_id = 'Jennifer-Orwell';
WHERE name LIKE 'Gabumon' AND name LIKE 'Pikachu'
SET owner_id = 'Bob';
WHERE name LIKE 'Devimon' AND name LIKE 'Plantmon'
SET owner_id = 'Melody-Pond';
WHERE name LIKE 'Charmander' AND name LIKE 'Squirtle' AND name LIKE 'Blossom'
SET owner_id = "Dean-Winchester";
WHERE name LIKE 'Angemon' AND name LIKE 'Boarmon';


