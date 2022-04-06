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
--  DDL for Table r_monitor
--------------------------------------------------------

-- Drop table
-- DROP TABLE stage_sild.r_monitor_parsed source

-- This view extracts the value for each vital sign in the table r_monitor using regexp.
CREATE OR REPLACE VIEW stage_sild.r_monitor_parsed
AS SELECT r_monitor.mandt,
    r_monitor.id_score,
    r_monitor.data,
    r_monitor.hora,
    r_monitor.patnr,
    r_monitor.id,
    r_monitor.usuari,
    r_monitor.vpid,
    r_monitor.vwert,
    r_monitor.pop_up,
    r_monitor.envio_medxat_med,
    r_monitor.envio_medxat_enf,
    r_monitor.envio_email, 
    "substring"(r_monitor.valors::text, 'ESTADO_CONCIENC_(.)'::text) AS conc_state,
    "substring"(r_monitor.valors::text, 'FC_EKG=([[:digit:]]*)'::text) AS hr_ecg,
    "substring"(r_monitor.valors::text, 'FC_OSC=([[:digit:]]*)'::text) AS hr_osc,
    "substring"(r_monitor.valors::text, 'FR_IP=([[:digit:]]*)'::text) AS rr_ip,
    "substring"(r_monitor.valors::text, 'FREC_RESP=([[:digit:]]*)'::text) AS rr,     
    "substring"(r_monitor.valors::text, 'O2_DIS_(.)'::text) AS o2_sup,    
    "substring"(r_monitor.valors::text, 'PA_S=([[:digit:]]*)'::text) AS pa_s,      
    "substring"(r_monitor.valors::text, 'PRESN_SIS=([[:digit:]]*)'::text) AS presn,
    "substring"(r_monitor.valors::text, 'PULSIOX=([[:digit:]]*)'::text) AS pulsiox,   
    "substring"(r_monitor.valors::text, 'PULSO=([[:digit:]]*)'::text) AS pulse,
    "substring"(r_monitor.valors::text, 'TEMP_AXI=([[:digit:]]*\.[[:digit:]])'::text) AS temp_axi,
    -- "substring"(r_monitor.valors::text, 'TEMP_BU=([[:digit:]]*\.[[:digit:]])'::text) AS temp_bu,    
    -- "substring"(r_monitor.valors::text, 'TEMP_CT=([[:digit:]]*\.[[:digit:]])'::text) AS temp_ct,       
    -- "substring"(r_monitor.valors::text, 'TEMP_TIM=([[:digit:]]*\.[[:digit:]])'::text) AS temp_tim,    
    r_monitor.aillat
   FROM stage_sild.r_monitor;
