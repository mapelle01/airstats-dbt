{{ config(materialized='incremental') }}

WITH src_airport_comments AS (
    SELECT * FROM {{ ref('src_airport_comments') }}
)
SELECT
    comment_id,
    airport_ident,
    comment_timestamp,
    COALESCE(member_nickname, '__UNKNOWN__') AS member_nickname,
    comment_subject,
    comment_body,
    current_timestamp() AS loaded_at
FROM src_airport_comments
WHERE comment_body IS NOT NULL
  AND TRIM(comment_body) <> ''
{% if is_incremental() %}
  AND comment_id > (SELECT MAX(comment_id) FROM {{ this }})
{% endif %}