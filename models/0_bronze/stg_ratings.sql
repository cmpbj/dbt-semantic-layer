with
    source_data as (
        select *
        from {{ source('raw', 'ratings') }}
    )

    , typed as (
        select
            cast(buyer_root_tax_id as string) as buyer_root_tax_id
            , cast(buyer_tax_id as string) as buyer_tax_id
            , cast(buyer_name as string) as buyer_name
            , upper(cast(credit_rating_latest as string)) as rating
            , safe_cast(snapshot_date as date) as snapshot_date
        from source_data
    )

select *
from typed
