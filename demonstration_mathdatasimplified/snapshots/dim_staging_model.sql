--{{ config(materialized='table') }}
{{ config(materialized='table') }}
SELECT "location", lat, lon, federal_state, code, CURRENT_TIMESTAMP AS new_column
FROM {{ source('source', 'postal-code-germany') }}



