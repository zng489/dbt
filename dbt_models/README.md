# pip install dbt-postgres

# dbt init

# C:\Users\PC\.dbt\profiles.yml

# dbt debug

# dbt run

# dbt test --models users.*


models:
  test_dbt:
    # Config indicated by + and applies to all files under models/example/
    #example:
    users:
      +materialized: view
# https://www.youtube.com/watch?v=gtZ8h8Aynmw&ab_channel=StartDataEngineerings


# dbt run -models users.*