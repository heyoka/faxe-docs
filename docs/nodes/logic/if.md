The if node
=====================

Simple if-then-else logic.

Almost everything you can do with this node, can also be done with an [eval](eval.md) node, using the [if function](../../dfs_script_language/built-in_functions.md#special-if-function).

Example
-------
```dfs  
|json_emitter()
.json(
      '{"address": "", "value": 99}',
      '{"address": "cond_scale", "value": 94}',
      '{"address": "cond_robot", "value": 95}'
      )
.as('data') 

|if(lambda: "data.address" == '')
.then('address is empty')
.else(lambda: str_concat('address is {{"data.address"}} and value is ', string("data.value")))
.as('data.note')

``` 

The if node adds a new field `data.note` with either the string 'address is empty' or, if the address is not empty,
a string with the address and the value of the field `data.value`.

If we would remove the `else` parameter in the example, every data-item for which the if test returns false, would not get the field
`data.note` added (and simply left untouched on emit).

Parameters
----------

| Parameter                 | Description                                                                         | Default   |
|---------------------------|-------------------------------------------------------------------------------------|-----------|
| _[node]_ test( `lambda` ) | if test lambda                                                                      |           |
| then( `any` )             | value when test evaluates as TRUE, any type including a lambda expression is valid  |           |
| else( `any` )             | value when test evaluates as FALSE, any type including a lambda expression is valid | undefined |
| as (`string`)             | field-path for the output value                                                     |           | 
 