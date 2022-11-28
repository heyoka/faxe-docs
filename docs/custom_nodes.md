# Custom nodes written in python

Faxe allows for custom nodes to be used in any flow just like any of the built-in nodes.
Therefore, a dedicated interface can be used, which will be described here.

Custom nodes are written in python 3.x in FAXE.

### Data types
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
    {'fields': {'f1': 1, 'f2': {'f2_1': 'mode_on'}}}, 'ts': 1669407781437, 'dtag': None, 'tags': {}}
    
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
        {'fields': {'f1': 1, 'f2': {'f2_1': 'mode_on'}}}, 'ts': 1669407781437, 'dtag': None, 'tags': {}},
        {'fields': {'f1': 2, 'f2': {'f2_1': 'mode_off'}}}, 'ts': 1669407781438, 'dtag': None, 'tags': {}},
        {'fields': {'f1': 3, 'f2': {'f2_1': 'mode_on'}}}, 'ts': 1669407781439, 'dtag': None, 'tags': {}},
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
see data-point for a description
 