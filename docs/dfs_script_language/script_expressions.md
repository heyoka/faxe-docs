# Script expressions

Script expressions look the same as [lambda expressions](lambda_expressions.md), but start with `e:` instead of `lambda:`.

There is a main difference between script expressions and lambda expressions:
> Script expressions are evaluated during dfs compilation.

> Therefore, script expressions can not use "references" to access fields in data-items.



## Example

```dfs

def topic = 'this/is/my/topic'
%% script expression, which uses the topic definition
def routing_key = e: str_replace(topic, '/', '.')

```

The above example will resolve to the following equivalent dfs script:


```dfs

def topic = 'this/is/my/topic'
%% script expression, which uses the topic definition
def routing_key = 'this.is.my.topic'

```


## References
References are used in lambda expression to access fields in data-items (data_points and data_batches).
They cannot be used in script expressions, so the next example will throw an error during script compilation:

```dfs

def base_topic = 'this/is/my/base/'
def topic = e: str_concat(base_topic, "data.postfix")

```
The above example will fail with the message: `"Reference(s) used in inline-expression: data.postfix"`

> Note: We use double quotes to reference a field in the current data_item.

## More examples

```dfs

def new_id = 3
def def_inline = e: string(3 + 5 + sqrt(new_id))
def i_string = 'this is my string'
def def_inline_string = e: str_replace(i_string, 'i', 'a')

```

```dfs
def batch_size = 50 
 
|amqp_consume()
.bindings('this.is.my.binding.#')
%% use of script expression for node option, 
%% we have to round to an integer with the `round` function
.prefetch(e: round(batch_size * 1.25) )
.exchange('x_xchange')
.queue('q_test')

|batch(batch_size)
.timeout(10s)

```

Script expression can be used for node parameters (except where a lambda expression is required of course), 
as long as the resulting value is of the required data-type.
