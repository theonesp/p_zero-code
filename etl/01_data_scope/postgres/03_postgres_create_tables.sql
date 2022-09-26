-- -------------------------------------------------------------------------------
--
-- Create data_scope tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - 08/03/2022
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
SET search_path TO data_scope; -- or your schema name

--------------------------------------------------------
--  DDL for Table data_scope.znt_score
--------------------------------------------------------

-- DROP TABLE IF EXISTS data_scope.znt_score;
CREATE TABLE data_scope.znt_score (
	patient_id int4 NULL,
	id int4 NULL,
	mandt int4 NULL,
	id_score varchar NULL,
	"data" date NULL,
	hora varchar NULL,
	usuari varchar NULL,
	vpid int4 NULL,
	vwert int4 NULL,
	pop_up varchar NULL,
	envio_medxat_med varchar NULL,
	envio_medxat_enf varchar NULL,
	envio_email varchar NULL,
	valors varchar NULL,
	aillat varchar NULL,
	ou_med_ref int4 NULL,
	care_level_ref int4 NULL
);

--------------------------------------------------------
--  DDL for Table data_scope.demog
--------------------------------------------------------
-- DROP TABLE IF EXISTS data_scope.demog;
CREATE TABLE data_scope.demog(
   patient_ref INTEGER 
  ,birth_date  TIMESTAMP
  ,sex         INTEGER 
  ,nation_ref  VARCHAR
  ,load_date	TIMESTAMP
);

--------------------------------------------------------
--  DDL for Table data_scope.nation_dic
--------------------------------------------------------
-- DROP TABLE IF EXISTS data_scope.nation_dic;
CREATE TABLE data_scope.nation_dic(
   natio_ref VARCHAR
  ,label      VARCHAR
  ,TT        VARCHAR
);

--------------------------------------------------------
--  DDL for Table data_scope.diag_scope
--------------------------------------------------------

-- DROP TABLE IF EXISTS data_scope.diag_scope;
CREATE TABLE data_scope.diag_scope(
   patient_ref INTEGER
  ,episode_ref INTEGER
  ,diag_ref INTEGER
  ,class    VARCHAR
  ,load_date TIMESTAMP
  ,diag_id  INTEGER
);

--------------------------------------------------------
--  DDL for Table data_scope.diag_dic
--------------------------------------------------------
-- DROP TABLE IF EXISTS data_scope.diag_dic;
CREATE TABLE data_scope.diag_dic(
    diag_ref INTEGER
    ,cie VARCHAR
    ,catalog INTEGER
    ,cie_ref VARCHAR
    ,´desc´ VARCHAR
    ,diag_sap_ref INTEGER
	
--------------------------------------------------------
--  DDL for Table data_scope.exitus_scope
--------------------------------------------------------
-- DROP TABLE IF EXISTS data_scope.exitus_scope;
CREATE TABLE data_scope.exitus_scope(
    patient_id INTEGER
    ,exitus_date TIMESTAMP
    ,load_date TIMESTAMP
);

--------------------------------------------------------
--  DDL for Table data_scope.lab_scope
--------------------------------------------------------
-- DROP TABLE data_scope.lab_scope;
CREATE TABLE data_scope.lab_scope (
  lab_id int4 NOT NULL,
  patient_ref int4 NULL,
  episode_ref int4 NULL,
  extrac_date varchar NULL,
  res_date varchar NULL,
  ou_med_ref varchar NULL,
  ou_loc_ref varchar NULL,
  care_level_ref int4 NULL,
  lab_ref int4 NULL,
  result_num numeric NULL,
  raw_result_txt varchar NULL,
  result_txt varchar NULL,
  load_date varchar NULL
);