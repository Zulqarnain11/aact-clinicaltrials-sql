SELECT intervention_type, COUNT(DISTINCT nct_id) AS study_count
FROM public.v_prospective_completed_cancer_trials
GROUP BY intervention_type
ORDER BY study_count DESC;
