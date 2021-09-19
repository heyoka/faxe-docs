The collect node
=====================

_`Experimental`_.

Since 0.15.2

The collect node will maintain a collection of data-points based on some criteria given as lambda-expressions.
It will output a data_batch item regularily (when `emit_every` is given) or on every incoming item.


Example
-------

```dfs  

%% input data ->

|json_emitter()
.every(500ms)
.json(
<<<{"code" : {"id": 224, "name" : "224"}, "message": "this is a test", "mode": 1}>>>,
<<<{"code" : {"id": 334, "name" : "334"}, "message": "this is another test", "mode": 1}>>>,
<<<{"code" : {"id": 114, "name" : "114"}, "message": "this is another test", "mode": 2}>>>,
<<<{"code" : {"id": 443, "name" : "443"}, "message": "this is another test", "mode": 1}>>>, 
<<<{"code" : {"id": 111, "name" : "111"}, "message": "this is another test", "mode": 1}>>>,
<<<{"code" : {"id": 443, "name" : "443"}, "message": "this is another test", "mode": 0}>>>,
<<<{"code" : {"id": 224, "name" : "224"}, "message": "this is another test", "mode": 0}>>>,
<<<{"code" : {"id": 111, "name" : "111"}, "message": "this is another test", "mode": 0}>>>,
<<<{"code" : {"id": 334, "name" : "334"}, "message": "this is another test", "mode": 0}>>>,
<<<{"code" : {"id": 551, "name" : "551"}, "message": "this is another test", "mode": 2}>>>,
<<<{"code" : {"id": 551, "name" : "551"}, "message": "this is another test", "mode": 0}>>>
)
.as('data')

%% collect 2 fields ('data.code' and 'data.message') with the key-field 'data.code'.
%% this node will output a data_batch item with a list of data-points
%% where the original timestamp and meta-data is preserved and
%% containing the fields mentioned before every 10 secondes

|collect()
%% the collect node will build an internal buffer with the value of the 'key_field' as index
.key_field('data.code')
%% criterion for adding a data-point to the internal collection buffer
.add(lambda: "data.mode" > 0)
%% criterion for removal of values
.remove(lambda: "data.mode" == 0)
%% we keep these fields in the resulting data_batch
.keep('data.code', 'data.message')
%% collection of type set, so no duplicates
.type('set')
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
remove(`lambda`) | Criterion for removing an incoming point from the collection, must return a boolen value.|
keep(`string_list`) | If given, these field will be kept from every data-point, if not given, the whole item will be kept. | undefined
type (`string`)  | The type of the collection: 'list' or 'set' (no duplicates) | 'set'
emit_every (`duration`)  | Interval at which to emit the current collection as a data_batch item. | undefined
 