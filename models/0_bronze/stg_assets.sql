with
    source_data as (
        select *
        from {{ source('raw', 'assets') }}
    )

    , typed as (
        select
            cast(asset_id as string) as asset_id
            , safe_cast(asset_created_timestamp as timestamp) as asset_created_timestamp
            , cast(collection_status as string) as collection_status
            , cast(asset_status as string) as asset_status
            , safe_cast(face_value_amount_brl_original as numeric) as face_value_amount_brl_original
            , safe_cast(face_value_amount_brl_outstanding as numeric) as face_value_amount_brl_outstanding
            , safe_cast(due_date_latest as date) as due_date_latest
            , safe_cast(settled_timestamp as timestamp) as settled_timestamp
            , cast(buyer_tax_id as string) as buyer_tax_id
            , cast(buyer_root_tax_id as string) as buyer_root_tax_id
            , upper(cast(buyer_state as string)) as buyer_state
            , cast(buyer_city as string) as buyer_city
            , cast(seller_name as string) as seller_name
            , cast(channel_name as string) as channel_name
            , cast(product_channel as string) as product_channel
            , safe_cast(collected_amount_brl as numeric) as collected_amount_brl
            , safe_cast(matured_amount_brl as numeric) as matured_amount_brl
            , safe_cast(as_of_date as date) as as_of_date
        from source_data
    )

select *
from typed
