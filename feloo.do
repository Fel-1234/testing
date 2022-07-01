clear
set obs 5
input str4 mystring
   -9
   -10
   999
   11
   21
 
gen mystring2 = mystring
l
replace mystring2 = "999" in 5
replace mystring2 = "9" in 1
l
foreach v in mystring mystring2 {
encode `v', gen(c`v')
quie su c`v' if `v'=="-9"
local a=r(mean)
if  r(N)== 0 {
local a
}
quie  su c`v' if `v'=="-10"
local b=r(mean)
if  r(N)== 0 {
local b
}
quie  su c`v' if `v'=="999"
local c=r(mean)
if  r(N)== 0 {
local c
}

if !missing("`a'") & !missing("`b'") & !missing("`c'"){
mvdecode c`v', mv("`a'"=.a \"`b'"=.b \"`c'"=.c)
}
if !missing("`a'") & !missing("`b'") & missing("`c'"){
mvdecode c`v', mv("`a'"=.a \"`b'"=.b )
}
if !missing("`a'") & missing("`b'") & missing("`c'"){
mvdecode c`v', mv("`a'"=.a)
}
if !missing("`a'") & missing("`b'") & !missing("`c'"){
mvdecode c`v', mv("`a'"=.a  \"`c'"=.c)
}
if missing("`a'") & !missing("`b'") & !missing("`c'"){
mvdecode c`v', mv("`b'"=.b \"`c'"=.c)
}
if missing("`a'") & missing("`b'") & !missing("`c'"){
mvdecode c`v', mv("`c'"=.c)
}
if missing("`a'") & !missing("`b'") & missing("`c'"){
mvdecode c`v', mv("`b'"=.b)
}
}

