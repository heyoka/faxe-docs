## Custom python node

Using a custom python node called `double` to double values of a data_batch.
Here data is produced every 2s, then accumulated to a data_batch of length 6, the result gets then forwarded
to our custom python node, which doubles all values of the field `val`.
 
### dfs

```dfs  
|value_emitter()
.every(2s)
.type(point)

|win_event()
.every(6) 

@double()
.field('val')
.as('double_val')

|debug()
```

### python
```python
from faxe import Faxe


class Double(Faxe):

    @staticmethod
    def options():
        opts = [
            (b'field', b'string'),
            (b'as', b'string')
        ]
        return opts

    def init(self, args):
        self.fieldname = args[b'field']
        self.asfieldname = args[b'as']

    def handle_point(self, point_data):
        self.emit(self.calc(point_data))

    def handle_batch(self, batch_data):
        out_list = list()
        for point in batch_data:
            out_list.append(self.calc(point))
        self.emit(out_list)

    def calc(self, point_dict):
        point_dict[self.asfieldname] = point_dict[self.fieldname] * 2
        return point_dict

```