{{ config(
    materialized = 'table',
    post_hook = "ALTER TABLE {{ this }} ADD SEARCH OPTIMIZATION on equality(ENS_DOMAIN,ENS_SUBDOMAINS)"
) }}

SELECT
    *
FROM
    {{ source(
        'crosschain_ens',
        'ez_ens_domains'
    ) }}
