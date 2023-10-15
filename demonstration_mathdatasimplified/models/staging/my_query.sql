WITH source_data AS (
  SELECT
    *,
    TIMESTAMP({{ source('source', 'postal-code-germany').timestamp_column }}) AS timestamp_column,
    DATE(TIMESTAMP({{ source('source', 'postal-code-germany').timestamp_column }})) AS date_column
  FROM {{ source('source', 'postal-code-germany') }}
)
SELECT *
FROM source_data;



SELECT "location", lat, lon, federal_state, code, CURRENT_TIMESTAMP AS new_column
FROM {{ source('source', 'postal-code-germany') }}