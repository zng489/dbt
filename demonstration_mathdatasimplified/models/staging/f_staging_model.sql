-- 'dim_staging_model' must be created to use it
--{{ config(materialized='table') }}

{{ config(materialized='table') }}
select * from {{ref('dim_staging_model')}}
where federal_state = 'Sanchsen'