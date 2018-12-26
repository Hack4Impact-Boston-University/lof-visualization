SELECT what_type_of_exploitation_311, date_exploitation_started_306
               FROM civicrm_value_human_traffic_40 as human_traffic
               INNER JOIN civicrm_activity_contact as activity_contact
               ON human_traffic.entity_id = activity_contact.activity_id
               INNER JOIN civicrm_contact as contact
               ON activity_contact.contact_id = contact.id;
