The python node
==============

> deprecated since vsn 1.0.0, see [custom_nodes](../custom_nodes.md).


--------------------------------------------------------------------------

Rules for python callback classes:

* Callback class must be in a module with the lowercase name of the class ie:
module: "double", class: "Double"
* python callback class must be a subclass of the class Faxe from module faxe
  * 'abstract' methods to implement are (note: they are all **optional**):
     * `options()` -> return a list of tuples // static
     * `init(self, args`) -> gets the object and a dict with args from options()
     * `handle_point(self, point_data)` -> point_data is a dict
     * `handle_batch(self, batch_data`) -> batch_data is a list of dicts (points)
* the callbacks need not return anything except for the options method
* to emit data the method `self.emit(data)` has to be used, where data is a dict or a list of dicts
* All fields of data-item going in and out of a custom python node are placed under the root-object `data`.

A custom python node is used with an `@` as node sign instead of `|` in dfs!

```dfs  
@my_custom_python_node()
```

Parameters
----------

Parameters can be freely defined by the python callback class via the static `options()` method (See example below).
Note that parameter definition must be in python's `bytes` type.


Example Callback
----------------

The example python callback class below defined 2 Parameters:

* `field` must be a string and has no default value (so it must be given)
* `as` must be a string and has the default value 'double'

```python
from faxe import Faxe


class Double(Faxe):

    @staticmethod
    def options():
        """
        overwrite this method to request options you would like to use

        return value is a list of tuples: (option_name, option_type, (optional: default type))
        a two tuple: (b"foo", b"string") with no default value is mandatory in the dfs script
        a three tuple: (b"foo", b"string", b"mystring") may be overwritten in a dfs script

        :return: list of tuples
        """
        opts = [
            (b'field', b'string'),
            (b'as', b'string', b'double')
        ]
        return opts

    def init(self, args):
        """
        will be called on startup with args requested with options()
        :param args: dict
        """
        self.fieldname = args[b'field']
        self.asfieldname = args[b'as']
        print("my args: ", args)

    def handle_point(self, point_data):
        """
        called when a data_point comes in to this node
        :param point_data: dict
        """
        self.emit(self.calc(point_data["data"]))

    def handle_batch(self, batch_data):
        """
        called when a data_batch comes in
        :param batch_data: list of dicts
        """
        out_list = list()
        for point in batch_data:
            out_list.append(self.calc(point["data"]))
        self.emit(out_list)

    def calc(self, point_dict):
        point_dict[self.asfieldname] = point_dict[self.fieldname] * 2
        return point_dict
```

Use in a dfs script:
```dfs  
@double()
.field('val')
.as('double_val')
```