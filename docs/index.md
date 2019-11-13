# Faxe

Flow based data-collector and time-centric data-processor.













## General

### Data in faxe

In faxe we deal with `data_points` and `data_batches`.

Every `data_point` consists of a `ts` field, `fields` and `tags`.
The value of the ts field is always: **unix-timestamp in millisecond precision without a timezone**.

`fields` and `tags` are essentially `key-value maps`.

Valid data-types for field and tag values are: `string, integer, float, key-value map (also deeply nested) and lists`. 
The only valid data-type for field and tag keys is `string`.

A data_batch consists of a list of data_points ordered by timestamp.

Most faxe nodes can deal with both points and batches. 

### Value referencing


As field and tag values can be deeply nested maps and lists, it is possible to use a `JSON-path` like syntax
to declare and reference these values:

Valid examples:

    averages
    axis.z.cur
    value.sub[2].data
    averages.emitted[5]
