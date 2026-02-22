with
    assets as (
        select *
        from {{ ref('silver_asset_rating_asof') }}
    )

    , scored as (
        select
            ass.asset_id
            , ass.as_of_date
            , ass.asset_created_timestamp
            , ass.buyer_tax_id
            , ass.buyer_root_tax_id
            , ass.buyer_state
            , ass.buyer_city
            , ass.seller_name
            , ass.channel_name
            , ass.product_channel
            , ass.collection_status
            , ass.asset_status
            , ass.economic_status
            , ass.days_overdue
            , ass.due_date_latest
            , ass.face_value_amount_brl_original
            , ass.face_value_at_risk_amount_brl
            , ass.rating_snapshot_date
            , ass.buyer_rating
            , case
                when ass.economic_status = 'Settled' then 0.00
                when ass.economic_status = 'Defaulted' then 1.00
                when ass.buyer_rating = 'A' then 0.01
                when ass.buyer_rating = 'B' then 0.05
                when ass.buyer_rating = 'C' then 0.10
                when ass.buyer_rating = 'D' then 0.20
                when ass.buyer_rating = 'E' then 0.30
                when ass.buyer_rating = 'F' then 0.40
                else 0.40
            end as provision_rate
        from assets as ass
    )

select
    sco.asset_id
    , sco.as_of_date
    , sco.asset_created_timestamp
    , sco.buyer_tax_id
    , sco.buyer_root_tax_id
    , sco.buyer_state
    , sco.buyer_city
    , sco.seller_name
    , sco.channel_name
    , sco.product_channel
    , sco.collection_status
    , sco.asset_status
    , sco.economic_status
    , sco.days_overdue
    , sco.due_date_latest
    , sco.face_value_amount_brl_original
    , sco.face_value_at_risk_amount_brl
    , sco.rating_snapshot_date
    , sco.buyer_rating
    , sco.provision_rate
    , sco.face_value_at_risk_amount_brl * sco.provision_rate as cost_of_risk_amount_brl
from scored as sco
