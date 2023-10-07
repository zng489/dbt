-- {{ config(materialized='table') }}
-- {{ config(materialized='view') }}
select * from {{source('source_parameter', 'dragon')}}
