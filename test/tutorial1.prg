/*
 * A simple program to write some data to an Excel file using the
 * libxlsxwriter library.
 *
 * This program is shown, with explanations, in Tutorial 1 of the
 * libxlsxwriter documentation.
 *
 * Copyright 2014-2018, John McNamara, jmcnamara@cpan.org
 *
 * Adapted for Harbour by Riztan Gutierrez, riztan@gmail.com
 *
 */

#include "hbxlsxwriter.ch"

#define ITEM  1
#define COST  2

function main() 

    local workbook, worksheet, row, col, aExpenses, bold

    aExpenses := { ;
	           { "Rent", 1000 },;
		   { "Gas",   100 },;
		   { "Food",  300 },;
		   { "Gym",    50 } ;
                 }

    /* Create a workbook and add a worksheet. */
    workbook  = workbook_new("tutorial01.xlsx")
    worksheet = workbook_add_worksheet(workbook, NIL)

    /* Add a bold format to use to highlight cells. */
    bold = workbook_add_format(workbook)
    format_set_bold(bold)

    col := 0

    /* Write some data header. */
    worksheet_write_string(worksheet, 0, col,     "Item", bold)
    worksheet_write_string(worksheet, 0, col + 1, "Cost", bold)

    /* Iterate over the data and write it out element by element. */
    for row := 1 to 4 
        worksheet_write_string(worksheet, row, col,     aExpenses[row][ITEM], NIL)
        worksheet_write_number(worksheet, row, col + 1, aExpenses[row][COST], NIL)
    next row

    /* Write a total using a formula. */
    worksheet_write_string (worksheet, row-1, col,     "Total",       NIL)
    worksheet_write_formula(worksheet, row-1, col + 1, "=SUM(B1:B4)", NIL)

    /* Save the workbook and free any allocated memory. */
    return workbook_close(workbook)

//eof
