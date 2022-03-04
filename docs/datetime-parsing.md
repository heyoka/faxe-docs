# Timestamps and Datetime strings in Faxe

In Faxe we deal a lot with timestamps and datetime strings, in fact, every message that flows through all the nodes, 
has a timestamp with it.

Its inner representation of points in time is always an integer denoting the milliseconds that past since 1.1.1970.
There is currently no timezone handling in Faxe.

## Datetime string parsing

Faxe uses its own library to parse datetime strings (from the outside) into it's internal timestamp format.
This is done in different nodes such as the [mqtt_subscribe](nodes/messaging/mqtt_subscribe.md) and the 
[amqp_consume](nodes/messaging/amqp_consume.md) node. Furthermore, datetime parsing can
be done in lambda-expression with the [dt_parse](dfs_script_language/lambda_expressions.md) function.

When parsing datetime strings with subsecond values smaller than milliseconds (microseconds and nanoseconds), if present, 
will be rounded to millisecond values.


### Parsing examples

| datetime | matching format string |
|----------|------------------------|
 |'Mon, 15 Jun 2009 20:45:30 GMT'|'a, d b Y H:M:S Z'|
 |'19.08.01  17:33:44,867000 ' | 'd.m.y  H:M:S,u ' |
 |'8/28/2033 8:03:45.576000 PM'|'n/d/Y l:M:S.u p'|


### Conversion Specification

The format used to parse and format dates closely resembles the one used
in `strftime()`[1]. The most notable exception is that meaningful characters
are not prefixed with a percentage sign (%) in *datestring*.

Characters not matching a conversion specification will be copied to the
output verbatim when formatting and matched against input when parsing.
Meaningful characters can be escaped with a backslash (\\).

<table>
    <thead>
        <tr>
            <th>Character Sequence</th>
            <th>Parsing</th>
            <th>Formatting</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>a</td>
            <td>Yes*</td>
            <td>Yes</td>
            <td>Abbreviated weekday name ("Mon", "Tue")</td>
        </tr>
        <tr>
            <td>A</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Weekday name ("Monday", "Tuesday")</td>
        </tr>
        <tr>
            <td>b</td>
            <td>Yes*</td>
            <td>Yes</td>
            <td>Abbreviated month name ("Jan", "Feb")</td>
        </tr>
        <tr>
            <td>B</td>
            <td>Yes*</td>
            <td>Yes</td>
            <td>Month name ("January", "February")</td>
        </tr>
        <tr>
            <td>d</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Day of month with leading zero ("01", "31")</td>
        </tr>
        <tr>
            <td>e</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Day of month without leading zero ("1", "31")</td>
        </tr>
        <tr>
            <td>F</td>
            <td>No</td>
            <td>Yes</td>
            <td>ISO 8601 date format (shortcut for "Y-m-d")</td>
        </tr>
        <tr>
            <td>H</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Hour (24 hours) with leading zero ("01", "23")</td>
        </tr>
        <tr>
            <td>I</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Hour (12 hours) with leading zero ("01", "11")</td>
        </tr>
        <tr>
            <td>k</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Hour (24 hours) without leading zero ("1", "23")</td>
        </tr>
        <tr>
            <td>l</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Hour (12 hours) without leading zero ("1", "11")</td>
        </tr>
        <tr>
            <td>m</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Month with leading zero ("1", "12")</td>
        </tr>
        <tr>
            <td>M</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Minute with leading zero ("00", "59")</td>
        </tr>
        <tr>
            <td>n</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Month without leading zero ("1", "12")</td>
        </tr>
        <tr>
            <td>o</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Ordinal number suffix abbreviation (st, nd, rd, th)</td>
        </tr>
        <tr>
            <td>p</td>
            <td>Yes*</td>
            <td>Yes</td>
            <td>AM/PM</td>
        </tr>
        <tr>
            <td>P</td>
            <td>Yes*</td>
            <td>Yes</td>
            <td>a.m./p.m.</td>
        </tr>
        <tr>
            <td>R</td>
            <td>No</td>
            <td>Yes</td>
            <td>The time as H:M (24 hour format) ("23:59")</td>
        </tr>
        <tr>
            <td>S</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Seconds with leading zero ("00", "59")</td>
        </tr>
        <tr>
            <td>T</td>
            <td>No</td>
            <td>Yes</td>
            <td>The time as H:M:S (24 hour format) ("23:49:49")</td>
        </tr>
        <tr>
            <td>c</td>
            <td>Yes</td>
            <td>No</td>
            <td>Milliseconds, 3 digits with leading zero ("034")</td>
        </tr>
        <tr>
            <td>u</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Microseconds, 6 digits with leading zero ("000034")</td>
        </tr>
        <tr>
            <td>f</td>
            <td>Yes</td>
            <td>No</td>
            <td>Nanoseconds, 9 digits with leading zero ("000034000")</td>
        </tr>
        <tr>
            <td>y</td>
            <td>Yes**</td>
            <td>Yes</td>
            <td>Year without century ("02", "12")</td>
        </tr>
        <tr>
            <td>Y</td>
            <td>Yes</td>
            <td>Yes</td>
            <td>Year including century ("2002", "2012")</td>
        </tr>
        <tr>
            <td>z</td>
            <td>Yes</td>
            <td>No</td>
            <td>UTC offset (+0100, +01:00, +01, -0100, -01:00, -01)</td>
        </tr>
        <tr>
            <td>Z</td>
            <td>Yes</td>
            <td>No</td>
            <td>Abbreviated timezone (UTC, GMT, CET etc)</td>
        </tr>
    </tbody>
</table>

\* Case-insensitive when parsing

\*\* Falls back on current century of system when parsing years without
century.

## Special formats

| dt_format           | description                                    | example                    |
|---------------------|------------------------------------------------|----------------------------|
| 'millisecond'       | timestamp UTC in milliseconds                  | 1565343079000              |
| 'microsecond'       | timestamp UTC in microseconds                  | 1565343079000123           |
| 'nanosecond'        | timestamp UTC in nanoseconds                   | 1565343079000123456        |
| 'second'            | timestamp UTC in seconds                       | 1565343079                 |
| 'float_micro'       | timestamp UTC float with microsecond precision | 1565343079.173588          |
| 'float_millisecond' | timestamp UTC float with millisecond precision | 1565343079.173             |
| 'ISO8601'           | ISO8601 Datetime format string                 | '2011-10-05T14:48:00.000Z' |
| 'RFC3339'           | RFC3339 Datetime format string                 | '2018-02-01 15:18:02.088Z' |
