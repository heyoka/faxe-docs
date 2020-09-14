The s7read node
=====================

Read data from a siemens s7 plc via the snap7 library using the `iso on tcp protocol`.
Reading can be done periodically and/or triggered via incoming data-items.
If the `every` parameter is not given, reading will be done only with trigger data-items.

* Data `addressing` can be done in a `Step7` schema or with a sligthly different schema used in node-red
(although the step7 variant is preferred). 
See table below for more information about addressing.

* The node will optimize reading by treating contiguous values as one reading var.
Thus more data can be read in one go.

* Connections to a PLC are handled by a connection pool, which can grow and shrink as needed.
The number of 
Min and Max connection count can be set in faxe [configuration](../../configuration.md). Defaults to 2 and 16.

### Strings
A String is defined as a sequence of contiguous char (byte) addresses.
For strings faxe uses a special syntax not found in step7 addressing: 
`DB5.DBS7.4 ` would read 4 bytes starting at byte 7 of DB 5 and output a string value.

`Note`: Characters with an ascii value below 32 will be stripped from the char-sequence.
Also for strings the above mentioned read-optimization will not be used.

----


`Note: data transfer size is limited to 128 bytes.`

Examples
-------
```dfs  
|s7read() 
.ip(10.1.1.5)
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

```dfs  
def db_number = 1140
def db = 'DB{{db_number}}.DB'
|s7read()  
.ip(10.1.1.5)
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

Use of `as_prefix` and `vars_prefix`. The node will not read data on its own, because it has no every parameter.
instead reading is done on data input from another node.

```dfs
|s7read()
.ip(10.1.1.5)
.rack(0)
.slot(2)
.every(300ms) 
.vars('DB12004.DBS36.30')
.as('data.LcBc')


```
Read a sequence of 30 bytes as a string.


```dfs
def db_number = 1140
def db = 'DB{{db_number}}.DB'
|s7read()
.ip(10.1.1.5)
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

In the last example `byte_offset` of 4 is used, so effectively the following addresses will be used:
`X4.0, X4.1, X4.4, X4.5`

Parameters
----------

Parameter     | Description | Default 
--------------|-------------|--------- 
ip( `string` )| ip address of plc |
port( `integer` )| network port | 102 (standard s7 port)
every( `duration` )|time between reads| undefined
align( is_set )|align read intervals according to every|false (not set)
slot( `integer` )| plc slot number|1
rack( `integer` )| plc rack number|0
vars( `string_list` )|list of s7 addresses ie: 'DB3.DBX2.5' (see table below)|
as( `string_list` )|output names for the read values|
vars_prefix( `string` )|vars  will be prefixed with this value| undefined
as_prefix( `string` )|as values will be prefixed with this value| undefined
byte_offset( `integer` )|offset for addressing, every address in vars gets this offset added| 0
diff( is_set )|when given, only output values different to previous values|false (not set)



Note that params `vars` and `as` must have the same length.


## Data addressing

`Note: Step7 style preferred and should be used !`

Address	| Step7 equivalent |	JS Data type |	Description
--------|------------------|-----------------|-------------
DB5,X0.1|	DB5.DBX0.1|	Boolean	|Bit 1 of byte 0 of DB 5
DB23,B1 or DB23,BYTE1|	DB23.DBB1|	Number|	Byte 1 (0-255) of DB 23
DB100,C2 or DB100,CHAR2|	DB100.DBB2| String|	Byte 2 of DB 100 as a Char
DB42,I3 or DB42,INT3|	DB42.DBW3|	Number|	Signed 16-bit number at byte 3 of DB 42
DB57,WORD4|	DB57.DBW4|	Number	|Unsigned 16-bit number at byte 4 of DB 57
DB13,DI5 or DB13,DINT5|	DB13.DBD5|	Number|	Signed 32-bit number at byte 5 of DB 13
DB19,DW6 or DB19,DWORD6|	DB19.DBD6|	Number|	Unsigned 32-bit number at byte 6 of DB 19
DB21,DR7 or DB21,REAL7|	DB19.DBD6	|Number	|Floating point 32-bit number at byte 7 of DB 21
DB2,S7.10*	|`DB2.DBS7.10` (faxe only)	|String	|String of length 10 starting at byte 7 of DB 2
I1.0 or E1.0|	I1.0 or E1.0|	Boolean|	Bit 0 of byte 1 of input area
Q2.1 or A2.1|	Q2.1 or A2.1|	Boolean|	Bit 1 of byte 2 of output area
M3.2|	QM3.2|	Boolean|	Bit 2 of byte 3 of memory area
IB4 or EB4|	IB4 or EB4|	Number|	Byte 4 (0 -255) of input area
QB5 or AB5|	QB5 or AB5|	Number|	Byte 5 (0 -255) of output area
MB6	|MB6	|Number	|Byte 6 (0 -255) of memory area
IC7 or EC7|	IB7 or EB7	|String|	Byte 7 of input area as a Char
QC8 or AC8|	QB8 or AB8	|String	|Byte 8 of output area as a Char
MC9	|MB9	|String	|Byte 9 of memory area as a Char
II10 or EI10	|IW10 or EW10	|Number	|Signed 16-bit number at byte 10 of input area
QI12 or AI12	|QW12 or AW12	|Number	|Signed 16-bit number at byte 12 of output area
MI14	|MW14	|Number	|Signed 16-bit number at byte 14 of memory area
IW16 or EW16	|IW16 or EW16	|Number	|Unsigned 16-bit number at byte 16 of input area
QW18 or AW18	|QW18 or AW18	|Number	|Unsigned 16-bit number at byte 18 of output area
MW20	|MW20	|Number	|Unsigned 16-bit number at byte 20 of memory area
IDI22 or EDI22	|ID22 or ED22	|Number	|Signed 32-bit number at byte 22 of input area
QDI24 or ADI24	|QD24 or AD24	|Number	|Signed 32-bit number at byte 24 of output area
MDI26	|MD26	|Number	|Signed 32-bit number at byte 26 of memory area
ID28 or ED28	|ID28 or ED28	|Number	|Unsigned 32-bit number at byte 28 of input area
QD30 or AD30	|QD30 or AD30	|Number	|Unsigned 32-bit number at byte 30 of output area
MD32	|MD32	|Number	|Unsigned 32-bit number at byte 32 of memory area
IR34 or ER34	|IR34 or ER34	|Number	|Floating point 32-bit number at byte 34 of input area
QR36 or AR36	|QR36 or AR36	|Number	|Floating point 32-bit number at byte 36 of output area
MR38	|MR38	|Number	|Floating point 32-bit number at byte 38 of memory area