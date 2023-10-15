{{config (
    materialized = 'incremental'
    
)}}

select * from {{ source('source', 'dim_staging_model') }}
--where 1 = 1
{% if is_incremental() %}
    --AND code >= (select max(code) from {{this}})
    where code > (select min(code) from {{ this }})
{% endif %}

-- tags = ['tag'],
-- unique_key = 'code'


-- Primeiro o script é rodado para gravar um banco, depois roda-se com a incremental no mesmo script, assim o banco irá mudar