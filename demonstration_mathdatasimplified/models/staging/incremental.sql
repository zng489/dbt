{{config (
    materialized = 'incremental'
    
)}}

select * from {{ source('source', 'postal-code-germany') }}
--where 1 = 1
{% if is_incremental() %}
    --AND code >= (select max(code) from {{this}})
    where lon = (select max(lon) from {{ this }})
{% endif %}

--tags = ['tag'],
--unique_key = 'code'