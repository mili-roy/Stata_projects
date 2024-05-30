
drop if period>1
*Q1-a
proportion anychd
*Q1-b
proportion anychd if sex==1
proportion anychd if sex==2
tabulate anychd sex,col
*Q1-c
proportion anychd if age>=65
proportion anychd if age<65
gen new_age=.
replace new_age=1 if age>=65
replace new_age=0 if age<65
tabulate anychd new_age, col
*Q1-d
gen new_sexage=.
replace new_sexage=1 if sex==1 & age>=65 
replace new_sexage=2 if sex==1 & age<65 
replace new_sexage=3 if sex==2 & age>=65 
replace new_sexage=4 if sex==2 & age<65 
codebook new_totchol
label define new_sexagel 1"Male>65" 2"Male<65" 3"Female>65" 4"Female<65"
label value new_sexage new_sexage

proportion anychd if new_sexage==1
proportion anychd if new_sexage==2
proportion anychd if new_sexage==3
proportion anychd if new_sexage==4


proportion sex if anychd==0
tabulate sex if anychd==0
proportion sex if anychd==1
tabulate sex if anychd==1
proportion age if anychd==0
tabulate age if anychd==0
proportion age if anychd==1

*Q2
proportion stroke if hyperten==0
proportion stroke if hyperten==1

*Q3
*a
gen new_totchol= .
replace new_totchol=1 if totchol>200 
replace new_totchol=0 if totchol<=200
codebook new_totchol
label define new_totchol 1"hypercholesterolemia" 0"normal"
label value new_totchol new_totchol
proportion new_totchol
*b
gen tot_totchol=.
replace tot_totchol=totchol if totchol>200

gen hyperchol_level=.
replace hyperchol_level=1 if tot_totchol>400 
replace hyperchol_level=2 if tot_totchol<=400 
codebook hyperchol_level
label define hyperchol_level 1 "High cholesterol" 2 "Very high cholesterol", modify
label value hyperchol_level hyperchol_level
proportion anychd if hyperchol_level==1 
proportion anychd if hyperchol_level==2 

*c
gen normal_totchol=.
replace normal_totchol=1 if totchol<=200
proportion anychd if normal_totchol==1
tabulate anychd hyperchol_level,chi2
prtest anychd ,by(sex)
tab totchol
logit anychd i.hyperchol_level, or

