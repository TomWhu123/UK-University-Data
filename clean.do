clear all
set more off, permanently 
cd "/Users/tom/Downloads" 

import delimited "uni_data.csv", varnames(1)

encode name, gen(uni)

rename x year

destring total, replace ignore(",") force

xtset uni year

bysort uni: gen change = total - tota[_n-1]

drop name

order ukprn uni year female male unknown total change lat lon 

export delimited "universities_data.csv", replace
