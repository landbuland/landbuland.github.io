//Replication Project 
//Ying Zeng

clear
cls
set more off
capture log close
cd "D:\Box Sync\Teaching\Applied microeconometrics\PPA_lectures\replication project"

log using replication_task1,replace

****************Part 1: Combine the data sets, select our sample****************
global datadir "D:\Box Sync\Data\CEPS2014"
use "$datadir/cepsw1studentEN.dta"
merge n:1 clsids using "$datadir/cepsw1teacherEN.dta"
drop _merge
merge n:1 schid using "$datadir/cepsw1principalEN.dta",keepusing(ple1503 ple16)
drop _merge

keep ple1503 ple16 schid clsid ids grade9 hra05 tr_chn tr_mat tr_eng ///
a01 a02a fall a03 a05 a06  b01 c01 c03 c04 c08 stlb_2c stmedu stfedu ///
hra01 hrc01 hrc02 hrc03 hrc04 hrc05 hrc06 hrc07 hrc08 hrc11 hrc12 ///
mata02 matb01 matb02 matb03 matb04 matb05 matb06 matb07 matb08 matb11 matb12 ///
chna02 chnb01 chnb02 chnb03 chnb04 chnb05 chnb06 chnb07 chnb08 chnb11 chnb12 ///
enga02 engb01 engb02 engb03 engb04 engb05 engb06 engb07 engb08 engb11 engb12 ///
a1204 a1205 a1206 c1301-c1309 c1704 c1705 c14

bysort schid grade9:egen tem=mean(hra05)
gen randclass=tem==2&ple1503==1&ple16==2
keep if randclass==1

****************Part 2: Define the variables**********************************
//female
gen stugirl=a01==2 if a01~=.  /*use a01 instead of stsex*/
label var stugirl "indicator of girl"
//age
gen studentage=2014-a02a-fall
label var studentage "age of the student"
//minority
gen mino=a03~=1 if a03~=.
label var mino "indicator of minority student"
//local
gen localres=a05==1 if a05~=.
label var localres "indicator of local residence"
//hukou
gen rural=.
replace rural=a06==1 if a06~=.&a06~=4 //This needs some special attention
label var rural "indicator of rural students"
//only
gen only=b01==1 if b01~=.
label var only "indicator of only child"
//preschool
gen pres=c01==1 if c01~=.
label var pres "indicator of attending preschool"
//repeat
gen repeatgr=c04>0 if c04~=.
label var repeatgr "indictor of repeating grade"
//skip
gen skipgr=c03>0 if c03~=.
label var skipgr "indicator of skipping grade"
//rank
rename c08 primrank
replace primrank=. if primrank==0 //Note, 0
label var primrank "rank in primary school"
//mother's years of schooling
recode stmedu (1=0) (2=6) (3=9) (4=11) (5=11) (6=12) (7=15) (8=16) (9=18),gen(momedu)
label var momedu "mother's years of schooling"
//father's years of schooling
recode stfedu (1=0) (2=6) (3=9) (4=11) (5=11) (6=12) (7=15) (8=16) (9=18),gen(dadedu) //different from mothers
label var dadedu "father's years of schooling"

local subs "chn mat eng" //some mino mistakes in Gong
foreach sub of local subs{
bysort schid grade9:egen mean_`sub'=mean(tr_`sub')             
bysort schid grade9:egen sd_`sub'=sd(tr_`sub')             
gen score_`sub'=(tr_`sub'-mean_`sub')/sd_`sub'
}
local subs "hrc chnb matb engb"
foreach sub of local subs{
gen female_`sub'=`sub'01==2 if `sub'01~=.
gen age_`sub'=2014-fall-`sub'02
gen married_`sub'=`sub'03~=1 if `sub'03<=2
gen edu_`sub'=16+2*(`sub'04==7) if `sub'04~=.
gen ped_`sub'=`sub'05==1 if `sub'05~=.
gen cre_`sub'=`sub'06==1 if `sub'06~=.
rename `sub'07 exp_`sub'
gen tenure_`sub'=`sub'11==1 if `sub'11~=.
rename `sub'12 zhicheng_`sub'
gen previous_`sub'=`sub'08==1 if `sub'08~=.
}
local tchcha "female age married edu ped cre exp tenure zhicheng previous"
local subs "chn mat eng"
gen head_teach=hra01
drop hra01
recode head_teach (2=1) (1=2),gen(hra01)
local j=1
foreach sub of local subs{
foreach v of local tchcha{
replace `v'_`sub'b=`v'_hrc if `v'_`sub'==.&hra01==`j'
rename `v'_`sub'b `v'_`sub'
}
local j=`j'+1
}

foreach v of local tchcha{
rename `v'_hrc head_`v'
}

forvalues i=4/6{
local j=`i'-3
bysort schid grade9:egen mean`i'=mean(a120`i')
bysort schid grade9:egen sd`i'=sd(a120`i')
gen stdcog`j'=(a120`i'-mean`i')/sd`i'
rename a120`i' cog`j'
}

egen block=group(schid grade9)
local subs "chn mat eng"
foreach sub of local subs{
gen inter_`sub'=female_`sub'*stugirl
gen tch14_`sub'=`sub'a02==2014
}
gen head_inter=head_female*stugirl
gen head_main=hra01>0 if hra01~=.

local vlist "useful ques prai"
local subs "mat chn eng"
local i=1
drop mean* sd*
foreach v of local vlist{
foreach sub of local subs{
egen mean`i'=mean(c130`i')
egen sd`i'=sd(c130`i')
gen `v'_`sub'=(c130`i'-mean`i')/sd`i'
local i=`i'+1
}
}
drop mean* sd*
local vlist "prai crit"
local i=4
foreach v of local vlist{
egen mean`i'=mean(c170`i')
egen sd`i'=sd(c170`i')
gen head_`v'=(c170`i'-mean`i')/sd`i'
local i=`i'+1
}
gen boymath=c14==1 if c14~=.
drop mean*
egen meanb=mean(boymath)
egen sdb=sd(boymath)
replace boymath=(boymath-meanb)/sdb
rename stlb_2c parenthome

local xlist "studentage mino localres rural only pres repeatgr skipgr primrank momedu dadedu stdcog1 stdcog2 stdcog3"
local tchcha "age married edu ped cre exp tenure zhicheng previous"


keep `xlist' parenthome schid clsid ids boymath schid grade9 stugirl head* *_chn *_mat *_eng cog1 cog2 cog3
drop head_teach
reshape long female inter tch14 `tchcha' score tr ques prai useful,i(ids) j(_sub) string
encode _sub,gen(sub0)
recode sub0 (1=1 "chn") (2=3 "eng") (3=2 "mat"),gen(sub) 
drop _sub sub0
label var female "indicator of female subject teacher"
label var age "age of subject teacher"
label var married "indicator of married subject teacher"
label var edu "subject teacher's years of education"
label var ped "subject teacher graduates from pedagogical universities or pedagogical majors"
label var cre "subject teacher has teacher certification"
label var tenure "subject teacher is a institutionally registered teacher admitted by the government"
label var previous "subject teacher has taught in other school before"
label var exp "subject teacher's years of experience"
label var zhicheng "subject teacher's professional title in teaching"
label var score "test score"
label var prai "praised by subject teacher (normalized)"
label var ques "subject teacher always asks the students to answer questions in class(normalized)"
label var useful "sutdent considers the subject helps a lot with future development"

label var head_female "indicator of female head teacher"
label var head_age "age of head teacher"
label var head_married "indicator of married head teacher"
label var head_edu "head teacher's years of education"
label var head_ped "head teacher graduates from pedagogical universities or pedagogical majors"
label var head_cre "head teacher has teacher certification"
label var head_tenure "head teacher is a institutionally registered teacher admitted by the government"
label var head_previous "head teacher has taught in other school before"
label var head_exp "head teacher's years of experience"
label var head_zhicheng "head teacher's professional title in teaching"
label var stdcog1 "normalized score of cog1"
label var stdcog2 "normalized score of cog2"
label var stdcog3 "normalized score of cog3"
label var head_main "indicator that head teacher is teaching a main subject"
label var head_prai "always praised by head teacher (homeroom teacher)(normalized)"
label var head_crit "always criticied by head teacher (homeroom teacher)(normalized)"
label var boymath " Do you agree that boys are better at mathematics than girls?(Nomalized)"
label var sub "subject"
label var tr "original test results in the mideterm of 2013"
drop inter head_inter tch14
save ppa_rep,replace
log close
