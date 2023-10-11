--{{ config(materialized='table') }}
{{ config(materialized='table') }}
select * from {{source('source', 'postal-code-germany')}}
where location = 'Dresden'
