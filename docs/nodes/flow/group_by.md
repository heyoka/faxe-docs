The group_by node
=====================

The `group_by` node is used to group a stream of data by the values of one or more fields.  
Each group is then processed independently and concurrently to the other groups, for the rest of the chain (subgraph).

> Note: The behaviour of using more than 1 `group_by` node within a flow is not defined.

See [group_union](group_union.md) for how to 'un-group' a dataflow.

> Be aware of high group cardinality, as for every group, a number of processes (depends on the size of the grouped sub-flow) 
> will be started in the dataflow engine.
> In other words, if you have a grouping that has high cardinality (many different values), more resources will be consumed.

Examples
-------

```dfs   
  |group_by('fieldname1', 'fieldname2') 
```
Groups data along two dimensions: `fieldname1` and `fieldname2`.

```dfs
def group_field = 'data.code'
 |json_emitter()
 .every(700ms)
 .json(
     <<<{"code" : 224, "message": "this is a test", "mode": 1}>>>,
     <<<{"code" : 334, "message": "this is another test", "mode": 1}>>>,
     <<<{"code" : 114, "message": "this is another test", "mode": 2}>>>,
     <<<{"code" : 443, "message": "this is another test", "mode": 1}>>>,
     <<<{"code" : 224, "message": "this is another test", "mode": 2}>>>,
     <<<{"code" : 111, "message": "this is another test", "mode": 1}>>>,
     <<<{"code" : 551, "message": "this is another test", "mode": 2}>>>
 )
 .as('data')

|group_by(group_field)
|eval(
    lambda: str_replace("data.message", 'test', string("data.code"))
    )
    .as('data.message')
|debug()

```
In the above example data is grouped by the `code` field, so eventually the `group_by` node will start 6 computing sub-graphs to handle all groups.
A computing sub-graph in this example will contain an `eval` node connected to a `debug` node.

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
_[node]_ fields( `string_list` ) | fieldnames to group by   | 
lambda( `lambda` ) | use a function to group the data-items (experimental) | undefined
 