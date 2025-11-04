CREATE OR REPLACE VIEW public.v_prospective_completed_cancer_trials AS
WITH cancer_studies AS (
  SELECT DISTINCT c.nct_id
  FROM ctgov.conditions c
  WHERE c.name ILIKE ANY (ARRAY[
    '%cancer%', '%carcinoma%', '%sarcoma%', '%melanoma%',
    '%tumor%', '%tumour%', '%neoplasm%', '%leukemia%', '%lymphoma%'
  ])
),
prospective_obs AS (
  SELECT DISTINCT d.nct_id
  FROM ctgov.designs d
  WHERE COALESCE(LOWER(d.time_perspective), '') LIKE '%prospective%'
)
SELECT
  s.nct_id,
  ARRAY_AGG(DISTINCT c.name) AS cancer_conditions,
  i.intervention_type,
  i.name AS intervention_name,
  i.description AS intervention_description
FROM ctgov.studies s
JOIN cancer_studies cs ON cs.nct_id = s.nct_id
LEFT JOIN prospective_obs po ON po.nct_id = s.nct_id
JOIN ctgov.conditions c ON c.nct_id = s.nct_id
JOIN ctgov.interventions i ON i.nct_id = s.nct_id
WHERE s.overall_status = 'Completed'
  AND s.study_type IN ('Interventional','Observational')
  AND (s.study_type = 'Interventional' OR po.nct_id IS NOT NULL)
  AND s.overall_status NOT IN ('Terminated','Withdrawn','Suspended')
GROUP BY s.nct_id, i.intervention_type, i.name, i.description;
