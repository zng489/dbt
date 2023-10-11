{{config (
    materialized = 'incremental',
    tags = ['tag'],
    unique_key = 'code'
)}}

select * from {{ref('dim_staging_model')}}

--where 1 = 1

{% if is_incremental() %}
    --AND code >= (select max(code) from {{this}})
    where code > (select max(code) from {{ this }})
{% endif %}