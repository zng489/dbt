-- {{ config(materialized='table') }}


select * from {{ref('uf_mun')}}
