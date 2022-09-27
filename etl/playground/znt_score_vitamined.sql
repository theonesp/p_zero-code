-- requires previous tables: znt_score, stay.

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


--CREATE NEW TABLE WITH REF TO PHI
--Join the new znt_score with patnr(phi) with previous  znt_score with patient_id(no phi)

drop table if exists playground.znt_ref_phi;

CREATE TABLE playground.znt_ref_phi as
(select patient_id, p.* from playground.znt_score z right join  playground.znt_score_phi p 
on
p.data=z.data and p.hora=z.hora and p.valors=z.valors

);


--CREATE TABLE playground.znt_ref_phi_filled
-- to solve the problem that there’s nulls in patient_id 

-- OBJECTIVES: create new table with the gaps in patient_id columns filled. 
-- creates a table key to transform patnr to patient_id (creation and selecting 
-- distinct rows with groupby)
-- using the key with the original table znt_score

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

-- INGEST MOVIMENTS DATA

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


-- Colapsar files a dies per poder seleccionar dies anteriors a ingres a uci,intemitjos,paro.
-- Utilitzarem dia d'ingrés per separar els diferents episodis.

DROP TABLE IF EXISTS collapsed_znt;

CREATE TABLE collapsed_znt AS
(
with output1 as -- agrupacio per pacient, sala , dia.
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
output2 as -- funcions finestra on cada finestra equival a un episodi(pacient,ingrés)
(select *,
    case
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,7) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
        when ou_loc_ref like 'G%' and 
            (lead(ou_loc_ref,6) over (partition by patient_ref,ingres order by patient_ref,data) similar to '(E|I|BPARO|PUR0)%')
            THEN 1
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
            THEN 2 -- 
        when ou_loc_ref like 'G%' --resta de pacients que estan en una sala G i no compleixen cases anterior.
            THEN 3
        else 0 --inclou altres sales que no son (G,E,I,BPARO,PUR0)
        END as intensive_care_level
from output1 
)
select * from output2 where  intensive_care_level::VARCHAR ~ '(1|2|3)'); --FILTRAT PER 