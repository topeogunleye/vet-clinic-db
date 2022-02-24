/* Database schema to keep the structure of entire database. */
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);
--           List of relations
--  Schema |  Name   | Type  |  Owner   
-- --------+---------+-------+----------
--  public | animals | table | postgres
-- (1 row)

ALTER TABLE animals  
ADD species varchar(150);
-- ALTER TABLE
-- \d animals
--                           Table "public.animals"
--      Column      |          Type          | Collation | Nullable | Default 
-- -----------------+------------------------+-----------+----------+---------
--  id              | integer                |           | not null | 
--  name            | character varying(100) |           | not null | 
--  date_of_birth   | date                   |           | not null | 
--  escape_attempts | integer                |           |          | 
--  neutered        | boolean                |           |          | 
--  weight_kg       | numeric                |           |          | 
--  species         | character varying(255) |           |          | 
-- Indexes:
--     "animals_pkey" PRIMARY KEY, btree (id)

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    full_name varchar(100) NOT NULL,
    age INT NOT NULL
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
DROP TABLE IF EXISTS species;
CREATE TABLE species (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    name varchar(100) NOT NULL
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals
DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);

