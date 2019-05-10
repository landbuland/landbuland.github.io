*********************************************************
********************** replication **********************
*********************************************************
** Author: Zhang Zihan, https://landbuland.github.io/ **

// ssc install outreg 

**** Login ****

pwd
cd"/Users/zhangzihan/Documents/STATA_PPA/ppa_replication"
clear
set more off
capture log close
log using rep_zzh,replace
// log using rep_zzh,replace //生产日志文件

**** descriptive statistics (Table 1)****

use ppa_rep.dta, replace

keep ids tr score female sub head_female stugirl studentage mino localres rural ///
only pres repeatgr skipgr primrank momedu dadedu cog1 cog2 cog3 stdcog1 stdcog2  ///
stdcog3 clsids schids grade9 //筛选数据

outreg2 using table1_1.tex ,replace sum(log) keep(tr female) eqkeep(mean sd N) 

reshape wide tr score female, i(ids) j(sub)

outreg2 using table1_2.tex ,replace sum(log) keep(head_female stugirl ///
studentage mino localres rural only pres repeatgr skipgr primrank momedu ///
dadedu cog1 cog2 cog3) eqkeep(mean sd N)


// reshape long

**** Balance Test (Table 2) ****

gen block = schids
replace block = 1000-schid if grade9 == 0

areg head_female stugirl studentage mino localres rural only pres repeatgr ///
skipgr primrank momedu dadedu stdcog1 stdcog2 stdcog3, absorb(block) cluster(block)

outreg2 using table2.txt,  e(F,pvalue) bdec(4) tdec(2) replace ctitle(Female head teacher)

areg female2 stugirl studentage mino localres rural only pres repeatgr ///
skipgr primrank momedu dadedu stdcog1 stdcog2 stdcog3, absorb(block) cluster(block)

outreg2 using table2.txt,  e(F,pvalue) bdec(4) tdec(2) append ctitle(Female math teacher)

areg female1 stugirl studentage mino localres rural only pres repeatgr ///
skipgr primrank momedu dadedu stdcog1 stdcog2 stdcog3, absorb(block) cluster(block)

outreg2 using table2.txt,  e(F,pvalue) bdec(4) tdec(2) append ctitle(Female Chinese teacher)

areg female3 stugirl studentage mino localres rural only pres repeatgr ///
skipgr primrank momedu dadedu stdcog1 stdcog2 stdcog3, absorb(block) cluster(block)

outreg2 using table2.tex,  e(F,pvalue) bdec(4) tdec(2) append ctitle(Female English teacher)

reshape long

**** Effect, panal B (table 3) ****
use ppa_rep.dta, replace
gen inter = female*stugirl
gen head_inter = head_female * stugirl 

// drop block

gen block = schids 
replace block = 1000 - schids if grade9 == 0

// 定义学生教师控制变量
global student_controls studentage primrank momedu dadedu mino rural localres only pres repeatgr skipgr stdcog1 stdcog2 stdcog3
global teacher_controls age exp zhicheng married cre tenure ped previous edu 
global head_controls head_main head_married head_edu head_cre head_exp head_previous head_tenure head_age head_ped

eststo: areg score inter female head_inter head_female stugirl, absorb(block) cluster(block)

// for column 5 in panel B
areg score inter female head_inter head_female stugirl $student_controls $teacher_controls $head_controls i.sub,absorb(block) cluster(block) 
outreg2 using table3.txt, keep(inter female head_inter head_female stugirl) replace bdec(4) sdec(4) ctitle(score) addtext(subject FE,yes,teacher controls,yes)

// for column 3 
areg score inter female stugirl $student_controls $teacher_controls i.sub if e(sample), absorb(block) cluster(block) 
outreg2 using table3.txt, keep(inter female head_inter head_female stugirl) append  bdec(4) sdec(4) ctitle(score) addtext(subject FE,yes,teacher controls,yes)

// for column 1 
areg score head_inter head_female stugirl $student_controls $head_controls i.sub  if e(sample), absorb(block) cluster(block)
outreg2 using table3.txt, keep(inter female head_inter head_female stugirl) append  bdec(4) sdec(4) ctitle(score) addtext(subject FE,yes,teacher controls,yes)

// for column 5 in panel A
areg score inter female head_inter head_female stugirl $student_controls i.sub if e(sample), absorb(block) cluster(block)
outreg2 using table3.txt, keep(inter female head_inter head_female stugirl) append bdec(4)  sdec(4) ctitle(score) addtext(subject FE,yes,teacher controls,no)

// for column 3 
areg score inter female stugirl $student_controls i.sub if e(sample),absorb(block) cluster(block) 
outreg2 using table3.txt, keep(inter female head_inter head_female stugirl) append bdec(4) sdec(4) ctitle(score) addtext(subject FE,yes,teacher controls,no)

// for column 1
areg score head_inter head_female stugirl $student_controls i.sub if e(sample),absorb(block) cluster(block) 
outreg2 using table3.tex, keep(inter female head_inter head_female stugirl) append bdec(4) sdec(4) ctitle(score) addtext(subject FE,yes,teacher controls,no)

**** machnism - teacher gender, colunm 1 (table 5)****
// create it controls = teacher_controls * teacher gender
gen it_age = age * female
gen it_exp =exp * female
gen it_zhicheng = zhicheng * female
gen it_married = married * female
gen it_cre = cre* female
gen it_tenure = tenure * female 
gen it_ped =ped * female
gen it_previous = previous * female 
gen it_edu = edu * female
global it_controls "it_age it_exp it_zhicheng it_married it_cre it_tenure it_ped it_previous it_edu"


// create ih controls = head_controls * teacher gender
gen ih_age = head_age * head_female
gen ih_exp = head_exp * head_female
gen ih_main = head_main * head_female
gen ih_married = head_married * head_female
gen ih_cre = head_cre* head_female
gen ih_tenure = head_tenure * head_female 
gen ih_ped = head_ped * head_female
gen ih_previous = head_previous * head_female 
gen ih_edu = head_edu * head_female
global ih_controls "head_main head_married head_edu head_cre head_exp head_previous head_tenure head_age head_ped"

// create ih1 controls = head_controls * teacher gender
gen ih1_age = head_age * stugirl
gen ih1_exp = head_exp * stugirl
gen ih1_main = head_main * stugirl
gen ih1_married = head_married * stugirl
gen ih1_cre = head_cre* stugirl
gen ih1_tenure = head_tenure * stugirl 
gen ih1_ped = head_ped * stugirl
gen ih1_previous = head_previous * stugirl 
gen ih1_edu = head_edu * stugirl
global ih1_controls "head_main head_married head_edu head_cre head_exp head_previous head_tenure head_age head_ped"

// create is controls = teacher_controls * student gender

gen is1_age = age * stugirl
gen is1_exp =exp * stugirl
gen is1_zhicheng = zhicheng * stugirl
gen is1_married = married * stugirl
gen is1_cre = cre* stugirl
gen is1_tenure = tenure * stugirl 
gen is1_ped =ped * stugirl
gen is1_previous = previous * stugirl 
gen is1_edu = edu * stugirl

global is_controls  is1_age is1_exp is1_zhicheng is1_married is1_cre is1_tenure ///
is1_ped is1_previous is1_edu
 
areg score inter female head_female head_inter stugirl i.sub  $student_controls $teacher_controls $head_controls $it_controls $is_controls , absorb(block) cluster(block)
outreg2 using table5.tex, keep(inter) replace bdec(4) tdec(4) ctitle(score) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes,female student * teacher control,yes,female teacher * teacher control,yes)

**** Teacher behaviour (table 6) ****
// column 1 
areg ques inter female head_inter head_female stugirl $student_controls $teacher_controls $head_controls i.sub, absorb(block) cluster(block)
outreg2 using table6.txt, keep(inter female head_inter head_female stugirl) replace ctitle(ques) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// column 2 
areg prai inter female head_inter head_female stugirl $student_controls $teacher_controls $head_controls i.sub, absorb(block) cluster(block)
outreg2 using table6.txt, keep(inter female head_inter head_female stugirl) append ctitle(prai) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// colunm 3
areg head_prai head_inter head_female stugirl $student_controls $head_controls  if sub == 1, absorb(block) cluster(block)
outreg2 using table6.txt, keep(inter female head_inter head_female stugirl) append ctitle(head_prai) bdec(4) sdec(4) addtext(block FE,yes,student control,yes,teacher controls,yes)
// column 4 
areg head_crit head_inter head_female stugirl $student_controls $head_controls  if sub == 1, absorb(block) cluster(block)
outreg2 using table6.tex, keep(inter female head_inter head_female stugirl) append ctitle(head_crit) bdec(4) sdec(4) addtext(block FE,yes,student control,yes,teacher controls,yes)

**** Students' response (table 7)****
// create math intersection term 
gen inter_math = inter if sub == 2
gen female_math = female if sub == 2

areg boymath inter_math female_math stugirl  $student_controls $teacher_controls ,absorb(block) cluster(block)
outreg2 using table7.txt, keep (inter_math female_math stugirl) replace ctitle(boymath) bdec(4) sdec(4) addtext(block FE,yes,student control,yes,teacher controls,yes)

areg useful inter female stugirl head_inter head_female $student_controls $teacher_controls $head_controls i.sub, absorb(block) cluster(block)
outreg2 using table7.tex, keep (inter female stugirl) append ctitle(useful) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)


**** Heterogeneous effect (table 8)**** 
// c1
areg score inter female stugirl head_female head_inter $student_controls $teacher_controls $head_controls i.sub if momedu > 9 & momedu != . ,absorb(block) cluster(block)
outreg2 using table8.txt, keep (inter female stugirl) replace ctitle(score) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// c2
areg score inter female stugirl head_female head_inter $student_controls $teacher_controls $head_controls i.sub if momedu <= 9 & momedu != .,absorb(block) cluster(block) 
outreg2 using table8.txt, keep (inter female stugirl) append ctitle(score) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// c3
areg score inter female stugirl head_female head_inter $student_controls $teacher_controls $head_controls i.sub if mino == 0,absorb(block) cluster(block)
outreg2 using table8.txt, keep (inter female stugirl) append ctitle(score) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// c4
areg score inter female stugirl head_female head_inter $student_controls $teacher_controls $head_controls i.sub if mino == 1,absorb(block) cluster(block)
outreg2 using table8.txt, keep (inter female stugirl) append ctitle(score) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// c5
areg score inter female stugirl head_female head_inter $student_controls $teacher_controls $head_controls i.sub if parenthome == 0,absorb(block) cluster(block)
outreg2 using table8.txt, keep (inter female stugirl) append ctitle(score) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)
// c6
areg score inter female stugirl head_female head_inter $student_controls $teacher_controls $head_controls i.sub if parenthome == 1,absorb(block) cluster(block)
outreg2 using table8.tex, keep (inter female stugirl) append ctitle(score) bdec(4) sdec(4) addtext(subject FE,yes,block FE,yes,student control,yes,teacher controls,yes)

log close
