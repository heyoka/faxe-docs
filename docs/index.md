# General

Flow based data-collector and time-centric data-processor.

Faxe's inner core is based on a dataflow computing engine and it's components also called `nodes` can be
freely combined into an acyclic graph.

Unlike other flowbased frameworks (node_red, ...) in Faxe computing graphs are built with a DSL called [`dfs`](dfs_script_language/index.md). 


## Rest Api

FAXE can be managed via its [rest api](./faxe_rest_api.html).


## General

### Data in faxe

As you can read [here](introduction.md#data), in faxe we deal with `data_points` and `data_batches` as basic data types. 
These `data-items` as we call them, are emitted by nodes that are freely combined into a computing graph to achieve the desired processing.

Every `data_point` consists of a `ts` field, `fields` and `tags`.
The value of the ts field is always: **unix-timestamp in millisecond precision without a timezone**.

`fields` and `tags` are essentially `key-value maps`.

Valid data-types for field and tag values are: `string, integer, float, key-value map (also deeply nested) and lists`. 
The only valid data-type for field and tag keys is `string`.

A data_batch consists of a list of data_points ordered by timestamp.

Most faxe nodes can deal with both points and batches. 



## Value referencing


As field and tag values can be deeply nested maps and lists, it is possible to use a `JSON-path` like syntax
to declare and reference these values:

Valid examples:

    averages
    axis.z.cur
    value.sub[2].data
    averages.emitted[5]

> For more information, you can read the [introduction](introduction.md).