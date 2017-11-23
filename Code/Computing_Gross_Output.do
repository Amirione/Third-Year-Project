***************************************************************************************************
*Author: Emeka N Ihuarulam
*3rd Year PhD Student
*Department of Economics
*University of Houston
*Answers to Problem Set 2---International Trade, ECON 8396
**************************************************************************************************


***************************************************************************************************
* The code computes gross output for Canada, Mexico, the UK and the US...
* To compute the gross output, I use data from the World Input Output Database, WIOD for 2007.
****************************************************************************************************

clear all

set more off

global PS2 "C:\Users\user\Documents\UHouston PhD\UH_Classes\3rd_Year_Classes\First Semester\International Trade\Homework\PS 2\Code"

cd "$PS2"

*local path "C:\Users\user\Documents\UHouston PhD\UH_Classes\3rd_Year_Classes\First Semester\International Trade\Homework\PS 2\Data\WIOT_2007"

cap log close

log using "Problem Set 2 Gross Output By Emeka_N_Ihuarulam", replace text

use "C:\Users\user\Documents\UHouston PhD\UH_Classes\3rd_Year_Classes\First Semester\International Trade\Homework\PS 2\Data\WIOT_2007", clear



bysort Country : egen gross_output=sum(TOT)


drop vAUS1-vROW61 IndustryCode IndustryDescription RNr TOT

collapse gross_output, by(Country)

save "C:\Users\user\Documents\UHouston PhD\UH_Classes\3rd_Year_Classes\First Semester\International Trade\Homework\PS 2\Data\gross_out", replace

log close




