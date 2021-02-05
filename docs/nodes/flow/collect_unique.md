The collect_unique node
=====================

With this node we can collect a unique set of values from data_points based on a given field's value.

For every different value of the `key-field`, the node will cache the last data_point with that value.

This node is useful, if you have multiple data-streams - all share a field called the `key-field` - 
that you want to condense into one data_point, according to that key-field's value;
One can think of it as sort of an "un-group" function.

---------------------------------- 
Note: This node produces a completely new data_point.

---------------------------------- 

Given the name of a `key-field`, this node collects data_points using the value of this field to group and cache every data_point.
Once the `min_vals` count of unique values is reached in internal buffer, it starts emitting every change
within this set of values.

New data_points, which have the same value for the key-field as seen before, will overwrite old values.

Data_points that do not have the key-field present, will be ignored.
On output, the node will condense the collected data_points into one, where all the data_points'
fields are grouped by the value of the key-field.

-----------------------------------------------
Note: The number of uniquely collected values will grow, but never shrink (at the moment).

----------------------------- 
Also note: The produced data_point can become very large, if the value of the `key-field` is ever changing, so that
the node will cache a lot of data and therefore may use a lot of memory, be aware of that !



Examples
-------
```dfs  

|collect_unique('data.key_field')
.min_vals(5)
.keep('data.values.node_id', 'data.values.request_ref')
.as('node_id', 'request_ref')

```

In the above example the node will collect the fields: "data.values.node_id" and "data.values.request_ref" from every data_point that has
a field called "data.key_field". As soon as it has collected 5 different values for "data.key_field" it will emit those collected values
as a new data_point with the two fields called "node_id" and "request_ref".
 

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
_[node]_ field( `string` )| path to the key-field |
min_vals( `integer` )| number of different items collected before first output starts|1
keep( `string_list` )|values to keep from every data_point|
as( `string_list` )|output names for the keep values|[]
max_age ( `duration` ) | max age for every collected entry | undefined
 
 