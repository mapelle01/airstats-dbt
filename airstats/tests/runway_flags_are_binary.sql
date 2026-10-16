SELECT *
FROM {{ ref('silver_runways') }}
WHERE runway_lighted NOT IN (0, 1)
   OR runway_closed NOT IN (0, 1)