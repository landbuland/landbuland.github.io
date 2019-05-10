//Replication Project: task 2 
//Ying Zeng

clear
cls
set more off
capture log close
cd "D:\Box Sync\Teaching\Applied microeconometrics\PPA_lectures\replication project"

log using ppa_rep_task2,replace
use ppa_rep,clear

gen inter=female*stugirl
gen head_inter=head_female*stugirl
egen block=group(schid grade9)

local xlist "studentage mino localres rural only pres repeatgr skipgr primrank momedu dadedu stdcog1 stdcog2 stdcog3"
local tchcha "age married edu ped cre exp tenure zhicheng previous"
local headchar "head_age head_married head_edu head_ped head_cre head_exp head_tenure head_previous head_main"

//Table 1
eststo clear
qui estpost sum tr female
esttab using tab1, cells("mean(fmt(2)) sd(fmt(2)) count(fmt(0))") noobs replace
qui estpost sum head_female stugirl studentage mino localres rural only pres repeatgr skipgr primrank momedu dadedu cog1 cog2 cog3 if sub==1
esttab using tab1, cells("mean(fmt(2)) sd(fmt(2)) count(fmt(0))") noobs append

//Table 2
eststo clear
qui eststo: areg head_female stugirl `xlist' if sub==1,absorb(block) cluster(block)
forvalues i=1/3{
qui eststo: areg female stugirl `xlist' if sub==`i',absorb(block) cluster(block)
}
esttab using tab2.txt,b(%9.3f) se(%9.3f) scalars(F p r2) replace //You just need F for all

//Table 3
eststo clear
qui eststo: areg score inter female head_inter head_female stugirl `xlist' `tchcha'  i.sub `headchar' ,absorb(block) cluster(block)
qui eststo: areg score inter female                        stugirl `xlist' `tchcha'  i.sub            if e(sample)==1,absorb(block) cluster(block)
qui eststo: areg score              head_inter head_female stugirl `xlist'           i.sub `headchar' if e(sample)==1 ,absorb(block) cluster(block) 
qui eststo: areg score inter female head_inter head_female stugirl `xlist'  i.sub if e(sample)==1 ,absorb(block) cluster(block)
qui eststo: areg score inter female stugirl `xlist' i.sub if e(sample)==1 ,absorb(block) cluster(block)
qui eststo: areg score head_inter head_female  stugirl `xlist'  i.sub if e(sample)==1,absorb(block) cluster(block)
esttab using tab3.txt,b(%9.3f) se(%9.3f) keep(inter female head_inter head_female stugirl) r2 replace

//Table 5
eststo clear
qui eststo: areg score inter female head_inter head_female stugirl `xlist' `tchcha'  i.sub `headchar' female#c.(`tchcha') stugirl#c.(`tchcha'),absorb(block) cluster(block)
esttab using tab5.txt,b(%9.3f) se(%9.3f)  keep(inter) r2 replace

//Table 6
eststo clear
qui eststo: areg ques inter female head_inter head_female stugirl  `xlist' `tchcha' `headchar' i.sub ,absorb(block) cluster(block)
qui eststo: areg prai inter female head_inter head_female stugirl  `xlist' `tchcha' `headchar' i.sub ,absorb(block) cluster(block)
qui eststo: areg head_prai head_inter head_female stugirl          `xlist' `headchar' if sub==1,absorb(block) cluster(block)
qui eststo: areg head_crit head_inter head_female stugirl          `xlist' `headchar' if sub==1,absorb(block) cluster(block)
esttab using tab6.txt,b(%9.3f) se(%9.3f) keep(inter female head_inter head_female stugirl) r2 replace //minor difference in R2 and observations

//Table 7
eststo clear
qui eststo: areg boymath inter female stugirl  `xlist' `tchcha' if sub==2,absorb(block) cluster(block) 
qui eststo: areg useful inter female head_inter head_female stugirl  `xlist' `tchcha' `headchar' i.sub ,absorb(block) cluster(block)
esttab using tab7.txt,b(%9.3f) se(%9.3f) keep(inter female stugirl) r2 replace

//Table 8
eststo clear
qui eststo: areg score inter female head_inter head_female  stugirl `xlist' `tchcha'  i.sub `headchar' if momedu>9,absorb(block) cluster(block) 
qui eststo: areg score inter female head_inter head_female  stugirl `xlist' `tchcha'  i.sub `headchar' if momedu<=9,absorb(block) cluster(block) 
qui eststo: areg score inter female head_inter head_female  stugirl `xlist' `tchcha'  i.sub `headchar' if mino==0,absorb(block) cluster(block) 
qui eststo: areg score inter female head_inter head_female  stugirl `xlist' `tchcha'  i.sub `headchar' if mino==1,absorb(block) cluster(block)
qui eststo: areg score inter female head_inter head_female  stugirl `xlist' `tchcha'  i.sub `headchar' if parenthome==0, absorb(block) cluster(block)
qui eststo: areg score inter female head_inter head_female  stugirl `xlist' `tchcha'  i.sub `headchar' if parenthome==1, absorb(block) cluster(block)
esttab using tab8.txt,b(%9.3f) se(%9.3f) keep(inter female  stugirl) r2 replace

log close
