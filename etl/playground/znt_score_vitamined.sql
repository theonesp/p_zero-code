-- requires previous tables: znt_score, stay.


-- creation of znt_score_phi  which is znt_score with nmr(patnr).

DROP TABLE IF EXISTS playground.znt_score_phi;

CREATE TABLE playground.znt_score_phi (
	
	id varchar NULL,
	mandt int4 NULL,
	id_score varchar NULL,
	"data" date NULL,
	hora varchar NULL,
    patnr int4 NULL,
	usuari varchar NULL,
	vpid int4 NULL,
	vwert int4 NULL,
	pop_up varchar NULL,
	envio_medxat_med varchar NULL,
	envio_medxat_enf varchar NULL,
	envio_email varchar NULL,
	valors varchar NULL,
	aillat varchar NULL

);

--COPY TO INGEST

copy playground.znt_score_phi  FROM '/home/admin/xavi_cabin/znt_score_phi.csv' DELIMITER ',' CSV HEADER;


--CREATE NEW  znt TABLE WITH deidentified unique patient code (paient_ref) and  PHI
--Join the new znt_score with patnr(phi) with previous  znt_score with patient_id(no phi)

drop table if exists playground.znt_ref_phi;

CREATE TABLE playground.znt_ref_phi as
(select patient_id, p.* from playground.znt_score z right join  playground.znt_score_phi p 
on
p.data=z.data and p.hora=z.hora and p.valors=z.valors

);


--CREATE TABLE playground.znt_ref_phi_filled
-- to solve the problem that there’s nulls in patient_id 

-- OBJECTIVES: create a new table with the gaps in patient_id columns filled. 
-- creates a table key to transform patnr to patient_id (creation and selecting 
-- distinct rows with groupby)
-- using the key with the original table znt_score.

Drop table if exists playground.znt_ref_phi_filled;
CREATE TABLE playground.znt_ref_phi_filled AS
(
WITH output1 as(
SELECT patient_id,patnr FROM playground.znt_ref_phi where patient_id is not null order by patnr
), key as(
select patient_id,patnr from output1 group by patient_id,patnr)
, output2 as(
select o.patient_id as patient_ref, z.* from playground.znt_ref_phi z join key o  on z.patnr=o.patnr
order by o.patient_id,data, hora)
select patient_ref,id,mandt,id_score, data, hora, patnr, usuari, vpid, vwert,envio_medxat_med,envio_medxat_enf,envio_email,valors,aillat from output2)



DROP TABLE IF EXISTS playground.moviments;

CREATE TABLE playground.moviments (
	patient_id int4 NULL,
	start_date date NULL,
	ou_loc_ref varchar NULL,
    register_date date NULL

);

-- INGEST MOVIMENTS DATA: 

copy playground.moviments FROM  '/home/admin/xavi_cabin/mov_2022-09-24.txt' DELIMITER ';' CSV HEADER;

/*
SCRIPT THAT RESOLVES DATA DUPLICATION AND MERGES ZNT_PHI_REF_FILLED AMB MOVEMENTS
problem: multiple files for each measurement where the values column has incremental characters.
strategy: I keep the row that has a higher length in the values column. I use the technique window functions and I keep the first case after sorting in descending order. 
In the same script I merge left join znt score and movements.
*/


DROP TABLE IF EXISTS playground.znt_phi_loc;

CREATE TABLE playground.znt_phi_loc AS(
with znt_rank0 as --len of valors column
    (SELECT *,char_length(valors) as len FROM playground.znt_ref_phi_filled),
znt_rank1 as -- rank the window function using  ordered len 
    (select row_number () over (partition by patnr ,data,hora order by len desc) as rang,*  from znt_rank0),
znt_rank2 AS -- select the first row (longest valors len)
    (select * from znt_rank1 where rang=1),
znt_rank3 as -- order by 
    (select * from znt_rank2  order by patnr , data, hora, rang),
znt_rank4 as -- fusion znt to moviments to get the location
    (select * from znt_rank3 z 
    left join playground.moviments i
    on z.patient_ref = i.patient_id and z.data=i.register_date order by patient_id,z.data,z.hora)
-- select the relevant columns
select patient_ref,
        id,
        mandt,
        id_score,
        data, 
        hora, 
        patnr,
        ou_loc_ref,
        start_date,
        usuari, 
        vpid, 
        vwert,
        envio_medxat_med,
        envio_medxat_enf,
        envio_email,
        valors,
        aillat from znt_rank4
);


-- Merge stay and znt_phi_loc to obtain the date of hospital admission and thus episode(hosp_adm).

DROP TABLE IF EXISTS playgroud.znt_phi_loc_stay;

CREATE TABLE  playground.znt_phi_loc_stay AS
(select z.*,s.start_date as ingres,s.end_date as alta from playground.znt_phi_loc z left join playground.stay s 
on z.patient_ref = s.patient_ref and z.data=s.data)





-- Collapse rows to days to be able to select the days prior to admission to uci, intermediate , shock room.
-- Use the day of entry to separate the different episodes.

DROP TABLE IF EXISTS collapsed_znt;

CREATE TABLE collapsed_znt AS
(
with output1 as -- aggregate by pacient, ward, day
(SELECT 
    patient_ref,
    max(patnr)as patnr,
    data, 
    count(*),
    max(start_date) as loc_adm_date,
    ou_loc_ref,
    max(ingres) as ingres
FROM playground.znt_phi_loc_stay group by patient_ref,ou_loc_ref,data 
having  count(*) >1 and max(ou_loc_ref) is NOT NULL
order by patient_ref,ou_loc_ref,data
),
output2 as -- windows functions where each window  is related to  an hospital_adm (pacient,ingres)
(select *,
    case
 
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,5) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,4) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,3) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,2) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,1) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
        when (ou_loc_ref similar to '(E|I|BPARO|PUR0)%' ) and 
            LAG(ou_loc_ref) over (partition by patient_ref,ingres order by patient_ref,data) like 'G%' 
            THEN 2 -- 2) intensive care/intermdiate/PUR0
        when ou_loc_ref like 'G%' -- 3)resta de pacients que estan en una sala G i no compleixen cases anterior.
            THEN 3
        else 0 --inclou altres sales que no son (G,E,I,BPARO,PUR0 etc)
        END as intensive_care_level
from output1 
)
select * from output2 where  intensive_care_level::VARCHAR ~ '(1|3)' --1) normal ward no need intensive care 2) intensive care
-- 3) normal ward ending in the intensive care.
); 



-- Stay_frame creation:
-- Collapse to obtain  stay_frame gralunarity.
-- Stay_frame concept: periods of normal ward stays that ends or not with the need of critical care admission 
-- (1: need for intensive admision , 3: no need for intensive admision )

drop table if exists playground.stay_frame;
create table playground.stay_frame as

(with output1 as(
select patient_ref, ingres, loc_adm_date ,ou_loc_ref,min(intensive_care_level) from playground.collapsed_znt 
group by patient_ref, ingres,loc_adm_date, ou_loc_ref order by patient_ref, loc_adm_date,ingres
),
output2 as (
select *,  row_number() over (partition by patient_ref,ingres,loc_adm_date order by patient_ref, loc_adm_date,ingres )
from output1) as stay_frame_seq
select * from output2 
order by patient_ref, ingres, loc_adm_date)



-- hosp_adm creation:
-- Collapse to obtain hosp_adm gralunarity.
drop table if exists playground.hosp_adm;
Create table playground.hosp_adm as
(with output1 as(
select patient_ref, ingres as hosp_adm from playground.collapsed_znt 
group by patient_ref, ingres order by patient_ref, ingres
),
output2 as (
select *,  row_number() over (partition by patient_ref order by patient_ref, hosp_adm ) as hosp_adm_seq
from output1)
select * from output2 
order by patient_ref, hosp_adm )



-- place unique identifiers to hosp_adm and stay_frame
ALTER TABLE playground.stay_frame ADD COLUMN stay_frame_id SERIAL PRIMARY KEY;
ALTER TABLE playground.hosp_adm ADD COLUMN hosp_adm_id SERIAL PRIMARY KEY;




-- CREATION znt_master
-- merge   hosp_adm, stay_id wiht  znt_loc_stay, not repeated columns selection, name change, filter the vitals rows that has 
-- no stay_frame_id

DROP TABLE IF EXISTS playground.znt_master;
CREATE TABLE playground.znt_master as
(
SELECT 
    z.patient_ref,
    z.ingres as hosp_adm_date,
    alta as hosp_discharge_date,
    hosp_adm_seq,
    hosp_adm_id,
    stay_frame_id,
    stay_frame_seq,
    min as evolution,
  --
    id,
    mandt,
    id_score,
    data,
    hora,
    patnr,
    z.ou_loc_ref,
    start_date as loc_adm_date,
    usuari,
    vpid,
    vwert,
    z.envio_medxat_med,
    envio_medxat_enf,
    valors,
    aillat
  

FROM playground.znt_phi_loc_stay z left join playground.hosp_adm adm 
on z.patient_ref=adm.patient_ref and z.ingres=adm.hosp_adm left join playground.stay_frame sf  
on z.patient_ref=sf.patient_ref and z.ingres=sf.ingres and z.start_date=sf.loc_adm_date
where stay_frame_id IS NOT NULL -- filter for all rows that have stay_frame
);





-- creació stay_scope : colapsa znt_loc_master a nivell de stay frames i borrar columnes de dades.

DROP TABLE IF EXISTS playground.stay_scope;
CREATE TABLE playground.stay_scope as
(
SELECT 
    patient_ref,
    hosp_adm_id,
    max(hosp_adm_date) as hosp_adm_date,
    max(hosp_discharge_date) as hosp_discharge_date,
    max(hosp_adm_seq) as hosp_adm_seq ,
    stay_frame_id,
    max(stay_frame_seq) as stay_frame_seq,
    max(evolution) as evolution
FROM playground.znt_master
GROUP BY patient_ref,hosp_adm_id,stay_frame_id
);


-- creació znt_scope: elimina columnes cd znt_master i només deixar dades i claus de conexio amb stay_scope

DROP TABLE IF EXISTS playground.znt_scope;
CREATE TABLE playground.znt_scope as
(
SELECT 
    patient_ref,
    hosp_adm_id,
    stay_frame_id,
  --
    id,
    mandt,
    id_score,
    data,
    hora,
    patnr,
    ou_loc_ref,
    loc_adm_date,
    usuari,
    vpid,
    vwert,
    envio_medxat_med,
    envio_medxat_enf,
    valors,
    aillat
FROM playground.znt_master
);

DROP TABLE IF EXISTS playground.stay_scope_exitus;
CREATE TABLE playground.stay_scope_exitus as
(
SELECT 
FROM playground.stay_scope left join playground.exitus_scope
);

-- Adding exitus data to stay_scope obtaining stay_scope_exitus

DROP TABLE IF EXISTS playground.stay_scope_exitus;
CREATE TABLE playground.stay_scope_exitus as
(
SELECT ss.*,exitus_date
FROM playground.stay_scope ss left join playground.exitus_scope  es on ss.patient_ref=es.patient_id
)