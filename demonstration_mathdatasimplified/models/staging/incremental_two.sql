
{{config (
    materialized = 'incremental'
    
)}}

select * from {{ source('source', 'incremental_one') }}
--where 1 = 1
{% if is_incremental() %}
    --AND code >= (select max(code) from {{this}})
    where new_column > (select max(new_column) from {{ this }})
{% endif %}

--tags = ['tag'],
--unique_key = 'code'