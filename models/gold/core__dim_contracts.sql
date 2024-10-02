{{ config(
    materialized = 'incremental',
    unique_key = ['blockchain','address'],
    cluster_by = ['blockchain'],
    post_hook = "ALTER TABLE {{ this }} ADD SEARCH OPTIMIZATION on equality(address, symbol)"
) }}

SELECT
    *
FROM
    {{ source(
        'crosschain_core',
        'dim_contracts'
    ) }}

{% if is_incremental() %}
WHERE
    modified_timestamp > (
        SELECT
            MAX(
                modified_timestamp
            )
        FROM
            {{ this }}
    )
{% endif %}
