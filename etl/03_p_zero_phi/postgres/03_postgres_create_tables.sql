-- -------------------------------------------------------------------------------
--
-- Create p_zero_phi tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - 19/01/2021
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
SET search_path TO p_zero_phi; -- or your schema name

--------------------------------------------------------
--  DDL for Table antibiograma
--------------------------------------------------------

DROP TABLE IF EXISTS p_zero_phi.dic_items;
CREATE TABLE p_zero_phi.dic_items
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
