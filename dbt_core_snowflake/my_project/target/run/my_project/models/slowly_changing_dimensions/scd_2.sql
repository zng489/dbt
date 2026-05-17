
  
    

create or replace transient table DBT_DB.PUBLIC.scd_2
    
    
    
    as (-- models/scd_2.sql


-- SELECT inicial: carga base vinda do old (primeira vez que a tabela é criada)
SELECT 
    DAT_REGISTRO,
    CPF_FORMATADO,
    DSC_RECLAMACAO,
    FLG_RECLAMACAO_CONSUMERISTA,
    CURRENT_TIMESTAMP() AS dbt_valid_from,
    NULL::TIMESTAMP     AS dbt_valid_to,
    TRUE                AS is_current
FROM DBT_DB.PUBLIC.consum_old
    )
;


  