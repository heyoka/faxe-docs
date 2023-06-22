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

The first two elements of the tuples must be strings, the third, if given, depends on the `data_type`.
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

> Do not overwrite the `__init__` method. The callback will not work in this case.

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
 

----------------------------------- 

## State persistence

Faxe introduced the concept of state persistence for flows in version 1.2.0.
With state persistence active for a flow, the faxe engine will persist state for every node in a flow to disc to be able
to continue a flow where it left off, if for example a restart of the whole engine is necessary due to a version update.

Read more about state persistence [here](state_persistence.md).

Custom python node can also utilize this feature. When on startup of a python node there is persisted state found for that
node on the disc, this state data will be injected to the node's startup procedure.

### Activate persistence

There are different ways, state gets persisted for custom python nodes:

```
# defined in Faxe.py 

STATE_MODE_HANDLE   = 'handle'
STATE_MODE_EMIT     = 'emit'
STATE_MODE_MANUAL   = 'manual'

```

* STATE_MODE_HANDLE means, that state is automatically persisted, after every call to either `handle_batch` or `handle_point`.
* STATE_MODE_EMIT means, state is auto persisted after every call to self.emit() by the python node.
* STATE_MODE_MANUAL means, that it is completely up to the python node when to persist state.

To choose which mode to use, simple implement the `state_mode` method:

```python 
from faxe import Faxe

def state_mode(self):
        return Faxe.STATE_MODE_MANUAL
```

In the above example, the state mode is `manual`. In this mode the python node has to decide when to persist state and this
is done with the `persist_state` method:

```
def persist_state(self, state=None):
        """
        :param state: any|None
        """
        ...

```

#### manual

If state is None, then the state that gets persisted will be retreived either from the format_state method (see below) or,
if format_state is not implemented, the state will be a dictionary with every member var of the object.


Example:

```python

def my_method(self):
   
    ...

    self.persist_state()
    
    # OR provide state
    self.persist_state(state={'mystate': 'dict'})
    
    ...

```


### State data

State data can be of any [pickle-able](https://docs.python.org/3/library/pickle.html) type.

If the python node does not overwrite the `format_state` method, 
the Faxe base class will provide a dictionary with all the member vars of the python callback object using
python's [vars](https://docs.python.org/3/library/functions.html#vars) function.

With the `format_state` method, the python node can provide state data as it wishes:

```python

def format_state(self):
   return {'counter': self.counter, 'items': self.items}

```

As shown [above](#manual), state data can also be given, when calling the persist_state method.



A python node can then get this state data with the `get_state` method:

```
def get_state(self):
    """
    get the last persisted state data, that was given to this node
    :return: any
    """
    return self._pstate
```

Example:

```python
from faxe import Faxe, Point, Batch


class Mynode(Faxe):

    def init(self, args=None):
        
        ...
        
        # get the state
        self.mystate = self.get_state()
        

    ...
    
```

We can also use the `get_state_value` method (works when state data is a dictionary) and initialize member vars in an elegant way:

```

def get_state_value(self, key, default=None):
        """
        get a specific entry from the state, if state is a dict, otherwise returns 'default'
        :param key: string
        :param default: any
        :return: any
        """
        if type(self._pstate) == dict:
            if key in self._pstate:
                return self._pstate[key]
        return default

```

Example:

```python
from faxe import Faxe, Point, Batch


class Mynode(Faxe):

    def init(self, args=None):
        
        ...
        
        self.item_counter = self.get_state_value('item_counter', 0)
        self.items = self.get_state_value('items', {})
        

    ...
    
```



## Helper classes

There are helper classes to make it easier to work with data coming from the faxe engine. All functions are static so you do not 
instanciate them and nothing is stored inside an object, making it possible to mix the usage of the helpers with inline code.

To use the helper classes, just import `faxe.Point` and/or `faxe.Batch`.

```python
from faxe import Faxe, Point, Batch


class Mynode(Faxe):
    ... 
    
```

---------------------------------------------------------------------


### Helper class for working with data-point objects.

```python
class Point:
    """
    Completely static helper class for data-point structures (dicts)

    point = dict()
    point['ts'] = int millisecond timestamp
    point['fields'] = dict()
    point['tags'] = dict()
    point['dtag'] = int

    """

    @staticmethod
    def new(ts=None):
        p = dict()
        p['fields'] = dict()
        p['tags'] = dict()
        p['dtag'] = None
        p['ts'] = ts
        return p

    @staticmethod
    def fields(point_data, newfields=None):
        """
        get or set all the fields (dict)
        :param point_data: dict()
        :param newfields: dict()
        :return: dict()
        """
        if newfields is not None:
            point_data['fields'] = newfields
            return point_data

        return dict(point_data['fields'])

    @staticmethod
    def value(point_data, path, value=None):
        """
        get or set a specific field
        :param point_data: dict()
        :param path: string
        :param value: any
        :return: None, if field is not found /
        """
        if value is not None:
            Jsn.set(point_data, path, value)
            return point_data

        return Jsn.get(point_data, path)

    @staticmethod
    def values(point_data, paths, value=None):
        """
        get or set a specific field
        :param point_data: dict
        :param paths: list
        :param value: any
        :return: point_data|list
        """
        if value is not None:
            for path in paths:
                Jsn.set(point_data, path, value)
            return point_data

        out = list()
        for path in paths:
            out.append(Jsn.get(point_data, path))
        return out

    @staticmethod
    def default(point_data, path, value):
        """

        :param point_data:
        :param path:
        :param value:
        :return:
        """
        if Point.value(point_data, path) is None:
            Point.value(point_data, path, value)

        return point_data

    @staticmethod
    def tags(point_data, newtags=None):
        if newtags is not None:
            point_data['tags'] = newtags
            return point_data

        return point_data['tags']

    @staticmethod
    def ts(point_data, newts=None):
        """
        get or set the timestamp of this point
        :param point_data: dict
        :param newts: integer
        :return: integer|dict
        """
        if newts is not None:
            point_data['ts'] = int(newts)
            return point_data

        return point_data['ts']

    @staticmethod
    def dtag(point_data, newdtag=None):
        if newdtag is not None:
            point_data['dtag'] = newdtag
            return point_data

        return point_data['dtag']



```

### Helper class for working with data-batch objects.

```python
class Batch:
    """
    Completely static helper class for data-batch structures (dicts)

    batch = dict()
    batch['points'] = list() of point dicts sorted by their timestamps
    batch['start_ts'] = int millisecond unix timestamp denoting the start of this batch

    batch['dtag'] = int
    """

    @staticmethod
    def new(start_ts=None):
        b = dict()
        b['points'] = list()
        b['dtag'] = None
        b['start_ts'] = start_ts
        return b

    @staticmethod
    def empty(batch_data):
        """
        a Batch is empty, if it has no points
        :param batch_data:
        :return: True | False
        """
        return ('points' not in batch_data) or (batch_data['points'] == [])

    @staticmethod
    def points(batch_data, points=None):
        """

        :param points: None | list()
        :param batch_data: dict
        :return: list
        """
        if points is not None:
            batch_data['points'] = points
            Batch.sort_points(batch_data)
            return batch_data

        return list(batch_data['points'])

    @staticmethod
    def value(batch_data, path, value=None):
        """
        get or set path from/to every point in a batch
        :param batch_data:
        :param path:
        :param value:
        :return: list
        """
        out = list()
        points = batch_data['points']
        for p in points:
            out.append(Point.value(p, path, value))
        if value is not None:
            return batch_data

        return out

    @staticmethod
    def values(batch_data, paths, value=None):
        """
        get or set path from/to every point in a batch
        :param batch_data:
        :param paths:
        :param value:
        :return: list
        """
        if not isinstance(paths, list):
            raise TypeError('Batch.values() - paths must be a list of strings')
        if value is not None:
            points = batch_data['points']
            for p in points:
                for path in paths:
                    Point.value(p, path, value)
            # batch_data['points'] = points
            return batch_data
        else:
            out = list()
            points = batch_data['points']
            for p in points:
                odict = dict()
                for path in paths:
                    odict[path] = Point.value(p, path, value)
                out.append(odict)
            return out

    @staticmethod
    def default(batch_data, path, value):
        """

        :param batch_data:
        :param path:
        :param value:
        :return:
        """
        points = batch_data['points']
        for p in points:
            Point.default(p, path, value)
        return batch_data

    @staticmethod
    def dtag(batch_data):
        return batch_data['dtag']

    @staticmethod
    def start_ts(batch_data, newts=None):
        if newts is not None:
            batch_data['start_ts'] = newts
            return batch_data

        return batch_data['start_ts']

    @staticmethod
    def add(batch_data, point):
        if ('points' not in batch_data) or (type(batch_data['points']) != list):
            batch_data['points'] = list()
            batch_data['points'].append(point)
        else:
            batch_data['points'].append(point)
            Batch.sort_points(batch_data)

        return batch_data

```