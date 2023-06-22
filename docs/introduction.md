# Intro

Faxe at it's core implements the architectural ideas of [dataflow computing](https://en.wikipedia.org/wiki/Dataflow) from the 1970s and 80s.

> The central idea was to replace the classic von Neumann architecture with something more powerful.
> In a von Neumann architecture, the processor follows explicit control flow, executing instructions one after another.
> In a dataflow processor, by contrast, an instruction is ready to execute as soon as all its inputs (typically referred to as “tokens”)
> are available, rather than when the control flow gets to it.
> This design promised efficient parallel execution in hardware when many “tokens” were ready to execute.
> -- <cite>[The remarkable utility of dataflow computing][1]</cite>


Nowadays with the need to process large amounts of (flowing) data and with the rise of machine learning frameworks, dataflow
computing has gained in popularity again.

> For example, machine learning frameworks like TensorFlow represent model training and inference as dataflow graphs,
> and the state transitions of actors
> (e.g., simulators used in reinforcement learning training) can be represented as dataflow edges, too.
> <br><br>
> Other research has extended the original dataflow graph abstraction for streaming computations.
> Instead of evaluating the dataflow graph once, with all inputs set at the beginning and all outputs produced at the end of evaluation,
> a streaming dataflow system continuously executes the dataflow in response to new inputs.
> This requires incremental processing and a stateful dataflow.
> In this setting, new inputs from a stream of input data combine with existing computation state inside the dataflow graph
> (e.g., an accumulator for a streaming sum).
> -- <cite>[The remarkable utility of dataflow computing][1]</cite>


This is exactly where FAXE picks up the dataflow computing idea.

---

To get started, we look at some of these concepts in Faxe.

## Nodes

The components that make up the computing graph are called `nodes` in faxe.
There are many `built-in nodes` for various different tasks, such as

* getting data from PLCs or Modbus devices
* reading and writing data from different databases
* publishing and consuming data from mqtt or other message brokers like [RabbitMQ](https://www.rabbitmq.com/)
* windowing
* statistics
* manipulating fields in data, that flows through the computing graph
* ....

Besides these nodes, FAXE users can also write `custom nodes implemented with python`, that can be used like the built-in ones
in dataflows.

> FAXE is implemented in [Erlang/OTP](https://www.erlang.org/) which makes it possible, that each of the nodes in a flow is running in its own seperate process.
> These processes share nothing in between them and only communicate with each other through `message passing`. This makes up for massive parallelism (concurrency)
> within a flow and also between all the flows running in a FAXE instance, matching exactly the architecture of the dataflow programming paradigm.
> <br>
> A FAXE instance can easily have thousands of processes runnning in parallel, which results in great throughput for a lot of data-streams.

## Data

### data-point

The smallest piece of data-item in FAXE is called a `data-point`.
Since FAXE is mainly used for time series processes, these data-points always carry a unix timestamp in a field called `ts` with them.
So a data-point holds data for a specific point in time and a series of such data-points then form this unbounded stream of data we call
time series data.

### How does this data look like ?

We can think of the before mentioned `data-point as a JSON object` (though internally it is not exactly JSON).

```json

{"ts" : 1629812164152, "value" : 2.33}

```

The timestamp is always there and the field holding it is always called `ts`.

Next to the timestamp a data-point can have any number of other `fields`, a field can be of the basic data-type like `int, string, float`,
or it can be an object itself, possibly deeply nested. Basically everything that is allowed in the JSON format.

```json

{
  "ts":1629812164152,
  "values":{
    "value1":12,
    "value2":"a string",
    "value3":{
      "value3_1":4.232341
    }
  }
}

```


```json

{
  "ts":1629812164152,
  "values":[
    {
      "value1":12
    },
    {
      "value2":"a string"
    }
  ]
}

```

In order to deal with these data structures, we can use a basic form of [JSON-Path](https://jsonpath.com/).

For example to reference the field **value2** in the second example, we would use the following `path`:

```
values.value2
```

The path for the field **value3_1** in the second example:

```
values.value3.value_3_1
```

In the third example we have a json-array, we can reference the field **value2** like so:

```
values[2].value2
```

#### Dots in fieldnames

If you have to deal with dots in fieldnames, there is a syntax for this: you can use a `star` instead in faxe flow scripts:

```json

{
  "ts":1629812164152,
  "data": {
    "stats.speed": 22.3,
    "stats.freq": 440.0,
    "stats.cnt": 12
  }
}
```

The path for the field **stats.freq** can be reached using a star character:

```
data.stats*freq
```

> Note: You should absolutely not use such a notation for you data, since normally you would in- and  output json data from flows and
> such a notation is against the rules of JSON-Path, the '.' character is the child operator.
> Start would be the wildcard in JSON path, but since Faxe does not support wildcards explicitely, we use it for literal dots in field
> names.

It is recommended to only use the star notation, if you are dealing with data from outside, that already has dots in fieldnames.
You should immediately [rename](nodes/flowdata/rename.md) this kind of data, before any other processing in a flow.

### data-batch

There is a second type of data-item called `data-batch`, which is simply a `list of data-points`.
The list of data-points that make up a data-batch is ordered by the points' timestamps.

In JSON notation a data-batch will look like this:

```json

[
  {
    "ts":1629812164152,
    "values":{
      "value1":12,
      "value2":"res-433"
    }
  },
  {
    "ts":1629812164154,
    "values":{
      "value1":13,
      "value2":"res-124"
    }
  },
  {
    "ts":1629812164156,
    "values":{
      "value1":11,
      "value2":"res-712"
    }
  }
]

```

## Strings and References

Unlike what is possible in some programming languages,
where you can use two different string notations: `'a string'` or `"also a string"`,
in DFS these two notations have a completely different meaning.

In DFS, single quotes are used for strings

```dfs
'faxe is canned beer' 

'baseField.subField'
```

or for text

```dfs
'
    SELECT * 
    FROM table 
    ORDER BY timestamp
    LIMIT 5;
'   
```

Double quotes are used for references and are used only in lambda-expressions,
to retrieve the value of the specified field from the current data-point.

```dfs
lambda: "data.value" > 3  
```

Return whether the value at `data.value` is greater than 3.

## Lambda expressions

See [lambda_expressions](dfs_script_language/lambda_expressions.md).

## Rest Api

FAXE can be managed via its [rest api](./faxe_rest_api.html).

## How nodes are connected

See [node_connection](dfs_script_language/node_connection.md).

[1]: https://www.sigops.org/2020/the-remarkable-utility-of-dataflow-computing/
[1]: https://www.sigops.org/2020/the-remarkable-utility-of-dataflow-computing/
