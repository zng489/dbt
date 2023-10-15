-- models/my_snapshot_model.sql

-- Define a model for your snapshot

-- models/orders.sql
{{ config(
  materialized='snapshot',
  unique_key='code',
  target_database='snapshots',
  target_schema='your_snapshot_schema',
  target_table='orders_snapshot'
) }}

select * from {{ ref('dim_staging_model') }}



