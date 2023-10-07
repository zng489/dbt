-- {{ config(materialized='table') }}

select id from {{source('testing', 'pokemon')}}
