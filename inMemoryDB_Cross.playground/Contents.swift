/*

 The basic level of the in-memory database contains records. Each record can be accessed with a unique identifier key, which is of string type. A record contains several field - value pairs, with field as string type and value a s Integer type.
 • SET_OR_INC <key> <field> ‹value> - should insert a field - value pair to the record associated with key. Al value should be integers. fI the field in the record already exists, increase the current value by the specified value. fI the record or field does not exist, a new one should be created with the value set to the value. This operation should return a string representing the inserted or updated value (in this level, an empty string is never returned).
 • GET ‹ k e y > ‹ fi e l d › — should return a string representing the value within fi e l d of the record associated with key. fI the record or the fi e l d does not exist, should return an empty string.
 • DELETE <key> <field> — should remove field from the record associated with key. Returns "true" ifthe field was deleted, and "false" otherwise. fI al fields ni a record have been deleted, the record should be deleted.
 
 Examples

 Queries
 
 queries = [
 ["SET_OR_INC", "A", "B", "5"],
 ["SET_OR_INC", "A", "в", "6"],
 ["GET", "A", "в"],
 [ "GET" , "A" , "C" ] ,
 ["DELETE", "A", "в"],
 ["DELETE", "A", "C"]
]
 
 output should be
 ["5", "11", "11", "", "true", " f a l s e "]
 
 Explanations
 returns "5"; database state: ("A": ("B": 5}}
 returns "11"; database state: ("A": ("B": 11}}
 returns "11"; database state: ("A": ("B": 11}}
 r e t u r n s " " as " C " i s n o t p r e s e n t .
 returns "true"; database state: ()
 returns "false"; database state: ()

 
 queries:
 [["SET_OR_INC","foo","bar","70"],
  ["SET_OR_INC","foo","two","60"],
  ["SET_OR_INC","foo","bar","30"],
  ["GET","foo","bar"],
  ["GET","foo","two"],
  ["SET_OR_INC","foo","two","50"],
  ["DELETE","foo","bar"],
  ["GET","foo","bar"],
  ["SET_OR_INC","foo","two","20"],
  ["SET_OR_INC","foo","two","150"],
  ["SET_OR_INC","foot","wo","30"],
  ["SET_OR_INC","foo","bar","70"],
  ["GET","foo","bar"],
  ["GET","foo","two"]]
   output ["70",
  "60",
  "100",
  "100",
  "60",
  "110",
  "true",
  "",
  "130",
  "280",
  "30",
  "70",
  "70",
  "280"]
 */


