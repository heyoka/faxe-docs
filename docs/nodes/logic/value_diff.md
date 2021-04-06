The value_diff node
=====================

Outputs the difference to a previous value for multiple fields.

If no previous value is found for a specific field, a configurable default value is used.

> This node can handle `numeric` values only.

Example
-------
  
```dfs    
|value_diff()
.fields('value')
.as('value_diff')
```     


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------  
fields( `string_list` )| |
as( `string_list` ) | names of the ouptput fields, if not specified all `fields` will be overwritten with diff values|defaults to `fields`
default( `number` )|Value to use a default |current value of field
mode( `string` ) | diff modes: `abs`(absolute difference between previous and current), `c-p` (current minus previous value), `p-c` (previous minus current)| 'abs'