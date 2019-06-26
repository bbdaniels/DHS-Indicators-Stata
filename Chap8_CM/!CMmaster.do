/*******************************************************************************************************************************
Program: 				CMmaster.do
Purpose: 				Master file for the Child Mortality Chapter. 
						The master file will call other do files that will produce the CM indicators and produce tables.
Data outputs:			coded variables and table output on screen and in excel tables.  
Author: 				Shireen Assaf			
Date last modified:		April 30, 2019
*******************************************************************************************************************************/
set more off

*local user 39585	//change employee id number to personalize path
global user 33697
cd "C:/Users/$user/ICF/Analysis - Shared Resources/Code/DHS-Indicators-Stata/Chap8_CM"

global datapath "C:/Users/$user/ICF/Analysis - Shared Resources/Data/DHSdata"

* select your survey

* IR Files
global irdata "KHIR73FL"
* MMIR71FL TJIR70FL GHIR72FL UGIR7AFL

global brdata "KHBR73FL"
* MMBR71FL TJBR70FL GHBR72FL UGBR7AFL

global krdata "KHKR73FL"
****************************

* do files that use the IR files

do CM_CHILD.do
*Purpose: 	Code child mortality indicators
*Code contains programs that will produce an excel file and data file with the mortality rates overall and by background variables with confidence interals
*The outputs will be manipulated to produce tables that match the tables in the reports.  
* WARNING: This code takes some time to run (about 5mins). 

do CM_PMR.do
*Purpose: 	Code perinatal mortality
*This do file uses IR and BR file

do CM_tables1.do
*Purpose: 	Produce tables for indicators computed from above do files. 

* open dataset
use "$datapath//$irdata.dta", clear

gen file=substr("$irdata", 3, 2)

do CM_RISK_wm.do
*Purpose: 	Code high risk fertility indicators amoung women
*WARNING: This do file will drop women that are not currently married

do CM_tables2.do
*Purpose: 	Produce tables for high risk fertility. 

*/
*******************************************************************************************************************************
*******************************************************************************************************************************

* KR file variables

* open dataset
use "$datapath//$krdata.dta", clear

gen file=substr("$krdata", 3, 2)

do CM_RISK_births.do
*Purpose: 	Code high risk birth indicators and risk ratios

do CM_tables2.do
*Purpose: 	Produce tables for high risk births.

*/
*******************************************************************************************************************************
