### Tutorial Slowly Changing Dimensions (SCD) with DBT

```
- Running
1. dbt seed --select consum_old
2. dbt seed --select consum_upgrade
3. dbt run --select scd_2
- Reminding: The script scd_1 is a just a test script to see the data


- Para cada modelo:
1. Roda o SELECT principal  →  cria a tabela/view
2. Roda o pre_hook (se tiver)  →  antes do SELECT
3. Roda o post_hook (se tiver)  →  depois do SELECT


- Problemas do SCD Type 2
1. Gravando na tabela fonte, não na tabela SCD
O UPDATE e INSERT apontam para {{ ref('consum_upgrade') }}, que é a tabela de origem dos dados. Ela é sobrescrita a cada run, então o histórico some. O correto é usar {{ this }} para gravar na própria tabela SCD.
2. dbt_valid_to não é preenchido ao fechar o registro
O UPDATE só faz SET is_current = FALSE, mas não registra quando a mudança aconteceu. O correto é também fazer SET dbt_valid_to = CURRENT_TIMESTAMP().
3. Ausência de uma tabela SCD separada
Faltou a distinção entre as três peças necessárias: consum_old (origem antiga), consum_upgrade (origem nova) e uma terceira tabela — a tabela SCD — onde o histórico realmente vive.

```