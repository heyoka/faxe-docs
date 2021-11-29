The collect node
=====================

_`Experimental`_.

Since 0.15.2

The collect node will maintain a `set` of data-points based on some criteria given as lambda-expressions.
It will output a data_batch item regularily (when `emit_every` is given) or on every incoming item.

On every incoming data_point the node will first check, if there is already an item with the same key-field value in the collection.
If  not the case, the node will evaluate the `add` function. If the add function returns true, the item will be added to the collection.

If there is already an item with the same key-value, the node would check if there is an `update` function and evaluate it and if no update happend, 
it will try to evaluate the `remove` function.

So if `update` happened, the node will skip evaluating the `remove` function.

### Output

When no `emit_every` is given, the node will output data with every incoming data-item, that has changed the internal set.
`data_batch` items are processed as a whole first and then may trigger an emit operation.


-------------------------------------------------------------
>Note: Produced data may become very large, if the value of `key_field` is ever-changing, so that
    the node will cache a lot of data and therefore may use a lot of memory, be aware of that !


Example
-------

```dfs  

%% input data ->

|json_emitter()
.every(500ms)
.json(
'{"code" : {"id": 224, "name" : "224"}, "message": " a test", "mode": 1}',
'{"code" : {"id": 334, "name" : "334"}, "message": " another test", "mode": 1}',
'{"code" : {"id": 114, "name" : "114"}, "message": " another test", "mode": 2}',
'{"code" : {"id": 443, "name" : "443"}, "message": " another test", "mode": 1}', 
'{"code" : {"id": 111, "name" : "111"}, "message": " another test", "mode": 1}',
'{"code" : {"id": 443, "name" : "443"}, "message": " another test", "mode": 0}',
'{"code" : {"id": 224, "name" : "224"}, "message": " another test", "mode": 0}',
'{"code" : {"id": 111, "name" : "111"}, "message": " another test", "mode": 0}',
'{"code" : {"id": 334, "name" : "334"}, "message": " another test", "mode": 0}',
'{"code" : {"id": 551, "name" : "551"}, "message": " another test", "mode": 2}',
'{"code" : {"id": 551, "name" : "551"}, "message": " another test", "mode": 0}'
)
.as('data')

%% collect 2 fields ('data.code' and 'data.message') 
%% with the key-field 'data.code'.
%% this node will output a data_batch item with a list of data-points
%% where the original timestamp and meta-data is preserved and
%% containing the fields mentioned before every 10 secondes

|collect()
%% the collect node will build an internal buffer 
%% with the value of the 'key_field' as index
.key_field('data.code')
%% criterion for adding a data-point to the internal collection buffer
.add(lambda: "data.mode" > 0)
%% criterion for removal of values
.remove(lambda: "data.mode" == 0)
%% we keep these fields in the resulting data_batch
.keep('data.code', 'data.message') 
.emit_every(10s)

%% make sense of the data-collection in counting the 'data.code' values
|aggregate()
.fields('data.code')
.functions('count')
.as('code_count')

|debug()

```



Parameters
----------

Parameter     | Description | Default
--------------|-------------|---------
key_field(`string`) | The value of the key-field will be used as an index for the collection, can be any data-type. |
add(`lambda`) | Criterion for adding an incoming point to the collection, must return a boolean value.|
remove(`lambda`) | Criterion for removing a point from the collection, must return a boolen value.|
update(`lambda`) | Criterion for updating a data_point in the collection, must return a boolen value. If not given, no updating will occur.| undefined
update_mode(`string`) | `replace` or `merge`. When updating, an existing point in the collection can be replaced by or merged with the new one.| 'replace'
tag_added(`boolean`) | When set to true, emitted data_points that have been added since the last emit will have a field called `added` with the value of `tag_value`| false
tag_value(`any`) | Value to be use for tag fields (`added`, `removed`)| 1
include_removed(`boolean`) | When set to true, data_points that would normally be removed from the collection will get a field called `removed` with the value of `tag_value` and are included in the next data-batch emit| false
keep(`string_list`) | If given, these field will be kept from every data-point, if not given, the whole item will be kept. | undefined 
emit_every (`duration`)  | Interval at which to emit the current collection as a data_batch item. If not given, every data-item (point or batch) that effects in a chang to the collection will trigger an output of the current collection| undefined
max_age(`duration`) | Maximum age for any data-item in the collection, after which it gets removed. The reference time for item age is the time the item entered the collection | 3h
 