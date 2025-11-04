SELECT COUNT(DISTINCT nct_id) AS breast_cancer_studies
FROM public.v_prospective_completed_cancer_trials
WHERE EXISTS (
  SELECT 1
  FROM UNNEST(cancer_conditions) AS cond
  WHERE cond ILIKE '%breast%'
);
