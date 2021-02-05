The combine node
=====================

Combine the values from 2 nodes, used to enrich a stream of data with data from another stream, that has lower frequency.

Port 1 is the trigger port and its the port where data to be enriched comes into the node. 
Port 2 is the one where enrichment data come in.
Every time a value is received on the trigger port, the node will emit a value, combined with whatever current value on port 2.
The node will never emit on port 2 values.

No output is given, as long as there has not arrived a value on port 2 to combine with.

---
#### fields
The `fields` parameter defines the fields to inject into the combination for the stream on port 2.
To rename these fields, parameter `prefix` or `aliases` can be used.
With `prefix_delimiter` a delimiter can be given, defaults to: `'_'`

---
#### merge
When `merge_field` is given, the node will merge the values from the input port 2 with the values from port 1.
Objects and lists and lists of objects will be merged.

If a path exists in both streams, the value in the first stream is superseded by the value in
the second stream (in2). Except for lists, which will be combined.

---
Either fields(optionally with `prefix` or `aliases`) or merge_field must be given. 



If you want to join 2 or more streams consider using the [join node](join.md).


Examples
-------
```dfs  
 def in1 =
  |value_emitter()
  .every(500ms)
  .type(point)
  .fields('val')
 
 def in2 =
  |value_emitter()
  .every(4s)
  .type(point)
  .fields('val2', 'val3') 
 
 in1
  |combine(in2)
  .fields('val2', 'val3')
  .prefix('comb')
  .prefix_delimiter('_')
```

In this example values from the stream called `in1` will be enriched with values from `in2`.
Outputfields will be called: `val`, `comb_val2` and `comb_val3` .
The flow will emit every 500 milliseconds after 4 seconds have past initially.

---
```dfs  
 def in1 =
  |value_emitter()
  .every(500ms)
  .type(point)
  .fields('data.val')
 
 def in2 =
  |value_emitter()
  .every(4s)
  .type(point)
  .fields('data.val2', 'data.val3') 
 
 in1
  |combine(in2)
  .merge_field('data') 

```

This example will merge data from `in2` into `in1`, such that the resulting data-point will have 
the fields: `data.val`, `data.val2`, `data.val3`

---
```dfs  
def v1 =
|json_emitter()
.every(1s)
.json(<<< {"condition": {"id": 0, "name": "OK", "sub_cond":
        [{"value": 33}]}, "condition_reason": "",
        "predicted_maintenance_time": 1584246411783,
        "vac_on_without_contact": [1.2, 2.5, 4.33]} >>>)

def v2 =
|json_emitter()
.every(5s)
.json(<<< {"condition": {"id1": 0, "name1": "OK", "sub_cond":
        [{"number": 44}]}, "condition_reason": "",
        "predicted_maintenance_time": 1584246411785,
        "vac_on_without_contact": [2.2, 2.5, 4.33],
        "vac_on_with_contact": [5.6, 45.98, 7.012]} >>>)

v1
    |combine(v2)
    .merge_field('data') 

```

The output from the above example will be:

    {"data":
        {"condition": {"id1":0,"id":0,"name1":"OK","name":"OK",
        "sub_cond":[{"number":44},{"value":33}]},
        "condition_reason":"",
        "predicted_maintenance_time":1584246411785,
        "vac_on_without_contact":[1.2,2.2,2.5,2.5,4.33,4.33],
        "vac_on_with_contact":[5.6,45.98,7.012]
        }


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
_[node]_ (`port`)| input node for port 2 |
merge_field( `string` )| Base field for the merge operation | []
fields( `string_list` )| List of fields to include| []
tags( `string_list` )| List of tags to include | []
aliases( `string_list` )| List of field aliases to use instead of the original field names| []
prefix( `string` )|Prefix for the injected fields from stream 2| undefined
prefix_delimiter( `string` )|Used to separate prefix and the original field name from stream 2|'_'
nofill ( `isset` ) | if set, dataoutput will happen regardless of a initial input on port 2 | false (not set)

When `merge_field` is given the params fields, prefix and prefix_delimiter have no effect.
Otherwise either `prefix` or `aliases` must be given these are mutually exclusive parameters. 
If both are given, then `prefix` will win.
  