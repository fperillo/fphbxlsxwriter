
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

Several thousand of files were removed from the embedded c library, from tests and examples directory - they are not needed for compilation. Other files will be removed in the future.

The library I cloned from used variables of type pointer without proper runtime checking and this could lead to core dumps, sometimes at random.

<b>lxw_workbook</b> and <b>lxw_format</b> (and other) c structs are now implemented as proper Harbour variables and are correctly deleted when they go out of scope. They are also checked at runtime when used as parameters, so that the C library doesn't core dumps and reports a Harbour error instead.

Unfortunately at the moment C struct <b>lxw_worksheet</b> is not checked and may generate core dumps, but I actually don't see how to solve the problem. 

The origin library did not implement parameter checking, almost no parameters are checked, so there may be errors in Harbour code that goes undetected. Probably the library should raise an Harbour error if the C library reports an error.


Implemented row_col_options passed as hash. So the hash for document meta data (author, description, etc). Some more hashes should be implemented.

### PLEASE NOTE

Unlike the origin project, I provide no compiled library. You should compili it by yourself

Just clone the repository or unzip the download, build the library with
hbmk2 hbxlsxwriter.hbp

Have a look in test directory (and hbmk.hbm file in that directory) to compile some sample code
To link, 
