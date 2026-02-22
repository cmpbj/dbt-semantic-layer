with
    assets as (
        select *
        from {{ ref('stg_assets') }}
    )

    , normalized as (
        select
            ass.asset_id
            , ass.as_of_date
            , ass.asset_created_timestamp
            , ass.collection_status
            , ass.asset_status
            , ass.face_value_amount_brl_original
            , coalesce(
                ass.face_value_amount_brl_outstanding
                , ass.face_value_amount_brl_original
                , 0
            ) as face_value_at_risk_amount_brl
            , ass.due_date_latest
            , ass.settled_timestamp
            , ass.buyer_tax_id
            , ass.buyer_root_tax_id
            , ass.buyer_state
            , ass.buyer_city
            , ass.seller_name
            , ass.channel_name
            , ass.product_channel
            , ass.collected_amount_brl
            , ass.matured_amount_brl
            , greatest(date_diff(ass.as_of_date, ass.due_date_latest, day), 0) as days_overdue
            , case
                when ass.settled_timestamp is not null then 'Settled'
                when ass.collection_status in ('Settled', 'Repaid') then 'Settled'
                when ass.due_date_latest < date_sub(ass.as_of_date, interval 30 day) then 'Defaulted'
                else 'Active'
            end as economic_status
        from assets as ass
    )

select *
from normalized
