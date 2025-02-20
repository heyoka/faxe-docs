The multi_map node
=====================

Maps fields from a json lookup table with data from the current data_item.
This node can basically do what multiple [select_first](../../dfs_script_language/built-in_functions.md#select-select_first-select_any) expression can do:

Example
-------

```dfs  

def variables = '[{"mod_num":4233, "alarm_name": "E1_failed", "alarm_text": "Error", "type": "E1"}, ...]'

|multi_map()
.fields('module', 'alarm')                    
.match_fields('mod_num', 'alarm_name')        % Match these fields from the look-up table 
.select_fields('alarm_text', 'type')    
.lookup(variables)                                  

% is equivalent to:

|eval(
    lambda: select_first('alarm_text', [{'mod_num', "module"}, {'alarm_name', "alarm"}], variables),
    lambda: select_first('type', [{'mod_num', "module"}, {'alarm_name', "alarm"}], variables)
)
.as('alarm_text', 'type')
```

Here we match 'module_number' and 'alarm_name' in the lookup table against the values of the data_point fields 'module' and
'alarm'. 
From the resulting object we select two fields 'alarm_text', 'alarm_type' and add the to them data_point.


Parameters
----------

| Parameter                      | Description                                                                                                     | Default   |
|--------------------------------|-----------------------------------------------------------------------------------------------------------------|-----------|
| fields( `string_list` )        | list of fieldnames from the current data_point to match data in the lookup table                                |           |
| match_fields( `string_list` )  | list of fields in the lookup table to match the values of `fields`                                              |           |
| select_fields( `string_list` ) | select this fields from the lookup for output                                                                   |           |
| lookup( `string` )             | json object list in string format                                                                               |           |
| as( `string_list`)             | list of new field names for the selected fields, if given, must have the same count of names as `select_fields` | undefined |
