The case node
=====================

Evaluates a series of lambda expressions in a top down manner.

* The node will output / add the corresponding value of the first lambda expression that evaluates as true.
* If none of the lambda expressions evaluate as true, a default value will be used


The case node works in a similar way CASE expressions in SQL work.

Example
-------
```dfs  
|case(
    lambda: "data.condition.name" == 'OK',
    lambda: "data.condition.name" == 'Warning',
    lambda: "data.condition.name" == 'Error'
)
.values(
    <<<{"cond": "Everything OK!"}>>>,
    <<<{"cond": "Oh, oh, a Warning!"}>>>,
    <<<{"cond": "Damn, Error!"}>>>
)
.json()
.as('data')
.default(<<<{"cond": "Nothing matched!!!"}>>>)

``` 


Parameters
----------

Parameter     | Description | Default 
--------------|-------------|---------
[node] lambdas( `lambda_list` )|  list of lambda expressions |
values( `string_list\|text_list` )| corresponding values |
json( `is_set` ) | if set, will treat the `values` and `default` parameters as json strings| false, not set
as (`string`) | field-path for the output value|
default(`any`) | default value to use, if no case clause matches| 
 