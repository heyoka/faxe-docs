# Custom nodes written in python

Faxe allows for custom nodes to be used in any flow just like any of the built-in nodes.
Therefore, a dedicated interface can be used, which will be described here.

Custom nodes are written in python >= 3.6 in FAXE.

The syntax for calling a custom node in [DFS](dfs_script_language/index.md) is exactly the same as for any built-in node, but instead of a 
pipe symbol, we use the `@` symbol.

```dfs
    |built_in_node()
    .opt1('somestring')
    .opt2(11)
    
    @custom_node()
    .option1('astring')
    .option2(22)
    
```



## Faxe base class
When writing a custom node in python, we have to create a python class, that inherits from the base class `Faxe`.

```python
from faxe import Faxe


class Mynode(Faxe):
    
    ...
    
```

In our class we can use a bunch of callbacks:

### Callbacks

> All callbacks are optional.

#### options (static)

The `options` callback is used to tell FAXE, what node options you want to use for your python node.
The return type for this callback is a `list of 2-or-3 tuples`.


> `options` is the only static callback and the only one, that has to return a value. 

The first two elements of the tuples must be strings, the third, if given depends on the `data_type`.
Every option, that has no `default value` (3rd element in the tuple) is mandatory in DFS scripts.
```python
    ("name_of_the_option", "data_type", {optional_default_value})
```

##### Example

```python
from faxe import Faxe


class Mynode(Faxe):

    @staticmethod
    def options():
        opts = [
            # mandatory
            ("field", "string"),
            # optional
            ("val", "integer", 33),
            
        ]
        return opts
    
    ...
    
```

The above example node can be used in DFS like so:
```dfs
    @mynode()
    % mandatory
    .field('some_field_path')
    % optional
    .val(44)
```

#### Data types for options

The second element of an options tuple defines the data type, that must be given in DFS.
A subset of the option types used for [built-in nodes](nodes/index.md) can be used.


| type           | description                       | DFS example                              |
|----------------|:----------------------------------|------------------------------------------|
| `string`       |                                   | .option('string_value')                  | 
| `integer`      |                                   | .option(123)                             |
| `float`        |                                   | .option(123.1564)                        | 
| `number`       | integer or float                  | .option(456.1564)                        | 
| `double`       | same as float                     | .option(13.98741755)                     | 
| `bool`         |                                   | .option(false)                           | 
| `string_list`  | 1 or more string values           | .option('string1', 'string2', 'string3') | 
| `integer_list` | 1 or more integer values          | .option(1, 2, 3, 4445)                   | 
| `float_list`   | 1 or more float values            | .option(1.11, 2.456486, 3.0, 44.45)      | 
| `number_list`  | 1 or more number values           | .option(1.11, 2, 3.0, 45)                | 
| `list`         | list of possibly mixed data types | .option('name', 11, 234.3, 'one', 'two') | 



#### init

The `init` callback is called on class instatiation, it gets injected a dictionary with the [option values](#callbacks) given in the DFS script.

> Do not overwrite python's `__init` method. The callback will not work in this case.

```python
from faxe import Faxe


class Mynode(Faxe):

    ...

    def init(self, args=None):
        # store the option values for later usage
        self.fieldname = args["field"]
        self.value = args["val"] 
        
    ...
    
```


#### handle_point

`handle_point` is called every time the custom node receives a data-point structure from upstream nodes in a FAXE flow.
For details on the point structure see [FAXE Data items - data_point](#data-point) below.

```python
from faxe import Faxe


class Mynode(Faxe):

    ...

    def handle_point(self, point_data):  
        # use the inherited emit method to emit data to downstream nodes in the flow
        self.emit(point_data)
        
    ...
    
```


#### handle_batch

`handle_batch` is called every time the custom node receives a data-batch structure from upstream nodes in a FAXE flow.
For details on the batch structure see [FAXE Data items - data_batch](#data-batch) below.

```python
from faxe import Faxe


class Mynode(Faxe):

    ...

    def handle_batch(self, batch_data):  
        # use the inherited emit method to emit data to downstream nodes in the flow
        self.emit(batch_data)
        
    ...
    
```


### Inherited methods from the Faxe class

#### emit

```python
def emit(self, emit_data: dict):
```

The `emit` method inherited from the base class (Faxe), is the only way send data to downstream nodes in a FAXE flow.
It can take both [point](#data-point) and [batch](#data-batch) data structures.

```python
from faxe import Faxe


class Mynode(Faxe):

    ...

    def my_method(self):
        batch_data = self.my_batch_data
        self.emit(batch_data)
        
    ...
    
```

#### log

```python
def log(self, msg: str, level='notice': str):
"""
:param level: 'debug' | 'info' | 'notice' | 'warning' | 'error' | 'critical' | 'alert'
"""
```

The `log` method inherited from the base class (Faxe), can be used for logging.
Using this method makes sure, your log data will be injected into FAXE's logging infrastructure.

```python
from faxe import Faxe


class Mynode(Faxe):

    ...

    def my_method(self, param):
        self.log(f"my_method is called with {param}", 'info')
        ...
        
    ...
    
```

#### now (static)

```python
@staticmethod
def now():
    """
    unix timestamp in milliseconds (utc)
    :return: int
    """
```
Used to retrieve the current timestamp in milliseconds.

```python
from faxe import Faxe


class Mynode(Faxe):

    ...

    def my_method(self, _param):
        now = Faxe.now()
        ...
        
    ...
    
```



## Data types
Comparing data types on each side


| FAXE                  | python                |
|-----------------------|-----------------------|
| string                | string                |
| binary                | string                |
| integer               | integer               |
| floating point number | floating point number |
| map                   | dictionary            |
| list                  | list                  |
| ----------------      | ------------------    |
| data-point            | dictionary, see below |
| data-batch            | dictionary, see below |


### FAXE Data items 

As you remember, in FAXE we know two types of data-items, data-point and data-batch.

How do data-items look like in python ?

### data-point

```python
    ## data-point
    {'fields': {'f1': 1, 'f2': {'f2_1': 'mode_on'}}, 'ts': 1669407781437, 'dtag': None, 'tags': {}}
    
```

| field    | data type       | meaning                                       |
|----------|-----------------|-----------------------------------------------|
| `ts`     | integer         | millisecond timestamp                         |
| `fields` | dictionary      | a dictionary of fields, a data-point carries, |                                                                                              
| `tags`   | dictionary      | a dictionary of tags, a data-point carries    | 
| `dtag`   | integer or None | delivery tag, see description below           | 


#### fields
A **key** in the `fields` dict is called `fieldname` and is always a **string**.


A dict **value** can be of any of the above listed data-types, including dictionary and list. 

_**Examples**_

```python
    {'field1': 'string'}
    {'field2': 1235468486}
    {'field3': 12354.68486}
    {'field4': {'field4_1': [1,43,4,67.7]}}
    
```


#### tags

For `tags`, keys and values are **strings** only.


#### dtag
A delivery tag is used to acknowledge a data-item to upstream nodes. Can be ignored for python nodes at the moment.



### data-batch

```python
    ## data-batch
    {'points': [
        {'fields': {'f1': 1, 'f2': {'f2_1': 'mode_on'}}, 'ts': 1669407781437, 'dtag': None, 'tags': {}},
        {'fields': {'f1': 2, 'f2': {'f2_1': 'mode_off'}}, 'ts': 1669407781438, 'dtag': None, 'tags': {}},
        {'fields': {'f1': 3, 'f2': {'f2_1': 'mode_on'}}, 'ts': 1669407781439, 'dtag': None, 'tags': {}},
    ], 
    'start_ts': 1669407781437, 'dtag': None}
    
```

| field      | data type       | meaning                                                     |
|------------|-----------------|-------------------------------------------------------------|
| `start_ts` | integer or None | millisecond timestamp, not always set                       |
| `points`   | list            | a list of data-points, sorted by their timestamps ascending |                                                                                              
| `dtag`     | integer or None | delivery tag, see description below                         | 


#### points
In a data-batch, `points` is a list of **data-points**, the list can be of any length (Note :there is no length check in place at the moment).



#### dtag
See [data-point](#data-point) for a description.
 


## Helper classes

TBD