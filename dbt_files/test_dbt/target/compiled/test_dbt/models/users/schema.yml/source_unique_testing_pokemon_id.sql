
    
    

select
    id as unique_field,
    count(*) as n_records

from "postgres"."public"."pokemon"
where id is not null
group by id
having count(*) > 1


