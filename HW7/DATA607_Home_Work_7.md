DATA607\_Home\_Work\_7
================
Dilip Ganesan
03/18/2017

DATA 607 Home Work
------------------

Pick three of your favorite books on one of your favorite subjects. At least one of the books should have more than one author. For each book, include the title, authors, and two or three other attributes that you find interesting. Take the information that you’ve selected about these three books, and separately create three files which store the book’s information in HTML (using an html table), XML, and JSON formats (e.g. “books.html”, “books.xml”, and “books.json”). To help you better understand the different file structures, I’d prefer that you create each of these files “by hand” unless you’re already very comfortable with the file formats.

Environment Setup
-----------------

``` r
if (!require('rvest')) install.packages('rvest')
```

    ## Loading required package: rvest

    ## Loading required package: xml2

``` r
if (!require('XML')) install.packages('XML')
```

    ## Loading required package: XML

    ## 
    ## Attaching package: 'XML'

    ## The following object is masked from 'package:rvest':
    ## 
    ##     xml

``` r
if (!require('jsonlite')) install.packages('jsonlite')
```

    ## Loading required package: jsonlite

Loading files into R
--------------------

``` r
# Loading Html into R using rvest.
html=read_html("books.html")
html_tab=html_table(html)
html_df = data.frame(html_tab)
knitr::kable(html_df)
```

| title                          |  year| authors                                                        | publisher   |  numpages|  goodreadsrank|
|:-------------------------------|-----:|:---------------------------------------------------------------|:------------|---------:|--------------:|
| R for Data Sciene              |  2016| Hadley Wickham                                                 | O Reilly    |       492|            4.7|
| Data Structures and Algorithms |  2003| Robert Lafore                                                  | SAMS        |       780|            4.1|
| Automated Data Collection in R |  2015| Simon Munzert, Christian Rubba, Peter Meissner, Dominic Nyhuis | Wiley Press |       480|            4.0|

``` r
# Loading JSON into R using jsonlite.
json=fromJSON("books.json")

# Reference from strack trace to use the function.
json = lapply(json, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})
json_df=do.call("rbind", json)
json_df=t(json_df)

knitr::kable(json_df)
```

|                | rbooklist                      |
|----------------|:-------------------------------|
| title1         | R for Data Sciene              |
| title2         | Data Structures and Algorithms |
| title3         | Automated Data Collection in R |
| year1          | 2016                           |
| year2          | 2003                           |
| year3          | 2015                           |
| authors1       | Hadley Wickham                 |
| authors2       | Robert Lafore                  |
| authors3       | Simon Munzert                  |
| authors4       | Christian Rubba                |
| authors5       | Peter Meissner                 |
| authors6       | Dominic Nyhuis                 |
| publisher1     | O Reilly                       |
| publisher2     | SAMS                           |
| publisher3     | Wiley Press                    |
| numpages1      | 492                            |
| numpages2      | 780                            |
| numpages3      | 480                            |
| goodreadsrank1 | 4.7                            |
| goodreadsrank2 | 4.1                            |
| goodreadsrank3 | 4                              |

``` r
xml_file=xmlParse("books.xml")
xml_df=xmlToDataFrame(xml_file)

knitr::kable(xml_df)
```

| title                          | year | authors                                                        | publisher   | numpages | goodreadsrank |
|:-------------------------------|:-----|:---------------------------------------------------------------|:------------|:---------|:--------------|
| R for Data Sciene              | 2016 | Hadley Wickham                                                 | O Reilly    | 492      | 4.7           |
| Data Structures and Algorithms | 2003 | Robert Lafore                                                  | SAMS        | 780      | 4.1           |
| Automated Data Collection in R | 2015 | Simon Munzert, Christian Rubba, Peter Meissner, Dominic Nyhuis | Wiley Press | 480      | 4.0           |

Comparing Data Frames
---------------------

``` r
# Test Case 1 : HTML vs JSON

all.equal(html_df,json_df)
```

    ##  [1] "Modes: list, character"                                              
    ##  [2] "Lengths: 6, 21"                                                      
    ##  [3] "names for target but not for current"                                
    ##  [4] "Attributes: < Names: 2 string mismatches >"                          
    ##  [5] "Attributes: < Component 1: Modes: character, numeric >"              
    ##  [6] "Attributes: < Component 1: Lengths: 1, 2 >"                          
    ##  [7] "Attributes: < Component 1: target is character, current is numeric >"
    ##  [8] "Attributes: < Component 2: Modes: numeric, list >"                   
    ##  [9] "Attributes: < Component 2: Lengths: 3, 2 >"                          
    ## [10] "Attributes: < Component 2: target is numeric, current is list >"     
    ## [11] "current is not list-like"

``` r
# Test Case 1 : HTML vs XML

all.equal(html_df,xml_df)
```

    ##  [1] "Component \"title\": Modes: character, numeric"                              
    ##  [2] "Component \"title\": Attributes: < target is NULL, current is list >"        
    ##  [3] "Component \"title\": target is character, current is factor"                 
    ##  [4] "Component \"year\": Attributes: < target is NULL, current is list >"         
    ##  [5] "Component \"year\": target is numeric, current is factor"                    
    ##  [6] "Component \"authors\": Modes: character, numeric"                            
    ##  [7] "Component \"authors\": Attributes: < target is NULL, current is list >"      
    ##  [8] "Component \"authors\": target is character, current is factor"               
    ##  [9] "Component \"publisher\": Modes: character, numeric"                          
    ## [10] "Component \"publisher\": Attributes: < target is NULL, current is list >"    
    ## [11] "Component \"publisher\": target is character, current is factor"             
    ## [12] "Component \"numpages\": Attributes: < target is NULL, current is list >"     
    ## [13] "Component \"numpages\": target is numeric, current is factor"                
    ## [14] "Component \"goodreadsrank\": Attributes: < target is NULL, current is list >"
    ## [15] "Component \"goodreadsrank\": target is numeric, current is factor"

``` r
# Test Case 1 : JSON vs XML

all.equal(json_df,xml_df)
```

    ##  [1] "Modes: character, list"                                                           
    ##  [2] "Lengths: 21, 6"                                                                   
    ##  [3] "names for current but not for target"                                             
    ##  [4] "Attributes: < Names: 2 string mismatches >"                                       
    ##  [5] "Attributes: < Component 1: Modes: numeric, character >"                           
    ##  [6] "Attributes: < Component 1: Lengths: 2, 1 >"                                       
    ##  [7] "Attributes: < Component 1: target is numeric, current is character >"             
    ##  [8] "Attributes: < Component 2: Modes: list, numeric >"                                
    ##  [9] "Attributes: < Component 2: Length mismatch: comparison on first 2 components >"   
    ## [10] "Attributes: < Component 2: Component 1: Modes: character, numeric >"              
    ## [11] "Attributes: < Component 2: Component 1: Lengths: 21, 1 >"                         
    ## [12] "Attributes: < Component 2: Component 1: target is character, current is numeric >"
    ## [13] "Attributes: < Component 2: Component 2: Modes: character, numeric >"              
    ## [14] "Attributes: < Component 2: Component 2: target is character, current is numeric >"
    ## [15] "target is matrix, current is data.frame"

Test Result.
------------

Only the values in the data frames are same, but the structures are different. Test Case 1 and 3 looks somewhat identical.
