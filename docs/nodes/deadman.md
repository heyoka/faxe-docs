The deadman node
=====================

Emits a point, if there is no point coming in for the given amount of time.
For output there are two options:

* If repeat_last param if set, the node will output the last message it saw incoming as the dead-message,
if there is no last message yet, an empty message will be emitted
* Multiple field and field_value can be provided to be included in the output
* If no fields (and field_values) parameter and is given, an empty datapoint will be emitted
* The repeat_last parameter will always override the fields and field_values parameter
* The node will forward every message it gets by default, this can be changed by using the no_forward flag

Example
-------
```dfs   
 
|deadman(15s)
 
```

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
[node] lambdas( `lambda_list` )|  list of lambda expressions |
values( `string_list\|text_list` )| corresponding values |
json( `is_set` ) | if set, will treat the `values` and `default` parameters as json strings| false, not set
as (`string`) | field-path for the output value|
default(`any`) | default value to use, if no case clause matches| 
 