-- -------------------------------------------------------------------------------
--
-- Create stage_sild tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - 08/03/2022
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
SET search_path TO stage_sild; -- or your schema name

--------------------------------------------------------
--  DDL for Table r_monitor
--------------------------------------------------------

-- Drop table

-- DROP TABLE r_monitor;

CREATE TABLE  r_monitor(
   MANDT            INTEGER 
  ,ID_SCORE         VARCHAR
  ,DATA             DATE 
  ,HORA             VARCHAR
  ,PATNR            INTEGER 
  ,id               INTEGER 
  ,USUARI           VARCHAR
  ,VPID             INTEGER 
  ,VWERT            INTEGER 
  ,POP_UP           VARCHAR
  ,ENVIO_MEDXAT_MED VARCHAR
  ,ENVIO_MEDXAT_ENF VARCHAR
  ,ENVIO_EMAIL      VARCHAR
  ,VALORS           VARCHAR
  ,AILLAT           VARCHAR
);
