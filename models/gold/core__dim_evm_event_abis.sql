{{ config(
    materialized = 'incremental',
    unique_key = ['parent_contract_address','event_signature','start_block','blockchain'],
    cluster_by = ['blockchain'],
    post_hook = "ALTER TABLE {{ this }} ADD SEARCH OPTIMIZATION on equality(parent_contract_address)"
) }}

SELECT
    *
FROM
    {{ source(
        'crosschain_core',
        'dim_evm_event_abis'
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
