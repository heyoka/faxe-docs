The json_emitter node
=====================

This node is used to produce data, that can be processed in a flow.

It can be used for debugging and testing/mocking purposes as well as produce default values for different kind of applications.

Starting with a given `list of JSON strings` (json structures in string format), this data can be emitted and/or modified on every 
emit in different ways:

* determine, how data for output gets `selected` from the list of json inputs, see also [select](json_emitter.md#select)
* modify the selected data with `modifier` lambda functions
* output periodically with `every`, possibly adding a timing `jitter`, or have exactly 1 output with the `one-shot` parameter


_experimental since 0.19.9_:
    With the `modify` and `modify_with` parameters, certain fields in the json string(s) can be modified with every interval.


Examples
-------
```dfs  
|json_emitter(
  ' {"condition": {"id": 0, "name": "OK"}, "condition_reason": ""} ',
  ' {"condition": {"id": 1, "name": "Warning"}, "condition_reason": "bad succer"} ',
  ' {"condition": {"id": 2, "name": "Error"}, "condition_reason": "something went really wrong!"} '
  )
  
```
     
Emit one of the three given json strings(selected randomly) every 5 seconds (default).

-----------------------------------------------------------

```dfs  
|json_emitter(
  ' {"condition": {"id": 0, "name": "OK"}, "condition_reason": ""} ',
  ' {"condition": {"id": 1, "name": "Warning"}, "condition_reason": "bad succer"} ',
  ' {"condition": {"id": 2, "name": "Error"}, "condition_reason": "something went really wrong!"} ' 
  )
.every(3s)
.select('seq')
  
```

Select one of the json strings in sequence every 3 seconds, starting with the first one. After the last json string has been
selectect and outputted, start over with the first one again. Produces data-point items.

------------------------------------------

### Using modifiers

```dfs  
|json_emitter(
  ' {"Current_Ph_A": 10.33, "Current_Ph_B": 10.53, "Current_Ph_C": 10.76} ' 
  )
.every(200ms)
.align(true)
.modify(
    'data.Current_Ph_A',
    'data.Current_Ph_B', 
    'data.Current_Ph_C'
     )
.modify_with(
    lambda: random_normal(), 
    lambda: "data.Current_Ph_A" + 0.45, 
    lambda: nth(random(4), [12.552, 44.2, 13.86, 16.22])
    )
.as('data') 
  
```

Output the json data every 200ms, modifying it on every emit with the given lambda functions.
Note the 'as' parameter here: It gives the output data a new root-object ('data') and the modifiers must target the 'rooted' fields.

Sample output:

```json

{"ts":  1675147412200, "data":  
  {"Current_Ph_A": 1.6554763679823647, "Current_Ph_B": 2.105476367982365, "Current_Ph_C": 44.2}
}

```

------------------------------------------------------

### Batch output

```dfs  
def start_time = '2021-11-16T16:21:00.000Z'
|json_emitter(
  ' {"Current_Ph_A": 10.33, "Current_Ph_B": 10.53, "Current_Ph_C": 10.76} ',
  ' {"Current_Ph_A": 11.13, "Current_Ph_B": 10.74, "Current_Ph_C": 11.17} ',
  ' {"Current_Ph_A": 13.78, "Current_Ph_B": 11.02, "Current_Ph_C": 11.12} ',
  ' {"Current_Ph_A": 12.46, "Current_Ph_B": 10.98, "Current_Ph_C": 11.71} '
  )
.select('batch')
.one_shot(true)
.start_ts(start_time)
  
```
Output a data-batch item (using all the  json items at once) exactly one time (one-shot), using `start_time` as timestamp.
After the first output, the node will go to sleep for the rest of its life.


-----------------------------------------------


Parameters
----------

| Parameter                      | Description                                                                                                                   | Default                    |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| _[node]_ json( `string_list` ) | list of json strings                                                                                                          |                            |
| every( `duration` )            | emit interval                                                                                                                 | 5s                         |
| jitter( `duration` )           | max random value for time jitter added to every, adds time jitter to the values produced                                      | 0ms                        |
| align( `bool` )                | align the time to the every param, does not have an effect, if `start_ts` is given.                                           | false                      |
| select( `string` )             | entry select mode, possible values: `rand` or `seq`, `batch`                                                                  | 'rand'                     |
| start_ts( `string` or `int` )  | Timestamp to start from, instead of wall clock time (default). ISO8601 datetime string or millisecond timestamp allowed here. | '2021-11-16T16:21:12.505Z' |
| modify( `string_list` )        | list of fields, that should be modified                                                                                       | undefined                  |
| modify_with( `lambda_list` )   | list of lambda expressions, that perform the modification on the fields given with `modify`                                   | undefined                  |
| as( `string` )                 | root object used for output items                                                                                             | undefined                  |
| one_shot( `bool` )             | when set to true, the node gives exactly 1 output, before it goes to sleep                                                    | false                      |

> Note : `modify` and `modify_with` must have the same number of parameters, if given.

select
------


| value   | Description                                                    | Resulting data-item |
|---------|----------------------------------------------------------------|---------------------|
| `rand`  | randomly selects one of the json structures                    | data-point          |
| `seq`   | selects the json entries in sequence starting from top         | data-point          |
| `batch` | selects all of the entries resulting in a batch of data-points | data-batch          |
 