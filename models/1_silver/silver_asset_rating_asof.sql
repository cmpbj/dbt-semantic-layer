with
    assets as (
        select *
        from {{ ref('silver_asset_portfolio_snapshot') }}
    )

    , ratings as (
        select *
        from {{ ref('stg_ratings') }}
    )

    , matched as (
        select
            ass.asset_id
            , ass.as_of_date
            , ass.asset_created_timestamp
            , ass.collection_status
            , ass.asset_status
            , ass.face_value_amount_brl_original
            , ass.face_value_at_risk_amount_brl
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
            , ass.days_overdue
            , ass.economic_status
            , rat.snapshot_date as rating_snapshot_date
            , rat.rating as rating_asof
            , row_number() over (
                partition by ass.asset_id, ass.as_of_date
                order by rat.snapshot_date desc nulls last
            ) as rating_recency_rank
        from assets as ass
        left join ratings as rat
            on ass.buyer_tax_id = rat.buyer_tax_id
            and ass.as_of_date >= rat.snapshot_date
    )

select
    mat.asset_id
    , mat.as_of_date
    , mat.asset_created_timestamp
    , mat.collection_status
    , mat.asset_status
    , mat.face_value_amount_brl_original
    , mat.face_value_at_risk_amount_brl
    , mat.due_date_latest
    , mat.settled_timestamp
    , mat.buyer_tax_id
    , mat.buyer_root_tax_id
    , mat.buyer_state
    , mat.buyer_city
    , mat.seller_name
    , mat.channel_name
    , mat.product_channel
    , mat.collected_amount_brl
    , mat.matured_amount_brl
    , mat.days_overdue
    , mat.economic_status
    , mat.rating_snapshot_date
    , coalesce(mat.rating_asof, 'F') as buyer_rating
from matched as mat
where mat.rating_recency_rank = 1
