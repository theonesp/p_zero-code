





-----------------------EXTRACCIÓ TAULES BASE DEL DATASCOPE-----------------------
---- corre en servidor datascope mysql

-- MOV_EVENTS: Extracció de mov_events de datalake per carregar al p_zero datascope
with znt_colap as (
(select distinct patient_ref from datascope.znt_score)
)
SELECT * FROM datascope.mov_events
where patient_ref in (select patient_ref from znt_colap)
and date(start_date) > '2020-06-01'

-- CARE_LEVEL_EVENTS: Extracció de care_level_events de datalake per carregar al p_zero datascope
with znt_colap as (
(select distinct patient_ref from datascope.znt_score)
)
SELECT * FROM datascope.care_level_events
where patient_ref in (select patient_ref from znt_colap)
and date(start_date) > '2020-06-01'



-- EPISODE_EVENTS: extracció taula episode_events
with znt_colap as (
(select distinct patient_ref from datascope.znt_score)
)
SELECT * FROM datascope.episodi_events
where patient_ref in (select patient_ref from znt_colap)
and date(start_date) > '2020-06-01'


-- extracció diagnostics de datascope (mysql)

with znt_colap as (
(select distinct patient_ref from datascope.znt_score)
)
SELECT * FROM datascope.diag_events
where patient_ref in (select patient_ref from znt_colap)
-- not time limit because we want previous conditions
-- filter by patient not by episode.
-- interpretació de diagnostics:  episodis consultes externes tenen data de dx el dia de la visita, episodis d'ingrés tenen data de dx el dia de l'ingrés.


-- extracció de diccionari de diagnostics de datascope (mysql)
-- traducció a cie-9 i cie-10
SELECT * FROM datascope.diag_sap_dic;



-- EVERYTHING BEFORE HERE HAPPENS ON CLINIC SERVER, BEFORE data_scope
-------------------------------------- BASE TABLES CREATE + INGESTIONS--------------------------------------


--- ZNT_SCORE

DROP TABLE IF EXISTS data_scope.znt_score;

CREATE TABLE data_scope.znt_score (
	
    id varchar DEFAULT NULL,
    MANDT int DEFAULT NULL,
    ID_SCORE varchar(45) DEFAULT NULL,
    DATA date NOT NULL,
    HORA  time NOT NULL,
    PATNR int NOT NULL,
   USUARI  varchar(45) NOT NULL,
   VPID  int NOT NULL,
   VWERT  int NOT NULL,
   POP_UP  varchar(2) DEFAULT NULL,
   ENVIO_MEDXAT_MED  varchar(2) DEFAULT NULL,
   ENVIO_MEDXAT_ENF  varchar(2) DEFAULT NULL,
   ENVIO_EMAIL  varchar(2) DEFAULT NULL,
   VALORS  varchar(256) NOT NULL,
   AILLAT  varchar(4) DEFAULT NULL,
   patient_ref  int DEFAULT NULL


);

copy data_scope.znt_score  FROM '/home/admin/xavi_cabin/znt_score.csv' DELIMITER ',' CSV HEADER;



-- MOV_EVENTS

DROP TABLE IF EXISTS data_scope.mov_events;

CREATE TABLE data_scope.mov_events (
    
    patient_ref  bigint NULL,
    episode_ref bigint  NULL,
    care_level_ref INT NULL,
    ou_med_ref varchar NULL,
    ou_loc_ref varchar NULL,
    start_date  timestamp NULL,
    end_date  timestamp NULL,
    load_date  timestamp NULL,
    mov_id bigint NULL
);


copy data_scope.mov_events  FROM '/home/admin/xavi_cabin/mov_events.csv' DELIMITER ',' CSV HEADER;




-- care_level_events

DROP TABLE IF EXISTS data_scope.care_level_events;

CREATE TABLE data_scope.care_level_events (
    
    care_level_ref INT NULL,
    patient_ref  bigint NULL,
    care_level_type_ref varchar NULL,
    start_date  timestamp NULL,
    end_date  timestamp NULL,
    id_hosp bigint NULL,
    id_stay varchar NULL,
    id_process varchar NULL,
    load_date  timestamp NULL
);

copy data_scope.care_level_events  FROM '/home/admin/xavi_cabin/care_level_events.csv' DELIMITER ',' CSV HEADER;



-- LAB_EVENTS


DROP TABLE IF EXISTS data_scope.lab_events;
CREATE TABLE data_scope.lab_events 
(
    lab_id INT NOT NULL,
    patient_ref bigINT NOT NULL,
    episode_ref bigINT NOT NULL,
    extrac_date TIMESTAMP NOT NULL,
    res_date timestamp NOT NULL,
    ou_med_ref varchar(20),
    ou_loc_ref varchar(20),
    care_level_ref bigint NULL,
    lab_ref  BIGINT NULL,
    result_num real NULL,
    result_txt varchar(255),
    load_date timestamp NULL
);

copy  data_scope.lab_events  FROM '/home/admin/xavi_cabin/lab_events.csv' DELIMITER ',' CSV HEADER;



-- LAB_DIC

DROP TABLE IF EXISTS data_scope.lab_dic;
CREATE TABLE data_scope.lab_dic 
(
   
    lab_ref  BIGINT NULL,
    descr varchar(255) NULL,
    units varchar(255) NULL
    
);

copy  data_scope.lab_dic FROM '/home/admin/xavi_cabin/lab_dic.csv' DELIMITER ',' CSV HEADER;


--EPISODE_EVENTS

DROP TABLE IF EXISTS data_scope.episode_events;

CREATE TABLE data_scope.episode_events 
(
    patient_ref BIGINT NOT NULL,
    episode_ref BIGINT NOT NULL,
    start_date TIMESTAMP  NULL,
    end_date TIMESTAMP NULL,
    mot_start   VARCHAR(255) NULL,
    mot_end     VARCHAR(255) NULL,
    load_date TIMESTAMP NULL
);

-- ingestio de dades de episodi_events
copy  data_scope.episode_events  FROM '/home/admin/xavi_cabin/episode_events.csv' DELIMITER ',' CSV HEADER;



-- DIAG_EVENTS
DROP TABLE IF EXISTS data_scope.diag_events;

CREATE TABLE data_scope.diag_events(
    patient_ref INT,
    episode_ref bigint, 
    diag_ref bigint,
    class  VARCHAR(20), -- motiu d'ingrés, informe secundari
    reg_date TIMESTAMP null,
    load_date TIMESTAMP null,
    diag_id bigint not null
);  

copy data_scope.diag_events  FROM '/home/admin/xavi_cabin/diag_events.csv' DELIMITER ',' CSV HEADER;

-- modificar taula seleccionant només els pacients del projecte zero només agafo els casos 
-- que els pacients estan a la taula demog.


-- DIAG_DIC (equival a taula diag_sap_dic de datascope)
DROP TABLE IF EXISTS data_scope.diag_dic;

CREATE TABLE data_scope.diag_dic( -- taula encaixa amb opcio 1  
    diag_ref bigint,
    cie  VARCHAR(20), -- motiu d'ingrés, informe secundari
    catalog  int null,
    cie_ref varchar(20) null,
    descr varchar(256),
    diag_sap_ref bigint null
);  

copy data_scope.diag_dic  FROM '/home/admin/xavi_cabin/diag_dic.csv' DELIMITER ',' CSV HEADER;






---------------STAGE TABLES CREATION-------------------------------------------------------
------------STAGE TABLES CREATION FROM DATA_SCOPE POSGRL TABLES--------------


-- per fer correr en servidor pzero (posgresql)
-- GENERACIÓ DE ZNT SCORE indexat per patient_ref, episode_ref, care_level_ref.
-- TAULES BASE: mov_events, care_level_events, znt_score

-- ZNT_SCORE_STAGE
CREATE TABLE p_zero_stage.znt_score_stage as
(
with  mov_colap as
( -- colapsa mov_events per per tenir granularitat episodi, care_level
Select patient_ref,episode_ref,care_level_ref
from data_scope.mov_events
group by patient_ref,episode_ref,care_level_ref
having patient_ref in
(select patient_ref
from data_scope.znt_score
group by patient_ref) -- utilitza taula znt_SCORE per filtrar 
),
stay as
( -- join amb care_level_events per tenir care_level_type (uci, sala etc)
SELECT m.patient_ref,m.episode_ref, m.care_level_ref,cl.care_level_type_ref,cl.start_date,cl.end_date
from mov_colap m
join data_scope.care_level_events cl using(care_level_ref)
where date(cl.start_date )>'2020-06-001'
and care_level_type_ref in ('SALA','ICU')
), 
new_znt_stay as
( -- fusio znt amb stay per donar a cada znt un care_level, etc etc. 
SELECT patient_ref,episode_ref,care_level_ref,care_level_type_ref,start_date,end_date,id,MANDT,ID_SCORE, DATA+HORA AS REG_DATETIME,PATNR,USUARI,VPID,VWERT,POP_UP,ENVIO_MEDXAT_MED,ENVIO_MEDXAT_ENF,ENVIO_EMAIL,VALORS,AILLAT 
FROM data_scope.znt_score
JOIN stay using(patient_ref)
WHERE DATA+HORA between start_date and end_date
),-- NETEJA DE TAULA ON COLUMNA VALORS FA LA FRASE MALEIDA, JOC DEL TELEFON.
znt_rank0 
as -- len of valors column
    (
    SELECT *,char_length(valors) as len 
    FROM new_znt_stay),
znt_rank1 as 
-- rank the window function using  ordered len 
	(
	select rank() over (partition by patnr ,reg_datetime order by len desc) as rang, z.*  from znt_rank0 z
    )

select patient_ref,patnr,episode_ref,care_level_ref, care_level_type_ref, start_date, end_date, id, mandt,id_score, reg_datetime ,usuari,vpid,vwert,pop_up,envio_medxat_med,envio_medxat_enf,envio_email,valors, aillat
from znt_rank1 
where rang=1 -- només agafo el que té més caracters (el que ha quedat rankejat primer)
 )





-- LAB_STAGE
-- per correr en servidor pzero (posgresql)
-- codi per generar els lab_events indexat :
-- taules base: lab_events, care_level_events, znt_score, lab_dic



drop table if exists p_zero_stage.lab_stage;
create table p_zero_stage.lab_stage as
(
Select distinct le.patient_ref,le.episode_ref,le.care_level_ref,ou_med_ref,care_level_type_ref,
le.extrac_date,le.lab_ref, ld.descr, result_num, units
from data_scope.lab_events le
join data_scope.care_level_events using(care_level_ref)
join data_scope.lab_dic ld using(lab_ref)
where date(extrac_date ) > '2020-06-01'
and care_level_type_ref in ('SALA','ICU')
and le.patient_ref in (select patient_ref
     from data_scope.znt_score
    group by patient_ref)
)







-- STAY_EVENTS_STAGE
-- per correr en servidor pzero (posgresql)
-- codi per generar taula stay_events_stage   :
-- taules base: mov_events, care_level_events, znt_score, episodi_events

CREATE TABLE p_zero_stage.stay_events_stage as(

with znt_colap as
( -- crea filtre per agafar només pacients que estan a znt_score
select patient_ref
from data_scope.znt_score
group by patient_ref
),
mov_colap as
( -- colapsa mov_events per per tenir granularitat episodi, care_level
Select patient_ref,episode_ref,care_level_ref
from data_scope.mov_events
group by patient_ref,episode_ref,care_level_ref
having patient_ref in
(select patient_ref from znt_colap)
),
stay as
( -- join amb care_level per tenir care_level_type (uci, sala etc)
SELECT m.patient_ref,m.episode_ref, m.care_level_ref,cl.care_level_type_ref,cl.start_date,cl.end_date
from mov_colap m
join data_scope.care_level_events cl using(care_level_ref)
where date(cl.start_date )>'2020-06-001'
), 
new_stay as
( -- afegeix columnes a l'stay amb granularitat care_level: num ordre de stay dins ingres i si va despres a uci o no i el los de icu
select *,
rank() over (partition by patient_ref,episode_ref -- ordre dins ingres
    order by patient_ref, episode_ref,care_level_ref, start_date) 
    as seq_num,
case -- to_icu
    when care_level_type_ref='SALA' and lead(care_level_type_ref='ICU') over (partition by patient_ref,episode_ref 
    order by patient_ref, episode_ref,care_level_ref, start_date) then 1
    else 0
    end as to_icu,
case -- icu_los
        when care_level_type_ref='SALA' and lead(care_level_type_ref='ICU') over (partition by patient_ref,episode_ref 
    order by patient_ref, episode_ref,care_level_ref, start_date)
    then DATE_PART('day', lead(end_date) over (partition by patient_ref,episode_ref 
    order by patient_ref, episode_ref,care_level_ref, start_date) - lead(start_date) over (partition by patient_ref,episode_ref 
    order by patient_ref, episode_ref,care_level_ref, start_date))
    
    -- mysql syntax:
    -- then datediff( lead(end_date) over (partition by patient_ref,episode_ref 
    -- order by patient_ref, episode_ref,care_level_ref, start_date),lead(start_date) over (partition by patient_ref,episode_ref 
    -- order by patient_ref, episode_ref,care_level_ref, start_date))
    end as icu_los
from stay
where care_level_type_ref in ('SALA','ICU')
order by patient_ref, episode_ref,care_level_ref, start_date
),
new_stay_hosp_los as( -- codi per afigir hosp_los
select ns.*,DATE_PART('day',epi.end_date-epi.start_date) as hosp_los
from new_stay ns
join data_scope.episode_events epi using(episode_ref)
)
select * from new_stay_hosp_los
order by patient_ref, episode_ref,care_level_ref, start_date
    
)

-- DIAG_EVENTS_STAGE
-- per correr en servidor pzero (posgresql)
-- codi per generar taula diag_events_stage   :
-- taules base: diag_events, diag_dic

CREATE TABLE p_zero_stage.diag_events_stage as (
SELECT patient_ref, episode_ref,  cie,cie_ref,class, reg_date,descr
FROM data_scope.diag_events
JOIN data_scope.diag_dic using(diag_ref)
where cie = 'CIE-10'
order by patient_ref,reg_date
)
