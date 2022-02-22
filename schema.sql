/* Database schema to keep the structure of entire database. */
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
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
