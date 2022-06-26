/*
Name:Felixkipkirui2018@gmail.com
PROGRAMMING IN STATA (TIME SERIES MODELLING) USING FINANCIAL TOOL PACKAGES IN STATA
FIELD SPECIALITY:STATA FOR STATISTICS
*/
clear all
set scheme sj
github install yalescheme
sscpax  sjlog,action(install) // installing packages from stata community site
//load datasets and log them to create log file
sjlog using candlechart1, replace
findit fetchyahooquotes //load package from Statistical Software Components
fetchyahooquotes AAPL, freq(d) chg(ln) start(01may2017) end(10december2017) field(o c h l v)
generate obs=_n //creating a sequence of obs
tsset obs
replace volume_AAPL = volume_AAPL/1000000
candlechart AAPL if month(date)>7
sjlog close, replace // log the log-file
graph export candlechart1.eps, replace 


sjlog using candlechart2, replace
clear all
fetchyahooquotes AAPL, freq(d) chg(ln) start(01may2017) end(10december2017) field(o c h l v)
generate obs=_n
tsset obs
replace volume_AAPL = volume_AAPL/1000000
candlechart AAPL if month(date)>7, price volume
sjlog close, replace
graph export candlechart2.eps, replace

sjlog using candlechart3, replace
clear all
fetchyahooquotes AAPL, freq(d) chg(ln) start(01may2017) end(10december2017) field(o c h l v)
generate obs=_n
tsset obs
replace volume_AAPL = volume_AAPL/1000000
candlechart AAPL if month(date)>7, price volume macd rsi bollinger
sjlog close, replace
gr export candlechart3.eps, replace /// exporting graph in terms of (Encapsulated PostScript)
//the file can be accesed using the following command in stata
gr use candelchart3 
sjlog using candlechart4, replace
clear all
fetchyahooquotes AAPL, freq(d) chg(ln) start(01may2017) end(10december2017) field(o c h l v)
generate obs=_n
tsset obs
replace volume_AAPL = volume_AAPL/1000000
//load the package boolinger ,rsi from SSC which are the top Financial tool package in STATA
candlechart AAPL if month(date)>7, price volume macd rsi bollinger ///
chart_options(ylabel(,angle(horizontal) format(%5.0fc)) ///
xlabel(, angle(vertical) format(%td)) scale(.50)) ///
combined_chart_options(title(Technical analysis charts for AAPL, size(3)))
sjlog close, replace
graph export candlechart4.eps, replace



