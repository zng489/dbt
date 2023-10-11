--{{ config(materialized='table') }}
{{ config(
    materialized='incremental',
    unique_key='charge_move'
) }}


select 
id,
pokemon,
charge_move,
dps,
tdo,
total
from {{source('source_parameter', 'table_view_one')}}





