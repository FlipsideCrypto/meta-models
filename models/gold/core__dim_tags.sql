{{ config(
    materialized = 'incremental',
    unique_key = ['blockchain','address','tag_type','start_date', 'tag_name'],
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
