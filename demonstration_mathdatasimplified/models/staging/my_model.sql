-- models/my_model.sql
{{ config(
  materialized='table'
) }}

{{ customSQL("my_query.sql") }}