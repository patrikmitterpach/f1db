
<img src="https://raw.githubusercontent.com/patrikmitterpach/f1db/main/images/f1-logo-big.png" width="100">  

# Formula One PostgreSQL Database

## Contents
- [Conceptual scheme](https://github.com/patrikmitterpach/f1db#-conceptual-scheme)
- [Basic overview](https://github.com/patrikmitterpach/f1db#-contents)
- [Instructions](https://github.com/patrikmitterpach/f1db#-instructions)
- [Commentary](https://github.com/patrikmitterpach/f1db#-commentary)
- [Sources](https://github.com/patrikmitterpach/f1db#-sources)

## Conceptual Scheme
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


## Commentary
The project was created as a learning exercise and should be taken as such. Several concepts could've been executed better with experience, however the project is something I am proud of nontheless.

## Sources
(pasted from the original version)
> 
> **[1]** Oficiálny zoznam jazdcov Formuly 1 [online]. Formula One World Championship Limited, 2022-2023 [cit. 24.04.2022].  
> Available at: https://www.formula1.com/en/drivers.html   
> **[2]** The 2021 Formula 1 cars [online]. RacingNews365, 2022 [cit. 17.04.2022].   
> Available at: https://racingnews365.com/2021-formula-1-car-names     
> **[3]** Seznam okruhů Formule 1 [online], Wikipedia, 2022 [cit. 27.04.2022].   
> Available at: https://cs.wikipedia.org/wiki/Seznam_okruh%C5%AF_Formule_1    
> **[4]** List of Formula One Grands Prix [online], Wikipedia, 2022 [cit. 27.04.2022].   
> Available at: https://en.wikipedia.org/wiki/List_of_Formula_One_Grands_Prix    
> **[5]** List of Formula One Seasons [online] Wikipedia, 2022 [cit. 27.04.2022].  
>  Available at: https://en.wikipedia.org/wiki/List_of_Formula_One_seasons    
> **[6]** Who are F1's new Race Directors for the 2022 season? [online], RacingNews365 [cit. 26.04.2022].  
>  Available at: https://racingnews365.com/who-are-formula-1s-new-race-directors    
> **[7]** Tímoví principáli [online] F1 Fandom  [cit. 26.04.2022].  
> Available at: https://f1.fandom.com/wiki/Team_principal  
> **[8]** List of Formula One Constructors [online] Wikipedia, 2022 [cit.27.04.2022].  
> Available at: https://en.wikipedia.org/wiki/List_of_Formula_One_constructors  
> **[9]** List of Formula One Engine Manufacturers [online] Wikipedia, 2022 [cit.27.04.2022].  
> Available at: https://en.wikipedia.org/wiki/List_of_Formula_One_engine_manufacturers  
> **[10]** Formula One 2021 Salaries [online]. Sportrac, 2021  [cit. 27.04.2022]. 
> Available at: https://www.spotrac.com/formula1/2021/    
> **[11]** Stránky předmětu DBS.BI-DBS FIT ČVUT Course Pages [online]. FIT ČVUT, 2022, [cit. 20.04.2021]. 
> Available at: https://courses.fit.cvut.cz  
> **[12]** HUNKA, Jiří Ing.: Zoo ve skluzu - Vzorová semestrální práce a **zdroj pre premazávaciu funkciu** [online] FIT ČVUT, 2022 [cit.20.04.2021].  
>  Available at: https://users.fit.cvut.cz/~hunkajir/dbs2/main.xml

