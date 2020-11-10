The delete node
=====================

Delete fields and/or tags from a data_point or from all data_points in a data_batch.

Optionally a lambda function can be given to perform deletion only on those data_points for which the function returns `true`.


Example
-------

```dfs  
|delete()
.fields('temp', 'data.meta[3]')
```

The above example will delete the field named `temp` and the third array entry of the field `data.meta` .

####Conditional
```dfs  
|delete()
.fields('temp', 'data.meta[3]')
.where(lambda: "data.condition.id" == 2 OR "data.condition.name" == 'warning')
```

The above example will delete the field named `temp` and the third array entry of the field `data.meta` only if the current point
has a field "data.condition.id" with value 2, or it has the field "data.condition.name" with value 'warning'.


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
fields( `string_list` )| list of fieldnames to delete | []
tags( `string_list` )| list of tagnames to delete | []
where( `lambda` )| lambda function for conditional deleting | undefined
