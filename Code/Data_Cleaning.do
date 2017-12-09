***************************************************************************************************
*Author: Emeka N Ihuarulam
*3rd Year PhD Student
*Department of Economics
*University of Houston
**************************************************************************************************


***************************************************************************************************
* The code cleans data and puts it into usable form
****************************************************************************************************

clear all

set more off

//Relative folder position. Change the folder below only in a new computer.
cd "C:\Users\enihuaru\Documents\Third-Year-Project"

cap log close

log using "DataCleaningEKRegression", replace text


use ".\Data\WIOT2007", clear //Read in the World Input-Output table 2007 (WIOT 2007)


bysort Country : egen gross_output=sum(TOT) //compute gross output.

gen GrossOutput = 1000000*gross_output // gross_output is in millions


keep Country GrossOutput  //drop all other variables except the two


collapse GrossOutput, by(Country) // collapse by country

rename Country iso_o // a unique identifier to use to merge data below
sort iso_o

save ".\Data\GrossOutput", replace //save gross output

clear

//Read in data: trade (import) data is from comtrade website: http://comtrade.un.org/
// GDP data is from the IMF's WEO database: http://www.imf.org/
// Distances of all the country pairs are from: https://sites.google.com/site/hiegravity/
use ".\Data\FinalDataAfterDroppingWithinCountryImport2", clear
sort iso_o

merge n:1 iso_o using ".\Data\GrossOutput" // merge with gross output

drop if _merge==2 // drop unmerged data

drop if _merge==1 // drop unmerged data

drop _merge


//Compute trade shares.
gen tradeshares= import/GrossOutput

//compute home country shares
by iso_o, sort: egen sum_shares = sum(tradeshares)

gen home_country_shares = 1-sum_shares
drop sum_shares

//compute log of the ratio of the importing country shares to the home country shares.
gen logshare = log(tradeshares/home_country_shares)

merge 1:1 iso_o iso_d using ".\Data\DistCEPII"
keep if _merge==3

drop if GrossOutput==0

drop _merge

rename contig DummyBorder // DummyBorder is 1 if two country pairs shares a common border and zero otherwise.

// Save data in usable form.
save ".\Data\EKRegressionModelWaugh", replace // save data
clear





















log close
