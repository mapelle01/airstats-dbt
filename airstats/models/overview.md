{% docs __overview__ %}
# AirStats

Analysis of global airport data from OurAirports, loaded into Snowflake (`RAW`) and modelled with dbt.

## How the silver tables interconnect

`silver_airports` is the central table: one row per airport, identified by `airport_ident`. `silver_runways` has one row per runway and `silver_airport_comments` has one row per user comment; both reference their airport through `airport_ident`, so an airport can have many runways and many comments. Some comments point to identifiers that are missing in `silver_airports`, which is why those relationship tests are configured as warnings.

The airport and runway tables are rebuilt on every run, while the comments table is incremental: each run only adds comments newer than the latest `comment_id` already loaded.
{% enddocs %}