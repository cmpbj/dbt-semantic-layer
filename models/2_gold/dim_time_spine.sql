with
    date_spine as (
        {{
            dbt.date_spine(
                "day",
                "cast('2020-01-01' as date)",
                "cast('2035-12-31' as date)"
            )
        }}
    )

select
    cast(date_day as date) as date_day
from date_spine
