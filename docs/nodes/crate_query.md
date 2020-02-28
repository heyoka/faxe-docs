The crate_query node
=====================

Query the CRATE database for `time series data`. This node is `experimental`.

The select statement will be executed periodically according to the `every` parameter.
Each time the database is queried, the timestamps will be set according to `period`.


Example
-------

    def host = '10.14.204.8'
    def port = 5433 
    def query = <<<
        SELECT
          avg(data_obj['x']['cur']) AS x_cur, avg(data_obj['y']['cur']) AS y_cur,
          avg(data_obj['z']['cur']) AS z_cur, avg(data_obj['yaw']['cur']) AS yaw_cur,
          avg(data_obj['pitch']['cur']) AS pitch_cur
        FROM robotplc_parted;
    >>>

    def s =
        |crate_query()
        .host(host)
        .port(port)
        .user('crate')
        .database('doc')
        .query(query)
        .group_by_time(3m)
        .every(15s)
        .period(30m)
        .align()

 
The above example will execute the query every 15 seconds. It get data which is in the timerange `now -30 minutes` and `now`.

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
host( `string` )| CrateDB host | from config file
port( `integer` )| CrateDB port | from config file
user( `string` )| username| from config file
pass( `string` )|password| from config file
database( `string` )|Database name| from config file
query( `string` `text` )|'SELECT-FROM' query clause
time_field( `string` )|name of the timefield to use |'ts'
every( `duration` )|time between query execution|5s
period( `duration` )|time span of data to query|1h
align( is_set )|whether to align `period` to full `every` durations| false (not set)
group_by_time( `duration` )|group the aggregations into time buckets|2m
group_by( `string_list` )|additional group by|[]
limit( `string` )|LIMIT statement| '30'
