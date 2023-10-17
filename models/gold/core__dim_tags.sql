{{ config(
    materialized = 'table',
    cluster_by = ['blockchain'],
    post_hook = "ALTER TABLE {{ this }} ADD SEARCH OPTIMIZATION on equality(address)"
) }}

SELECT
    *
FROM
    {{ source(
        'crosschain_core',
        'dim_tags'
    ) }}
