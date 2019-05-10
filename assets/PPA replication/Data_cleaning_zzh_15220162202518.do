*******************
* Data Processing *
*******************
// Zhang Zihan

**** Merging ****
cd "/Users/zhangzihan/Documents/STATA_PPA/ppa_replication/merge"
use stu.dta, replace

merge 1:1 ids using par.dta
drop _merge

merge m:1 clsids using tea.dta
drop _merge

merge m:1 schids using sch.dta
drop _merge 

**** Data Cleaning ****
keep if ple1503 == 1 // 保留声称随机分班的学校
keep if ple16 == 2 // 保留8.9年级不重新分班的学校

// drop if hra05 == .
gen hra05_1 = hra05
replace hra05_1 = 0 if hra05 == 2 // 保留班主任声称随机分班的学校

gen gradeid = schids
replace gradeid = 1000 - schids if grade9 == 0

bysort gradeid: egen assign = mean(hra05_1)
drop if assign != 0 // 只要有报告不随机分班，就删除该年级

sort ids 

**** Rename Variables ****
keep ple1503 ple16 schid clsid ids grade9 hra05 tr_chn tr_mat tr_eng a01 a02a ///
fall a03 a05 a06 b01 c01 c03 c04 c08 stlb_2c stmedu stfedu hra01 hrc01 hrc02 ///
hrc03 hrc04 hrc05 hrc06 hrc07 hrc08 hrc11 hrc12 mata02 matb01 matb02 matb03 ///
matb04 matb05 matb06 matb07 matb08 matb11 matb12 chna02 chnb01 chnb02 chnb03 ///
chnb04 chnb05 chnb06 chnb07 chnb08 chnb11 chnb12 enga02 engb01 engb02 engb03 ///
engb04 engb05 engb06 engb07 engb08 engb11 engb12 a1204 a1205 a1206 c1301-c1309 ///
c1704 c1705 c14

drop hra05 ple1503 ple16

{ // 学生变量处理
rename stlb_2c parenthome
rename a1204 cog1
rename a1205 cog2
rename a1206 cog3
rename a01 stugirl

{ // 性别
	label var stugirl "indicator of girls"
	label value stugirl typelbl
	replace stugirl = 0 if stugirl == 1
	replace stugirl = 1 if stugirl == 2
	label define typelbl 0 "male" 1 "female"
						
	}
{ // 独生子女
	rename b01 only
	label var only "indicator of only child"
	replace only = 0 if only == 2
	label value only only_ 
	label define only_ 0 "No" 1 "Yes"
	}
{ // 少数民族
	rename a03 mino
	replace mino = 0 if mino == 1
	replace mino = 1 if mino != 0 & mino !=.
	label value mino mino_
	label define mino_ 0 "HAN ZU" 1"minority"
	}
{ // 本地户口
	rename a05 localres
	label var localres "indicator of local hukou"
	replace localres = 0 if localres == 2 & localres!= .
	label value localres local_
	label define local_ 0 "non local" 1 "local"
	}
{ // 农村户口
	rename a06 rural
	label var rural "indicator of rural hukou"
	replace rural = 0 if rural != 1 & rural != .
	}
{ //学生年龄
	replace fall = 2014 if fall == 0 & fall!=.
	replace fall = 2013 if fall == 1 & fall!=.
	gen studentage = fall - a02a if a02a != . & fall != .
	drop a02a
	label var studentage "age of student"
	}
{ //学前教育
	rename c01 pres
	replace pres = 0 if pres == 2
	label var pres "indicator of attending preschool"
	label value pres pres_
	label define pres_ 0 "No" 1 "Yes"
	}
{ //跳级
	rename c03 skipgr
	replace skipgr = 1 if skipgr > 0 & skipgr != .
	label var skipgr "indicator of skipping grade"
	}
{ //留级
	rename c04 repeatgr
	replace repeatgr = 1 if repeatgr >0 & repeatgr != .
	label var repeatgr "indicator of repeating grade"
	}
rename c08 primrank
replace primrank=. if primrank == 0
label var primrank "rank in Primary school"

{ // 父母教育
	rename stmedu momedu
	replace momedu = 0 if momedu == 1
	replace momedu = 6 if momedu == 2
	replace momedu = 9 if momedu == 3
	replace momedu = 11 if momedu == 4 | momedu == 5
	replace momedu = 12 if momedu == 6
	replace momedu = 15 if momedu == 7
	replace momedu = 16 if momedu == 8
	replace momedu = 18 if momedu == 9
	
	rename stfedu dadedu 
	replace dadedu = 0 if dadedu == 1
	replace dadedu = 6 if dadedu == 2
	replace dadedu = 9 if dadedu == 3
	replace dadedu = 11 if dadedu == 4 | momedu == 5
	replace dadedu = 12 if dadedu == 6
	replace dadedu = 15 if dadedu == 7
	replace dadedu = 16 if dadedu == 8
	replace dadedu = 18 if dadedu == 9
}
	
{ //生成标准化的成绩
	gen block = schids if grade9 == 0
	replace block = 1000 - schids if grade9 == 1
	bysort block: center tr_chn tr_mat tr_eng, standardize // 需要安装center包
	rename c_tr_chn score_chn
	rename c_tr_mat score_mat
	rename c_tr_eng score_eng
}

}

{ // 班主任变量处理
{ // 女性班主任
	rename hrc01 head_female
	replace head_female = 0 if head_female == 1
	replace head_female = 1 if head_female == 2
	label var head_female "indicator of female head teachers"
 	}
{ // 班主任年龄
	gen head_age = fall - hrc02 if hrc02 != . & fall != .
	label var head_age "age of head teacher"
	drop hrc02
}
{ // 班主任婚姻状况
	rename hrc03 head_married 
	replace head_married = 0 if head_married == 1
	replace head_married = 1 if head_married == 2
	replace head_married = . if head_married == 4
	label var head_married "marriage status of head teachers"
	}
{ // 班主任教育
	rename hrc04 head_edu
	replace head_edu = 18 if head_edu == 7
	replace head_edu = 16 if head_edu != 7 & head_edu != . & head_edu != 18
	label var head_edu "head teachers' years of education"
	}
{ // head_ped
	rename hrc05 head_ped
	replace head_ped = 0 if head_ped == 2
	label value head_ped head_ped_
	label define head_ped_ 0 "No" 1"Yes"
	}
{ // 教师资格证
	rename hrc06 head_cre
	replace head_cre = 0 if head_cre == 2
	label value head_cre cre_
	label define cre_ 0 "No" 1"Yes"
	}
	
	rename hrc07 head_exp
	
{ // 班主任跳槽没？
	rename hrc08 head_previous
	replace head_previous =0 if head_previous ==1
	replace head_previous =1 if head_previous ==2
	label var head_previous "head teacher has taught in other school before"
	label drop hrc08
	label value head_previous hrc08
	label define hrc08 0 "No" 1 "Yes"
	}
	
{ // head_tenure
	rename hrc11 head_tenure
	replace head_tenure = 0 if head_tenure == 2
	label value head_tenure tenure_
	label define tenure_ 0 "No" 1 "Yes"
	}
{ // 职称
	rename hrc12 head_zhicheng
	}
}

{ // 学科教师变量处理

{ //性别
	rename chnb01 female_chn
	rename matb01 female_mat
	rename engb01 female_eng
	replace female_chn = 0 if female_chn == 1
	replace female_chn = 1 if female_chn == 2
	replace female_mat = 0 if female_mat == 1
	replace female_mat = 1 if female_mat == 2
	replace female_eng = 0 if female_eng == 1
	replace female_eng = 1 if female_eng == 2
	label drop jtb01
	label define female_ 0 "male" 1"female"
	label value female_chn female_mat female_eng female_
	}
{ // 年龄
	gen age_chn = -(chnb02 - fall) if chnb02 != . & fall != .
	gen age_mat = -(matb02 - fall) if matb02 != . & fall != .
	gen age_eng = -(engb02 - fall) if engb02 != . & fall != .
	drop chnb02 matb02 engb02
	}
{ // 婚姻状况
	rename chnb03 married_chn 
	replace married_chn = 0 if married_chn == 1
	replace married_chn = 1 if married_chn == 2
	replace married_chn = . if married_chn == 4
	label var married_chn "marriage status of subject teachers"
	
	rename matb03 married_mat
	replace married_mat = 0 if married_mat == 1
	replace married_mat = 1 if married_mat == 2
	replace married_mat = . if married_mat == 4
	label var married_mat "marriage status of subject teachers"
	
	rename engb03 married_eng
	replace married_eng = 0 if married_eng == 1
	replace married_eng = 1 if married_eng == 2
	replace married_eng = . if married_eng == 4
	label var married_eng "marriage status of subject teachers"
	}
{ // 受教育程度
	rename chnb04 edu_chn
	rename matb04 edu_mat
	rename engb04 edu_eng
	
	replace edu_chn = 18 if edu_chn == 7
	replace edu_chn = 16 if edu_chn != 7 & edu_chn != . & edu_chn != 18
	
	replace edu_mat = 18 if edu_mat == 7
	replace edu_mat = 16 if edu_mat != 7 & edu_mat != . & edu_mat != 18
	
	replace edu_eng = 18 if edu_eng == 7
	replace edu_eng = 16 if edu_eng != 7 & edu_eng != . & edu_eng != 18

	label var edu_chn "head teachers' years of education"
	label var edu_mat "head teachers' years of education"
	label var edu_eng "head teachers' years of education"
	}

{ // ped
	rename chnb05 ped_chn
	rename matb05 ped_mat
	rename engb05 ped_eng
	
	replace ped_chn = 0 if ped_chn == 2
	replace ped_mat = 0 if ped_mat == 2
	replace ped_eng = 0 if ped_eng == 2
	
	label value ped_eng ped_mat ped_chn head_ped_
	}
{ // 教师资格证
	rename chnb06 cre_chn
	rename matb06 cre_mat
	rename engb06 cre_eng
	
	replace cre_mat = 0 if cre_mat == 2
	replace cre_eng = 0 if cre_eng == 2
	replace cre_chn = 0 if cre_chn == 2
	
	label value cre_eng cre_chn cre_mat cre_
	}
{ // 跳过槽吗
	rename chnb08 previous_chn
	rename matb08 previous_mat
	rename engb08 previous_eng

	replace previous_chn =0 if previous_chn ==1
	replace previous_chn =1 if previous_chn ==2
	
	replace previous_mat =0 if previous_mat ==1
	replace previous_mat =1 if previous_mat ==2

	replace previous_eng =0 if previous_eng ==1
	replace previous_eng =1 if previous_eng ==2	
	
	label var previous_eng "teacher has taught in other school before"
	label var previous_chn "teacher has taught in other school before"
	label var previous_mat "teacher has taught in other school before"

	label value previous_eng previous_mat previous_chn hrc08
	}
{ // 教学经验
	rename chnb07 exp_chn 
	rename matb07 exp_mat
	rename engb07 exp_eng
	}
	
{ // tenure
	rename chnb11 tenure_chn
	rename matb11 tenure_mat
	rename engb11 tenure_eng
	
	replace tenure_chn = 0 if tenure_chn == 2
	replace tenure_mat = 0 if tenure_mat == 2
	replace tenure_eng = 0 if tenure_eng == 2
	label value tenure_eng tenure_mat tenure_chn tenure_

	}
{ // 职称
	rename chnb12 zhicheng_chn
	rename matb12 zhicheng_mat
	rename engb12 zhicheng_eng
	}
	
	// indicator of main subject teacher of a head teacher
	
	gen which = hra01 - 1 if hra01 == 2
	replace which = hra01 +1 if hra01 ==1
	replace which = hra01 if hra01 ==3
	
	rename hra01 head_teacher
	replace head_teacher = 1 if head_teacher != 0 & head_teacher != .
	label value head_teacher teacher_
	label define teacher_ 0 "No" 1"Yes"
	label var head_teacher "indicator of head teacher teaching a main subject"
	
	drop fall
	
{ // self recognitive
	center c1301-c1309 c1704 c1705, standardize
	drop c1301-c1309 c1704 c1705
	sort ids
	rename c_c1301 useful_mat
	rename c_c1302 useful_chn
	rename c_c1303 useful_eng
	rename c_c1304 ques_mat
	rename c_c1305 ques_chn
	rename c_c1306 ques_eng
	rename c_c1307 prai_mat
	rename c_c1308 prai_chn
	rename c_c1309 prai_eng
	rename c_c1704 head_prai
	rename c_c1705 head_crit
	
	
	replace c14 = 0 if c14 ==2
	center c14, standardize
	drop c14
	rename c_c14 boymath

	}
	
	// reshape to long shape
	rename tr_chn tr1
	rename tr_mat tr2
	rename tr_eng tr3
	rename edu_chn edu1 
	rename ped_chn ped1
	rename cre_chn cre1
	rename exp_chn exp1
	rename previous_chn previous1
	rename tenure_chn tenure1
	rename zhicheng_chn zhicheng1
	rename edu_mat edu2 
	rename ped_mat ped2
	rename cre_mat cre2
	rename exp_mat exp2
	rename previous_mat previous2
	rename tenure_mat tenure2
	rename zhicheng_mat zhicheng2
	rename edu_eng edu3 
	rename ped_eng ped3
	rename cre_eng cre3
	rename exp_eng exp3
	rename previous_eng previous3
	rename tenure_eng tenure3
	rename zhicheng_eng zhicheng3
	rename score_chn score1
	rename score_mat score2
	rename score_eng score3
	rename age_chn age1
	rename age_mat age2
	rename age_eng age3
	rename useful_chn useful1
	rename useful_mat useful2
	rename useful_eng useful3
	rename ques_chn ques1
	rename ques_mat ques2
	rename ques_eng ques3
	rename prai_mat prai2
	rename prai_chn prai1
	rename prai_eng prai3
	rename married_chn married1
	rename married_mat married2
	rename married_eng married3
	rename female_chn female1
	rename female_mat female2
	rename female_eng female3
}
 drop chna02 mata02 enga02

**** save and reshape ****
save part1.dta,replace

// keep alternative variables
keep ids grade9 stugirl mino localres rural cog1 cog2 cog3 only ///
pres skipgr repeatgr primrank parenthome momedu dadedu head_teacher head_female ///
 head_married head_edu head_cre head_exp head_previous head_tenure head_zhicheng ///
 studentage block head_age head_prai head_crit head_ped boymath which
save part2.dta,replace

// keep individual variables
use part1.dta,replace

keep ids clsids schids tr1 tr2 tr3 female1 female2 female3 married1 married2 married3 edu1 edu2 edu3 ///
 ped1 ped2 ped3 cre1 cre2 cre3 previous1 previous2 previous3 tenure1 tenure2 tenure3 ///
 zhicheng1 zhicheng2 zhicheng3 exp1 exp2 exp3 score1 score2 score3 age1 age2 age3 ///
 useful1 useful2 useful3 ques1 ques2 ques3 prai1 prai2 prai3
 
 reshape long tr female married edu ped cre previous tenure zhicheng exp score ///
 age useful ques prai, i(ids clsids schids) j(sub)
 
 merge m:1 ids using part2.dta
 drop _merge
 
 // 标准化cog123
 
 center cog1 cog2 cog3, standardize 
 rename c_cog1 stdcog1
 rename c_cog2 stdcog2
 rename c_cog3 stdcog3
 
 label define sub_ 1 "chn" 2 "mat" 3 "eng"
 label value sub sub_
 
 **** 班主任补充学科教师缺失值****
 rename head_teacher head_main
 replace female = head_female if which == sub
 replace married = head_married if which == sub
 
 label define mar 0 "not married" 1 "married"
 label value married mar
 label value head_married mar
 
 replace edu = head_edu if which == sub
 replace ped = head_ped if which == sub 
 replace cre = head_cre if which == sub
 replace previous = head_previous if which == sub
 replace tenure = head_previous if which == sub
 replace zhicheng = head_zhicheng if which == sub
 replace exp = head_exp if which == sub
 replace age=head_age    if which == sub
 
 drop block which
 
 **** 补充label ****
 label var sub subject
 label var age "age of subject teacher"
 label var married "indicator of female subject teacher"
 label var edu "subject teachers' years of education"
 label var ped "subject teacher graduates from pedagogical universities of majors"
 label var cre "subject teacher has teacher certificates"
 label var tenure "subject teacher is an instuitionally registered teacher admitted by government"
 label var previous "subject teacher has taught"
 label var zhicheng "subject teacher's professional title"
 label var tr "orignial test result in 2013"
 label var exp "teacher's year of experience of teaching"
 label var female "indicator of a female teacher"
 label var score "test score(standardized) "
 label var prai "praised by subject teacher(normed)"
 label var ques "always ask questions (normed)"
 label var useful "student considers it helps future development"
 
 

 
 
