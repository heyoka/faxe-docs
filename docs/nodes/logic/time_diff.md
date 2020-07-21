The time_diff node
=====================

The time_diff node adds a field to the current data-item containing the difference between the timestamps of the consecutive items.
Note that the difference in time will be calculated from the data-points timestamp fields 
and does not reflect the difference in time points coming into the node.

For the other behaviour see [time_elapsed](time_elapsed.md).
 
The unit for output values is milliseconds.

Example
-------
  
```dfs    
|time_diff()
.as('time_diff')
```     


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
as( `string` ) | name of the field for parsed data|'timediff'  