The s7read node
=====================

Read data from a siemens s7 plc via the snap7 library using the `iso on tcp protocol`.
The node is tested to read data from S7 **300** and S7 **1500** CPUs, but should be able to read data from any S7 PLC that supports the
S7 comm protocol.

Reading can be done periodically and/or triggered via incoming data-items.
If the `every` parameter is not given, reading will be done only with trigger data-items.

* Data `addressing` can be done in a `Step7` schema or with a slightly different schema used in node-red
(although the step7 variant is preferred). 
See table below for more information about addressing.


## Optimzation when reading data

* The node will optimize reading by treating contiguous values as one reading var.
Thus more data can be read in one go.
* since 0.20.0: when `optimized` is set to true (default), then optimization and reading will be done outside of the node. 
 All variables from all s7read nodes, that target the same PLC are optimized as a whole, this makes it possible to take advantage of the maximum PDU size.
 This will possibly lead to more than one request for a specific time slot, if there are many vars to read.
 In optimized mode, it does not make a difference, if we use many s7read nodes, where every node just reads a view vars, or if we have
 only one s7read node, that reads a lot of vars (or anything in between)


* Connections to a PLC are handled by a connection pool, if `use_pool` is set to true, which can grow and shrink as needed.
(This is especially useful, when connecting to a PLC, that has limited connection resources)
The number of 
Min and Max connection count can be set in faxe [configuration](../../configuration.md). Defaults to 2 and 16.

### Strings
A String is defined as a sequence of contiguous char (byte) addresses.
For strings faxe uses a special syntax not found in step7 addressing: 
`DB5.DBS7.4 ` would read 4 bytes starting at byte 7 of DB 5 and output a string value.

`Note`: Characters with an ascii value below 32 will be stripped from the char-sequence.
Also for strings the above mentioned read-optimization will not be used.

---- 

Examples
-------
```dfs  

|s7read() 
.ip('10.1.1.5')
.rack(0)
.slot(2)
.every(300ms) 
.vars(
    'DB1140.DBX4.0', 'DB1140.DBX4.1',
    'DB1140.DBX4.4', 'DB1140.DBX4.5'
    )

.as(
    'data.tbo[1].ix_OcM1', 'data.tbo[1].ix_OcM2',
    'data.tbo[1].ix_Lift_PosTop', 'data.tbo[1].ix_Lift_PosBo'
    )

```  

Read 4 values (BOOL in this case) from a plc every 300 milliseconds and name them with a deep json path.

{% raw %}
```dfs  

def db_number = 1140
def db = 'DB{{db_number}}.DB'
|s7read()  
.ip('10.1.1.5')
.as_prefix('data.tbo.') 
.vars_prefix(db)
.vars(
    'X4.0', 'X4.1',
    'X4.4', 'X4.5'
    )

.as(
    'ix_OcM1', 'ix_OcM2',
    'ix_Lift_PosTop', 'ix_Lift_PosBo'
    )

```  
{% endraw %}

Use of `as_prefix` and `vars_prefix`. The node will not read data on its own, because it has no every parameter.
instead reading is done on data input from another node.

```dfs
|s7read()
.ip('10.1.1.5')
.rack(0)
.slot(2)
.every(300ms) 
.vars('DB12004.DBS36.30')
.as('data.LcBc')


```
Read a sequence of 30 bytes as a string.

{% raw %}
```dfs

def db_number = 1140
def db = 'DB{{db_number}}.DB'
|s7read()
.ip('10.1.1.5')
.as_prefix('data.tbo.') 
.vars_prefix(db)
.byte_offset(4)
.vars(
    'X0.0', 'X0.1',
    'X0.4', 'X0.5'
    )

.as(
    'ix_OcM1', 'ix_OcM2',
    'ix_Lift_PosTop', 'ix_Lift_PosBo'
    )
```
{% endraw %}

In the last example `byte_offset` of 4 is used, so effectively the following addresses will be used:
`X4.0, X4.1, X4.4, X4.5`

------------------------------------

`since v0.19.5` 

When `as` is not given, every second entry in `vars` is used as a field-name instead.

{% raw %}
```dfs

def db_number = 1140
def db = 'DB{{db_number}}.DB'
|s7read()
.ip('10.1.1.5')
.as_prefix('data.tbo.') 
.vars_prefix(db)
.byte_offset(4)
.vars(
    'X0.0', 'ix_OcM1',
    'X0.1', 'ix_OcM2',
    'X0.4', 'ix_Lift_PosTop',
    'X0.5', 'ix_Lift_PosBo'
    )
 
```
{% endraw %}



Parameters
----------

| Parameter                | Description                                                                                                                                       | Default                |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|
| ip( `string` )           | ip address of plc                                                                                                                                 |                        |
| port( `integer` )        | network port                                                                                                                                      | 102 (standard s7 port) |
| every( `duration` )      | time between reads                                                                                                                                | undefined              |
| align( is_set )          | align read intervals according to every                                                                                                           | false (not set)        |
| slot( `integer` )        | plc slot number                                                                                                                                   | 1                      |
| rack( `integer` )        | plc rack number                                                                                                                                   | 0                      |
| vars( `string_list` )    | list of s7 addresses ie: 'DB3.DBX2.5' (see table below)                                                                                           |                        |
| as( `string_list` )      | output names for the read values<br> Since 0.19.5: if not given, every second entry in `vars` is used as a fieldname (prefixes can still be used) | undefined              |
| vars_prefix( `string` )  | vars  will be prefixed with this value                                                                                                            | undefined              |
| as_prefix( `string` )    | as values will be prefixed with this value                                                                                                        | undefined              |
| byte_offset( `integer` ) | offset for addressing, every address in vars gets this offset added                                                                               | 0                      |
| diff( is_set )           | when given, only output values different to previous values                                                                                       | false (not set)        |
| use_pool ( `bool` )      | whether to use the built-in connection pool                                                                                                       | from config value      |
| optimized ( `bool` )     | whether to use the collected read optimization or do standalone reading for this node                                                             | from config value      |

Note that params `vars` and `as` must have the same length (if both are given).


## Data addressing

`Note: Step7 style preferred and should be used !`

| Address	                | Step7 equivalent              | 	Description                                                    |
|-------------------------|-------------------------------|-----------------------------------------------------------------|
| DB5,X0.1                | 	DB5.DBX0.1                   | Bit 1 of byte 0 of DB 5                                         |
| DB23,B1 or DB23,BYTE1   | 	DB23.DBB1                    | 	Byte 1 (0-255) of DB 23                                        |
| DB100,C2 or DB100,CHAR2 | 	DB100.DBC2                   | 	Byte 2 of DB 100 as a Char                                     |
| --                      | 	DB42.DBSINT36 or DB42.DBSI36 | 	Signed 8-bit integer at byte 36 of DB 42                       |
| --                      | 	DB42.DBUSINT5 or DB42.DBUSI5 | 	Unsigned 8-bit integer at byte 5 of DB 42 (equivalent to BYTE) |
| DB42,I3 or DB42,INT3    | 	DB42.DBI3 or DB42.DBINT3     | 	Signed 16-bit integer at byte 3 of DB 42                       |
| DB57,WORD4              | 	DB57.DBW4                    | Unsigned 16-bit integer at byte 4 of DB 57                      |
| DB13,DI5 or DB13,DINT5  | 	DB13.DBDI5  or DB13.DBDINT5  | 	Signed 32-bit integer at byte 5 of DB 13                       |
| DB19,DW6 or DB19,DWORD6 | 	DB19.DBDW6                   | 	Unsigned 32-bit integer at byte 6 of DB 19                     |
| DB21,DR7 or DB21,REAL7  | 	DB21.DBDR7 or DB21.DBR7	     | Floating point 32-bit number at byte 7 of DB 21                 |
| DB2,S7.10*	             | `DB2.DBS7.10` (faxe only)	    | String of length 10 starting at byte 7 of DB 2                  |
| DB1100,DT8	             | DB1100.DBDT8 or DB1100.DT8	   | 8 byte S7 DATE_AND_TIME format (DT) (UTC is assumed)            |
| I1.0 or E1.0            | 	I1.0 or E1.0                 | 	Bit 0 of byte 1 of input area                                  |
| Q2.1 or A2.1            | 	Q2.1 or A2.1                 | 	Bit 1 of byte 2 of output area                                 |
| M3.2                    | 	QM3.2                        | 	Bit 2 of byte 3 of memory area                                 |
| IB4 or EB4              | 	IB4 or EB4                   | 	Byte 4 (0 -255) of input area                                  |
| QB5 or AB5              | 	QB5 or AB5                   | 	Byte 5 (0 -255) of output area                                 |
| MB6	                    | MB6	                          | Byte 6 (0 -255) of memory area                                  |
| IC7 or EC7              | 	IB7 or EB7	                  | Byte 7 of input area as a Char                                  |
| QC8 or AC8              | 	QB8 or AB8	                  | Byte 8 of output area as a Char                                 |
| MC9	                    | MB9	                          | Byte 9 of memory area as a Char                                 |
| II10 or EI10	           | IW10 or EW10	                 | Signed 16-bit integer at byte 10 of input area                  |
| QI12 or AI12	           | QW12 or AW12	                 | Signed 16-bit integer at byte 12 of output area                 |
| MI14	                   | MW14	                         | Signed 16-bit integer at byte 14 of memory area                 |
| IW16 or EW16	           | IW16 or EW16	                 | Unsigned 16-bit integer at byte 16 of input area                |
| QW18 or AW18	           | QW18 or AW18	                 | Unsigned 16-bit integer at byte 18 of output area               |
| MW20	                   | MW20	                         | Unsigned 16-bit integer at byte 20 of memory area               |
| IDI22 or EDI22	         | ID22 or ED22	                 | Signed 32-bit integer at byte 22 of input area                  |
| QDI24 or ADI24	         | QD24 or AD24	                 | Signed 32-bit integer at byte 24 of output area                 |
| MDI26	                  | MD26	                         | Signed 32-bit integer at byte 26 of memory area                 |
| ID28 or ED28	           | ID28 or ED28	                 | Unsigned 32-bit integer at byte 28 of input area                |
| QD30 or AD30	           | QD30 or AD30	                 | Unsigned 32-bit integer at byte 30 of output area               |
| MD32	                   | MD32	                         | Unsigned 32-bit integer at byte 32 of memory area               |
| IR34 or ER34	           | IR34 or ER34	                 | Floating point 32-bit number at byte 34 of input area           |
| QR36 or AR36	           | QR36 or AR36	                 | Floating point 32-bit number at byte 36 of output area          |
| MR38	                   | MR38	                         | Floating point 32-bit number at byte 38 of memory area          |