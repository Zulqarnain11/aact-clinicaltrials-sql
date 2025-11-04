SELECT LOWER(intervention_name) AS name_lc,
       COUNT(DISTINCT nct_id) AS studies
FROM public.v_prospective_completed_cancer_trials
GROUP BY name_lc
ORDER BY studies DESC
LIMIT 25;

WITH tokens AS (
  SELECT nct_id,
         LOWER(regexp_replace(tok, '[^a-z0-9+.-]', '', 'g')) AS term
  FROM (
    SELECT nct_id,
           regexp_split_to_table(
             COALESCE(intervention_name,'') || ' ' || COALESCE(intervention_description,''),
             '\s+'
           ) AS tok
    FROM public.v_prospective_completed_cancer_trials
  ) t
),
filtered AS (
  SELECT term
  FROM tokens
  WHERE term <> '' AND length(term) >= 3
    AND term NOT IN ('with','and','the','for','this','that','from','into','dose','mg','per','day','study')
)
SELECT term, COUNT(DISTINCT nct_id) AS studies
FROM filtered
GROUP BY term
ORDER BY studies DESC
LIMIT 50;

WITH biomarker_hits AS (
  SELECT DISTINCT nct_id, intervention_type
  FROM public.v_prospective_completed_cancer_trials
  WHERE (intervention_name ILIKE ANY (ARRAY['%egfr%','%her2%','%alk%','%pd-1%','%pd-l1%','%brca%']))
     OR (intervention_description ILIKE ANY (ARRAY['%egfr%','%her2%','%alk%','%pd-1%','%pd-l1%','%brca%']))
)
SELECT intervention_type, COUNT(*) AS biomarker_linked_trials
FROM biomarker_hits
GROUP BY intervention_type
ORDER BY biomarker_linked_trials DESC;
