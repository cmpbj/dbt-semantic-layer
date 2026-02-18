with source_data as (
    select *
    from {{ source('raw', 'ratings') }}
),
typed as (
    select
        safe_cast(created_at as timestamp) as created_at,
        cast(tax_id as string) as tax_id,
        cast(rating as string) as rating
    from source_data
)
select *
from typed
