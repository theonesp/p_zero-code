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


--------------------------------------------------------
--  DDL for Table znt_score_tp
--------------------------------------------------------

-- Drop table
-- DROP TABLE stage_sild.znt_score_tp source

-- This table extracts the value for each vital sign from the table data_scope.znt_score using regexp and performs some transformations.

CREATE TABLE stage_sild.znt_score_tp
AS SELECT
	id_score AS score_id,
	CONCAT(date,hora) AS result_date,
	patnr,
	id AS patient_ref,
	care_level_ref,
	ou_med_ref,
	usuari AS znt_score_tp_user,
	vpid, 
	vwert AS score,
	"substring"(valors::text, 'ESTADO_CONCIENC_(.)'::text) AS conc_state,
    "substring"(valors::text, 'FC_EKG=([[:digit:]]*)'::text) AS hr_ecg,
    "substring"(valors::text, 'FC_OSC=([[:digit:]]*)'::text) AS hr_osc,
    "substring"(valors::text, 'FR_IP=([[:digit:]]*)'::text) AS rr_ip,
    "substring"(valors::text, 'FREC_RESP=([[:digit:]]*)'::text) AS rr,     
    "substring"(valors::text, 'O2_DIS_(.)'::text) AS o2_sup,    
    "substring"(valors::text, 'PA_S=([[:digit:]]*)'::text) AS pa_s,      
    "substring"(valors::text, 'PRESN_SIS=([[:digit:]]*)'::text) AS presn,
    "substring"(valors::text, 'PULSIOX=([[:digit:]]*)'::text) AS pulsiox,   
    "substring"(valors::text, 'PULSO=([[:digit:]]*)'::text) AS pulse,
    "substring"(valors::text, 'TEMP_AXI=([[:digit:]]*\.[[:digit:]])'::text) AS temp_axi,
    "substring"(valors::text, 'TEMP_BU=([[:digit:]]*\.[[:digit:]])'::text) AS temp_bu,    
    "substring"(valors::text, 'TEMP_CT=([[:digit:]]*\.[[:digit:]])'::text) AS temp_ct,       
    "substring"(valors::text, 'TEMP_TIM=([[:digit:]]*\.[[:digit:]])'::text) AS temp_tim,    
	aillat AS group_flag
FROM
	data_scope.znt_score;	
ALTER TABLE  stage_sild.znt_score_tp ADD COLUMN znt_score_tp_id BIGSERIAL PRIMARY KEY;	

