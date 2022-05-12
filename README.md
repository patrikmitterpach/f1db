
<img src="https://raw.githubusercontent.com/patrikmitterpach/f1db/main/images/f1-logo-big.png" width="100">  

# Formula One PostgreSQL Database

## Contents
- [Basic overview](https://github.com/patrikmitterpach/f1db#-contents)
- [Instructions](https://github.com/patrikmitterpach/f1db#-instructions)

<img src="https://github.com/patrikmitterpach/f1db/blob/main/images/conceptual_scheme.png?raw=true"> 

## Basic overview
Created as a semestral work, this PostgreSQL database tries to encapsulate the essence of Formula One as a learning project for the Structured Query Language **SQL**. Despite strict guidelines, this project recieved full points in the BI-DBS course, placing it in among the **top 1%** of projects evaluated, marking it a personal success. 

The database, *written in Slovak*, consists of:
- `12 tables`
- `17 relations` 
- `200+ records`
- `25 SQL queries`

## Instructions
To properly utilize the queries, the files have to be executed in the following order:  
```
createScript.sql > sampleData.sql > queryScript.sql
```
`queryScript.sql` contains 25+ SQL queries, so it is recommended to execute it one-by-one if the program allows it. The queries were written based on certain criteria which is not explicitly denoted in the script, mostly for the sake of clarity. A wide array of SQL concepts are contained within the queries, including:
- several diffrent `JOIN` queries, including combinations of `OUTER`, `FULL`, `LEFT` and such.
- modification of database records with `UPDATE`, `REMOVE`, `ADD`
- usage of `ORDER BY`, `WHERE`, `HAVING`, `GROUP BY`, `LIMIT`
- nested / complex queries
