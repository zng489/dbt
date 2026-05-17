with consumerista as (
    select * from {{ ref('consumerista') }}
),
reclamacoes as (
    select * from {{ source('external', 'RECLAMACOES') }}
)
select
    c.DAT_REGISTRO as dat_registro_consumerista,
    c.DSC_RECLAMACAO,
    c.cpf_formatado,
    c.FLG_RECLAMACAO_CONSUMERISTA,
    r.DAT_REGISTRO as dat_registro_reclamacoes,
    r.DSC_RECLAMACAO as dsc_reclamacao_reclamacoes,
    r.CPF_FORMATADO as cpf_formatado_reclamacoes,
    r.FLG_RECLAMACAO_CONSUMERISTA as flg_reclamacao_consumerista_reclamacoes
from consumerista c
inner join reclamacoes r
    on c.cpf_formatado = r.cpf_formatado





    with consumerista as (
    select * from {{ ref('consumerista') }}
),
reclamacoes as (
    select * from {{ source('external', 'RECLAMACOES') }}
)
select
    c.DAT_REGISTRO as dat_registro_consumerista,
    c.DSC_RECLAMACAO,
    c.cpf_formatado,
    c.FLG_RECLAMACAO_CONSUMERISTA,
    r.DAT_REGISTRO as dat_registro_reclamacoes,
    r.DSC_RECLAMACAO as dsc_reclamacao_reclamacoes,
    r.CPF_FORMATADO as cpf_formatado_reclamacoes,
    r.FLG_RECLAMACAO_CONSUMERISTA as flg_reclamacao_consumerista_reclamacoes
from consumerista c
inner join reclamacoes r
    on c.cpf_formatado = r.cpf_formatado
where {{ clean_string('c.DSC_RECLAMACAO') }} like '%CONSUMIDOR%'