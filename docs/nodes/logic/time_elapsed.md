The time_elapsed node
=====================

The time_elapsed node adds a field to the current data-item containing the difference in arrival time of consecutive items.

See the [time_diff node](time_diff.md).
 
The unit for output values is milliseconds.

Example
-------

```dfs  
|time_elapsed()
.as('time_dur')

```   


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
as( `string` ) | name of the field for parsed data|'elapsed'  