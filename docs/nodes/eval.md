The eval node
=====================

Evaluate one or more lambda expressions.
For an explanation of lambdas, see [lambda](../dfs_script_language/lambda_expressions.md).

The list of lambda expressions given, will be evaluated top down.
This means that a lambda can use the result of a previous expression.

The resulting fields named with the `as` parameter will be added to the current data-point.


Examples
--------
```dfs  
|eval(lambda: "val" * 2, lambda: "double" / 2)
%% 'double' is also used in the second expression above
.as('double', 'val')
```

This example demonstrates the 'serial' behaviour of the `eval` node.
The second expression uses the field `double`, which the first expression just created.

```dfs 
|eval( 
    lambda: int(str_concat(string(int("val")),string(int("val"))))
)
.as('concat_string.int')
```
The string value of the field 'val' is concatenated to itself, this is then casted to an int value and 
added to the current data-point as the field 'concat_string.int'. 


For more lambda examples see [lambda](../dfs_script_language/lambda_expressions.md)


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
_[node]_ lambdas( `lambda_list` )| list of lambda expressions |
as( `string_list` )| list of output fieldnames (must have the same length as `lambdas`)|
tags ( `string_list` )|list of output tagnames | []
