# Notas dbt — Referência Rápida

---

## 1. dbt seed vs dbt model

- **`dbt seed`** → só ingere dados (CSV → tabela física no banco). Não transforma.
- **`dbt model`** → pode ser `TABLE` ou `VIEW`. As transformações vêm sempre depois do seed, nos models.

| Comando | Resultado | Tipo |
|---|---|---|
| `dbt seed` | Sempre TABLE | Ingere |
| `dbt model` | TABLE ou VIEW | Transforma |

---

## 2. Erro: No dbt_project.yml found

O dbt precisa ser rodado de dentro da pasta do projeto, onde o `dbt_project.yml` existe.

```bash
cd my_project
dbt seed --select censo_superior
```

---

## 3. Separador CSV no dbt seed

- O dbt só aceita **vírgula** (`,`) como separador.
- Não há configuração nativa para ponto e vírgula (`;`).
- A correção deve ser feita **no próprio arquivo CSV** antes de rodar o `dbt seed`.

---

## 4. O que o `ref()` aponta

O `ref()` **nunca lê arquivo** — sempre lê tabela ou view já existente no banco.

```
consumerista.csv
     ↓
dbt seed              ← CSV vira tabela no banco
     ↓
tabela: consumerista  ← isso é o que o ref() aponta
     ↓
{{ ref('consumerista') }}  ← referencia a tabela, não o CSV
```

**Exemplo:**

```sql
with base as (
    select *
    from {{ ref('consumerista') }}  -- lê a tabela que o seed criou
)
select
    *,
    upper(DSC_RECLAMACAO)  as dsc_reclamacao_maiuscula,
    length(cpf_formatado)  as tamanho_cpf
from base
```

O dbt traduz para:

```sql
with base as (
    select *
    from shopmax.vendas.consumerista  -- nome real da tabela no banco
)
```

| O que parece | O que realmente é |
|---|---|
| `{{ ref('consumerista') }}` | Tabela no banco criada pelo seed |
| `consumerista.csv` | Arquivo fonte que o seed leu |

---

## 5. `ref()` vs `source()`

| Como usar | Aponta para |
|---|---|
| `{{ ref('consumerista') }}` | Tabela criada pelo dbt (seed ou model) |
| `{{ source('external', 'consumerista') }}` | Tabela criada fora do dbt (manualmente, COPY INTO, etc.) |

**Quando usar cada um:**

```
Tabela criada pelo dbt seed     → {{ ref('consumerista') }}
Tabela criada pelo COPY INTO    → {{ source('external', 'consumerista') }}
Tabela criada manualmente       → {{ source('external', 'consumerista') }}
Tabela criada por outro model   → {{ ref('nome_do_model') }}
```

O arquivo `sources.yml` é um mapa — diz ao dbt onde encontrar tabelas que existem no banco mas que ele não criou.

---

## 6. Como ver o resultado de um model — `dbt show`

O `dbt show` funciona com **qualquer tipo**, não só analyses:

```bash
dbt show --select consumerista           # model SQL
dbt show --select consumerista_python    # model Python
dbt show --select exemplo_analise        # analyses
dbt show --select categorias             # seed
dbt show --select join_consumerista_reclamacoes --limit 10
```

**Alternativa — `dbt compile`:**

```bash
dbt compile --select exemplo_analise
# gera SQL puro em: target/compiled/my_project/analyses/exemplo_analise.sql
```

---

## 7. Models Python no Snowflake

No Snowflake, os models Python usam **Snowpark** (não pandas, não PySpark).

```
dbt Python model
      ↓
Snowpark (biblioteca do Snowflake)
      ↓
Snowflake executa
```

| Banco | Biblioteca |
|---|---|
| Snowflake | Snowpark |
| Databricks | PySpark |
| BigQuery | pandas / bigframes |

**Exemplo com Snowpark:**

```python
def model(dbt, session):
    dbt.config(materialized='table')
    df = dbt.ref('consumerista')
    df = df.withColumn('DSC_RECLAMACAO_LIMPA', df['DSC_RECLAMACAO'].cast('string'))
    return df
```

> Usar pandas funciona, mas é mais lento — carrega tudo na memória local. Snowpark processa dentro do Snowflake.

---

## 8. Snapshots

### Nomenclatura

```
models/     → nome do model     → join_consumerista_reclamacoes_consumidor.sql
snapshots/  → nome + _snapshot  → join_consumerista_reclamacoes_consumidor_snapshot.sql
```

### Estrutura de pastas

```
my_project/
  └── snapshots/
        └── join_consumerista_reclamacoes_consumidor_snapshot.sql
```

### Rodar snapshots

```bash
dbt snapshot
# ou junto com o dbt run
dbt run && dbt snapshot
```

**Ordem recomendada:**

```bash
dbt run       # primeiro: cria/atualiza as tabelas
dbt snapshot  # depois: captura o histórico
dbt test      # por último: valida a qualidade
```

---

## 9. Agendar execução diária no Windows

### Arquivo `rodar_dbt.bat`

```bat
@echo off
cd C:\Users\Yuan\Desktop\dbt_core_snowflake\my_project
call .\wh\Scripts\activate
dbt run
dbt snapshot
dbt test
echo Finalizado em %date% %time% >> logs\dbt.log
```

### Task Scheduler

```
1. Pesquisa no Windows → "Task Scheduler"
2. Create Basic Task
3. Nome: "dbt diário"
4. Trigger: Daily → horário: 06:00
5. Action: Start a program
6. Program: cmd
7. Arguments: /c "C:\Users\Yuan\Desktop\dbt_core_snowflake\my_project\rodar_dbt.bat"
8. Finish
```

### Verificar execuções

```bash
type logs\dbt.log
```

Saída esperada:

```
Finalizado em 27/04/2026 06:00:01
Finalizado em 28/04/2026 06:00:01
```
