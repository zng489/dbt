{{
  config(
    materialized='table',
    pre_hook="
    
    CREATE OR REPLACE TEMPORARY TABLE 
                base_temp 
          AS SELECT * FROM {{ ref('consum_old') }}"
  )
}}

SELECT 
    * REPLACE (
        upper(DSC_RECLAMACAO) AS DSC_RECLAMACAO,
        length(cpf_formatado) AS CPF_FORMATADO),
        CURRENT_TIMESTAMP() AS dbt_valid_from, -- time when the record is inserted into the target table
        NULL::TIMESTAMP AS dbt_valid_to,  -- Se for NULL é por que a tabela é atual, não houve mudança
        TRUE AS is_current -- TRUE é atual e FALSE é histórico
FROM base_temp