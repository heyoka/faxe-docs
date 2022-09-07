The deadman node
=====================

Emits a point, if there is no item coming in for the given amount of time.
For output there are two options:

* If `repeat_last` param is set, the node will output the last message it saw incoming as the dead-message,
if there is no last message yet, an empty message will be emitted
* With `fields` and `field_values` a list of values can be provided to be included in the output.


* If no fields (and field_values) parameter and is given, an empty datapoint will be emitted.
* The `repeat_last` parameter will always override the `fields` and `field_values` parameter
* The node will forward every message it gets by default, this can be changed by using the `no_forward` flag

Examples
-------
```dfs   
 
|deadman(15s)
 
```
Outputs an empty data-point item, if the node does not see any items coming in withing 15 seconds, while simply forwarding any item it gets. 
The first timeout starts, when the node is starting.


```dfs   
 
def interval = 15s 

|deadman(interval)
.trigger_on_value()
.repeat_last()
.repeat_interval(interval)
 
```
Outputs every item as a passthrough and, if no item is seen with 15 seconds, 
outputs the last item with a new timestamp, that is derived from the last iteration and increased by interval (15s). 


Parameters
----------

| Parameter                      | Description                                                                                                                                                                                                                                                                         | Default        |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|
| *[node]* timeout( `duration` ) | timeout value for the node                                                                                                                                                                                                                                                          |                |
| fields( `string_list` )        |                                                                                                                                                                                                                                                                                     | undefined      |
| field_values (`string_list`)   |                                                                                                                                                                                                                                                                                     | undefined      |
| repeat_last( is_set)           | whether to output the last value seen                                                                                                                                                                                                                                               | false, not set |
| no_forward( is_set)            | whether to output every message that comes in (pass through)                                                                                                                                                                                                                        | false, not set |
| repeat_with_new_ts ( `bool` )  | when repeating an item, set the current timestamp to that item before emitting                                                                                                                                                                                                      | true           |
| repeat_interval ( `duration` ) | when repeating an item, adds this amount of time to a buffered timestamp (from the last item seen, or from the last addition of this interval) to genereate a new timestamp for the repeated item, this setting is independent of `repeat_with_new_ts` and takes precedence over it | undefined      |
 