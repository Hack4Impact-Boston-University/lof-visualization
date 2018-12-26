SELECT  
civicrm_value_human_traffic_40.state_province_309 as state_code, 
civicrm_value_human_traffic_40.date_exploitation_started_306 as sd, 
civicrm_value_human_traffic_40.what_type_of_exploitation_311 as exploitation,
civicrm_contact.birth_date as bd, 
civicrm_contact.gender_id as gender,
civicrm_state_province.name as state
FROM civicrm_value_human_traffic_40 
INNER JOIN civicrm_activity_contact
ON civicrm_value_human_traffic_40.entity_id = civicrm_activity_contact.activity_id 
INNER JOIN civicrm_contact 
ON civicrm_activity_contact.contact_id=civicrm_contact.id
INNER JOIN civicrm_state_province 
ON civicrm_value_human_traffic_40.state_province_309 = civicrm_state_province.id
WHERE state_province_309 IS NOT NULL AND birth_date IS NOT NULL
