The mem node
=====================

Flow wide value storage. mem values are available to any other node (in lambda expressions) within a flow.

There are 3 types of memories:

* 'single' holds a single value
* 'list' holds a list of values, value order is preserved within the list
* 'set' holds a list of values, where values have no duplicates

Here `value` can be any valid datatype that is supported in faxe, from a single scalar to a nested map and/or list.

The values will be held in a non persistent ets term storage.

Example 1
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

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
Example 2
---------

```dfs  
def default_map = 
    '{"key1":"topic/1/new", "key2":"topic/2/new", "key3":"topic/3/new"}'

|mem() 
.key('topic_lookup')
.default(default_map)
.default_json()

```

In the above example the `mem` node has no `field` parameter, but it is prepopulated with a json structure. The mem node is used 
as a lookup table here. The default  value will stay in the storage as long as the node is running. With no field parameter
given, a data_item coming in to the node will not overwrite the stored value.

The internal representation of the given json object is a `map` in faxe.

The stored map could then be use in a lambda expression:
```dfs  
|eval(lambda: map_get("some_field_name", ls_mem('topic_lookup'))).as('topic')
```
So based on the value of the field "some_field_name", the field `topic` will get the value of the corresponding map-key stored in the mem node.



_____________________________________________________________________________________________________
> For a list of lambda_library functions see [lambda_functions](../dfs_script_language/built-in_functions.md).


Parameters
----------

| Parameter          | Description                                                        | Default                             |
|--------------------|--------------------------------------------------------------------|-------------------------------------|
| field( `string` )  | field-path                                                         | undefined                           |
| key( `string` )    | name of the value storage                                          |                                     |
| type( `string` )   | Type of mem storage, one of 'single', 'list' or 'set'              | 'single'                            |
| default( `string` \| `number` )                                                         | Prefill the storage with this value | undefined       |
| default_json( is_set) | When set, the `default` value will be interpreted as a json string | false (not set)                     |

> At least one of the parameters `field` and/or `default` has to be defined, otherwise this node will not be able to do anything useful.