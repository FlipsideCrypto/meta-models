{{ config(
    materialized = 'table',
    cluster_by = ['blockchain'],
    post_hook = "ALTER TABLE {{ this }} ADD SEARCH OPTIMIZATION on equality(token_address,symbol)"
) }}

SELECT
    *
FROM
    {{ source(
        'crosschain_price',
        'ez_asset_metadata'
    ) }}
