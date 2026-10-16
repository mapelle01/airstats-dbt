# AirStats: dbt + Snowflake

Analytics engineering project that models global airport data (airports, runways and user comments) with **dbt** on **Snowflake**. Built as the capstone of *The Complete dbt Bootcamp*.

## Architecture

```
RAW (Snowflake) → bronze (ephemeral) → silver (tables) → snapshots (SCD2)
```

- **Sources**: `airports`, `runways` and `airport_comments` in `AIRSTATS.RAW`.
- **Bronze**: renaming and column selection only (`src_*`).
- **Silver**: cleaned tables. `silver_airport_comments` is **incremental** (only new `comment_id` values are loaded).
- **Snapshots**: `scd_silver_airports` and `scd_silver_runways`, using the `check` strategy on all columns, to keep history of changes.
- **Tests**: unique / not null, accepted values, relationships (warn), `dbt-expectations`, singular tests, and `store_failures` enabled.
- **Docs**: column descriptions, a reusable `doc()` block and a project overview.

## Run it

```bash
uv sync && source .venv/bin/activate
cd airstats
cp profiles.yml.example profiles.yml     # then set the SNOWFLAKE_* env vars
dbt deps
dbt build
dbt docs generate && dbt docs serve
```

Required environment variables: `SNOWFLAKE_ACCOUNT`, `SNOWFLAKE_USER`, `SNOWFLAKE_PRIVATE_KEY_PATH`, `SNOWFLAKE_PRIVATE_KEY_PASSPHRASE`.

## Data
[OurAirports](https://ourairports.com/data/) open data.