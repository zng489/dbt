
  
    

create or replace transient table DBT_DB.PUBLIC.creating_table
    
    
    
    as (

SELECT * FROM (VALUES 
    (1, 'WAGNER', 'vendi_meu_carro@comprar_um_melhor') as C (customer_id, name, email))
    )
;


  