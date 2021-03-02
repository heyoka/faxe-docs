The mem node
=====================

Flow wide value storage. mem values are available to any other node (in lambda expressions) within a flow.

There are 3 types of memories:

* 'single' holds a single value
* 'list' holds a list of values, value order is preserved within the list
* 'set' holds a list of values, where values have no duplicates

The values will be held in a non persistent ets term storage.

Example
-------
```dfs  
|mem()
.type('set')
.field('topic')
.key('topics_seen')

```
 
Holds a set of values from the field named `topic`.
The set of values is available in lambda expression (within the same flow) with the key `topics_seen`.



The above set can be used in lambda expressions with the functions: `ls_mem`, `ls_mem_list`, `ls_mem_set`.
```dfs

|where(
    lambda: member("topic", ls_mem_set('topics_seen')) 
)
```
    
This will filter out all points that have a topic field, which has already been stored in the mem set.
Thus the `where` node will only output points with a unique topic value.

_For a list of lambda_library functions see [lambda_functions](../dfs_script_language)._


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
field( `string` )| field-path  |
key( `string` )| name of the value storage | 
type( `string` )| Type of mem storage, one of 'single', 'list' or 'set' | 'single' 
 