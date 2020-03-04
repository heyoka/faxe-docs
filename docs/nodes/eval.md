The eval node
=====================

Evaluate one or more lambda expressions.
For an explanation of lambdas, see [lambda](../dfs_script_language/lambda_expressions.md).

The list of lambda expressions given, will be evaluated in a serial fashion.
This means that a lambda can use the result of a previous expression.


Examples
--------
```dfs  
|eval(lambda: "val" * 2, lambda: "double" / 2)
.as('double', 'val')
```

This example demonstrates the 'serial' behaviour of the `eval` node.
The second expression uses the field `double`, which the first expression just created.

```dfs 
|eval()
.lambdas(
    lambda: int(str_concat(string(int("val")),string(int("val"))))
)
.as('concat_string.int')
```

The above example uses several built in casting and string functions to demonstrate complex expressions.


For more lambda examples see [lambda](../dfs_script_language/lambda_expressions.md)


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
[node] lambdas( `lambda_list` )| list of lambda expressions |
as( `string_list` )| list of output fieldnames (must have the same length as `lambdas`)|
tags ( `string_list` )|list of output tagnames | []
