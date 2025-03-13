A complete list of currently supported functions.

> These function can be used in lambda and script expressions

### Type conversion
With a few exceptions every type can be converted to every other type.

**Bool**

    bool(a_value) -> true|false

**Integer**

    int(value) -> integer

If value is a float, then int(value) is equivalent to  `trunc(value)`

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


### Type checks

| Function                    |     |                                                                                           
|-----------------------------|-----|
| `is_string(Data)` -> bool   |     |
| `is_integer(Data)` -> bool  |     |
| `is_int(Data)` -> bool      |     |
| `is_float(Data)` -> bool    |     |
| `is_number(Data)` -> bool   |     |
| `is_list(Data)` -> bool     |     |
| `is_duration(Data)` -> bool |     |
| `is_boolean(Data)` -> bool  |     |
| `is_bool(Data)` -> bool     |     |


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
| `trunc(x)` -> integer                | Returns an integer by truncating a number  |
| `sin(x)` -> float                    |                                            |
| `sinh(x)` -> float                   |                                            |
| `sqrt(x)` -> float                   |                                            |
| `tan(x)` -> float                    |                                            |
| `tanh(x)` -> float                   |                                            |

### String functions
String positions start with index 0.

| Function                                                   | Description                                                                                                                                                                                                                                                                                                                     |
|------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `str_at(x, pos)` -> string/undefined                       | Returns the grapheme in the position of the given utf8 string. If position is greater than string length, then it returns undefined. Negative offsets count back from the end of the string.                                                                                                                                    |
| `str_capitalize(x)` -> string                              | Converts the first character in the given string to uppercase and the remaining to lowercase                                                                                                                                                                                                                                    |
| `str_concat(string1, string2)` -> string                   | Concatenate 2 strings.                                                                                                                                                                                                                                                                                                          |
| `str_concat([string1, string2, ...])` -> string            | Concatenate a list of strings.                                                                                                                                                                                                                                                                                                  |
| `str_contains(x, contents)` -> bool                        | Check if string contains any of the given contents                                                                                                                                                                                                                                                                              |
| `str_downcase(x)` -> string                                | Convert all characters on the given string to lowercase                                                                                                                                                                                                                                                                         |
| `str_enclose(Wrapper, StringOrList)` -> string or list     | Prepend and append Wrapper to a string or each entry of a list of strings                                                                                                                                                                                                                                                       |
| `str_ends_with(x, suffix)` -> string                       | Returns true if string ends with suffix, otherwise false.                                                                                                                                                                                                                                                                       |
| `str_ends_with_any(x, suffixes)` -> string                 | Returns true if string ends with any of the suffixes given, otherwise false.                                                                                                                                                                                                                                                    |
| `str_eqi(x,y)` -> bool                                     | Compares strings case insensitively                                                                                                                                                                                                                                                                                             |
| `str_find(string, pattern)` -> string/undefined            | Removes anything before `pattern` in `string` and returns the remainder of the string or undefined if pattern is not found. Same as str_find(string, pattern, 'leading').                                                                                                                                                       |
| `str_find(string, pattern, dir)` -> string/undefined       | Like str_find/2, but `dir`, which can be 'leading' or 'trailing', indicates from which direction characters are to be searched.                                                                                                                                                                                                 |
| `str_first(x)` -> string/undefined                         | Returns the first grapheme from an utf8 string, undefined if the string is empty                                                                                                                                                                                                                                                |
| `str_last(x)` -> string/undefined                          | Returns the last grapheme from an utf8 string, undefined if the string is empty                                                                                                                                                                                                                                                 |
| `str_length(x)` -> int                                     | Returns the number of unicode graphemes in an utf8 string                                                                                                                                                                                                                                                                       |
| `str_lstrip(x)` -> string                                  | Returns a string where leading Unicode whitespace has been removed                                                                                                                                                                                                                                                              |
| `str_lstrip(string, char::int)` -> string                  | Returns a string where leading char have been removed ('char' number of leading chars)                                                                                                                                                                                                                                          |
| str_pad_leading/2                                          |                                                                                                                                                                                                                                                                                                                                 |
| str_pad_leading/3                                          |                                                                                                                                                                                                                                                                                                                                 |
| str_pad_trailing/2                                         |                                                                                                                                                                                                                                                                                                                                 |
| str_pad_trailing/3                                         |                                                                                                                                                                                                                                                                                                                                 |
| `str_quote(string)` -> string                              | Enclose a string with double quotes.                                                                                                                                                                                                                                                                                            |
| `str_replace(x, patt, repl)` -> string                     | Returns a new string based on subject by replacing the parts matching pattern by replacement. Both `pattern` and `replace` may be of type string or list.                                                                                                                                                                       |
| str_replace_leading/3                                      | Replaces all leading occurrences of match by replacement of match in string.                                                                                                                                                                                                                                                    |
| str_replace_trailing/3                                     | Replaces all trailing occurrences of match by replacement of match in string.                                                                                                                                                                                                                                                   |
| `str_replace_prefix(x, match, repl)` -> string             | Replaces prefix in string by replacement if it matches match. Returns the string untouched if there is no match. If match is an empty string (""), replacement is just prepended to string.                                                                                                                                     |
| `str_replace_suffix(x, match, repl)` -> string             | Replaces suffix in string by replacement if it matches match. Returns the string untouched if there is no match. If match is an empty string (""), replacement is just appended to string.                                                                                                                                      |
| `str_reverse(x)` -> string                                 | Reverses the given string.                                                                                                                                                                                                                                                                                                      |
| `str_rstrip(x)` -> string                                  | Returns a string where trailing Unicode whitespace has been removed                                                                                                                                                                                                                                                             |
| `str_rstrip(x, char)` -> string                            | Returns a string where trailing char have been removed                                                                                                                                                                                                                                                                          |
| `str_slice(x, start, len)` -> string                       | Returns a substring starting at the offset given by the first, and a length given by the second param, if offset is negative, count back from end of string.                                                                                                                                                                    |
| `str_slice(x, start)` -> string                            | Returns a substring starting at the offset given by start.                                                                                                                                                                                                                                                                      |
| str_split/1                                                |                                                                                                                                                                                                                                                                                                                                 |
| str_split/2                                                |                                                                                                                                                                                                                                                                                                                                 |
| str_split/3                                                |                                                                                                                                                                                                                                                                                                                                 |
| str_split_at/2                                             |                                                                                                                                                                                                                                                                                                                                 |
| str_split_by_any/2                                         |                                                                                                                                                                                                                                                                                                                                 |
| str_split_by_any/3                                         |                                                                                                                                                                                                                                                                                                                                 |
| str_split_by_re/2                                          |                                                                                                                                                                                                                                                                                                                                 |
| str_split_by_re/3                                          |                                                                                                                                                                                                                                                                                                                                 |
| `str_starts_with(x, pre)` -> bool                          | Returns true if string starts with Prefix                                                                                                                                                                                                                                                                                       |
| `str_starts_with_any(x, prefixes)` -> bool                 | Returns true if string starts with any of the prefixes given, otherwise false.                                                                                                                                                                                                                                                  |
| `str_strip(x)` -> string                                   | Returns a string where leading/trailing Unicode whitespace has been removed                                                                                                                                                                                                                                                     |
| `str_strip(x, char)` -> string                             | Returns a string where leading/trailing char have been removed                                                                                                                                                                                                                                                                  |
| `str_upcase(x)` -> string                                  | Convert all characters on the given string to uppercase                                                                                                                                                                                                                                                                         |
| `str_repeat_replace(string, pattern, replaceList)` -> list | Given a string, a pattern and a list of strings, produces a new list of strings by `duplicating` string `length(replaceList)` times, while replacing every occurance of `pattern` with the corresponding entry from `replaceList`. <br> If `pattern` is not found in `string`, it will be left untouched and simply duplicated. |


### Lists


| Function                                        | Description                                                                                                                                                                                                        | Example                                                              |
|-------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| `head(List)` -> any                             | Returns the head, or the first element, of list List.                                                                                                                                                              | `head("data.lines")`                                                 |
| `nth(Integer, List)` -> any                     | Returns the nth element from list List, list indices start with 1.                                                                                                                                                 | `nth(N, "data.lines")`                                               |
| `nthtail(Integer, List)` -> any                 | Returns the Nth tail of List, that is, the sublist of List starting at N+1 and continuing up to the end of the list.                                                                                               | `nthtail(N, "data.lines")`                                           |
| `list_append(List1, List2)` -> list             | Returns a new list, which is made from the elements of List1 followed by the elements of List2.                                                                                                                    | `list_append(['a', 'b', 'c'], [1, 2, 4])`                            |
| `list_delete(Elem, List)` -> list               | Returns a copy of List, where the first element matching Elem is deleted, if there is such an element.                                                                                                             | `list_delete(2, [1, 2, 4]) -> [1, 4]  `                              |
| `list_last(List)` -> any                        | Returns the last element from List.                                                                                                                                                                                |                                                                      |
| `list_max(List)` -> any                         | Returns the first element of List that compares greater than or equal to all other elements of List.                                                                                                               | `list_max([1, 2, 4]) -> 4`                                           |
| `list_min(List)` -> any                         | Returns the first element of List that compares less than or equal to all other elements of List.                                                                                                                  | `list_min([1, 2, 4]) -> 1`                                           |
| `list_reverse(List)` -> list                    | Returns a list with the elements in List1 in reverse order.                                                                                                                                                        | `list_reverse([1, 2, 4]) -> [4, 2, 1] `                              |
| `list_sort(List)` -> list                       | Returns a list containing the sorted elements of List1.                                                                                                                                                            | `list_sort([4, 5, 1, 2, 4]) -> [1, 2, 4, 4, 5] `                     |
| `list_subtract(List1, List2)` -> list           | Returns a new list List3 that is a copy of List1, subjected to the following procedure:for each element in List2, its first occurrence in List1 is deleted.                                                        |                                                                      |
| `list_sum(List)` -> number                      | Returns the sum of the elements in List.                                                                                                                                                                           |                                                                      |
| `list_unique(List)` -> list                     | Returns a new list with only unique values from List.                                                                                                                                                              | `list_unique("data.lines")`                                          |
| `list_usort(List)` -> list                      | Returns a list containing the sorted elements of List1 where all except the first element of the elements comparing equal have been deleted.                                                                       |                                                                      |
| `list_join(List)` -> string                     | Equivalent to list_join(',', List).                                                                                                                                                                                | `list_join("data.lines")`                                            |
| `list_join(Separator, List)` -> string          | Join a list of strings with a separator string.                                                                                                                                                                    | `list_join('-', "data.lines")`                                       |
| `list_of_strings(List)` -> list                 | Convert every entry of a list to a string and return the list of strings.                                                                                                                                          | `list_of_strings("data.lines")`                                      |
| `list_string_prefix(List, Prefix)` -> list      | Prefix the elements of a list of strings with a given string.                                                                                                                                                      | `list_string_prefix(['v1', 'v2'], 'mod_') -> ['mod_v1', 'mod_v2']`   |
| `list_string_postfix(List, Postfix)` -> list    | Postfix the elements of a list of strings with a given string.                                                                                                                                                     | `list_string_postfix(['v1', 'v2'], '_dfe') -> ['v1_dfe', 'v2_dfe']`  |
| `list_string_concat(List1, List2)` -> list      | Concatenate the string representation of the elements of 2 lists, the resulting list is as long as the shorter of the two lists.                                                                                   | `list_string_concat(['v1', 'v2'], ['k1', 'k2']) -> ['v1k1', 'v2k2']` |
| `list_string_concat(List1, List2, Sep)` -> list | Concatenate the string representation of the elements of 2 lists, the resulting list is as long as the shorter of the two lists. The given separator string will be place in between each of the pairs of strings. |                                                                      |
| `sublist(List, Len))` -> list                   | Returns the sublist of List1 starting at position 1 and with (maximum) Len elements.  It is not an error for Len to exceed the length of the list, in that case the whole list is returned.                        |                                                                      |
| `sublist(List, Start, Len))` -> list            | Returns the sublist of List1 starting at Start and with (maximum) Len elements. It is not an error for Start+Len to exceed the length of the list.                                                                 |                                                                      |


### Lists and Maps (jsn)

Functions marked with a star (*), can work directly on json strings representing lists or objects (maps in faxe).
For example, you can feed a json object string to `map_get` to get a value out of the json object: 
```dfs
def json_map = '{"key1": "value1", "key2": "value2"}'

def key1_val = e:map_get('key1', json_map)
%% 'value1'
 
```


To use a json string in other functions listed here, you have to convert them to faxe's internal format first, using
`from_json_string`:

```dfs
def json_map = '{"key1": "value1", "key2": "value2", "key3": "value3"}'
%% first convert to faxe's internal format
def internal_map = e: from_json_string(json_map)
def has_key3 = e:member('key3', internal_map)
%% true   
```



| Function                                        | Description                                                                                                                                                                                        | Example                                                    |
|-------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| *`from_json_string(String)` -> faxe map or list | Convert a valid json string into faxe's internal data-structure.                                                                                                                                   | from_json_string('{"a":"b"}')                              |
| `to_json_string(String)` -> string              | Convert faxe's internal data-structure into a json string.                                                                                                                                         | to_json_string("data.struct")                              |
| `size(ListOrMap)` -> integer                    | Get the number of entries in a list or map.                                                                                                                                                        | size("data.lines")                                         |
| `member(Ele, ListOrMap)` -> bool                | Check for list/set membership of a value, or when used with a map, check if Ele is a key in the map.                                                                                               |                                                            |
| `not_member(Ele, ListOrMap)` -> bool            |                                                                                                                                                                                                    |                                                            |
| *`map_get(Key, Map)` -> any                     | Get a value from a map, equivalent to `map_get(Key, Map, 'undefined')`.                                                                                                                            | map_get("topic", '{"data/temp/val1": "temp"}')             |
| *`map_get(Key, Map, Default)` -> any            | Get a value from a map, `Default` is returned, if the key is not present in map.                                                                                                                   | map_get("topic", '{"data/temp/val1": "temp"}', 'no_match') |
| *`select(Key, Jsn)` -> list                     | Select every value with the path `Key` from a json-array.                                                                                                                                          | See description below.                                     |
| *`select(Key, Where, Jsn)` -> list              | Select every value with the path `Key` and conditions `Where` from a json-array. Elements that do not meet the given conditions are filtered out.                                                  | See description below.                                     |                                         
| *`select_all(Key, Where, Jsn)` -> list          | Select every value with the path `Key` and conditions `Where` from a json-array. The list of `Where` conditions are `OR`ed in this case, so there is a select operation for every entry in `Where` | See description below.                                     |                                         
| *`select_first(Key, Jsn)` -> any                | Select the first value with the path `Key` from a json-array.                                                                                                                                      | See description below.                                     |                                         
| *`select_first(Key, Where, Jsn)` -> any         | Select the first value with the path `Key` and conditions `Where` from a json-array.                                                                                                               | See description below.                                     |                                         
| *`select_any(Key, Where, Jsn)` -> any           | Select the first value with the path `Key` that is found with any of the `Where` conditions from a json-array.                                                                                     | See description below.                                     |                                         

#### select, select_first, select_any
With these functions we can select values from a json-array like datastructure, meaning an array of - possibly nested - json objects.
```dfs    
def fruits =
'[
  {"color":  "orange", "name": "orange", "peel":  true}, 
  {"color":  "orange", "name": "mandarin", "peel":  true}, 
  {"color":  "orange", "name": "peach", "peel":  false},
  {"color":  "orange", "name": "navel-orange", "peel":  true},
  {"color":  "yellow", "name": "lemon", "peel":  true}
]'
```


The Where parameter in select functions is a list of tuples.
```dfs    
e: select('name', [{'peel', true}], fruits)

e: select_first('name', [{'color', 'orange'}, {'peel', false}], fruits)
```

The first example above would select the names of all fruits, that have a 'peel' value of true: 
`['orange', 'mandarin', 'navel-orange', 'lemon']`.
The second example selects the first name with 'color' `orange` and the 'peel' value `false`: `'peach'`.



Besides an exact match in the Where parameters, we can also use a regular expression:

```dfs     
e: select('name', [{'regex', 'name', 'orange$'}], fruits)
```
Results in `['orange', 'navel-orange']`.



### Misc

| Function                                                    | Description                                                                                                                                     | Example                                          |
|-------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| `defined(Key::string)` -> bool                              | whether the given Key is defined in the current data-item                                                                                       |                                                  |
| `undefined(Key::string)` -> bool                            | whether the given Key is NOT defined in the current data-item                                                                                   |                                                  |
| `empty(Key::string)` -> bool                                | whether the given Key points to an empty or not defined value, empty means an empty string or an empty list or tuple                            | empty("data.topic") -> false                     |
| `topic_part(TopicString, PartIndex, [Seperator])` -> string | extract a part from a topic string, Separator defaults to '/', the index of the first part is `1` not 0                                         | topic_part('this/is/mytopic', 2) -> 'is'         |
| `random(N::int)` -> integer                                 | generate a random integer uniformly distributed between 1 and N, N > 0                                                                          |                                                  |
| `random(N::int, M::int)` -> integer                         | generate a random integer uniformly distributed between N and M, N > 0 and M > N                                                                |                                                  |
| `random_real(N)` -> float                                   | generate a random float between 0.0 and 1.0, that gets multiplied by N                                                                          |                                                  |
| `random_normal()` -> float                                  | generate a standard normal deviate float (that is, the mean is 0 and the standard deviation is 1)                                               |                                                  |
| `random_latin_string(Length)` -> string                     | Returns a random string of size Length, consisting of latins `[a-zA-Z]` and digits `[0-9]`.                                                     |                                                  |
| `base64_encode(String)` -> string                           | Encode a string to base64 format.                                                                                                               |                                                  |
| `base64_decode(String)` -> string                           | Decode a base64 encoded string.                                                                                                                 |                                                  |
| `crc32(String)` -> string                                   | Computes the crc32 (IEEE 802.3 style) checksum for the given string.                                                                            |                                                  |
| `phash(Any)` -> integer                                     | Portable hash function, that outputs an integer in the range 0..2^27-1                                                                          |                                                  |
| `uuidv4()` -> string                                        | Get a strong v4 UUID string (using crypto/openssl)                                                                                              |                                                  |
| `env(Key::string)` -> string \| false                       | Get the value from an OS-ENV variable, if not found, returns `false`. Note that the value returned (except false) is always as string.          | env('FAXE_MQTT_HOST') -> '127.0.0.1'             |
| `env(Key::string, Default)` -> string \| any                | Get the value from an OS-ENV variable, if not found, returns `Default`. Note that the value returned (except Default) is always as string.      | env('FAXE_MQTT_HOS', '127.0.0.1') -> '127.0.0.1' |
| `envs()` -> map                                             | Get a map of all OS-ENV variables. All keys and values are strings.                                                                             |                                                  |
| `mem` values are set with the [mem node](../nodes/mem.md)   |                                                                                                                                                 |                                                  |
| `ls_mem(Key)` -> any                                        | get the single value associated with Key from the flow-memory                                                                                   |                                                  |
| `ls_mem_list(Key)` -> any                                   | get the list value associated with Key from the flow-memory                                                                                     |                                                  |
| `ls_mem_set(Key)` -> any                                    | get the set value associated with Key from the flow-memory                                                                                      |                                                  |
| `build_plc_addresses(Jsn)` -> list                          | Given jsn list with PLC address information, builds address strings, that can be used for the [s7read](../nodes/data_collection/s7read.md) node |                                                  |
| `build_plc_addresses(Jsn, FieldName::string)` -> list       | Injects the results of building the addresses back into the given JsnList and returns the updated List                                          |                                                  |

### build_plc_addresses(Jsn) -> list 

Jsn is a list of objects containing plc address information in one of two formats:

* `{"bit": 2, "byte": 7, "db": 2077.0, "offset": 324}` results in a BOOL address: `DB2077.DBX342.2` (byte-1 + 12<const offset>)
* `{"offset": 36.0, "db": 11245.0, "var_type": "DINT" [, "var_len":1]}` results in `DB11245.DBDINT36` (`var_len` is only used, when `var_type` is "STRING")

| var_type |                 |
|----------|-----------------|
| BOOL     |                 | 
| UINT     |                 |
| UDINT    |                 | 
| WORD     |                 | 
| DWORD    |                 | 
| TIME     |                 | 
| CHAR     |                 | 
| BYTE     |                 | 
| REAL     |                 |
| DATETIME |                 |
| STRING   | needs `var_len` |

If the function sees any other format or a field missing, it will fail.

----------------------------------------------------------------

### Conditional functions

## Special if function

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
