# this code creates a long version of the r_monitor_parsed table looping over the unique elements of 

# include unique items that will be present in chartevents in the following vector.
vitals<-c('ESTADO_CONCIENC_','FC_EKG','FC_OSC','FR_IP','FREC_RESP','O_DIS_','PA_S','PRESN_SIS','PULSIOX','PULSO','TEMP_AXI')

for (i in 1:length(vitals)) {
  print(
    cat(
      '
SELECT
patnr,
usuari,
vpid,
data,
hora,
',i,'AS item_id,   
',vitals[i],'AS value
FROM
stage_sild.r_monitor_parsed
WHERE',vitals[i],'IS NOT null
UNION ALL'
    )
  )
}