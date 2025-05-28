The change_detect node
=====================

Emits new point-values only if different from the previous point.
 
* Multiple fields can be monitored for change by this node.
* If no fields are given, the complete data-item is compared to the last one.
* If a reset_timeout is given, all previous values will be reset when no value is received within this amount of time.
So that after the timeout the first data_item will be emitted. 
* For value comparison erlang's strict equals (=:=) is used, so 1.0 is not equal to 1.


Example
-------
```dfs  
%% detects any changes in data_items
|change_detect()

%% detect changes in one field, with timeout
%% outputs at least the first data_item coming in after a 3 second timeout
|change_detect('val')
.reset_timeout(3s)

%% detect changes in two fields, with timeout
|change_detect('data.State.Err', 'data.State.Msg')
.reset_timeout(60s) 

% in-example json notation: 
% {"data": {"x": {"temp": 32.4564}, "y" : {"temp" : 31.15155}} }

|change_detect('data.x.temp', 'data.y.temp')

```

Parameters
----------

| Parameter                        | Description                                                                                                                                                                                    | Default   |
|----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| _[node]_ fields( `string_list` ) | List of fields to monitor                                                                                                                                                                      | undefined |
| reset_timeout( `duration` )      | Previous values TTL                                                                                                                                                                            | 3h        |
| group_by( `string` )             | Group the internal buffer by the value of this field, so that for every different value of it holds its own last value.                                                                        | undefined |
| strict( `boolean` )              | If `fields` are given, when strict is set to true, all values have to change in order for the node to let a data_point pass. This has no effect, when the number of `fields` is less than two. | true      |
 