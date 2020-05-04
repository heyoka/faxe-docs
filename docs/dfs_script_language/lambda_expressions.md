# Lambda expressions

## Overview

DFS uses lambda expressions to define transformations on data points as well as define Boolean conditions that act as filters. 
Lambda expressions wrap mathematical operations, Boolean operations, internal function calls or a combination of all three.  

All lambda expressions in DFS begin with the `lambda:` keyword.
```dfs
|where(lambda: "topic" == 'ttop/grap/prec')
```
In the above example `"topic"` is used to access the value of a field called `topic` 
from the current data_point and compared against the string `'ttop/grap/prec'`.
Note here that literal string values are declared using single quotes, 
while double quotes are used only in lambda expressions to access the values of tags and fields.

## !
As field and tag values can be deeply nested maps and lists, it is possible to use a `JSON-path` like syntax
to reference them:

Valid examples:

    "averages"
    "axis.z.cur"
    "value.sub[2].data"
    "averages.emitted[5]"

------------------------------------------------------------------------

## Built-in functions

### Type conversion
With a few exceptions every type can be converted to every other type.

**Bool**

    bool(a_value) -> true|false
    
**Integer**

    int(value) -> integer
    
**Float**

    float(value) -> float
    
**String**

    string(val) -> string
    
### Time functions

Every data_point in faxe contains a field called **`ts`** .


Function                         | Description
---------------------------------|--------------------------------------------
`now()` -> integer | returns a utc timestamp in milliseconds
`to_iso8601(ts)` -> string | converts the timestamp to an ISO8601 string
`millisecond(ts)` -> integer         | milliseconds within the second [0, 999]
`second(ts)` -> integer            | second within the minute [0, 59]
`minute(ts)` -> integer           | minute within the hour [0, 59]
`hour(ts)` -> integer             | hour within the day [0, 23]
`day(ts)` -> integer              | day within the month [1, 31]
`day_of_week(ts)` -> integer      | the weekday with week [1, 7] 1 is monday
`week(ts)` -> integer               | isoweek-number within year [1, 53]
`month(ts)` -> integer            | month within the year [1, 12]

Example:
```dfs    
lambda: hour("ts") >= 8 AND hour("ts") < 19
```
The above expression evaluates to true if the hour of the day for the data point falls between 08:00 and 19:00.


### Math functions

Function                    | Description
----------------------------|------------
`abs(x)` -> number|
`acos(x)` -> float |
`acosh(x)` -> float|
`asin(x)` -> float|
`asinh(x)` -> float|
`atan(x)` -> float|
`atan2(y, x)` -> float|
`atanh(x)` -> float|
`ceil(x)` -> float|
`cos(x)` -> float|
`cosh(x)` -> float|
`exp(x)` -> float|
`floor(x)` -> float|
`fmod(x, y)` -> float|
`log(x)` -> float|
`log10(x)` -> float|
`log2(x)` -> float|
`max(x, y)` -> number|
`min(x, y)` -> number|
`pow(x, y)` -> float|
`round(x)` -> integer| round a number to an integer
`round_float(x, precision)` -> float| round a float (x) with the given precision
`sin(x)` -> float|
`sinh(x)` -> float|
`sqrt(x)` -> float|
`tan(x)` -> float|
`tanh(x)` -> float|


### String functions

Function                    | Description
----------------------------|------------
str_at/2 |
str_capitalize/1|
str_chunk/2|
str_codepoints/1|
str_contains/2|
str_downcase/1|
str_ends_with/2|
str_ends_with_any/2|
str_eqi/2|
str_first/1|
str_last/1|
str_length/1|
str_lstrip/1|
str_lstrip/2|
str_next_codepoint/1|
str_normalize/2|
str_pad_leading/2|
str_pad_leading/3|
str_pad_trailing/2|
str_pad_trailing/3|
str_replace/3|
str_replace_leading/3|
str_replace_prefix/3|
str_replace_suffix/3|
str_replace_trailing/3|
str_reverse/1|
str_rstrip/1|
str_rstrip/2|
str_slice/3|
str_split/1|
str_split/2|
str_split/3|
str_split_at/2|
str_split_by_any/2|
str_split_by_any/3|
str_split_by_re/2|
str_split_by_re/3|
str_starts_with/2|
str_starts_with_any/2|
str_strip/1|
str_strip/2|
str_upcase/1|

### Misc

Function | Description
---------| -----------
`defined(Key)` -> bool | whether the given Key is defined in the current data-item
`undefined(Key)` -> bool | whether the given Key is NOT defined in the current data-item
`member(Ele, List)` -> bool | check for list/set membership
`not_member(Ele, List)` -> bool | 
`random(N)` -> integer   | generate a random integer between 1 and N
`random_real(N)` -> float | generate a random float between 0.0 and 1.0, that gets multiplied by N
`ls_mem(Key)` -> any| get the single value associated with Key from the flow-memory
`ls_mem_list(Key)` -> any|get the list value associated with Key from the flow-memory
`ls_mem_set()` -> any|get the set value associated with Key from the flow-memory


### Conditional functions

**If**

Returns the result of its operands depending on the value of the first argument. 
The second and third arguments must return the same type.

Example:
```dfs  
|eval(lambda: if("field.val1" > threshold AND "field.val1" != 0, 'true', 'false'))
.as('value')
```
The value of the field `value` in the above example will be the string `true` or `false`, 
depending on the condition passed as the first argument.

The if function’s return type is the same type as its second and third arguments.

    if(condition, true expression, false expression)
    
    
    
    
  



