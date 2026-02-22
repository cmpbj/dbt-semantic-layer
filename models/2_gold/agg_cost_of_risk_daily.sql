with
    costs as (
        select *
        from {{ ref('fct_cost_of_risk') }}
    )

select
    cor.as_of_date
    , cor.buyer_state
    , cor.economic_status
    , cor.buyer_rating
    , count(distinct cor.asset_id) as assets_count
    , sum(cor.face_value_at_risk_amount_brl) as outstanding_face_value_amount_brl
    , sum(cor.cost_of_risk_amount_brl) as cost_of_risk_amount_brl
    , safe_divide(
        sum(cor.cost_of_risk_amount_brl)
        , nullif(sum(cor.face_value_at_risk_amount_brl), 0)
    ) as implied_cost_of_risk_rate
from costs as cor
group by
    cor.as_of_date
    , cor.buyer_state
    , cor.economic_status
    , cor.buyer_rating
