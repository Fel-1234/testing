/* stata assignment*/
*********************************
//load the stataversion datasets 
use "C:\Users\HP\Downloads\stataversion2.dta"
d, fullnames 
br Q5_9_2_1
//question 1)
renvars Q5_9_2_1 / finexclusion //
// install the package from ssc i.e sscpax renvars, action(nstall) or ssc install renvars 
// question ii) 
drop if missing(finexclusion) // drop the missing obs from outcome varaible
count
br finexclusion
d, short 
br Q1_3
// question iii) 
sort Q1_3
egen female_dummy = group(Q1_3), misssing 
 br female_dummy 
 // recode the new variable dummy where female is coded 0 and 1 for male
 recode female_dummy (2=1) (1=0) // 1 for male and 0 for females
 su ibn.female_dummy
 // question iv) generate single_dummy 
 gsort - Q1_4 // sort in ascending order 
 egen int single_dummy = group(Q1_4)
 // question v) generate dummy rural_dummy
 egen rural_dummy = group(RU), sort // sort RU
 // recode the variable rural_dummy i.e 1 for rurral and 0 for urban 
 ren rural_dummy rural_dweller 
 recode rural_dweller (2=0) 
 //question vi) generate new variable age_squared 
 ge int age_squaerd = (Q1_2)^2 
 //question vii) generate education dummy
 egen educ_dummy = group(Q1_5) 
 drop educ_dummy 
 //question viii) get summary statistics 
 renvars Q1_2 / age 
 su finexclusion educ_dummy single_dummy HH_size rural_dweller  age Monthly_Income 
 //probit regression modelling
 /* before executing the model estimation, recode depvar to 0/1 */
 sort finexclusion
 egen int financial_exclusion = group(finexclusion) 
 recode financial_exclusion (2=0) // for NO ==0 and YES == 1
 probit financial_exclusion  single_dummy Monthly_Income age age_squaerd HH_size educ_dummy, robust 
 est sto probit, title(probit)
 estwrite * using probit_model // install the package ssc inst estwrite
 est clear 
 estread probit_model
 *******END*******************************************8
 *************************STATA PROBIT MODELLLING***************
