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

If val is a list:

**String**

    string(list) -> string
*Converting a list into a string with `string` is equivalent to*

```dfs   
list_join(',', list_of_strings(List))
```

Converts every entry of List to a string first and then joins the resulting list with a comma.

```dfs   
[1,2,3] => ['1', '2', '3'] => '1,2,3'
```


### Time functions

Every data_point in faxe contains a field called **`ts`**, which holds a UTC timestamp in milliseconds.


| Function                                | Description                                                                                                        |
|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `now()` -> integer                      | returns an utc timestamp in milliseconds                                                                           |
| `dt_parse(ts, formatstring)` -> integer | used to parse a datetime string to the internal format, see [datetime-parsing](../datetime-parsing.md) for details |
| `to_iso8601(ts)` -> string              | converts the timestamp to an ISO8601 datetime string                                                               |
| `to_rfc3339(ts)` -> string              | converts the timestamp to an RFC3339 datetime string                                                               |
| `from_duration(ts)` -> integer          | converts a [duration](index.md#duration-literals) to it's millisecond equivalent                                   |
| `millisecond(ts)` -> integer            | milliseconds within the second [0, 999]                                                                            |
| `second(ts)` -> integer                 | second within the minute [0, 59]                                                                                   |
| `minute(ts)` -> integer                 | minute within the hour [0, 59]                                                                                     |
| `hour(ts)` -> integer                   | hour within the day [0, 23]                                                                                        |
| `day(ts)` -> integer                    | day within the month [1, 31]                                                                                       |
| `day_of_week(ts)` -> integer            | the weekday with week [1, 7] 1 is monday                                                                           |
| `week(ts)` -> integer                   | isoweek-number within year [1, 53]                                                                                 |
| `month(ts)` -> integer                  | month within the year [1, 12]                                                                                      |
| `time_align(ts, duration)` -> integer   | align the given timestamp to duration                                                                              |

Examples:
```dfs    
lambda: hour("ts") >= 8 AND hour("ts") < 19
```
The above expression evaluates to true if the hour of the day for the data point falls between 08:00 and 19:00.

--------------------------------------

```dfs    
lambda: time_align("ts", 3m)
```
Will align every timestamp (ts) to a multiple of the 3 minutes within an hour (ie: 00:00, 00:03, 00:06, ...)

### Math functions

| Function                             | Description                                |
|--------------------------------------|--------------------------------------------|
| `abs(x)` -> number                   |                                            |
| `acos(x)` -> float                   |                                            |
| `acosh(x)` -> float                  |                                            |
| `asin(x)` -> float                   |                                            |
| `asinh(x)` -> float                  |                                            |
| `atan(x)` -> float                   |                                            |
| `atan2(y, x)` -> float               |                                            |
| `atanh(x)` -> float                  |                                            |
| `ceil(x)` -> float                   |                                            |
| `cos(x)` -> float                    |                                            |
| `cosh(x)` -> float                   |                                            |
| `exp(x)` -> float                    |                                            |
| `floor(x)` -> float                  |                                            |
| `fmod(x, y)` -> float                |                                            |
| `log(x)` -> float                    |                                            |
| `log10(x)` -> float                  |                                            |
| `log2(x)` -> float                   |                                            |
| `max(x, y)` -> number                |                                            |
| `max(list)` -> number                |                                            |
| `min(x, y)` -> number                |                                            |
| `min(list)` -> number                |                                            |
| `pi() -> float`                      | gives pi                                   |
| `pow(x, y)` -> float                 |                                            |
| `round(x)` -> integer                | round a number to an integer               |
| `round_float(x, precision)` -> float | round a float (x) with the given precision |
| `sin(x)` -> float                    |                                            |
| `sinh(x)` -> float                   |                                            |
| `sqrt(x)` -> float                   |                                            |
| `tan(x)` -> float                    |                                            |
| `tanh(x)` -> float                   |                                            |

### String functions
String positions start with index 0.

| Function                                               | Description                                                                                                                                                                                  |
|--------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `str_at(x, pos)` -> string/undefined                   | Returns the grapheme in the position of the given utf8 string. If position is greater than string length, then it returns undefined. Negative offsets count back from the end of the string. |
| `str_capitalize(x)` -> string                          | Converts the first character in the given string to uppercase and the remaining to lowercase                                                                                                 |
| `str_contains(x, contents)` -> bool                    | Check if string contains any of the given contents                                                                                                                                           |
| `str_downcase(x)` -> string                            | Convert all characters on the given string to lowercase                                                                                                                                      |
| `str_enclose(Wrapper, StringOrList)` -> string or list | Prepend and append Wrapper to a string or each entry of a list of strings                                                                                                                    |
| `str_ends_with(x, suffix)` -> string                   | Returns true if string ends with suffix, otherwise false.                                                                                                                                    |
| `str_ends_with_any(x, suffixes)` -> string             | Returns true if string ends with any of the suffixes given, otherwise false.                                                                                                                 |
| `str_eqi(x,y)` -> bool                                 | Compares strings case insensitively                                                                                                                                                          |
| `str_first(x)` -> string/undefined                     | Returns the first grapheme from an utf8 string, undefined if the string is empty                                                                                                             |
| `str_last(x)` -> string/undefined                      | Returns the last grapheme from an utf8 string, undefined if the string is empty                                                                                                              |
| `str_length(x)` -> int                                 | Returns the number of unicode graphemes in an utf8 string                                                                                                                                    |
| `str_lstrip(x)` -> string                              | Returns a string where leading Unicode whitespace has been removed                                                                                                                           |
| `str_lstrip(x, char)` -> string                        | Returns a string where leading char have been removed                                                                                                                                        |
| str_pad_leading/2                                      |                                                                                                                                                                                              |
| str_pad_leading/3                                      |                                                                                                                                                                                              |
| str_pad_trailing/2                                     |                                                                                                                                                                                              |
| str_pad_trailing/3                                     |                                                                                                                                                                                              |
| `str_replace(x, patt, repl)` -> string                 | Returns a new string based on subject by replacing the parts matching pattern by replacement.                                                                                                |
| str_replace_leading/3                                  | Replaces all leading occurrences of match by replacement of match in string.                                                                                                                 |
| str_replace_trailing/3                                 | Replaces all trailing occurrences of match by replacement of match in string.                                                                                                                |
| `str_replace_prefix(x, match, repl)` -> string         | Replaces prefix in string by replacement if it matches match. Returns the string untouched if there is no match. If match is an empty string (""), replacement is just prepended to string.  |
| `str_replace_suffix(x, match, repl)` -> string         | Replaces suffix in string by replacement if it matches match. Returns the string untouched if there is no match. If match is an empty string (""), replacement is just appended to string.   |
| `str_reverse(x)` -> string                             | Reverses the given string.                                                                                                                                                                   |
| `str_rstrip(x)` -> string                              | Returns a string where trailing Unicode whitespace has been removed                                                                                                                          |
| `str_rstrip(x, char)` -> string                        | Returns a string where trailing char have been removed                                                                                                                                       |
| `str_slice(x, start, len)` -> string                   | Returns a substring starting at the offset given by the first, and a length given by the second param, if offset is negative, count back from end of string.                                 |
| str_split/1                                            |                                                                                                                                                                                              |
| str_split/2                                            |                                                                                                                                                                                              |
| str_split/3                                            |                                                                                                                                                                                              |
| str_split_at/2                                         |                                                                                                                                                                                              |
| str_split_by_any/2                                     |                                                                                                                                                                                              |
| str_split_by_any/3                                     |                                                                                                                                                                                              |
| str_split_by_re/2                                      |                                                                                                                                                                                              |
| str_split_by_re/3                                      |                                                                                                                                                                                              |
| `str_starts_with(x, pre)` -> bool                      | Returns true if string starts with Prefix                                                                                                                                                    |
| `str_starts_with_any(x, prefixes)` -> bool             | Returns true if string starts with any of the prefixes given, otherwise false.                                                                                                               |
| `str_strip(x)` -> string                               | Returns a string where leading/trailing Unicode whitespace has been removed                                                                                                                  |
| `str_strip(x, char)` -> string                         | Returns a string where leading/trailing char have been removed                                                                                                                               |
| `str_upcase(x)` -> string                              | Convert all characters on the given string to uppercase                                                                                                                                      |

### Lists and Maps (jsn)

| Function                                       | Description                                                                                                                                       | Example                                   |
|------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
| `from_json_string(String)` -> faxe map or list | convert a valid json string into faxe's internal data-structure                                                                                   | from_json_string('{"a":"b"}')             |
| `to_json_string(String)` -> string             | convert faxe's internal data-structure into a json string                                                                                         | to_json_string("data.struct")             |
| `size(ListOrMap)` -> integer                   | get the number of entries in a list or map                                                                                                        | size("data.lines")                        |
| `head(List)` -> any                            | returns the head, or the first element, of list List                                                                                              | head("data.lines")                        |
| `nth(Integer, List)` -> any                    | returns the nth element from list List                                                                                                            | nth(N, "data.lines")                      |
| `list_join(List)` -> any                       | equivalent to list_join(',', List)                                                                                                                | list_join("data.lines")                   |
| `list_join(Separator, List)` -> any            | join a list of strings with a separator string                                                                                                    | list_join('-', "data.lines")              |
| `list_of_strings(List)` -> any                 | convert every entry of a list to a string and return the list of strings                                                                          | list_of_strings("data.lines")             |
| `member(Ele, ListOrMap)` -> bool               | check for list/set membership of a value, or when used with a map, check if Ele is a key in the map                                               |                                           |
| `not_member(Ele, ListOrMap)` -> bool           |                                                                                                                                                   |                                           |
| `map_get(Key, Map)` -> any                     | get a value from a map, 'undefined' is returned, if the key is not present in map                                                                 | map_get("topic", ls_mem('stream_lookup')) |
| `select(Key, Jsn)` -> list                     | Select every value with the path `Key` from a json-array                                                                                          |                                           |
| `select(Key, Where, Jsn)` -> list              | Select every value with the path `Key` and conditions `Where` from a json-array. Elements that do not meet the given conditions are filtered out. |                                           |                                         
| `select_first(Key, Jsn)` -> any                | Select the first value with the path `Key` from a json-array.                                                                                     |                                           |                                         
| `select_first(Key, Where, Jsn)` -> any         | Select the first value with the path `Key` and conditions `Where` from a json-array.                                                              |                                           |                                         

####select
The Where parameter in select and select_first is a list of tuples.
```dfs    
lambda: select('key', [{'id', "data.id"}], jsn_array)
```

### Misc

| Function                                                    | Description                                                                                                          | Example                                  |
|-------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| `defined(Key)` -> bool                                      | whether the given Key is defined in the current data-item                                                            |                                          |
| `undefined(Key)` -> bool                                    | whether the given Key is NOT defined in the current data-item                                                        |                                          |
| `empty(Key)` -> bool                                        | whether the given Key points to an empty or not defined value, empty means an empty string or an empty list or tuple | empty("data.topic") -> false             |
| `topic_part(TopicString, PartIndex, [Seperator])` -> string | extract a part from a topic string, Separator defaults to '/', the index of the first part is `1` not 0              | topic_part('this/is/mytopic', 2) -> 'is' |
| `random(N)` -> integer                                      | generate a random integer between 1 and N                                                                            |                                          |
| `random_real(N)` -> float                                   | generate a random float between 0.0 and 1.0, that gets multiplied by N                                               |                                          |
| `crc32(String)` -> string                                   | Computes the crc32 (IEEE 802.3 style) checksum for the given string.                                                 |                                          |
| `phash(Any)` -> integer                                     | Portable hash function, that outputs an integer in the range 0..2^27-1                                               |                                          |
| `mem` values are set with the [mem node](../nodes/mem.md)   |                                                                                                                      |                                          |
| `ls_mem(Key)` -> any                                        | get the single value associated with Key from the flow-memory                                                        |                                          |
| `ls_mem_list(Key)` -> any                                   | get the list value associated with Key from the flow-memory                                                          |                                          |
| `ls_mem_set(Key)` -> any                                    | get the set value associated with Key from the flow-memory                                                           |                                          |

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
    
    
    
    
  



