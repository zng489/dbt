Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


dbt run --models <folder> users.*<subfolder>
dbt run --models users.*



-- location,lat,lon,federal_state,code

{% set columns = ["location", "lat", "lon"] %}

select
    {% for each_column in columns %}
    '{{each_column}}' ,
    {% endfor %} from {{ref('postal-code-germany')}}