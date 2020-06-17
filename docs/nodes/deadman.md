The deadman node
=====================

Emits a point, if there is no point coming in for the given amount of time.
For output there are two options:

* If `repeat_last` param is set, the node will output the last message it saw incoming as the dead-message,
if there is no last message yet, an empty message will be emitted
* With `fields` and `field_values` a list of values can be provided to be included in the output.
* If no fields (and field_values) parameter and is given, an empty datapoint will be emitted.
* The `repeat_last` parameter will always override the `fields` and `field_values` parameter
* The node will forward every message it gets by default, this can be changed by using the `no_forward` flag

Example
-------
```dfs   
 
|deadman(15s)
 
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
*[node]* timeout( `duration` )| timeout value for the node |
fields( `string_list` ) | | undefined
field_values (`string_list`) |  | undefined
repeat_last( is_set) | whether to output the last value seen | false, not set
no_forward( is_set) | whether to output every message that comes in (pass through) | false, not set
 