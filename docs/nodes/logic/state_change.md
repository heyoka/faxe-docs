The state_change node
=====================

Computes the duration and count of points of a given state. The state is defined via a lambda expression.

For each consecutive point for which the expression evaluates as true, state count and duration will be incremented.

This node can be used to track state in data and produce new data based on the state-events.
It can produce new data-points every time the state is `entered` and/or `left`. 

### The enter data-point

If the `.enter()` option is set, a new data-point will be emitted on state-enter.
The new data-point will have a field, named with the `.enter_as()` option, set to `1`.
This fieldname defaults to `state_entered`.

> new since 0.19.51: `state_id`, uuid v4 is created on every state entry  


### The leave data-point

If the `.leave()` option is set, a new data-point will be emitted on state-leave.
Fields for this data-point:

| Name             | Description                                                                                          |
|------------------|------------------------------------------------------------------------------------------------------|
| `state_left`     | stateflag, set to `1`                                                                                |
| `state_start_ts` | timestamp at which the state has been entered                                                        |
| `state_end_ts`   | timestamp at which the state-expression has been satisfied the last time                             |
| `state_duration` | duration of the state in `milliseconds`                                                              |
| `state_count`    | number of points, the number of consecutive data-points for which the state-expression returned true |
| `state_id`       | new since `0.19.51`, uuid v4 is created on every state-enter action                                  |

When the lambda expression generates an error during evaluation, the current point is discarded
and does not affect any calculations.

_Note that while state-count is 1, state-duration will be 0, if there is exactly 1 data-point within the state-window._


Example
-------

```dfs    

%% the lambda defines our state    
|state_change(lambda: "val" < 7 AND "err" != 0)
%% the node will emit a data-point on state-leave only
.leave()
%% we keep these fields for the new state-leave data-point
.leave_keep('err', 'err_code')

```
Example output in json:
```json

{
    "ts": 1232154654655, 
    "err": 1, "err_code": 1492, "state_left": 1, "state_id" : "07aae050-9d30-4570-989d-74f5f21d52bf",
    "state_start_ts": 1232154644655, "state_end_ts" : 1232154654655,
    "state_duration": 10000, "state_count": 22
}

```
------------
```dfs    

%% the lambda defines our state    
|state_change(lambda: "val" > 2 OR "err" == 1)
%% the node will emit a data-point on state-enter
.enter()
%% the node will emit a data-point on state-leave
.leave()
%% we keep these fields for the new state-enter data-point
.enter_keep('err', 'err_code')
%% we keep these fields for the new state-leave data-point
.leave_keep('err', 'err_code')
%% prefix all fields written by this node with 'my_'
.prefix('my_')

```
Example output in json for the enter data-point:
```json

{
    "ts": 1232154654655, "state_id": "07aae050-9d30-4570-989d-74f5f21d52bf", 
    "err": 1, "err_code": 1492, "my_state_entered": 1
}
```
 

Parameters
----------

| Parameter                   | Description                                                                   | Default           |
|-----------------------------|-------------------------------------------------------------------------------|-------------------|
| _[node]_ lambda( `lambda` ) | state lambda expression                                                       |                   |
| enter( is_set )             | emit a datapoint on state-enter                                               | undefined         |
| leave( is_set )             | emit a datapoint on state-leave                                               | undefined         |
| enter_as( `string` )        | name for the "enter" field, it will be set to true                            | 'state_entered'   |
| leave_as( `string` )        | name for the "leave" field, it will be set to true                            | 'state_left'      |
| state_id_as( `string` )     | since 0.19.51: name for the "state_id" field,                                 | 'state_id'        |
| enter_keep( `string_list` ) | a list of fieldnames that should be kept for the `enter` data-point           | []                |
| leave_keep( `string_list` ) | a list of fieldnames that should be kept for the `leave` data-point           | []                |
| prefix( `string` )          | prefix fields added by this node with a string (`keep`-fields stay untouched) | '' (empty string) |

At least one of the `enter | leave` options must be given.
