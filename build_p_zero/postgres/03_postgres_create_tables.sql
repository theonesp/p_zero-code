-- -------------------------------------------------------------------------------
--
-- Create covidhm tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - 19/01/2021
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
SET search_path TO zero; -- or your schema name

--------------------------------------------------------
--  DDL for Table antibiograma
--------------------------------------------------------

DROP TABLE IF EXISTS zero.dic_items;
CREATE TABLE zero.dic_items
(
  itemid INTEGER NOT NULL,
  label VARCHAR(100) NOT NULL,
  abbreviation VARCHAR(50) NOT NULL,
  linksto VARCHAR(30) NOT NULL,
  category VARCHAR(50) NOT NULL,
  unitname VARCHAR(50),
  param_type VARCHAR(20) NOT NULL,
  lownormalvalue FLOAT,
  highnormalvalue FLOAT
);
