--{{ config(materialized='table') }}
{{ config(materialized='table') }}


--select * from {{source('source', 'postal-code-germany')}}
--where location = 'Dresden'

SELECT "location", lat, lon, federal_state, code, CURRENT_TIMESTAMP AS new_column
FROM {{ source('source', 'postal-code-germany') }}
where location = 'Dresden'