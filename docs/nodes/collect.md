The collect node
=====================

_`Experimental`_.

Since 0.15.2

The collect node will maintain a `set` of data-points based on some criteria given as lambda-expressions.
It will `output a data_batch` item regularily (when `emit_every` is given) or based on every incoming item.

The internal collection is a key-value set with unqiue values for the keys, taken from the `key_fields`.
[{Key, DataPoint}]

With every incoming data-item the node will first check, if there is already an item with the same key-field value in the collection.
If this is not the case, the node will evaluate the `add` function, if given.
Data_points that do not have the key-field present, will be ignored.

An item will be added to the collection if the key is new to the collection and if the `add`-function

* returns true
* is not given

 

If there is already an item with the same value(s) for the key-field(s), 
the node would check, if there is an `update` function and evaluate it and if no update happend, 
it will try to evaluate the `remove` function.

If an `update` happened, the node will skip evaluating the `remove` function.

If no `remove` function is given, data-items will not be removed, but only evicted by the `max_age` option.



### Output

When no `emit_every` is given, the node will output data with every incoming data-item.

With `emit_unchanged` set to false, output will only happen after processing a data-item that has changed the internal set.

`data_batch` items are processed as a whole first and then may trigger an emit operation.


-------------------------------------------------------------
>Note: Produced data may become very large, if the value of `key_fields` is ever-changing, so that
    the node will cache a lot of data and therefore may use a lot of memory, be aware of that !


Example1
-------

```dfs   
|collect()
.key_field('data.code')
.max_age(2m) 

|debug()

```
Collect by the field `data.code` keeping every data-item for 2 minutes.
No `update` or `remove` will occur otherwise.

Example2
-------

```dfs   
|collect()
.key_field('data.code')
.update(lambda: "data.mode" == 1) 
.delete(lambda: str_length("data.message") > 7)

|debug()

```
Collect by the field `data.code`, update an item when the `data.mode` field is 1.

Items get deleted, if they have a value for `data.message`, that is more than 7 chars long.

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

Parameter     | Description                                                                                                                                                                                                                                                                         | Default
--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------
key_fields(`string`) | The value of the key-field will be used as an index for the collection.                                                                                                                                                                                                             |
add(`lambda`) | Criterion for adding an incoming point to the collection, must return a boolean value.                                                                                                                                                                                              | undefined
remove(`lambda`) | Criterion for removing a point from the collection, must return a boolen value.                                                                                                                                                                                                     | undefined
update(`lambda`) | Criterion for updating a data_point in the collection, must return a boolen value. If not given, no updating will occur.                                                                                                                                                            | undefined
update_mode(`string`) | `replace`, `merge`, `merge_reverse`. When updating, an existing point in the collection can be replaced by or merged with the new one. With `merge_reverse` data_point positions for the merge operation get flipped, so that the existing point is merged onto the new data_point. | 'replace'
tag_added(`boolean`) | When set to true, emitted data_points that have been added since the last emit will have a field called `added` with the value of `tag_value`                                                                                                                                       | false
tag_value(`any`) | Value to be use for tag fields (`added`, `removed`)                                                                                                                                                                                                                                 | 1
include_removed(`boolean`) | When set to true, data_points that would normally be removed from the collection will get a field called `removed` with the value of `tag_value` and are included in the next data-batch emit                                                                                       | false
keep(`string_list`) | If given, these field will be kept from every data-point, if not given, the whole item will be kept.                                                                                                                                                                                | undefined 
emit_unchanged (`boolean`)  | When set to false, processing of a data-item that does not result in a change to the collection, will not trigger an output of data.                                                                                                                                                | true
emit_every (`duration`)  | Interval at which to emit the current collection as a data_batch item. If not given, every data-item (point or batch) will trigger an output (based on the value of `emit_unchanged`).                                                                                              | undefined
max_age(`duration`) | Maximum age for any data-item in the collection, before it gets removed. Reference time for item age is the time the item entered the collection.                                                                                                                                   | 3h
 