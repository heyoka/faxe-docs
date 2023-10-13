The collect node
=====================

Since 0.15.2

The collect node will maintain a `set` of data-points based on some criteria given as lambda-expressions.
It will normally `output a data_batch` item regularily (when `emit_every` is given) or based on every incoming item.


The internal collection is a key-value set with unqiue values for the keys, taken from the `key_fields`.
[{Key, DataPoint}]

> Although it should be straight forward, the behaviour of this node can get quite complex and a bit hard to understand, depending on the options given. 
> If you just want to collect and hold a bunch of values for certain fields, take a look at 
> the [collect_fields](./collect_fields.md) node, it may be better suited for your needs.

### Adding, updating and removing a value

With every incoming data-item the node will first check, if there is already an item with the same key-field value in the collection.
If this is not the case, the node will evaluate the `add` function, if given.
Data_points that do not have (any of) the key-field(s) present, will be ignored.

An item will be added to the collection if the key is new to the collection and if the `add`-function

* returns true
* is not given


If there is already an item with the same value(s) for the key-field(s), 
the node would check, if there is an `update` function and evaluate it and if no update happend, 
it will try to evaluate the `remove` function.

If an `update` happened, the node will skip evaluating the `remove` function.

If no `remove` function is given, data-items will not be removed, but only evicted by the `max_age` and/or the `max_ts_age` option.

### Update and remove expression

In the `update` or `remove` lambda-expressions, the datapoint, that is already in the collection, can be used, for comparing for example.
That is to say: When the update or remove function is evaluated, it gets injected the data-point for the same key-field value, that is
found in the collection. There is a root-object used for the fields in this datapoint: `__state`.

What this means is, that you can do something like this in the `update` expression (see also Example 3 below)

```dfs
|collect()
.key_fields('data.id') 

%% comparing the current value of 'val' to the value from the data-point currently in the collection
%% here we use the value from the internal buffer that is found in the '__state' object.
.update(lambda: "data.val" > "__state.data.val") 

```

### Output

When no `emit_every` is given, the node will output data with every incoming data-item.

With `emit_unchanged` set to false, output will only happen after processing a data-item that has changed the internal set.

`data_batch` items are processed as a whole first and then may trigger an emit operation.

_`Since 0.19.4`_ : The output batch can be conflated into a single data_point item, when the `merge` option is set to true.

-------------------------------------------------------------
>Note: Produced data may become very large, if the value of `key_fields` is ever-changing, so that
    the node will cache a lot of data and therefore may use a lot of memory, be aware of that !


Example 1
-------

```dfs   
|collect()
.key_field('data.code')
.max_age(2m) 
 

```
Collect by the field `data.code` keeping every data-item for 2 minutes.
No `update` or `remove` will occur otherwise.

Example 2
-------

```dfs   
|collect()
.key_field('data.code')
.update(lambda: "data.mode" == 1) 
.remove(lambda: str_length("data.message") > 7)
 

```
Collect by the field `data.code`, update an item when the `data.mode` field is 1.

Items get removed, if they have a value for `data.message`, that is more than 7 chars long.

Example 3
--------

```dfs   
%% input data ->

|json_emitter()
 .every(500ms)
 .json(
    '{"id": 224, "name" : "twotwofour", "val": 12, "mode": 1}',
    '{"id": 112, "name" : "oneonetow", "val": 11, "mode": 1}',
    '{"id": 358, "name" : "threefiveeigth", "val": 7, "mode": 1}',
    '{"id": 102, "name" : "onezerotwo", "val": 12, "mode": 1}',
    '{"id": 224, "name" : "twotwofour", "val": 13, "mode": 1}',
    '{"id": 112, "name" : "oneonetow", "val": 9, "mode": 1}',
    '{"id": 358, "name" : "threefiveeigth", "val": 4, "mode": 1}',
    '{"id": 102, "name" : "onezerotow", "val": 2, "mode": 1}',

        '{"id": 224, "name" : "twotwofour", "val": 3, "mode": 1}',
        '{"id": 112, "name" : "oneonetow", "val": 15, "mode": 1}',
        '{"id": 358, "name" : "threefiveeigth", "val": 22, "mode": 1}',
        '{"id": 102, "name" : "onezerotwo", "val": 9, "mode": 1}',


        '{"id": 224, "name" : "twotwofour", "val": 0, "mode": 0}',
        '{"id": 112, "name" : "oneonetow", "val": 0, "mode": 0}',
        '{"id": 358, "name" : "threefiveeigth", "val": 0, "mode": 0}',
        '{"id": 102, "name" : "onezerotow", "val": 0, "mode": 0}'
    )

 .as('data')
 .select('rand')

|collect()
.key_fields('data.id')
.keep('data.id', 'data.val')
.update(lambda: "data.val" > "__state.data.val")
.remove(lambda: "data.mode" == 0)

```

Collect the max value of `data.val` for every different `data.id` value.
Note the use of the `'__state'` prefix for previous value, that can be used in the `update` expression.


Example 4
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

| Parameter                    | Description                                                                                                                                                                                                                                                                         | Default   |
|------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| key_fields(`string`)         | The value of the key-field will be used as an index for the collection.                                                                                                                                                                                                             |           |
| add(`lambda`)                | Criterion for adding an incoming point to the collection, must return a boolean value. Will always `add`, if not given.                                                                                                                                                             | undefined |
| remove(`lambda`)             | Criterion for removing a point from the collection, must return a boolen value.                                                                                                                                                                                                     | undefined |
| update(`lambda`\| `boolean`) | Criterion for updating a data_point in the collection, must return a boolen value. If not given, no updating will occur. Reference the current value with `__state`. If `true`, will always update.                                                                                 | false     |
| update_mode(`string`)        | `replace`, `merge`, `merge_reverse`. When updating, an existing point in the collection can be replaced by or merged with the new one. With `merge_reverse` data_point positions for the merge operation get flipped, so that the existing point is merged onto the new data_point. | 'replace' |
| tag_added(`boolean`)         | When set to true, emitted data_points that have been added since the last emit will have a field called `added` with the value of `tag_value`                                                                                                                                       | false     |
| tag_value(`any`)             | Value to be use for tag fields (`added`, `removed`)                                                                                                                                                                                                                                 | 1         |
| include_removed(`boolean`)   | When set to true, data_points that would normally be removed from the collection will get a field called `removed` with the value of `tag_value` and are included in the next data-batch emit                                                                                       | false     |
| keep(`string_list`)          | If given, these field will be kept from every data-point, if not given, the whole item will be kept.                                                                                                                                                                                | undefined |
| keep_as(`string_list`)       | Rename fields that are kept (must have the same number of entries as `keep`).                                                                                                                                                                                                       | undefined |
| emit_unchanged (`boolean`)   | When set to false, processing of a data-item that does not result in a change to the collection, will not trigger an output of data.                                                                                                                                                | true      |
| emit_every (`duration`)      | Interval at which to emit the current collection as a data_batch item. If not given, every data-item (point or batch) will trigger an output (based on the value of `emit_unchanged`).                                                                                              | undefined |
| max_age(`duration`)          | Maximum age for any data-item in the collection, before it gets removed. Reference time for item age is the time the item entered the collection.                                                                                                                                   | 3h        |
| max_ts_age(`duration`)       | Maximum age for any data-item in the collection, before it gets removed. Reference time for item age is the timestamp within the item.                                                                                                                                              | 3h        |
| merge(`boolean`)             | Whether to condense the output data_batch into a single data_point item by merging them.                                                                                                                                                                                            | false     |
 