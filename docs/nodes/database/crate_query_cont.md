The crate_query_cont node
=====================

since 0.19.0

Query the [CRATE](https://crate.io) database for `time series data`. 

This node is used for continous timeseries queries.

### Query 

A select statement will be executed periodically, on every iteration a `timefilter` gets adjusted according to the `period` parameter.
For this to work, the query given must contain the `$__timefilter` placeholder in the query's where clause:

> Queries must start with the keyword `select/SELECT` or `with/WITH` and must contain the keyword `from/FROM` to be valid.

```dfs 
 def query = 
 '
    SELECT ts, id, temp1 FROM doc.table 
    WHERE $__timefilter 
    AND stream_id = 'dd419f94834a'
    ORDER BY ts ASC
 '
```
The timefilter placeholder gets replaced by this statement:
```sql
ts >= $1 AND ts < $2

```

### Start

The `start` parameter determines the query start time. It's value is a past point in time.

There are two possible ways to provide this:

* provide an [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) Datetimestamp, ie: '2021-11-16T17:15:00.000Z'
* provide a query that results in 1 row with exactly 1 column named 'ts' containing an ISO8601 Datetimestamp.

```sql
SELECT DATE_FORMAT(ts) FROM table WHERE worked_on = false ORDER BY ts LIMIT 1

```

or with a fallback start-time

```sql
SELECT COALESCE(
    (SELECT DATE_FORMAT(ts) FROM table WHERE worked_on = false ORDER BY ts LIMIT 1),
    '2021-11-16T16:20:00.000000Z'
    )
AS ts

```

### Historic and up-to-date data

While reading data from the past, `min_interval` will be used to schedule the operation.

Once the `timefilter` reaches present wall-clock time, the `offset` parameter will determine an amount of time to add to
the scheduled time, that is now `period`. This is to account for late incoming data to the database.



Example
-------
```dfs

def period = 1m
def sql = 
'SELECT ts, id, temp1 FROM doc.table 
 WHERE $__timefilter AND stream_id = 'dd419f94834a'
 ORDER BY ts ASC
'

|crate_query_cont()
.query(sql)
.period(period)  
.start('2021-11-16T16:03:42.040000Z')
 
```
 
The above example will execute the query periodically, emitting data_batch items with data_points worth of 1 minute. 

`start` will be aligned to `period`, so that the `timefilter` will look like this for the first query:
```sql
ts >= '2021-11-16T16:03:00.000Z' AND ts < '2021-11-16T16:04:00.000Z'

```



Parameters
----------

| Parameter                     | Description                                                                                                                                         | Default                                            |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| host( `string` )              | CrateDB host                                                                                                                                        | config: `crate.host`/`FAXE_CRATE_HOST`             |
| port( `integer` )             | CrateDB port                                                                                                                                        | config: `crate.port`/`FAXE_CRATE_PORT`             |
| tls( `boolean` )              | whether to use tls                                                                                                                                  | config: `crate.tls.enable`/`FAXE_CRATE_TLS_ENABLE` |
| user( `string` )              | username                                                                                                                                            | config: `crate.user`/`FAXE_CRATE_USER`             |
| pass( `string` )              | password                                                                                                                                            | config: `crate.pass`/`FAXE_CRATE_PASS`             |
| database( `string` )          | Database name                                                                                                                                       | config: `crate.database`/`FAXE_CRATE_DATABASE`     |
| query( `string` )             | 'SELECT' query with `$__timefilter` placeholder                                                                                                     |                                                    |
| start( `string` )             | `timefilter` start point .ISO8601 datetime string or query that retrieves an ISO8601 datetime string from the database                              |                                                    |
| stop( `string` )              | `timefilter` stop point .ISO8601 datetime string or query that retrieves an ISO8601 datetime string from the database                               | undefined                                          |
| stop_flow( `boolean` )        | Whether to stop the whole flow, this node runs in, when stop time is reached. If this is false, then the node will just stop querying the database. | true                                               |
| filter_time_field( `string` ) | name of timestamp db column, used for `timefiler`                                                                                                   | 'ts'                                               |
| result_time_field( `string` ) | name of result column, used for retrieving timestamps                                                                                               | defaults to filter_time_field                      |
| period( `duration` )          | timefilter timespan, query boundaries will be aligned to this value                                                                                 | 1h                                                 |
| offset( `duration` )          | offset at which the database is queried when the timefilter reached 'now' time                                                                      | 20s                                                |
| min_interval( `duration` )    | minimum query-interval when the timefilter is in the past                                                                                           | 5s                                                 |
