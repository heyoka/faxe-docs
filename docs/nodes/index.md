# Faxe nodes

## Parameters

Faxe nodes can have `2 types of parameters`:

1. **Node parameters** provided to the node declaration function

```dfs  
% the level parameter is given to the node declaration function
|debug('notice')
```


    
2. **Option parameters** provided to an option call

```dfs  
% the level parameter is given as an extra option function
|debug()
.level('notice')

```

    
    
Some parameters are required and others are optional.

**Every parameter with no default value is mandatory !**

The following is a list of all possible parameter types faxe supports based on the basic data-types:

Name | Description | Example
-----|-------------|--------
is_set         | Special parameter type that evaluates to true if called (even with no value) | .use_ssl()
number         | Integer or float value | 324 or 4.3424325
integer        | Integer value
float          | Floating point value
double         | Floating point value
string         | String value | .topic('home/alex/garage')
binary         | 
atom           | used internally only
list           | any kind of list
lambda         | a lambda expression
bool           | 
number_list    | a list of numbers | .values(3, 44, 34.5)
integer_list   | a list of integers | .ints(2, 3, 4, 5)
float_list     | a list of floats | .floats(43.4, 12.2, 545.009832)
string_list    | a list of strings | .strings('alex1', 'alex2', 'flo', 'markus')
binary_list    |
atom_list      | internally only
lambda_list    | a list of lambda expressions | .functions(lambda: "val" * 2, lambda: "val" * 3, lambda: "val" / 4)

What is important to note:
If a node requires a `_list` type for any parameter, 
we just provide 1 or more of the same data-type separated be commas.

For example the eval node requires the lambdas parameter to be of type `lambda_list`, the following calls would be valid:

```dfs

|eval(lambda: str_concat("strval", '_postfix')

|eval(lambda: str_starts_with("strval", 'pre'), lambda: 3 * ("val1" + "val2"))

|eval(
    lambda: sqrt("base") + const,
    lambda: if(hour("ts") > 18 AND day_of_week("ts") < 6, 'late_for_work', 'ok'),
    lambda: abs("ts" - "ts_previous")
)

```