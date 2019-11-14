# Introducing the DFS Script Language

Faxe uses a DSL called **dfs** (Dataflow Scripting Language).
Dfs is heavily influenced by InfluxData's `TICKScript`, in fact faxe started out as a clone of Kapacitor.

To get a basic understanding of dfs, you can therefore read [Introducing the TICKscript language](https://docs.influxdata.com/kapacitor/v1.5/tick/introduction/).

Some notable differencies between TICKScript and dfs include:

* dfs uses the `def` keyword for declarations
* for comments the `%` sign is used
* in dfs there are no top-level `stream` or `batch` nodes
* lambda expression use different functions
* regular expressions start and end with '?'

There is more, we will get to that ...

In general dfs is used to build up DAGs (Directed Acyclic Graph) of computing nodes via a script language.

While reading [TICKscript syntax](https://docs.influxdata.com/kapacitor/v1.5/tick/syntax/) will help you get more understanding
of `dfs`, here is also were the differences between TICKScript and dfs start to get bigger (tough not so much in syntax, so reading is recommended).

After that, lets dive right in and override some details you just read about TICKScript:

DFS
=== 

Keywords
--------

Word   |    Usage
-------|---------
true | boolean true
false | boolean false
TRUE | boolean true
FALSE | boolean false
lambda: | used to denote lambda expression
def | starts a variable declaration



Operators
---------

Operator    | Usage
------------|------
+| addition operator
-|substraction operator
/|division operator
*|multiplication operator
AND | and
OR | or
< | less than
> | greater than
=< | less than or equal
<= | less than or equal
=> |  greater or equal
 >= | greater or equal
 == | equal
!= | Not equal
/= | Not equal
! | Logical Not
rem| remainder
div|integer division

These operators are mainly used in Lambda expressions in faxe.

Chaining operators
------------------

Operator | Usage | Example
---------|-------|--------
\|       | Used to declare a new node instance and chains it to the node above it (if any)| `|some_node() |debug()` 
.        | Declares a property (or parameter) call, setting or changing an internal param in the node to which it belongs| `|log() .file('log1.txt')`
@        | Declares a user defined node written in python. Same as  \|, but for user defined nodes | `|some_node() ... @mynode()`
 

Variables and literals
======================
Variables are declared using the keyword `def` at the start of a declaration. 
Variables are immutable and cannot be reassigned new values later on in the script, 
though they can be used in other declarations and can be passed into methods. 
  
Variable declarations
---------------------

    def string = 'this is a string !'
    def text = <<< this is a text with some weird chars :// %& >>>
    def func = lambda: "value" / 3
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
    
Datatypes
---------

DFS recognizes six types, the type of the literal will be interpreted from its declaration.

Type name | Description | Examples
----------|-------------|---------
string    | String type. Single quotes are used for string, string can also be multiline | 'this_is_a_string'
text      | Text type. Mostly used where strings are used | <<< SELECT MEAN(obj['current']) FROM mytable >>>
integer   | Integer type. Arbitrarily big ints are allowed | 123456789987654321, 55
float     | Floating point number. May be arbitrarily big  | 12.343422023, 5.6
duration  | A duration literal. See section below.         | 34s, 500ms, 2d
lambda    | A lambda expression. See extra section in this documentarion| lambda: str_downcase('BIG')
    
### Duration literals 

Duration literals define a span of time. 

A duration literal is comprised of two parts: an integer and a duration unit. It is essentially an integer terminated by one or a pair of reserved characters, which represent a unit of time.

The following table presents the time units used in declaring duration types.

Unit | Meaning
-----|--------
ms|millisecond
s|second
m|minute
h|hour
d|day
w|week


Internally all time and duration related values are converted to milliseconds in faxe.

#### Examples
    
    def span = 10s
    def frequency = 10m
    def short = 50ms
    
    |win_time()
    .period(1h)
    .every(30m)