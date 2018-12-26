SELECT 
 	`civicrm_value_human_traffic_40`.`date_exploitation_started_306` as sd, 
 	`civicrm_value_human_traffic_40`.`date_exploitation_ended_307` as ed, 
 	`civicrm_contact`.`birth_date` as bd, 
 	`civicrm_contact`.`gender_id` as gender,
    	`civicrm_value_human_traffic_40`.`entity_id`,
    	`civicrm_contact`.`id`
 FROM `civicrm_activity_contact` 
 INNER JOIN `civicrm_value_human_traffic_40` ON 
 	`civicrm_value_human_traffic_40`.`entity_id` = `civicrm_activity_contact`.`activity_id` 
 INNER JOIN `civicrm_contact` ON 
 	`civicrm_contact`.`id` = `civicrm_activity_contact`.`contact_id`
 WHERE `date_exploitation_started_306` IS NOT NULL AND `date_exploitation_ended_307` IS NOT NULL  