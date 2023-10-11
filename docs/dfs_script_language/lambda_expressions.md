# Lambda expressions

> In version 1.2.0, lambda expressions have been completely rewritten and are now fully compiled erlang code and thus much faster than before.

## Overview

DFS uses lambda expressions to define transformations on data points as well as define Boolean conditions that act as filters. 
Lambda expressions wrap mathematical operations, Boolean operations, internal function calls or a combination of all three.  

All lambda expressions in DFS begin with the `lambda:` keyword.
```dfs
|where(lambda: "topic" == 'ttop/grap/prec')
```
In the above example `"topic"` is used to access the value of a field called `topic` 
from the current data_point and compared against the string `'ttop/grap/prec'`.

> Note here that literal string values are declared using single quotes, 
while double quotes are used to access the values of tags and fields within the current data_item.

## Field paths
> As field and tag values can be deeply nested maps and lists, it is possible to use a `JSON-path` like syntax
to reference them:

Valid examples:

    "averages"
    
    "axis.z.cur"
    
    "value.sub[2].data"
    
    "averages.emitted[5]"

------------------------------------------------------------------------

## Built-in functions

Faxe features a lot of built-in functions, that can be used in lambda and script expressions.

See [here](built-in_functions.md) for a full list of them.

### Special if function

**If**

In DFS `if` is not a language construct, but a function with 3 parameters.
The if function’s return type is the same type as its second and third arguments.
 
```dfs
if(condition, true expression, false expression)
```

Returns the result of its operands depending on the value of the first argument.  

Examples:
```dfs  
|eval(lambda: if("field.val1" > threshold AND "field.val1" != 0, 'true', 'false'))
.as('value')
```
The value of the field `value` in the above example will be the string `true` or `false`, 
depending on the condition passed as the first argument.

```dfs  
|eval(lambda: if(is_float("data.duration_ms"), trunc("data.duration_ms" * 1000), "data.duration_ms"))
.as('value')
```
Both expressions (2nd and 3rd parameter) may also be arbitrarily complex.
In this example, if the condition returns true, `data.duration_ms` will be mulitplied be 1000 and then truncated to an integer.
If the condition returns false, just the value of `data.duration_ms` will be returned.

    
    
    
    
  



