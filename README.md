1- 
pip install dbt-postgres

2-
dbt init <name_of_project>
C:\Users\PC\.dbt\profiles.yml

3-
Using profiles.yml file at C:\Users\PC\.dbt\profiles.yml

Take care 
Using dbt_project.yml file at C:\Users\PC\Desktop\dbt\dbt\dbt\dbt_files\test_dbt\dbt_project.yml

dbt debug

* rais
(myenv) C:\Users\PC\Desktop\dbt\dbt_rais\rais>dbt debug



4- 
dbt test is just a really test!!
dbt test --models <folder> users.*<subfolder>
dbt test --models users.*


dbt run --select fiel
For csv file

dbt seed -s uf_mun

5-
dbt run --models <folder> users.*<subfolder>
dbt run --models users.*

dbt docs generate
dbt docs serve

6-
models:
  test_dbt:
    # Config indicated by + and applies to all files under models/example/
    #example:
    users:
      +materialized: view

7-
model-paths: ["models"]
#data-paths: ["data"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

* seed-paths: ["seeds"];
seed-paths is linking with "seeds" folder;
for example seed-paths: ["data"], seed-path with "data" folder;

dbt run --full-refresh --select incremental
8-
test_dbt:
  outputs:

    dev:
      type: postgres
      threads: 1 #[1 or more]
      host: localhost #[host]
      port: 5433 #[port]
      user: postgres #[dev_username]
      pass: '123' #[dev_password]
      dbname: postgres #[dbname]
      schema: postgres #[dev_schema]

    prod:
      type: postgres
      threads: 1 #[1 or more]
      host: localhost #[host]
      port: 5433 #[port]
      user: postgres #[dev_username]
      pass: '123' #[dev_password]
      dbname: postgres #[dbname]
      schema: postgres #[dev_schema]

  target: dev

sql_jinja:
  outputs:

    dev:
      type: postgres
      threads: 1 #[1 or more]
      host: localhost #[host]
      port: 5433 #[port]
      user: postgres #[dev_username]
      pass: '123' #[dev_password]
      dbname: postgres #[dbname]
      schema: postgres #[dev_schema]

    prod:
      type: postgres
      threads: 1 #[1 or more]
      host: localhost #[host]
      port: 5433 #[port]
      user: postgres #[dev_username]
      pass: '123' #[dev_password]
      dbname: postgres #[dbname]
      schema: postgres #[dev_schema]

  target: dev
9-
seeds
properties.yml
version: 2

seeds:
  - name: uf_mun
    columns:
      - name: country_code
        tests:
        - not_null


0.19

C:\Users\PC\Desktop\tmp\dbt\demonstration_mathdatasimplified\packages.yml
dbt deps

https://www.youtube.com/watch?v=VRTx97llL-A&ab_channel=SleekData
links
tops
https://www.linkedin.com/pulse/come%C3%A7ando-com-o-dbt-data-build-tool-asafe-felipe/?originalSubdomain=pt
https://www.youtube.com/watch?v=toSAAgLUHuk&ab_channel=JieJenn
https://www.buckenhofer.com/2022/11/data-engineering-with-dbt-first-steps-using-postgresql-and-oracle/
https://www.linkedin.com/pulse/dbt-data-build-tools-uma-abordagem-intuitiva-para-de-dados-miguel/?originalSubdomain=pt
https://medium.com/israeli-tech-radar/first-steps-with-dbt-over-postgres-db-f6b350bf4526
https://www.youtube.com/watch?v=gtZ8h8Aynmw&ab_channel=StartDataEngineering
https://www.startdataengineering.com/post/dbt-data-build-tool-tutorial/#333-staging
https://www.youtube.com/watch?v=kUkDJEr93H8&ab_channel=KamalrajMM
https://docs.getdbt.com/quickstarts/manual-install?step=6
https://github.com/insightbuilder/dbt_handson_tutorial
https://www.youtube.com/watch?v=t3G8dKCd8LI&ab_channel=JieJenn
https://docs.getdbt.com/docs/build/sources?source=post_page-----f6b350bf4526--------------------------------
https://docs.getdbt.com/docs/build/sources?source=post_page-----f6b350bf4526--------------------------------
https://medium.com/apolitical-engineering/how-we-use-dbt-and-bigquery-external-connections-to-easily-and-reliably-warehouse-cloud-sql-data-b0f68e873aad

csv file
https://www.youtube.com/watch?v=t3G8dKCd8LI&ab_channel=JieJenn

airflow dbt
https://www.linkedin.com/pulse/come%C3%A7ando-com-o-dbt-data-build-tool-asafe-felipe/?originalSubdomain=pt

jinja
https://medium.com/@promediaz.adrian/using-dbts-jinja-and-seeds-to-reduce-code-duplication-637881cf1a86
https://medium.com/google-cloud/loading-and-transforming-data-into-bigquery-using-dbt-65307ad401cd
https://towardsdatascience.com/jinja-dbt-sql-templating-in-jupyterlab-vscode-1179e818fe17

unknows
https://www.youtube.com/watch?v=gtZ8h8Aynmw&ab_channel=StartDataEngineerings

ALTER TABLE postgres.rais_ RENAME TO rais;
