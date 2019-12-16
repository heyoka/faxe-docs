The join node
=====================

Join data from two or more nodes, given a list of prefixes, for each row.

If the 'field_merge' parameter is given, the node will merge the field given from every in-node, instead of
joining.

When considering the "fill" option, the following rules apply:

* none - (default) skip rows where a point is missing, inner join.
* null - fill missing points with null, full outer join.
* Any numerical value - fill fields with given value, full outer join.

Note, that this node will produce a completely new stream.



Example
-------
    
    def v1 =
    |value_emitter()
    .every(3s)
    .type(point)
    .align()

    def v2 =
    |value_emitter()
    .every(5s)
    .type(point)
    .align()

    v1
        |join(v2)
        .prefix('v1.joined', 'v2.joined')
        .tolerance(3s)
        .missing_timeout(3s)
        .fill(none)

Joins the fields of `v1` and `v2` and produces a stream, that has the fields `v1.joined.val` and `v2.joined.val`


Node Parameters
---------------
Parameter     | Description | Default 
--------------|-------------|--------- 
nodes( `node_list` )| list of node (chains) to merge  | []


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
prefix( `string_list` )| list of prefixes (used in join mode) | []
field_merge( `string` )|when given, the join node will do a field merge operation| undefined
missing_timeout( `duration` )| values that do not arrive within this timeout will be treated as missing | 20s
tolerance( `duration` )|db fieldnames (mapping for faxe fieldname to table field names)|
fill( 'none' 'null' `any` )|fill missing values / join behaviour|'none'


### Merge example

Let's look at an example where the streams coming out of two nodes are not joined with prefixes, but
a merge operation is performed. 

    def v1 =
    |json_emitter()
    .every(3s)
    .json(<<< {"condition": {"id": 0, "name": "OK", "sub_cond":
            [{"value": 33}]}, "condition_reason": "",
            "predicted_maintenance_time": 1584246411783,
            "vac_on_without_contact": [1.2, 2.5, 4.33]} >>>)
    
    def v2 =
    |json_emitter()
    .every(3s)
    .json(<<< {"condition": {"id1": 0, "name1": "OK", "sub_cond":
            [{"number": 44}]}, "condition_reason": "",
            "predicted_maintenance_time": 1584246411783,
            "vac_on_without_contact": [2.2, 2.5, 4.33],
            "vac_on_with_contact": [5.6, 45.98, 7.012]} >>>)
    
    v1
        |join(v2)
        .field_merge('data')
        .tolerance(20ms)
        .missing_timeout(30ms)
        .fill(null)

    |debug()
    
#### v1 node data-field (in json format for readability):
   
```json
{"condition": {"id": 0, "name": "OK", "sub_cond":
            [{"value": 33}]}, "condition_reason": "Reason",
 "predicted_maintenance_time": 1584246411783,
 "vac_on_without_contact": [1.2, 2.5, 4.33]
            }
```  
#### v2 node data-field:
   
```json
{"condition": {"id1": 0, "name1": "OK", "sub_cond":
            [{"number": 44}]}, "condition_reason": "",
 "predicted_maintenance_time": 1584246411785,
 "vac_on_without_contact": [2.2, 2.5, 4.33],
 "vac_on_with_contact": [5.6, 45.98, 7.012]
            }
```  
    
    
The result data-field after merge (json format here):

```json
{"condition":
         {"name1":"OK","name":"OK","id1":0,"id":0,
         "sub_cond":[{"number":44}, {"value":33}]
         },
 "predicted_maintenance_time":1584246411785,
 "vac_on_without_contact":[1.2,2.2,2.5,2.5,4.33,4.33],
 "vac_on_with_contact":[5.6,45.98,7.012],
 "condition_reason":""
         }
```

Objects and lists and lists of objects will be merged.

If a path exists in several streams, the value in the first stream is superseded by the value in
a following stream ("condition_reason" and "predicted_maintenance_time" in this example).
Except for lists, which will be merged ("vac_on_without_contact").

    