The aggregate node
==============

The aggregate node lets you compute statistical functions on data_batches.
This node can compute multiple statistic functions on multiple fields.

See nodes under /nodes/statistics for details (Not all of these are available here).

This node can only take `data_batch` items, 
so in most cases you will need some kind of batch or window node to collect batches.

The aggregate node produces a new stream of data consisting of `data_point` items.

Example
-------

```dfs
 
|value_emitter()
.every(1s)
.type('point') 

|win_time()
.every(15s)
 
|aggregate()
.fields('val', 'val', 'val', 'val')
.functions('variance', 'sum', 'avg', 'count_distinct')
.as('variance', 'sum', 'average', 'count_distinct')

|debug()

```


Parameters
----------

| Parameter                  | Description                                                                                              | Default                                      |
|----------------------------|----------------------------------------------------------------------------------------------------------|----------------------------------------------|
| fields( `string_list` )    | names of the fields used for each computation                                                            |                                              |
| functions( `string_list` ) | list of function names (see 'Functions' table below for possible values)                                 |                                              |
| as( `string_list` )        | names for the fields for output values                                                                   | defaults to the name of the compute function |
| keep( `string_list` )      | fields that should be kept from the input data-items                                                     | []                                           |
| keep_tail( `boolean` )     | keep the last data-point from every incoming batch, so it can be used for `count_change` as inital value | true                                         |

Functions
---------

| Name             | Description                                             | Note                                                                  |
|------------------|---------------------------------------------------------|-----------------------------------------------------------------------|
| `sum`            | computes the sum of all values                          | numerical values only                                                 |
| `avg`            | computes the average of all values                      | numerical values only                                                 |
| `min`            | computes the minimum value                              |                                                                       |
| `max`            | computes the maximum value                              |                                                                       |
| `mean`           | computes the mean value                                 | numerical values only                                                 |
| `median`         | computes the median value                               | numerical values only                                                 |
| `first`          | outputs the first (oldest) value                        |                                                                       |
| `last`           | outputs the last (newest) value                         |                                                                       |
| `count`          | outputs the total number of values                      |                                                                       |
| `count_distinct` | outputs the number of unique values                     |                                                                       |
| `count_change`   | outputs the number of value changes for the given field | with keep_tail set to true, the last item will serve as initial value |
| `range`          | computes the range                                      | between minimum and maximum                                           |
| `variance`       | computes the variance                                   | numerical values only                                                 |
| `stddev`         | computes the standard deviation of the values           | numerical values only                                                 |
| `skew`           | computes the skew of all values                         | numerical values only                                                 |

