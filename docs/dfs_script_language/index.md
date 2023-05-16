# Introducing the DFS Script Language


Faxe  uses a Domain Specific Language(DSL) named **dfs** (Dataflow Scripting Language) to define dataflow tasks 
involving the extraction, collection, transformation and loading and writing of data and involving, moreover, 
the tracking of arbitrary changes and the detection of events within data. 

Dfs is heavily influenced by InfluxData's [TICKScript](https://docs.influxdata.com/kapacitor/v1.5/tick/introduction/).

Dfs is used in .dfs files or via API to define pipelines and graphs for processing data. 
The Dfs language is designed to chain together the invocation of data processing operations defined in nodes.

At the heart of its's engine, faxe will run an acyclic graph of computing nodes. 
Every node runs in its own erlang process.

## DFS Definitions 

### Keywords 

| Word    | Usage                                                        |
|---------|--------------------------------------------------------------|
| true    | boolean true                                                 |
| false   | boolean false                                                |
| TRUE    | boolean true                                                 |
| FALSE   | boolean false                                                |
| lambda: | used to denote [lambda expression](./lambda_expressions.md)  |
| e:      | used to denote [script expressions](./script_expressions.md) |
| def     | starts a variable declaration                                |

### Operators 

| Operator | Usage                   |
|----------|-------------------------|
| +        | addition operator       |
| -        | substraction operator   |
| /        | division operator       |
| *        | multiplication operator |
| AND      | and                     |
| OR       | or                      |
| <        | less than               |
| >        | greater than            |
| =<       | less than or equal      |
| <=       | less than or equal      |
| =>       | greater or equal        |
| >=       | greater or equal        |
| ==       | equal                   |
| !=       | Not equal               |
| /=       | Not equal               |
| !        | Logical Not             |
| rem      | remainder               |
| div      | integer division        |

These operators are mainly used in Lambda expressions.

### Chaining operators 

| Operator | Usage                                                                                                          | Example                                                                        
|---------|----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| `| `                                                                                                              | Used to declare a new node instance and chains it to the node above it (if any) | `|some_node() |debug()` |
| `|| `                                                                                                              | Used to reference a macro script| `||some_macro().some_param(3)` |
| `.`       | Declares a property (or parameter) call, setting or changing an internal param in the node to which it belongs | `                                                                              |log() .file('log1.txt')` |
| `@`       | Declares a [user defined node written in python](../custom_nodes.md). Same as `                                | `, but for user defined nodes | `|some_node() ... @mynode()` |
 

## Variables and literals 

Variables are declared using the keyword `def` at the start of a declaration. 
Variables are immutable and cannot be reassigned new values later on in the script, 
though they can be used in other declarations and can be passed into functions, property calls and text-templates.
  
### Variable declarations

```dfs
    def string = 'this is a string !'
    def text = ' this is a text with some weird chars :// %& '
    %% escape single quotes in strings with a second single quote:
    def string_with_single quotes = 'my string has ''single quotes'' in it'
    def func = lambda: "value" / 3
    def expr = e: str_replace(string, ' ', '_')
    def meas = 4.44
    % A lambda expression as literal
    def func2 = lambda: int(meas / 13)
    def an_int = 32342
    def a_float = 2131.342
    
    % a chain can also be bound to a declaration
    def in1 =
        |mqtt_subscribe()
        .host('127.0.0.1')
        .topic('some/topic')
    % it can then be used like so
    in1
        |debug()
```

### Datatypes


DFS recognizes a view basic data types, the type of the literal will be interpreted from its declaration.

| Type name | Description                                                                                                                                                              | Examples                                                                               |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| string    | String/text type. Single quotes are used for strings, strings can also be multiline.<br />To use single quotes in your string, simple use 2 single quotes (since 0.19.0) | 'this_is_a_string' <br /> _since 0.19.0_: 'SELECT MEAN(obj[''current'']) FROM mytable' |
| integer   | Integer type. Arbitrarily big ints are allowed                                                                                                                           | 123456789987654321, 55                                                                 |
| float     | Floating point number. May be arbitrarily big                                                                                                                            | 12.343422023, 5.6                                                                      |
| double    | Same as float                                                                                                                                                            | 12.343422023, 5.6                                                                      |
| duration  | A duration literal. See section below.                                                                                                                                   | 34s, 500ms, 2d                                                                         |
| lambda    | A lambda expression. See [extra section](lambda_expressions.md) in this documentation.                                                                                   | lambda: str_downcase('BIG')                                                            |
| list      | A list of above simple types.                                                                                                                                            | ['a', 'b'] [1, 456,  4536]                                                             |

#### Json strings
A bunch of faxe's [built-in lambda functions](built-in_functions.md#lists-and-maps-jsn) and some nodes ([json_emitter](../nodes/debug/json_emitter.md) for example) can directly work with json strings, in faxe, we
call them `jsn`.

### Duration literals 

Duration literals define a span of time. 

A duration literal is comprised of two parts: an integer and a duration unit.
It is essentially an integer terminated by one or a pair of reserved characters, which represent a unit of time.

The following table presents the time units used in declaring duration types.

| Unit | Meaning     |
|------|-------------|
| ms   | millisecond |
| s    | second      |
| m    | minute      |
| h    | hour        |
| d    | day         |
| w    | week        |

Internally all time and duration related values are converted to milliseconds.

#### Examples
```dfs
def span = 10s
def frequency = 10m
def short = 50ms
    
|win_time()
.period(1h)
.every(30m)
```

## Text templates

Embedding literal values in a string, using double curly braces:

{% raw %} 
```dfs

{{ variable_name }}
    
```
{% endraw %}
#### Use
{% raw %}
```dfs
def this_portion = 'it'
def text_template = 'Some string/text where {{this_portion}} will get replaced'
```
{% endraw %}

In the above example, after compilation of the dfs script the variable `text_template` will hold the following value:

`Some string/text where it will get replaced`

Text templates can be used in variable declarations like in the above example, 
they can be used in node-parameter and option-parameter calls.

When used in template scripts string/text templates can be very powerful.
The variable `this_portion` could be overwritten with a new value for every instantiation of a template script.

#### More examples
{% raw %}
```dfs
def an_integer = 33
def a_float = 345.78
def a_string = 'Embedding an integer: {{an_integer}} and a floating point number: {{a_float}}.'
% results in: 'Embedding an integer: 33 and a floating point number: 345.78.'

%% list:
def fruits =
'[
  {"color":  "orange", "name": "orange", "peel": true}, 
  {"color":  "orange", "name": "mandarin", "peel": true}, 
  {"color":  "orange", "name": "peach", "peel": false},
  {"color":  "orange", "name": "navel-orange", "peel": true},
  {"color":  "yellow", "name": "lemon", "peel": true}
]'
def selected_fruits = e: select('name', [{'peel', true}], fruits)
def citric_fruits = 'citrus fruits are: {{selected_fruits}}.'
% results in: 'citrus fruits are: orange,mandarin,navel-orange,lemon.'
```

There is another version of text-templating which uses a value inside the current data_point, that can be used with some nodes in faxe:

{% raw %}
```dfs

{{"field_name"}}
    
```
{% endraw %}

----------------------

{% raw %}
```dfs
|email()
.body('
    No data since {{"datetime"}} on topic ''ttgw/energy'', last value was {{"val"}}. 
    ')
```
{% endraw %}

> Note: We use double quotes to reference a field in the current data_item.

Here the values for `datetime` and `val` will be taken from the current data_point in the email node.
 
If a field used in a text_template is not present in the current data_point, the string 'undefined' will be used.
