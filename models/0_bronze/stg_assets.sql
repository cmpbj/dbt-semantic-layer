with
    source_data as (
        select *
        from {{ source('raw', 'assets') }}
    )

    , typed as (
        select
            safe_cast(created_at as timestamp) as created_at
            -- cast(asset_id as string) as asset_id,
, cast(collection_status as string) as collection_status
            , safe_cast(face_value as numeric) as face_value
            , safe_cast(settled_at as timestamp) as settled_at
            , safe_cast(due_date as date) as due_date
            , cast(buyer_tax_id as string) as buyer_tax_id
            , cast(seller_name as string) as seller_name
            , upper(cast(buyer_state as string)) as buyer_state
        from source_data
    )

select *
from typed
