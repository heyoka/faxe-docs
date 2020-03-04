The keep node
=====================

Keep only those fields and tags specified by the parameters.

Example
-------
```dfs  
|keep('data.topic', 'data.temperature')
.as('topic', 'temperature')
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
[node] fields( `string_list` )| list of fieldnames to keep from the incoming data |
tags( `string_list` )| list of tagnames to keep from the incoming data | []
as( `string_list`)|list of new field names for the kept fields, if given, must have the same count of names as `fields`|[]
