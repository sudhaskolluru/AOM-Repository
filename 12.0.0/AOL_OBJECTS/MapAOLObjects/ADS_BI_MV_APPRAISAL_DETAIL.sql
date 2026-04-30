  CREATE OR REPLACE EDITIONABLE VIEW "ADS_BI_MV_APPRAISAL_DETAIL" ("BUSINESS_GROUP_NAME", "DEPARTMENT", "APPRAISEE", "APPRAISER", "MAIN_APPRAISER", "APPRAISAL_DATE", "APPRAISAL_START_DATE", "APPRAISAL_END_DATE", "NEXT_APPRAISAL_DATE", "APPRAISAL_COMMENTS", "RATING_LEVEL_NAME", "STEP_VALUE", "APPRAISAL_TYPE", "APPRAISAL_STATUS", "APPRAISEE_ACCESS", "APPRAISAL_TYPE_CODE", "APPRAISAL_STATUS_CODE", "APPRAISEE_ACCESS_CODE", "CREATION_DATE", "LAST_UPDATE_DATE", "APPRAISAL_ID", "BUSINESS_GROU
P_ID", "APPRAISAL_TEMPLATE_ID", "APPRAISEE_PERSON_ID", "APPRAISER_PERSON_ID", "GROUP_INITIATOR_ID", "OVERALL_PERFORMANCE_LEVEL_ID", "MAIN_APPRAISER_ID", "ASSIGNMENT_ID", "EVENT_ID", "RATING_SCALE_ID", "COMPETENCE_ID", "ORGANIZATION_ID") AS
  SELECT bgrT.name Business_Group_Name,
orgT.name Department,
apse.full_name Appraisee,
appr.full_name Appraiser,
mapr.full_name Main_Appraiser ,
apr.appraisal_date Appraisal_Date,
apr.appraisal_period_start_date Appraisal_Start_Date,
apr.appraisal_period_end_date Appraisal_End_Date,
apr.next_appraisal_date Next_Appraisal_Date,
apr.comments Appraisal_Comments,
rtt.name Rating_Level_Name,
rtl.step_value Step_Value,
HR_BIS.BIS_DECODE_LOOKUP('APPRAISAL_TYPE',apr.type) Appraisal_Type,
HR_BIS.BIS_DECODE_LOOKUP('APPRAISAL_SYSTEM_STATUS',apr.appraisal_system_status) Appraisal_Status,
HR_BIS.BIS_DECODE_LOOKUP('APPRAISEE_ACCESS',apr.appraisee_access) Appraisee_Access,
apr.type Appraisal_Type_Code,
apr.appraisal_system_status Appraisal_Status_Code,
apr.appraisee_access Appraisee_Access_Code,
apr.creation_date creation_date,
apr.last_update_date last_update_date,
apr.appraisal_id Appraisal_Id,
apr.business_group_id Business_Group_Id,
apr.appraisal_template_id Appraisal_Template_Id,
apr.appraisee_person_id Appraisee_Person_Id,
apr.appraiser_person_id Appraiser_Person_Id,
apr.group_initiator_id Group_Initiator_Id,
apr.overall_performance_level_id Overall_Performance_Level_Id,
apr.main_appraiser_id Main_Appraiser_Id,
apr.assignment_id Assignment_Id,
apr.event_id Event_Id,
rtl.rating_scale_id rating_scale_id,
rtl.competence_id competence_id,
orgT.organization_id organization_id
FROM per_appraisals apr ,
hr_all_organization_units_tl bgrT ,
hr_all_organization_units_tl orgT ,
per_people_x apse ,
per_people_x appr ,
per_people_x mapr ,
per_rating_levels rtl ,
per_rating_levels_tl rtt
WHERE
    apr.business_group_id = bgrT.organization_id
AND bgrT.language = USERENV('LANG')
AND apr.assignment_organization_id = orgT.organization_id
AND orgT.language = USERENV('LANG')
AND apr.appraisee_person_id = apse.person_id AND apr.appraiser_person_id = appr.person_id
AND apr.main_appraiser_id = mapr.person_id (+)
AND apr.overall_performance_level_id = rtl.rating_level_id (+)
AND rtl.rating_level_id = rtt.rating_level_id (+)
AND rtt.language (+) = USERENV('LANG')
 ;
