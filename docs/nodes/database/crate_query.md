The crate_query node
=====================

Query the CRATE database for `time series data`. This node is `experimental`.

The select statement will be executed periodically according to the `every` parameter.
Each time the database is queried, the timestamps will be set according to `period`.

> Queries must start with the keyword `select/SELECT` or `with/WITH` and must contain the keyword `from/FROM` to be valid. 

Example
-------
```dfs
 def host = '10.14.204.8'
 def port = 5433 
 
 %% to escape single quotes (') we use double single quotes ('')
 def query = '
  SELECT
 avg(data_obj[''x''][''cur'']) AS x_cur, avg(data_obj[''y''][''cur'']) AS y_cur,
 avg(data_obj[''z''][''cur'']) AS z_cur, avg(data_obj[''yaw''][''cur'']) AS yaw_cur,
 avg(data_obj[''pitch''][''cur'']) AS pitch_cur
  FROM robotplc_parted;
 '

 def s =
  |crate_query()
  .query(query)
  .group_by_time(3m)
  .every(15s)
  .period(30m)
  .align()

```
 
The above example will execute the query every 15 seconds. It gets data which is in the timerange `now -30 minutes` and `now`.

Parameters
----------

| Parameter                   | Description                                         | Default                                            |
|-----------------------------|-----------------------------------------------------|----------------------------------------------------|
| host( `string` )            | CrateDB host                                        | config: `crate.host`/`FAXE_CRATE_HOST`             |
| port( `integer` )           | CrateDB port                                        | config: `crate.port`/`FAXE_CRATE_PORT`             |
| tls( `boolean` )            | whether to use tls                                  | config: `crate.tls.enable`/`FAXE_CRATE_TLS_ENABLE` |
| user( `string` )            | username                                            | config: `crate.user`/`FAXE_CRATE_USER`             |
| pass( `string` )            | password                                            | config: `crate.pass`/`FAXE_CRATE_PASS`             |
| database( `string` )        | Database name                                       | config: `crate.database`/`FAXE_CRATE_DATABASE`     |
| query( `string` `text` )    | 'SELECT-FROM' query clause                          |                                                    |
| time_field( `string` )      | name of the timefield to use                        | 'ts'                                               |
| every( `duration` )         | time between query execution                        | 5s                                                 |
| period( `duration` )        | time span of data to query                          | 1h                                                 |
| align( is_set )             | whether to align `period` to full `every` durations | false (not set)                                    |
| group_by_time( `duration` ) | group the aggregations into time buckets            | 2m                                                 |
| group_by( `string_list` )   | additional group by                                 | []                                                 |
| limit( `string` )           | LIMIT statement                                     | '30'                                               |
