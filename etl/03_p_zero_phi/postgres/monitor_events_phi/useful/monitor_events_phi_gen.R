# this code creates a long version of the znt_score_tp table looping over the unique elements of 

# include unique items that will be present in chartevents in the following vector.
#('ESTADO_CONCIENC_','FC_EKG','FC_OSC','FR_IP','FREC_RESP','O_DIS_','PA_S','PRESN_SIS','PULSIOX','PULSO','TEMP_AXI')
vitals<-c('conc_state','hr_ecg','hr_osc','rr_ip','rr','o2_sup','pa_s','presn','pulsiox','pulse','temp_axi')
for (i in 1:length(vitals)) {
    cat(
      'SELECT
patient_ref,
patient_phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
',i,'AS reg_clin_ref,   
',vitals[i],'AS value
FROM
p_zero_stage.znt_score_tp
WHERE',vitals[i],'IS NOT NULL
UNION ALL
      ')

}
