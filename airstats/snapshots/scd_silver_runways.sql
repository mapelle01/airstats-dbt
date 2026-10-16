{% snapshot scd_silver_runways %}

{{
    config(
        target_schema='DEV',
        unique_key='runway_id',
        strategy='check',
        check_cols='all'
    )
}}

SELECT * FROM {{ ref('silver_runways') }}

{% endsnapshot %}