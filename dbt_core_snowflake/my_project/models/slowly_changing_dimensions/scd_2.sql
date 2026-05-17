-- models/scd_2.sql
{{
  config(
    materialized='table',
    post_hook="""

    -- 1) FECHAR REGISTROS ANTIGOS (na própria tabela SCD)
    UPDATE {{ this }}
    SET 
        is_current  = FALSE,
        dbt_valid_to = CURRENT_TIMESTAMP()   -- ← registra quando mudou
    WHERE CPF_FORMATADO IN (

        WITH base AS (
            SELECT 
                o.CPF_FORMATADO
            FROM {{ ref('consum_old') }} o
            JOIN {{ ref('consum_upgrade') }} u
                ON o.CPF_FORMATADO = u.CPF_FORMATADO
            WHERE o.DSC_RECLAMACAO != u.DSC_RECLAMACAO  -- houve mudança
        )
        SELECT CPF_FORMATADO FROM base
    )
    AND is_current = TRUE;


    -- 2) INSERIR NOVOS REGISTROS ou REGISTROS QUE MUDARAM
    INSERT INTO {{ this }} (
        DAT_REGISTRO,
        CPF_FORMATADO,
        DSC_RECLAMACAO,
        FLG_RECLAMACAO_CONSUMERISTA,
        dbt_valid_from,
        dbt_valid_to,
        is_current
    )
    WITH base AS (
        SELECT 
            u.DAT_REGISTRO,
            u.CPF_FORMATADO,
            u.DSC_RECLAMACAO,
            u.FLG_RECLAMACAO_CONSUMERISTA,
            CASE 
                WHEN o.CPF_FORMATADO IS NULL            THEN 'NOVO'
                WHEN o.DSC_RECLAMACAO != u.DSC_RECLAMACAO THEN 'MUDOU'
                ELSE 'NÃO MUDOU'
            END AS STATUS
        FROM {{ ref('consum_upgrade') }} u
        LEFT JOIN {{ ref('consum_old') }} o
            ON u.CPF_FORMATADO = o.CPF_FORMATADO
    )
    SELECT 
        DAT_REGISTRO,
        CPF_FORMATADO,
        DSC_RECLAMACAO,
        FLG_RECLAMACAO_CONSUMERISTA,
        CURRENT_TIMESTAMP() AS dbt_valid_from,
        NULL::TIMESTAMP     AS dbt_valid_to,
        TRUE                AS is_current
    FROM base
    WHERE STATUS IN ('NOVO', 'MUDOU');

    """
  )
}}

-- SELECT inicial: carga base vinda do old (primeira vez que a tabela é criada)
SELECT 
    DAT_REGISTRO,
    CPF_FORMATADO,
    DSC_RECLAMACAO,
    FLG_RECLAMACAO_CONSUMERISTA,
    CURRENT_TIMESTAMP() AS dbt_valid_from,
    NULL::TIMESTAMP     AS dbt_valid_to,
    TRUE                AS is_current
FROM {{ ref('consum_old') }}