
# hbxlsxwriter

hbxlsxwriter: a library to create .xlsx file from Harbour

The library is source-code, self-contained and doesn't need any dll or other external libs.

### Sources from:

hbxlsxwriter is based on the original C library:
[libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter)
Code from libxlsxwriter is included in hbxlsxwriter so there is no need to access that library. The version included is 1.1.8 August 2024 <br>

### Acknowledgemnt

As far as I understand the first incarnation of 
hbxlsxwriter was originally developed by 
[https://github.com/riztan/hbxlsxwriter](https://github.com/riztan/hbxlsxwriter)

Then it was cloned (not forked?) and updated in this repository
[https://github.com/diegofazio/hbxlsxwriter](https://github.com/diegofazio/hbxlsxwriter)

Then I forked and made a lot of changes that I decided to publish. The changes are massive and I don't want to break other people projects so I decided not to create a PR.

***
### Note for this fork:

Done a lot of changes to improve the use of the library.

Several thousand of files were removed from the embedded C library, from tests and examples directory - they are not needed for compilation. Other files will be removed in the future.

The library I cloned from used variables of type pointer without proper runtime checking and this could lead to core dumps, sometimes at random.

<b>lxw_workbook</b> and <b>lxw_format</b> (and other) C structs are now implemented as proper Harbour variables and are correctly deleted when they go out of scope. They are also checked at runtime when used as parameters, so that the C library doesn't core dumps and reports a Harbour error instead.

Unfortunately at the moment C struct <b>lxw_worksheet</b> is not checked and may generate core dumps, but I actually don't see how to solve the problem. 

The origin library did not implement parameter checking, almost no parameters are checked, so there may be errors in Harbour code that goes undetected. Probably the library should raise an Harbour error if the C library reports an error.


Implemented row_col_options passed as hash. So the hash for document meta data (author, description, etc). Some more hashes should be implemented.

### PLEASE NOTE

Unlike the origin project, I provide no compiled library. You should compile it by yourself

Just clone the repository or unzip the download, build the library with

```C
hbmk2 hbxlsxwriter.hbp
```

Have a look in test directory (and hbmk.hbm file in that directory) to compile some sample code

### Sample code

```C

#include "hbxlsxwriter.ch"

#define ITEM  1
#define COST  2

function main() 

    local workbook, worksheet, row, col, aExpenses, hProperties

    aExpenses := { ;
       { "Rent", 1000 },;
		   { "Gas",   100 },;
		   { "Food",  300 },;
		   { "Gym",    50 } ;
    }

    /* Create a workbook and add a worksheet. */
    workbook  = workbook_new("properties.xlsx")
    worksheet = workbook_add_worksheet(workbook, NIL)

    hProperties := { "title" => "This is another title" , ;
                   "subject" => "This is the subject" , ;
                    "author" => "This is the author" , ;
                   "manager" => "This is the manager" , ;
                   "company" => "This is the company" , ;
                  "category" => "This is the category" , ;
                  "keywords" => "This is the keywords" , ;
                  "comments" => "This is the comments" , ;
                    "status" => "This is the status" , ;
            "hyperlink_base" => "This is the hyperlink" }

    workbook_set_properties( workbook, hProperties )

    col := 0

    /* Iterate over the data and write it out element by element. */
    for row := 1 to 4 
        worksheet_write_string(worksheet, row, col,     aExpenses[row][ITEM], NIL)
        worksheet_write_number(worksheet, row, col + 1, aExpenses[row][COST], NIL)
    next row

    /* Write a total using a formula. */
    worksheet_write_string (worksheet, row, col,     "Total",       NIL)
    worksheet_write_formula(worksheet, row, col + 1, "=SUM(B1:B4)", NIL)

    /* Save the workbook and free any allocated memory. */
    return workbook_close(workbook)

```
##
