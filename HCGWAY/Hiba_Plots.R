years <- 2011:2018 #list of years to be used by EVERY loop

oldw <- getOption("warn")
options(warn = -1)

# Get Arguments from web
args <- commandArgs(TRUE)
webCompanyId <- args[1]  

# Downloading libraries that enable the analysis
library(ggplot2)
require(ggplot2)
library(scales)
library(RColorBrewer)
require(RColorBrewer)

#Accessing images
library(jpeg)
require(jpeg)


cols <- brewer.pal(8,"Set1")
cols <- c("tomato","olivedrab3","darkturquoise","mediumorchid2")

# Load RODBC package
library(RMySQL)
con = dbConnect(MySQL(fetch.default.rec = 10000), user='sec_user', password='eKcGZr59zAa2BEWUXP', dbname='secure_login', host='localhost')
comp <- dbGetQuery(con, "SELECT * FROM secure_login.adminresults")


# # Get Cur Company Name
# webCompanyNameStore <- dbGetQuery(con, paste ("SELECT company_name FROM secure_login.Company where id=", webCompanyId));
# webCompanyName <- webCompanyNameStore$company_name
# 
# #1 Net Profit Percentage Query
# netProfitPercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   netProfitPercentageList[i] <- dbGetQuery(con, paste("SELECT net_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND net_profit_percentage is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# netProfitPercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   netProfitPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT net_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND net_profit_percentage is not null"));
#   i = i+1 #increment
# } 
# 
# #2 Gross Profit Percentage Query
# grossProfitPercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   grossProfitPercentageList[i] <- dbGetQuery(con, paste("SELECT gross_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND gross_profit_percentage is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# grossProfitPercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   grossProfitPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT gross_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND gross_profit_percentage is not null"));
#   i = i+1 #increment
# } 
# 
# #3 Overhead Percentage Query
# overheadPercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overheadPercentageList[i] <- dbGetQuery(con, paste("SELECT overhead_percentage FROM secure_login.adminresults WHERE year=", yr, " AND overhead_percentage is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overheadPercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overheadPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overhead_percentage FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overhead_percentage is not null"));
#   i = i+1 #increment
# } 
# 
# #4 Hit Rate Percentage Query
# hitRatePercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   hitRatePercentageList[i] <- dbGetQuery(con, paste("SELECT hit_rate FROM secure_login.Year WHERE year=", yr, " AND hit_rate is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# hitRatePercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   hitRatePercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT hit_rate FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND hit_rate is not null"));
#   i = i+1 #increment
# } 
# 
# # Turnover Rate Percentage Query
# turnoverRatePercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   turnoverRatePercentageList[i] <- dbGetQuery(con, paste("SELECT turnover_rate_bargaining_perc FROM secure_login.Year WHERE year=", yr, " AND turnover_rate_bargaining_perc is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# turnoverRatePercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   turnoverRatePercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT turnover_rate_bargaining_perc FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND turnover_rate_bargaining_perc is not null"));
#   i = i+1 #increment
# } 
# 
# # Absenteeism Percentage Query
# absenteeismPercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   absenteeismPercentageList[i] <- dbGetQuery(con, paste("SELECT absenteeism_perc FROM secure_login.Year WHERE year=", yr, " AND absenteeism_perc is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# absenteeismPercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   absenteeismPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT absenteeism_perc FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND absenteeism_perc is not null"));
#   i = i+1 #increment
# } 
# 
# # OSHA Query
# OSHAList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   OSHAList[i] <- dbGetQuery(con, paste("SELECT osha_incident_rate FROM secure_login.Year WHERE year=", yr, " AND osha_incident_rate is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# OSHACurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   OSHACurCompanyList[i] <- dbGetQuery(con, paste ("SELECT osha_incident_rate FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND osha_incident_rate is not null"));
#   i = i+1 #increment
# } 
# 
# # EMR Query
# EMRList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   EMRList[i] <- dbGetQuery(con, paste("SELECT emr FROM secure_login.Year WHERE year=", yr, " AND emr is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# EMRCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   EMRCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT emr FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND emr is not null"));
#   i = i+1 #increment
# } 
# 
# # Repeat Business Customers Query
# repeatCustomerPercentageList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   repeatCustomerPercentageList[i] <- dbGetQuery(con, paste("SELECT repeat_customer_perc FROM secure_login.Year WHERE year=", yr, " AND repeat_customer_perc is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# repeatCustomerPercentageCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   repeatCustomerPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT repeat_customer_perc FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND repeat_customer_perc is not null"));
#   i = i+1 #increment
# } 
# 
# #5 Cost of purchased materials by the company as a percentage of the revenue Query
# costPurchasedMaterialsList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   costPurchasedMaterialsList[i] <- dbGetQuery(con, paste("SELECT cost_purchased_materials FROM secure_login.adminresults WHERE year=", yr, " AND cost_purchased_materials is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# costPurchasedMaterialsCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   costPurchasedMaterialsCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_purchased_materials FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_purchased_materials is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #6 Payments Disbursed to Subcontractors as a percentage of the Revenue Query
# payDisbursedSubContrList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   payDisbursedSubContrList[i] <- dbGetQuery(con, paste("SELECT pay_disbursed_subcontr FROM secure_login.adminresults WHERE year=", yr, " AND pay_disbursed_subcontr is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# payDisbursedSubContrCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   payDisbursedSubContrCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT pay_disbursed_subcontr FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND pay_disbursed_subcontr is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #8 Overall Productivity Measurement – Dollar Revenue/Hours of Company’s People Query
# overallProductivityMeasurementList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallProductivityMeasurementList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_measurement_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_measurement_dollar_revenue is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallProductivityMeasurementCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallProductivityMeasurementCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_measurement_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_measurement_dollar_revenue is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #9 Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People 
# overallProductivityMeasurementDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallProductivityMeasurementDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_measurement_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_measurement_dollar_value_added is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallProductivityMeasurementDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallProductivityMeasurementDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_measurement_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_measurement_dollar_value_added is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #10 Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People
# overallProductivityMeasurementDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallProductivityMeasurementDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_measurement_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_measurement_dollar_net_profit is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallProductivityMeasurementDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallProductivityMeasurementDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_measurement_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_measurement_dollar_net_profit is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #11 Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel 
# projectManagementDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_revenue is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_revenue is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #12 Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel 
# projectManagementDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_value_added is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_value_added is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #13 Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel 
# projectManagementDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_net_profit is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_net_profit is not null"));
#   i = i+1 #increment
# } 
# 
# 
# #14 Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees 
# craftWorkerDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_revenue is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_revenue is not null"));
#   i = i+1 #increment
# }
# 
# 
# #15 Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit
# craftWorkerDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_value_added is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_value_added is not null"));
#   i = i+1 #increment
# }
# 
# 
# #16 Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees 
# craftWorkerDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_net_profit is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_net_profit is not null"));
#   i = i+1 #increment
# }
# 
# 
# #17 Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees 
# supportingEmployeeDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_revenue is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_revenue is not null"));
#   i = i+1 #increment
# }
# 
# 
# #18 Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees
# supportingEmployeeDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_value_added is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_value_added is not null"));
#   i = i+1 #increment
# }
# 
# 
# #19 Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees
# supportingEmployeeDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_net_profit is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_net_profit is not null"));
#   i = i+1 #increment
# }
# 
# 
# #20 Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People 
# overallProductivityDollarRevenueFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallProductivityDollarRevenueFteList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallProductivityDollarRevenueFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallProductivityDollarRevenueFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #21 - Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People 
# overallProductivityDollarValueAddedFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallProductivityDollarValueAddedFteList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallProductivityDollarValueAddedFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallProductivityDollarValueAddedFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #22 - Overall Profitability Measurement – Dollar Net Profit /FTEs of  Company’s People
# overallProductivityDollarNetProfitFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallProductivityDollarNetProfitFteList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_dollar_net_profit_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallProductivityDollarNetProfitFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallProductivityDollarNetProfitFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_dollar_net_profit_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #23 - Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel 
# projectManagementDollarRevenuePersonnelFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementDollarRevenuePersonnelFteList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementDollarRevenuePersonnelFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementDollarRevenuePersonnelFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #24 - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management 
# projectManagementDollarValueAddedPersonnelFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementDollarValueAddedPersonnelFteList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementDollarValueAddedPersonnelFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementDollarValueAddedPersonnelFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #25 - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel 
# projectManagementDollarNetProfitPersonnelFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementDollarNetProfitPersonnelFteList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_net_profit_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementDollarNetProfitPersonnelFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementDollarNetProfitPersonnelFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_net_profit_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #26 - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees 
# craftWorkerDollarRevenueFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarRevenueFteList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerDollarRevenueFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarRevenueFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #27 - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit 
# craftWorkerDollarValueAddedFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarValueAddedFteList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerDollarValueAddedFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarValueAddedFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #28 - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees
# craftWorkerDollarNetProfitFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarNetProfitFteList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_net_profit_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerDollarNetProfitFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerDollarNetProfitFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_net_profit_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #29 - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees 
# supportingEmployeeDollarRevenueFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarRevenueFteList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeDollarRevenueFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarRevenueFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_revenue_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #30 - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees
# supportingEmployeeDollarValueAddedFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarValueAddedFteList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeDollarValueAddedFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarValueAddedFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_value_added_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #31 - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees
# supportingEmployeeDollarNetProfitFteList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarNetProfitFteList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_net_profit_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_net_profit_added_fte is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeDollarNetProfitFteCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeDollarNetProfitFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_net_profit_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_net_profit_added_fte is not null"));
#   i = i+1 #increment
# }
# 
# 
# #32 - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People 
# overallCostEffectivenessDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallCostEffectivenessDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT overall_cost_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND overall_cost_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallCostEffectivenessDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallCostEffectivenessDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_cost_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_cost_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# #33 - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People 
# overallCostEffectivenessDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallCostEffectivenessDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT overall_cost_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND overall_cost_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallCostEffectivenessDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallCostEffectivenessDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_cost_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_cost_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #34 - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People 
# overallCostEffectivenessDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   overallCostEffectivenessDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT overall_cost_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND overall_cost_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# overallCostEffectivenessDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   overallCostEffectivenessDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_cost_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_cost_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# #35 - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel 
# projectManagementCostDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementCostDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementCostDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementCostDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #36 - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel 
# projectManagementCostDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementCostDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementCostDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementCostDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# #37 - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel 
# projectManagementCostDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   projectManagementCostDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# projectManagementCostDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   projectManagementCostDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #38 - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees 
# craftWorkerCostEffectDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerCostEffectDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerCostEffectDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerCostEffectDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #39 - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees
# craftWorkerCostEffectDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerCostEffectDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerCostEffectDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerCostEffectDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #40 - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees 
# craftWorkerCostEffectDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   craftWorkerCostEffectDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# craftWorkerCostEffectDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   craftWorkerCostEffectDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #41 - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees 
# supportingEmployeeCostEffectDollarRevenueList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeCostEffectDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeCostEffectDollarRevenueCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeCostEffectDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_revenue_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #42 - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees
# supportingEmployeeCostEffectDollarValueAddedList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeCostEffectDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeCostEffectDollarValueAddedCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeCostEffectDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_value_added_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #43 - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees
# supportingEmployeeCostEffectDollarNetProfitList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   supportingEmployeeCostEffectDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# supportingEmployeeCostEffectDollarNetProfitCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   supportingEmployeeCostEffectDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_net_profit_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #44 - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel
# costFieldProjManagementList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   costFieldProjManagementList[i] <- dbGetQuery(con, paste("SELECT cost_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND cost_field_project_management_personnel is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# costFieldProjManagementCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   costFieldProjManagementCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_field_project_management_personnel is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #45 - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees
# costBargainingUnitEmployeeList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   costBargainingUnitEmployeeList[i] <- dbGetQuery(con, paste("SELECT cost_bargaining_unit_employee_expended FROM secure_login.adminresults WHERE year=", yr, " AND cost_bargaining_unit_employee_expended is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# costBargainingUnitEmployeeCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   costBargainingUnitEmployeeCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_bargaining_unit_employee_expended FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_bargaining_unit_employee_expended is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #46 - Cost of Supporting Employees per Hours of Supporting Employees
# costSupportingEmployeesList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   costSupportingEmployeesList[i] <- dbGetQuery(con, paste("SELECT cost_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND cost_supporting_employee_per_hour is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# costSupportingEmployeesCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   costSupportingEmployeesCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_supporting_employee_per_hour is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #47 - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees 
# costFieldProjManagementPersonnelList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   costFieldProjManagementPersonnelList[i] <- dbGetQuery(con, paste("SELECT cost_field_project_management_personnel_cost FROM secure_login.adminresults WHERE year=", yr, " AND cost_field_project_management_personnel_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# costFieldProjManagementPersonnelCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   costFieldProjManagementPersonnelCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_field_project_management_personnel_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_field_project_management_personnel_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #48 - Cost of Supporting Employees per Cost of Bargaining Unit Employees
# costSupportingEmployeeCostBargainingList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   costSupportingEmployeeCostBargainingList[i] <- dbGetQuery(con, paste("SELECT cost_supp_employee_cost FROM secure_login.adminresults WHERE year=", yr, " AND cost_supp_employee_cost is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# costSupportingEmployeeCostBargainingCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   costSupportingEmployeeCostBargainingCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_supp_employee_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_supp_employee_cost is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #49 - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees 
# hoursFieldProjectManagementList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   hoursFieldProjectManagementList[i] <- dbGetQuery(con, paste("SELECT hours_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND hours_field_project_management_personnel is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# hoursFieldProjectManagementCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   hoursFieldProjectManagementCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT hours_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND hours_field_project_management_personnel is not null"));
#   i = i+1 #increment
# }
# 
# 
# 
# #50 - Hours of Supporting Employees per Hours of Bargaining Unit Employees 
# hoursSupportingEmployeeList <- c()
# i <- 1
# for(yr in years){ #loop through every year in years
#   hoursSupportingEmployeeList[i] <- dbGetQuery(con, paste("SELECT hours_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND hours_supporting_employee_per_hour is not null"));
#   i = i+1 #increment
# } 
# i <- 1
# hoursSupportingEmployeeCurCompanyList <- c()
# for(yr in years){ #loop through every year in years
#   hoursSupportingEmployeeCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT hours_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND hours_supporting_employee_per_hour is not null"));
#   i = i+1 #increment
# }


######################################################################################################################################

Hours.of.Supporting.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$hours_supporting_employee_per_hour
Hours.of.Field.Project.Management.Personnel.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$hours_field_project_management_personnel
Cost.of.Supporting.Employees.per.Cost.of.Bargaining.Unit.Employees=comp$cost_supp_employee_cost
Cost.of.Field.Project.Management.Personnel.per.Cost.of.Bargaining.Unit.Employees=comp$cost_field_project_management_personnel_cost
Cost.of.Supporting.Employees.per.Hours.of.Supporting.Employees=comp$cost_supporting_employee_per_hour
Cost.of.Bargaining.Unit.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$cost_bargaining_unit_employee_expended
Cost.of.Field.Project.Management.Personnel.per.Hours.of.Field.Project.Management.Personnel=comp$cost_field_project_management_personnel
Net.Profit.per.Cost.of.Supporting.Employees=comp$supporting_employee_dollar_net_profit_cost
Value.Added.per.Cost.of.Supporting.Employees=comp$supporting_employee_dollar_value_added_cost
Revenue.per.Cost.of.Supporting.Employees=comp$supporting_employee_dollar_revenue_cost
Net.Profit.per.Cost.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_net_profit_cost
Value.Added.per.Cost.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_value_added_cost
Revenue.per.Cost.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_revenue_cost
Net.Profit.per.Cost.of.Field.Project.Management.Personnel=comp$project_management_dollar_net_profit_cost
Value.Added.per.Cost.of.Field.Project.Management.Personnel=comp$project_management_dollar_value_added_cost
Revenue.per.Cost.of.Field.Project.Management.Personnel=comp$project_management_dollar_revenue_cost
Net.Profit.per.Total.Cost.of.People=comp$overall_cost_dollar_net_profit_cost
Value.Added.per.Total.Cost.of.People=comp$overall_cost_dollar_value_added_cost
Revenue.per.Total.Cost.of.People=comp$overall_cost_dollar_revenue_cost
Net.Profit.per.FTE.of.Supporting.Employees=comp$supporting_employee_dollar_net_profit_added_fte
Value.Added.per.FTE.of.Supporting.Employees=comp$supporting_employee_dollar_value_added_fte
Revenue.per.FTE.of.Supporting.Employees=comp$supporting_employee_dollar_revenue_fte
Net.Profit.per.FTE.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_net_profit_fte
Value.Added.per.FTE.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_value_added_fte
Revenue.per.FTE.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_revenue_fte
Net.Profit.per.FTE.of.Field.Project.Management.Personnel=comp$project_management_dollar_net_profit_fte
Value.Added.per.FTE.of.Field.Project.Management.Personnel=comp$project_management_dollar_value_added_fte
Revenue.per.FTE.of.Field.Project.Management.Personnel=comp$project_management_dollar_revenue_fte
Net.Profit.per.Total.FTE.of.People=comp$overall_productivity_dollar_net_profit_fte
Value.Added.per.Total.FTE.of.People=comp$overall_productivity_dollar_value_added_fte
Revenue.per.Total.FTE.of.People=comp$overall_productivity_dollar_revenue_fte
Net.Profit.per.Hours.of.Supporting.Employees=comp$supporting_employee_dollar_net_profit
Value.Added.per.Hours.of.Supporting.Employees=comp$supporting_employee_dollar_value_added
Revenue.per.Hours.of.Supporting.Employees=comp$supporting_employee_dollar_revenue
Net.Profit.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_net_profit
Value.Added.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_value_added
Revenue.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_revenue
Net.Profit.per.Hour.of.Field.Project.Management.Personnel=comp$project_management_dollar_net_profit
Value.Added.per.Hour.of.Field.Project.Management.Personnel=comp$project_management_dollar_value_added
Revenue.per.Hour.of.Field.Project.Management.Personnel=comp$project_management_dollar_revenue
Net.Profit.per.Total.hours.of.People=comp$overall_productivity_measurement_dollar_net_profit
Value.Added.per.Total.hours.of.People=comp$overall_productivity_measurement_dollar_value_added
Revenue.per.Total.hours.of.People=comp$overall_productivity_measurement_dollar_revenue
Percentage.of.Revenue.as.Payments.Disbursed.to.Subcontractors=comp$pay_disbursed_subcontr
Percentage.of.Revenue.as.Cost.of.Purchased.Materials=comp$cost_purchased_materials
Net.Profit.Percentage=comp$net_profit_percentage
Gross.Profit.Percentage=comp$gross_profit_percentage
Overhead.Percentage=comp$overhead_percentage
Hit.Rate=comp$hit_rate
Turnover.Rate.of.Bargaining.Unit.Employees=comp$turnover_rate_bargaining_perc
Absenteeism.Percentage=comp$absenteeism_perc
OSHA.Recordable.Incident.Rate=comp$osha_incident_rate
Experience.Modification.Rate=comp$emr
Repeat.Business.Customers.Percentage=comp$repeat_customer_perc


# #50 - Hours of Supporting Employees per Hours of Bargaining Unit Employees 
# hoursSupportingEmployeeQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   hoursSupportingEmployeeQuantileList[[i]] = quantile(unlist(hoursSupportingEmployeeList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# 
# hoursSupportingEmployeeMeanList = c()
# i <- 1
# for (yr in years)
# {
#   hoursSupportingEmployeeMeanList[[i]] = mean(unlist(hoursSupportingEmployeeList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #49 - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees 
# hoursFieldProjectManagementQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   hoursFieldProjectManagementQuantileList[[i]] = quantile(unlist(hoursFieldProjectManagementList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# hoursFieldProjectManagementMeanList = c()
# i <- 1
# for (yr in years)
# {
#   hoursFieldProjectManagementMeanList[[i]] = mean(unlist(hoursFieldProjectManagementList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #48 - Cost of Supporting Employees per Cost of Bargaining Unit Employees
# costSupportingEmployeeCostBargainingQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   costSupportingEmployeeCostBargainingQuantileList[[i]] = quantile(unlist(costSupportingEmployeeCostBargainingList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# costSupportingEmployeeCostBargainingMeanList = c()
# i <- 1
# for (yr in years)
# {
#   costSupportingEmployeeCostBargainingMeanList[[i]] = mean(unlist(costSupportingEmployeeCostBargainingList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# 
# #47 - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees 
# costFieldProjManagementPersonnelQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   costFieldProjManagementPersonnelQuantileList[[i]] = quantile(unlist(costFieldProjManagementPersonnelList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# costFieldProjManagementPersonnelMeanList = c()
# i <- 1
# for (yr in years)
# {
#   costFieldProjManagementPersonnelMeanList[[i]] = mean(unlist(costFieldProjManagementPersonnelList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #46 - Cost of Supporting Employees per Hours of Supporting Employees
# costSupportingEmployeesQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   costSupportingEmployeesQuantileList[[i]] = quantile(unlist(costSupportingEmployeesList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# costSupportingEmployeesMeanList = c()
# i <- 1
# for (yr in years)
# {
#   costSupportingEmployeesMeanList[[i]] = mean(unlist(costSupportingEmployeesList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #45 - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees
# costBargainingUnitEmployeeQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   costBargainingUnitEmployeeQuantileList[[i]] = quantile(unlist(costBargainingUnitEmployeeList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# costBargainingUnitEmployeeMeanList = c()
# i <- 1
# for (yr in years)
# {
#   costBargainingUnitEmployeeMeanList[[i]] = mean(unlist(costBargainingUnitEmployeeList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# 
# #44 - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel
# costFieldProjManagementQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   costFieldProjManagementQuantileList[[i]] = quantile(unlist(costFieldProjManagementList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# costFieldProjManagementMeanList = c()
# i <- 1
# for (yr in years)
# {
#   costFieldProjManagementMeanList[[i]] = mean(unlist(costFieldProjManagementList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #43 - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees
# supportingEmployeeCostEffectDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeCostEffectDollarNetProfitQuantileList[[i]] = quantile(unlist(supportingEmployeeCostEffectDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeCostEffectDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeCostEffectDollarNetProfitMeanList[[i]] = mean(unlist(supportingEmployeeCostEffectDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# 
# #42 - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees
# supportingEmployeeCostEffectDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeCostEffectDollarValueAddedQuantileList[[i]] = quantile(unlist(supportingEmployeeCostEffectDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeCostEffectDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeCostEffectDollarValueAddedMeanList[[i]] = mean(unlist(supportingEmployeeCostEffectDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #41 - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees 
# supportingEmployeeCostEffectDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeCostEffectDollarRevenueQuantileList[[i]] = quantile(unlist(supportingEmployeeCostEffectDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeCostEffectDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeCostEffectDollarRevenueMeanList[[i]] = mean(unlist(supportingEmployeeCostEffectDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #40 - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees 
# craftWorkerCostEffectDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerCostEffectDollarNetProfitQuantileList[[i]] = quantile(unlist(craftWorkerCostEffectDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerCostEffectDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerCostEffectDollarNetProfitMeanList[[i]] = mean(unlist(craftWorkerCostEffectDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #39 - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees
# craftWorkerCostEffectDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerCostEffectDollarValueAddedQuantileList[[i]] = quantile(unlist(craftWorkerCostEffectDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerCostEffectDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerCostEffectDollarValueAddedMeanList[[i]] = mean(unlist(craftWorkerCostEffectDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #38 - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees 
# craftWorkerCostEffectDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerCostEffectDollarRevenueQuantileList[[i]] = quantile(unlist(craftWorkerCostEffectDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerCostEffectDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerCostEffectDollarRevenueMeanList[[i]] = mean(unlist(craftWorkerCostEffectDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #37 - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel
# projectManagementCostDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementCostDollarNetProfitQuantileList[[i]] = quantile(unlist(projectManagementCostDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementCostDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementCostDollarNetProfitMeanList[[i]] = mean(unlist(projectManagementCostDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #36 - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel
# projectManagementCostDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementCostDollarValueAddedQuantileList[[i]] = quantile(unlist(projectManagementCostDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementCostDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementCostDollarValueAddedMeanList[[i]] = mean(unlist(projectManagementCostDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #35 - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel 
# projectManagementCostDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementCostDollarRevenueQuantileList[[i]] = quantile(unlist(projectManagementCostDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementCostDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementCostDollarRevenueMeanList[[i]] = mean(unlist(projectManagementCostDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #34 - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People 
# overallCostEffectivenessDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallCostEffectivenessDollarNetProfitQuantileList[[i]] = quantile(unlist(overallCostEffectivenessDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallCostEffectivenessDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallCostEffectivenessDollarNetProfitMeanList[[i]] = mean(unlist(overallCostEffectivenessDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #33 - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People 
# overallCostEffectivenessDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallCostEffectivenessDollarValueAddedQuantileList[[i]] = quantile(unlist(overallCostEffectivenessDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallCostEffectivenessDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallCostEffectivenessDollarValueAddedMeanList[[i]] = mean(unlist(overallCostEffectivenessDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #32 - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People 
# overallCostEffectivenessDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallCostEffectivenessDollarRevenueQuantileList[[i]] = quantile(unlist(overallCostEffectivenessDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallCostEffectivenessDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallCostEffectivenessDollarRevenueMeanList[[i]] = mean(unlist(overallCostEffectivenessDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #31 - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees
# supportingEmployeeDollarNetProfitFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarNetProfitFteQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarNetProfitFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeDollarNetProfitFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarNetProfitFteMeanList[[i]] = mean(unlist(supportingEmployeeDollarNetProfitFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #30 - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees
# supportingEmployeeDollarValueAddedFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarValueAddedFteQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarValueAddedFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeDollarValueAddedFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarValueAddedFteMeanList[[i]] = mean(unlist(supportingEmployeeDollarValueAddedFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #29 - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees 
# supportingEmployeeDollarRevenueFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarRevenueFteQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarRevenueFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeDollarRevenueFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarRevenueFteMeanList[[i]] = mean(unlist(supportingEmployeeDollarRevenueFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #28 - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees 
# craftWorkerDollarNetProfitFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarNetProfitFteQuantileList[[i]] = quantile(unlist(craftWorkerDollarNetProfitFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerDollarNetProfitFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarNetProfitFteMeanList[[i]] = mean(unlist(craftWorkerDollarNetProfitFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #27 - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit 
# craftWorkerDollarValueAddedFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarValueAddedFteQuantileList[[i]] = quantile(unlist(craftWorkerDollarValueAddedFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerDollarValueAddedFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarValueAddedFteMeanList[[i]] = mean(unlist(craftWorkerDollarValueAddedFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #26 - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees 
# craftWorkerDollarRevenueFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarRevenueFteQuantileList[[i]] = quantile(unlist(craftWorkerDollarRevenueFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerDollarRevenueFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarRevenueFteMeanList[[i]] = mean(unlist(craftWorkerDollarRevenueFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #25 - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel 
# projectManagementDollarNetProfitPersonnelFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementDollarNetProfitPersonnelFteQuantileList[[i]] = quantile(unlist(projectManagementDollarNetProfitPersonnelFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementDollarNetProfitPersonnelFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementDollarNetProfitPersonnelFteMeanList[[i]] = mean(unlist(projectManagementDollarNetProfitPersonnelFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #24 - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management 
# projectManagementDollarValueAddedPersonnelFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementDollarValueAddedPersonnelFteQuantileList[[i]] = quantile(unlist(projectManagementDollarValueAddedPersonnelFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementDollarValueAddedPersonnelFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementDollarValueAddedPersonnelFteMeanList[[i]] = mean(unlist(projectManagementDollarValueAddedPersonnelFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #23 - Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel 
# projectManagementDollarRevenuePersonnelFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementDollarRevenuePersonnelFteQuantileList[[i]] = quantile(unlist(projectManagementDollarRevenuePersonnelFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementDollarRevenuePersonnelFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementDollarRevenuePersonnelFteMeanList[[i]] = mean(unlist(projectManagementDollarRevenuePersonnelFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #22 - Overall Profitability Measurement – Dollar Net Profit /FTEs of  Company’s People
# overallProductivityDollarNetProfitFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityDollarNetProfitFteQuantileList[[i]] = quantile(unlist(overallProductivityDollarNetProfitFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallProductivityDollarNetProfitFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityDollarNetProfitFteMeanList[[i]] = mean(unlist(overallProductivityDollarNetProfitFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #21 Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People 
# overallProductivityDollarValueAddedFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityDollarValueAddedFteQuantileList[[i]] = quantile(unlist(overallProductivityDollarValueAddedFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallProductivityDollarValueAddedFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityDollarValueAddedFteMeanList[[i]] = mean(unlist(overallProductivityDollarValueAddedFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #20 Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People
# overallProductivityDollarRevenueFteQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityDollarRevenueFteQuantileList[[i]] = quantile(unlist(overallProductivityDollarRevenueFteList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallProductivityDollarRevenueFteMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityDollarRevenueFteMeanList[[i]] = mean(unlist(overallProductivityDollarRevenueFteList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #19 Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees
# supportingEmployeeDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarNetProfitQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarNetProfitMeanList[[i]] = mean(unlist(supportingEmployeeDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #18 Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees
# supportingEmployeeDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarValueAddedQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarValueAddedMeanList[[i]] = mean(unlist(supportingEmployeeDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #17 Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees 
# supportingEmployeeDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarRevenueQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# supportingEmployeeDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   supportingEmployeeDollarRevenueMeanList[[i]] = mean(unlist(supportingEmployeeDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #16 Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees 
# craftWorkerDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarNetProfitQuantileList[[i]] = quantile(unlist(craftWorkerDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarNetProfitMeanList[[i]] = mean(unlist(craftWorkerDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #15 Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit  
# craftWorkerDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarValueAddedQuantileList[[i]] = quantile(unlist(craftWorkerDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarValueAddedMeanList[[i]] = mean(unlist(craftWorkerDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #14 Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees 
# craftWorkerDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarRevenueQuantileList[[i]] = quantile(unlist(craftWorkerDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# craftWorkerDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   craftWorkerDollarRevenueMeanList[[i]] = mean(unlist(craftWorkerDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #13 Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel
# projectManagementProductivityDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementProductivityDollarNetProfitQuantileList[[i]] = quantile(unlist(projectManagementDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementProductivityDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementProductivityDollarNetProfitMeanList[[i]] = mean(unlist(projectManagementDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #12 Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel 
# projectManagementProductivityDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementProductivityDollarValueAddedQuantileList[[i]] = quantile(unlist(projectManagementDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementProductivityDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementProductivityDollarValueAddedMeanList[[i]] = mean(unlist(projectManagementDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #11 Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel 
# projectManagementProductivityDollarRevenueQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementProductivityDollarRevenueQuantileList[[i]] = quantile(unlist(projectManagementDollarRevenueList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# projectManagementProductivityDollarRevenueMeanList = c()
# i <- 1
# for (yr in years)
# {
#   projectManagementProductivityDollarRevenueMeanList[[i]] = mean(unlist(projectManagementDollarRevenueList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #10 Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People
# overallProductivityMeasurementDollarNetProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityMeasurementDollarNetProfitQuantileList[[i]] = quantile(unlist(overallProductivityMeasurementDollarNetProfitList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallProductivityMeasurementDollarNetProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityMeasurementDollarNetProfitMeanList[[i]] = mean(unlist(overallProductivityMeasurementDollarNetProfitList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #9 Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People 
# overallProductivityMeasurementDollarValueAddedQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityMeasurementDollarValueAddedQuantileList[[i]] = quantile(unlist(overallProductivityMeasurementDollarValueAddedList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallProductivityMeasurementDollarValueAddedMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityMeasurementDollarValueAddedMeanList[[i]] = mean(unlist(overallProductivityMeasurementDollarValueAddedList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #8 Overall Productivity Measurement – Dollar Revenue/Hours of Company’s People
# overallProductivityMeasurementDollarRevenueHoursQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityMeasurementDollarRevenueHoursQuantileList[[i]] = quantile(unlist(overallProductivityMeasurementList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overallProductivityMeasurementDollarRevenueHoursMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overallProductivityMeasurementDollarRevenueHoursMeanList[[i]] = mean(unlist(overallProductivityMeasurementList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #6 Payments Disbursed to Subcontractors as a percentage of the Revenue
# payDisbursedSubContrQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   payDisbursedSubContrQuantileList[[i]] = quantile(unlist(payDisbursedSubContrList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# payDisbursedSubContrMeanList = c()
# i <- 1
# for (yr in years)
# {
#   payDisbursedSubContrMeanList[[i]] = mean(unlist(payDisbursedSubContrList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# #Cost of purchased materials by the company as a percentage of the revenue
# costPurchasedMaterialsQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   costPurchasedMaterialsQuantileList[[i]] = quantile(unlist(costPurchasedMaterialsList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# costPurchasedMaterialsMeanList = c()
# i <- 1
# for (yr in years)
# {
#   costPurchasedMaterialsMeanList[[i]] = mean(unlist(costPurchasedMaterialsList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Net Profit Percentage
# netProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   netProfitQuantileList[[i]] = quantile(unlist(netProfitPercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# netProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   netProfitMeanList[[i]] = mean(unlist(netProfitPercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Gross Profit Percentage
# grossProfitQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   grossProfitQuantileList[[i]] = quantile(unlist(grossProfitPercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# grossProfitMeanList = c()
# i <- 1
# for (yr in years)
# {
#   grossProfitMeanList[[i]] = mean(unlist(grossProfitPercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Overhead Percentage
# overheadQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   overheadQuantileList[[i]] = quantile(unlist(overheadPercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# overheadMeanList = c()
# i <- 1
# for (yr in years)
# {
#   overheadMeanList[[i]] = mean(unlist(overheadPercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Hit Rate Percentage
# hitRateQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   hitRateQuantileList[[i]] = quantile(unlist(hitRatePercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# hitRateMeanList = c()
# i <- 1
# for (yr in years)
# {
#   hitRateMeanList[[i]] = mean(unlist(hitRatePercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Turnover Rate Percentage
# turnoverRateQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   turnoverRateQuantileList[[i]] = quantile(unlist(turnoverRatePercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# turnoverRateMeanList = c()
# i <- 1
# for (yr in years)
# {
#   turnoverRateMeanList[[i]] = mean(unlist(turnoverRatePercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Absenteeism Percentage
# absenteeismQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   absenteeismQuantileList[[i]] = quantile(unlist(absenteeismPercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# absenteeismMeanList = c()
# i <- 1
# for (yr in years)
# {
#   absenteeismMeanList[[i]] = mean(unlist(absenteeismPercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # OSHA Recordable Incident Rate 
# OSHAQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   OSHAQuantileList[[i]] = quantile(unlist(OSHAList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# OSHAMeanList = c()
# i <- 1
# for (yr in years)
# {
#   OSHAMeanList[[i]] = mean(unlist(OSHAList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # EMR 
# EMRQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   EMRQuantileList[[i]] = quantile(unlist(EMRList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# EMRMeanList = c()
# i <- 1
# for (yr in years)
# {
#   EMRMeanList[[i]] = mean(unlist(EMRList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# # Repeat Business Customers
# repeatCustomerPercentageQuantileList = c()
# i <- 1
# for (yr in years)
# {
#   repeatCustomerPercentageQuantileList[[i]] = quantile(unlist(repeatCustomerPercentageList[i][1]),c(.25,.5,.75))
#   i = i + 1
# }
# 
# repeatCustomerPercentageMeanList = c()
# i <- 1
# for (yr in years)
# {
#   repeatCustomerPercentageMeanList[[i]] = mean(unlist(repeatCustomerPercentageList[i][1]))
#   i = i + 1
# }
# 
# 
# 
# checkNA <- function(x) {
#   if(length(x) == 0) {
#     result <- NA
#   }
#   else
#   {
#     result <- x
#   }
#   return(result)
# }


# BELOW THIS IS FOR PLOTTING

# Renaming the year as well as company name (Eckardt in the previous example) 
year=ordered(comp$year, levels=c("2011","2012","2013","2014","2015", "2016"))
# Company=comp$company_name

#function that saves the plots into jpeg
jpeg_save <- function(graph,title)
{
  str = paste (title ,".jpeg")
  ggsave(str, plot = graph,scale = 1,width = 200, height = 150,dpi = 72, limitsize = FALSE)
}

# function that plots output graph
plotGraphType1<-function(yAxis, titleVal)
{
  p <- ggplot(comp, aes_string(x="factor(year)", y=yAxis))
  p + geom_boxplot(outlier.size=NA, lwd=5) + geom_jitter(width=0.25,size=35,color="coral2")+
  scale_y_continuous(labels = scales::comma)+
  labs(x="",y=yAxis)+ 
  
  stat_summary(fun.y=mean, geom="point", shape="MEAN", size=50)+ 
  theme(text=element_text(size=300), plot.background = element_rect(color = "grey"), panel.grid.major = element_line(color = "white", size = 10), panel.grid.minor = element_line(color = "white", size = 5))
}

# function that plots output graph
plotGraphType2<-function(yAxis, titleVal)
{
  p <- ggplot(comp, aes_string(x="factor(year)", y=yAxis))
  p + geom_boxplot(outlier.size=NA, lwd=5) + geom_jitter(width=0.25,size=35,color="coral2")+
  scale_y_continuous(labels = percent)+
  labs(x="",y=yAxis)+
  
  stat_summary(fun.y=mean, geom="point", shape="MEAN", size=50)+ 
  theme(text=element_text(size=300), plot.background = element_rect(color = "grey"), panel.grid.major = element_line(color = "white", size = 10), panel.grid.minor = element_line(color = "white", size = 5))
}

# Function that plots pdf output data
#plotData<-function(pdfTitle, pdfTitle2, pdfCompName, quantileList, meanList, curCompList)
#{
# 	plot(-21:11, type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# 	text(17, 11, adj = c( 0.5, NA ),paste("",pdfTitle,""),cex=20.0, col="red", font=2)
# 	text(17, 9, adj = c( 0.5, NA ),paste("",pdfTitle2,""),cex=20.0, col="red", font=2)
# 	
# 	text(1, 7.5, adj = c( 0, 1 ),"2011", col="red",cex=13.0)
# 	text(1, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[1]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[1]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[1]]["25%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[1]), 2), nsmall = 2),""),cex=13.0)
# 	text(1, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[1])), 2), nsmall = 2),""), cex=13.0, col="red")
# 
# 	text(12, 7.5, adj = c( 0, 1 ),"2012", col="red",cex=13.0)
# 	text(12, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[2]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[2]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[2]]["25%"]))), 2), nsmall = 2),""),cex=13.0)
# 	text(12, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[2]), 2), nsmall = 2),""),cex=13.0)
# 	text(12, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[2])), 2), nsmall = 2),""), col="red",cex=13.0)
# 
# 	text(23, 7.5, adj = c( 0, 1 ),"2013", col="red",cex=13.0)
# 	text(23, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[3]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(23, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[3]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(23, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[3]]["25%"]))), 2), nsmall = 2),""),cex=13.0)
# 	text(23, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[3]), 2), nsmall = 2),""),cex=13.0)
# 	text(23, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[3])), 2), nsmall = 2),""), col="red",cex=13.0)
# 	
# 	text(1, -3, adj = c( 0, 1 ),"2014", col="red",cex=13.0)
# 	text(1, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[4]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[4]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[4]]["25%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[4]), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[4])), 2), nsmall = 2),""), col="red",cex=13.0)
# 
# 	text(12, -3, adj = c( 0, 1 ),"2015", col="red",cex=13.0)
# 	text(12, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[5]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[5]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[5]]["25%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[5]), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[5])), 2), nsmall = 2),""), col="red",cex=13.0)
# 
# 	text(23, -3, adj = c( 0, 1 ),"2016", col="red",cex=13.0)
# 	text(23, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[6]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(23, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[6]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(23, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[6]]["25%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(23, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[6]), 2), nsmall = 2),""),cex=13.0)
# 	text(23, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[6])), 2), nsmall = 2),""), col="red",cex=13.0)
# 	
# 	text(1, -13.5, adj = c( 0, 1 ),"2017", col="red",cex=13.0)
# 	text(1, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[7]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[7]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[7]]["25%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[7]), 2), nsmall = 2),""),cex=13.0)
# 	text(1, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[7])), 2), nsmall = 2),""), col="red",cex=13.0)
# 	
# 	text(12, -13.5, adj = c( 0, 1 ),"2018", col="red",cex=13.0)
# 	text(12, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[8]]["75%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[8]]["50%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[8]]["25%"])), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[8]), 2), nsmall = 2),""),cex=13.0)
# 	text(12, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[8])), 2), nsmall = 2),""), col="red",cex=13.0)
# }



# Function that plots pdf output data
# plotDataType2<-function(pdfTitle, pdfTitle2, pdfCompName, quantileList, meanList, curCompList)
# {
# 	plot(-21:11, type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# 	text(17, 11, adj = c( 0.5, NA ),paste("",pdfTitle,""),cex=20.0, col="red", font=2)
# 	text(17, 9, adj = c( 0.5, NA ),paste("",pdfTitle2,""),cex=20.0, col="red", font=2)
# 	
# 	text(1, 7.5, adj = c( 0, 1 ),"2011", col="red",cex=13.0)
# 	text(1, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA((unlist(quantileList[[1]]["75%"]))*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[1]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[1]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[1]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[1])*100), 2), nsmall = 2),"%"), cex=13.0, col="red")
# 
# 	text(12, 7.5, adj = c( 0, 1 ),"2012", col="red",cex=13.0)
# 	text(12, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[2]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[2]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[2]]["25%"]))*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[2]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[2])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
# 
# 	text(23, 7.5, adj = c( 0, 1 ),"2013", col="red",cex=13.0)
# 	text(23, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[3]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[3]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[3]]["25%"]))*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[3]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[3])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
# 	
# 	text(1, -3, adj = c( 0, 1 ),"2014", col="red",cex=13.0)
# 	text(1, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[4]]["75%"])*100), 2), nsmall = 2),"%"),cex=14.0)
# 	text(1, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[4]]["50%"])*100), 2), nsmall = 2),"%"),cex=14.0)
# 	text(1, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[4]]["25%"])*100), 2), nsmall = 2),"%"),cex=14.0)
# 	text(1, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[4]*100), 2), nsmall = 2),"%"),cex=14.0)
# 	text(1, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[4])*100), 2), nsmall = 2),"%"), col="red",cex=14.0)
# 
# 	text(12, -3, adj = c( 0, 1 ),"2015", col="red",cex=13.0)
# 	text(12, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[5]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[5]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[5]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[5]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[5])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
# 
# 	text(23, -3, adj = c( 0, 1 ),"2016", col="red",cex=13.0)
# 	text(23, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[6]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[6]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[6]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[6]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(23, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[6])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
# 	
# 	text(1, -13.5, adj = c( 0, 1 ),"2017", col="red",cex=13.0)
# 	text(1, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[7]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[7]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[7]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[7]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(1, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[7])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
# 	
# 	text(12, -13.5, adj = c( 0, 1 ),"2018", col="red",cex=13.0)
# 	text(12, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[8]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[8]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[8]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[8]*100), 2), nsmall = 2),"%"),cex=13.0)
# 	text(12, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[8])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
# 	
# }
# 
# # Function that plots pdf output data
# plotData_noDec<-function(pdfTitle, pdfTitle2, pdfCompName, quantileList, meanList, curCompList)
# {
#   plot(-21:11, type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
#   text(17, 11, adj = c( 0.5, NA ),paste("",pdfTitle,""),cex=20.0, col="red", font=2)
#   text(17, 9, adj = c( 0.5, NA ),paste("",pdfTitle2,""),cex=20.0, col="red", font=2)
#   
#   text(1, 7.5, adj = c( 0, 1 ),"2011", col="red",cex=13.0)
#   text(1, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[1]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[1]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[1]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[1]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[1])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), cex=13.0, col="red")
#   
#   text(12, 7.5, adj = c( 0, 1 ),"2012", col="red",cex=13.0)
#   text(12, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[2]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[2]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[2]]["25%"]))), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[2]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[2])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
#   
#   text(23, 7.5, adj = c( 0, 1 ),"2013", col="red",cex=13.0)
#   text(23, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[3]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[3]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[3]]["25%"]))), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[3]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[3])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
#   
#   text(1, -3, adj = c( 0, 1 ),"2014", col="red",cex=13.0)
#   text(1, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[4]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[4]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[4]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[4]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[4])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
#   
#   text(12, -3, adj = c( 0, 1 ),"2015", col="red",cex=13.0)
#   text(12, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[5]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[5]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[5]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[5]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[5])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
#   
#   text(23, -3, adj = c( 0, 1 ),"2016", col="red",cex=13.0)
#   text(23, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[6]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[6]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[6]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[6]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(23, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[6])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
#   
#   text(1, -13.5, adj = c( 0, 1 ),"2017", col="red",cex=13.0)
#   text(1, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[7]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[7]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[7]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[7]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(1, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[7])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
#   
#   text(12, -13.5, adj = c( 0, 1 ),"2018", col="red",cex=13.0)
#   text(12, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[8]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[8]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[8]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[8]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
#   text(12, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[8])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
# }


# jj1 <- readJPEG("updated_Img/Slide1.JPG",native=TRUE)
# jj2 <- readJPEG("updated_Img/Slide2.JPG",native=TRUE)
# jj3 <- readJPEG("updated_Img/Slide3.JPG",native=TRUE)
# jj4 <- readJPEG("updated_Img/Slide4.JPG",native=TRUE)
# jj5 <- readJPEG("updated_Img/Slide5.JPG",native=TRUE)
# jj6 <- readJPEG("updated_Img/Slide6.JPG",native=TRUE)
# jj7 <- readJPEG("updated_Img/Slide7.JPG",native=TRUE)
# jj8 <- readJPEG("updated_Img/Slide8.JPG",native=TRUE)
# jj9 <- readJPEG("updated_Img/Slide9.JPG",native=TRUE)
# jj10 <- readJPEG("updated_Img/Slide10.JPG",native=TRUE)
# jj11 <- readJPEG("updated_Img/Slide11.JPG",native=TRUE)
# jj12 <- readJPEG("updated_Img/Slide12.JPG",native=TRUE)
# jj13 <- readJPEG("updated_Img/Slide13.JPG",native=TRUE)
# jj14 <- readJPEG("updated_Img/Slide14.JPG",native=TRUE)


# str = paste (webCompanyName ,".pdf")
# pdf(str, width=200, height=150, bg="white")
# par(family = 'Helvetica', ps=20)
# 
# 
# #Page 1: Landing
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj1,1,1,1000,1000)
# text(500, 400, adj = c( 0.5, NA ),paste("",webCompanyName,""),cex=25.0, col="grey20", font=2)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj2,1,1,1000,1000)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj3,1,1,1000,1000)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj4,1,1,1000,1000)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj5,1,1,1000,1000)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj6,1,1,1000,1000)


#Formula 1
#Page : Net Profit Percentage Plot 
jpeg_save(plotGraphType2("Net.Profit.Percentage", "Net Profit Percentage"),"Net.Profit.Percentage")

#Page : Net Profit Percentage Data
# plotDataType2("Net Profit Percentage", "", webCompanyName, 
#               netProfitQuantileList, netProfitMeanList, netProfitPercentageCurCompanyList)

#Formula 
#Page : Gross Profit Percentage Plot 
jpeg_save(plotGraphType2("Gross.Profit.Percentage", "Gross Profit Percentage"),"Gross.Profit.Percentage")

#Page : Gross Profit Percentage Data
# plotDataType2("Gross Profit Percentage", "", webCompanyName, 
#               grossProfitQuantileList, grossProfitMeanList, grossProfitPercentageCurCompanyList)

#Formula 
#Page : Overhead Percentage Plot 
jpeg_save(plotGraphType2("Overhead.Percentage", "Overhead Percentage"),"Overhead.Percentage")

#Page : Overhead Percentage Data
# plotDataType2("Overhead Percentage", "", webCompanyName, 
#               overheadQuantileList, overheadMeanList, overheadPercentageCurCompanyList)

#Formula 
#Page : Hit Rate Percentage Plot 
jpeg_save(plotGraphType2("Hit.Rate", "Hit Rate"),"Hit.Rate")

#Page : Hit Rate Percentage Data
# plotDataType2("Hit Rate", "", webCompanyName, 
#               hitRateQuantileList, hitRateMeanList, hitRatePercentageCurCompanyList )

#Formula 5
#Page : Cost of purchased materials by the company as a percentage of the revenue Plot
jpeg_save(plotGraphType2("Percentage.of.Revenue.as.Cost.of.Purchased.Materials", "Cost of Purchased Materials by the Company"),"Percentage.of.Revenue.as.Cost.of.Purchased.Materials")

#Page : Cost of purchased materials by the company as a percentage of the revenue Data
# plotDataType2("Cost of Purchased Materials by the Company", "", webCompanyName, 
#               costPurchasedMaterialsQuantileList, costPurchasedMaterialsMeanList, costPurchasedMaterialsCurCompanyList)
# 

#Formula 6
#Page : Payments Disbursed to Subcontractors as a percentage of the revenue Plot
jpeg_save(plotGraphType2("Percentage.of.Revenue.as.Payments.Disbursed.to.Subcontractors", "Payments Disbursed to Subcontractors"),"Percentage.of.Revenue.as.Payments.Disbursed.to.Subcontractors")

#Page : Cost of purchased materials by the company as a percentage of the revenue Data
# plotDataType2("Payments Disbursed to Subcontractor", "", webCompanyName, 
#               payDisbursedSubContrQuantileList, payDisbursedSubContrMeanList, payDisbursedSubContrCurCompanyList)

#Transition
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj6,1,1,1000,1000)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj7,1,1,1000,1000)

#Formula 23
#Page : Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel Plot
jpeg_save(plotGraphType1("Revenue.per.FTE.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Revenue/FTEs of Project Management Personnel"),"Revenue.per.FTE.of.Field.Project.Management.Personnel")

#Page : Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel Data
# plotData_noDec("Project Management Productivity Measurement: ", "Dollar Revenue/FTEs of Project Management Personnel", webCompanyName, 
#                projectManagementDollarRevenuePersonnelFteQuantileList, projectManagementDollarRevenuePersonnelFteMeanList, projectManagementDollarRevenuePersonnelFteCurCompanyList)


#Formula 24
#Page  - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management Plot
jpeg_save(plotGraphType1("Value.Added.per.FTE.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Value Added/FTEs of Project Management"),"Value.Added.per.FTE.of.Field.Project.Management.Personnel")

#Page  - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management Data
# plotData_noDec("Project Management Productivity Measurement: ", "Dollar Value Added/FTEs of Project Management", webCompanyName, 
#                projectManagementDollarValueAddedPersonnelFteQuantileList, projectManagementDollarValueAddedPersonnelFteMeanList, projectManagementDollarValueAddedPersonnelFteCurCompanyList)


#Formula 25
#Page  - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel Plot
jpeg_save(plotGraphType1("Net.Profit.per.FTE.of.Field.Project.Management.Personnel", "Project Management Profitability Measurement: \nDollar Net Profit /FTEs of Project Management Personnel"),"Net.Profit.per.FTE.of.Field.Project.Management.Personnel")

#Page  - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel Data
# plotData_noDec("Project Management Profitability Measurement: ","Dollar Net Profit /FTEs of Project Management Personnel", webCompanyName, 
#                projectManagementDollarNetProfitPersonnelFteQuantileList, projectManagementDollarNetProfitPersonnelFteMeanList, projectManagementDollarNetProfitPersonnelFteCurCompanyList)


#Formula 26
#Page  - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Revenue.per.FTE.of.Bargaining.Unit.Employees", "Craft Worker Productivity Measurement: \nDollar Revenue/ FTEs of Bargaining Unit Employees"),"Revenue.per.FTE.of.Bargaining.Unit.Employees")

#Page  - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees Data
# plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Revenue/ FTEs of Bargaining Unit Employees", webCompanyName, 
#                craftWorkerDollarRevenueFteQuantileList, craftWorkerDollarRevenueFteMeanList, craftWorkerDollarRevenueFteCurCompanyList)


#Formula 27
#Page  - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit Plot
jpeg_save(plotGraphType1("Value.Added.per.FTE.of.Bargaining.Unit.Employees", "Craft Worker Productivity Measurement: \nDollar Value Added/ FTEs of Bargaining Unit"),"Value.Added.per.FTE.of.Bargaining.Unit.Employees")

#Page  - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit Data
# plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Value Added/ FTEs of Bargaining Unit Employees", webCompanyName, 
#                craftWorkerDollarValueAddedFteQuantileList, craftWorkerDollarValueAddedFteMeanList, craftWorkerDollarValueAddedFteCurCompanyList)


#Formula 28
#Page  - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Net.Profit.per.FTE.of.Bargaining.Unit.Employees", "Craft Worker Profitability Measurement: \nDollar Net Profit / FTEs of Bargaining Unit Employees"),"Net.Profit.per.FTE.of.Bargaining.Unit.Employees")

#Page  - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees Data
# plotData_noDec("Craft Worker Profitability Measurement: ","Dollar Net Profit / FTEs of Bargaining Unit Employees", webCompanyName, 
#                craftWorkerDollarNetProfitFteQuantileList, craftWorkerDollarNetProfitFteMeanList, craftWorkerDollarNetProfitFteCurCompanyList)

#Transition
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj8,1,1,1000,1000)

#Formula 14
#Page : Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Revenue.per.Expended.Man.Hours.of.Bargaining.Unit.Employees","Craft Worker Productivity Measurement: \nDollar Revenue/ Hours of Bargaining Unit Employees"),"Revenue.per.Expended.Man.Hours.of.Bargaining.Unit.Employees")

#Page : Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees Data
# plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Revenue/ Hours of Bargaining Unit Employees", webCompanyName, 
#                craftWorkerDollarRevenueQuantileList, craftWorkerDollarRevenueMeanList, craftWorkerDollarRevenueCurCompanyList)


#Formula 15
#Page : Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit Plot
jpeg_save(plotGraphType1("Value.Added.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Craft Worker Productivity Measurement: \nDollar Value Added/ Hours of Bargaining Unit"),"Value.Added.per.Expended.Man.Hours.of.Bargaining.Unit.Employees")

#Page : Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit Data
# plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Value Added/ Hours of Bargaining Unit", webCompanyName, 
#                craftWorkerDollarValueAddedQuantileList, craftWorkerDollarValueAddedMeanList, craftWorkerDollarValueAddedCurCompanyList)


#Formula 16
#Page : Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Net.Profit.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Craft Worker Profitability Measurement: \nDollar Net Profit / Hours of Bargaining Unit Employees"),"Net.Profit.per.Expended.Man.Hours.of.Bargaining.Unit.Employees")

#Page : Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees Data
# plotData("Craft Worker Profitability Measurement: ","Dollar Net Profit / Hours of Bargaining Unit Employees", webCompanyName,
#          craftWorkerDollarNetProfitQuantileList, craftWorkerDollarNetProfitMeanList, craftWorkerDollarNetProfitCurCompanyList)

#Transition
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj9,1,1,1000,1000)
# 
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj10,1,1,1000,1000)

#Formula 35
#Page  - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel Plot
jpeg_save(plotGraphType1("Revenue.per.Cost.of.Field.Project.Management.Personnel", "Project Management Cost Effectiveness: \nDollar Revenue/ Cost of Project Management Personnel"),"Revenue.per.Cost.of.Field.Project.Management.Personnel")

#Page  - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel Data
# plotData("Project Management Cost Effectiveness: ", "Dollar Revenue/ Cost of Project Management Personnel", webCompanyName, 
#          projectManagementCostDollarRevenueQuantileList, projectManagementCostDollarRevenueMeanList, projectManagementCostDollarRevenueCurCompanyList)


#Formula 36
#Page  - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel Plot
jpeg_save(plotGraphType1("Value.Added.per.Cost.of.Field.Project.Management.Personnel", "Project Management Cost Effectiveness: \nDollar Value Added/ Cost of Project Management Personnel"),"Value.Added.per.Cost.of.Field.Project.Management.Personnel")

#Page  - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel Data
# plotData("Project Management Cost Effectiveness: ", "Dollar Value Added/ Cost of Project Management Personnel", webCompanyName, 
#          projectManagementCostDollarValueAddedQuantileList, projectManagementCostDollarValueAddedMeanList, projectManagementCostDollarValueAddedCurCompanyList)


#Formula 37
#Page  - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel Plot
jpeg_save(plotGraphType1("Net.Profit.per.Cost.of.Field.Project.Management.Personnel", "Project Management Cost Effectiveness: \nDollar Net Profit / Cost of Project Management Personnel"),"Net.Profit.per.Cost.of.Field.Project.Management.Personnel")

#Page  - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel Data
# plotData("Project Management Cost Effectiveness: ", "Dollar Net Profit / Cost of Project Management Personnel", webCompanyName, 
#          projectManagementCostDollarNetProfitQuantileList, projectManagementCostDollarNetProfitMeanList, projectManagementCostDollarNetProfitCurCompanyList)


#Formula 38
#Page  - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Revenue.per.Cost.of.Bargaining.Unit.Employees", "Craft Worker Cost Effectiveness: \nDollar Revenue/ Cost of Bargaining Unit Employees"),"Revenue.per.Cost.of.Bargaining.Unit.Employees")

#Page  - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees Data
# plotData("Craft Worker Cost Effectiveness: ", "Dollar Revenue/ Cost of Bargaining Unit Employees", webCompanyName, 
#          craftWorkerCostEffectDollarRevenueQuantileList, craftWorkerCostEffectDollarRevenueMeanList, craftWorkerCostEffectDollarRevenueCurCompanyList)


#Formula 39
#Page  - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Value.Added.per.Cost.of.Bargaining.Unit.Employees", "Craft Worker Cost Effectiveness: \nDollar Value Added/ Cost of Bargaining Unit Employees"),"Value.Added.per.Cost.of.Bargaining.Unit.Employees")

#Page  - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees Data
# plotData("Craft Worker Cost Effectiveness: ", "Dollar Value Added/ Cost of Bargaining Unit Employees", webCompanyName, 
#          craftWorkerCostEffectDollarValueAddedQuantileList, craftWorkerCostEffectDollarValueAddedMeanList, craftWorkerCostEffectDollarValueAddedCurCompanyList)


#Formula 40
#Page  - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Net.Profit.per.Cost.of.Bargaining.Unit.Employees", "Craft Worker Cost Effectiveness: \nDollar Net Profit / Cost of Bargaining Unit Employees"),"Net.Profit.per.Cost.of.Bargaining.Unit.Employees")

#Page  - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees Data
# plotData("Craft Worker Cost Effectiveness: ", "Dollar Net Profit / Cost of Bargaining Unit Employees", webCompanyName, 
#          craftWorkerCostEffectDollarNetProfitQuantileList, craftWorkerCostEffectDollarNetProfitMeanList, craftWorkerCostEffectDollarNetProfitCurCompanyList)
# 
# #Transition
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj11,1,1,1000,1000)

#Formula 
#Page : Turnover Rate Percentage Plot 
jpeg_save(plotGraphType2("Turnover.Rate.of.Bargaining.Unit.Employees", "Turnover Rate of Bargaining Unit Employees"),"Turnover.Rate.of.Bargaining.Unit.Employees")

#Page : Turnover Rate Percentage Data
# plotDataType2("Turnover Rate of Bargaining Unit Employees", "", webCompanyName, 
#               turnoverRateQuantileList, turnoverRateMeanList, turnoverRatePercentageCurCompanyList)

#Formula 47
#Page  - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Cost.of.Field.Project.Management.Personnel.per.Cost.of.Bargaining.Unit.Employees", "Cost of Field Project Management Personnel \nper Cost of Bargaining Unit Employees"),"Cost.of.Field.Project.Management.Personnel.per.Cost.of.Bargaining.Unit.Employees")

#Page  - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees Data
# plotData("Cost of Field Project Management Personnel", "per Cost of Bargaining Unit Employees", webCompanyName, 
#          costFieldProjManagementPersonnelQuantileList, costFieldProjManagementPersonnelMeanList, costFieldProjManagementPersonnelCurCompanyList)

#Formula 45
#Page  - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees Plot
jpeg_save(plotGraphType1("Cost.of.Bargaining.Unit.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Cost of Bargaining Unit Employees \nper Expended Man Hours of Bargaining Unit Employees"),"Cost.of.Bargaining.Unit.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees")

#Page  - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees Data
# plotData("Cost of Bargaining Unit Employees", "per Expended Man Hours of Bargaining Unit Employees", webCompanyName, 
#          costBargainingUnitEmployeeQuantileList, costBargainingUnitEmployeeMeanList, costBargainingUnitEmployeeCurCompanyList)

#Transition
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj12,1,1,1000,1000)

#Formula 
#Page : OSHA Recordable Incident Rate Plot 
jpeg_save(plotGraphType1("OSHA.Recordable.Incident.Rate", "OSHA Recordable Incident Rate"),"OSHA.Recordable.Incident.Rate")

#Page : OSHA Recordable Incident Rate Data
# plotData("OSHA Recordable Incident Rate", "", webCompanyName, 
#          OSHAQuantileList, OSHAMeanList, OSHACurCompanyList)

#Transition
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj13,1,1,1000,1000)

#Formula 
#Page : Repeat Business Customers Percentage Plot 
jpeg_save(plotGraphType2("Repeat.Business.Customers.Percentage", "Repeat Business Customers Percentage"),"Repeat.Business.Customers.Percentage")

#Page : Repeat Business Customers Percentage Data
# plotDataType2("Repeat Business Customers Percentage", "", webCompanyName, 
#               repeatCustomerPercentageQuantileList, repeatCustomerPercentageMeanList, repeatCustomerPercentageCurCompanyList)


# #end
# plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
# rasterImage(jj14,1,1,1000,1000)
# 
# dev.off()
# 
# options(warn = oldw)

###################################################################################################################
#OLD FUNCTIONS

#Formula 8
#Page : Overall Productivity Measurement: Dollar Revenue/Hours of Company People Plot 
#returnGraph4<-plotGraphType1("Revenue.per.Total.hours.of.People", "Overall Productivity Measurement: \nDollar Revenue/Hours of Company People")
#plot(returnGraph4)
#Page : Overall Productivity Measurement – Dollar Revenue/Hours of Company’s People Data
#plotData("Overall Productivity Measurement: ", "Dollar Revenue/Hours of Company People", webCompanyName, 
         #overallProductivityMeasurementDollarRevenueHoursQuantileList, overallProductivityMeasurementDollarRevenueHoursMeanList, overallProductivityMeasurementCurCompanyList)


#Formula 9
#Page : Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People Plot
#returnGraph5<-plotGraphType1("Value.Added.per.Total.hours.of.People", "Overall Productivity Measurement: \nDollar Value Added/Hours of Company People")
#plot(returnGraph5)
#Page : Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People Data
#plotData("Overall Productivity Measurement: ", "Dollar Value Added/Hours of Company People", webCompanyName,
         #overallProductivityMeasurementDollarValueAddedQuantileList, overallProductivityMeasurementDollarValueAddedMeanList, overallProductivityMeasurementDollarValueAddedCurCompanyList)



#Formula 10
#Page : Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People Plot
#returnGraph6<-plotGraphType1("Net.Profit.per.Total.hours.of.People", "Overall Profitability Measurement: \nDollar Net Profit /Hours of Company People")
#plot(returnGraph6)
#Page 13: Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People Data
#plotData("Overall Profitability Measurement: ", "Dollar Net Profit /Hours of Company People", webCompanyName, 
         #overallProductivityMeasurementDollarNetProfitQuantileList, overallProductivityMeasurementDollarNetProfitMeanList, overallProductivityMeasurementDollarNetProfitCurCompanyList)



#Formula 11
#Page : Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel Plot
#jpeg_save(plotGraphType1("Revenue.per.Hour.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Revenue/Hours of Project Management Personnel")
#plot(returnGraph7)
#Page : Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel Data
#plotData("Project Management Productivity Measurement: ", "Dollar Revenue/Hours of Project Management Personnel", webCompanyName,
         #projectManagementProductivityDollarRevenueQuantileList, projectManagementProductivityDollarRevenueMeanList, projectManagementDollarRevenueCurCompanyList)


#Formula 12
#Page : Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel  Plot
#jpeg_save(plotGraphType1("Value.Added.per.Hour.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Value Added/Hours of Project Management Personnel")
#plot(returnGraph7)
#Page : Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel  Data
#plotData("Project Management Productivity Measurement: ", "Dollar Value Added/Hours of Project Management Personnel", webCompanyName,
         #projectManagementProductivityDollarValueAddedQuantileList, projectManagementProductivityDollarValueAddedMeanList, projectManagementDollarValueAddedCurCompanyList)         


#Formula 13
#Page : Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel Plot
#jpeg_save(plotGraphType1("Value.Added.per.Hour.of.Field.Project.Management.Personnel", "Project Management Profitability Measurement: \nDollar Net Profit /Hours of Project Management Personnel")
#plot(returnGraph7)
#Page : Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel Data
#plotData("Project Management Profitability Measurement: ", "Dollar Net Profit /Hours of Project Management Personnel", webCompanyName,
#         projectManagementProductivityDollarNetProfitQuantileList, projectManagementProductivityDollarNetProfitMeanList, projectManagementDollarNetProfitCurCompanyList)


#Formula 17
#Page : Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees Plot
#returnGraph8<-plotGraphType1("Revenue.per.Hours.of.Supporting.Employees","Supporting Employees Productivity Measurement: \nDollar Revenue/ Hours of Supporting Employees")
#plot(returnGraph8)
#Page : Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees Data
#plotData("Supporting Employees Productivity Measurement: ","Dollar Revenue/ Hours of Supporting Employees", webCompanyName, 
        # supportingEmployeeDollarRevenueQuantileList, supportingEmployeeDollarRevenueMeanList, supportingEmployeeDollarRevenueCurCompanyList)


#Formula 18
#Page : Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees Plot
#returnGraph8<-plotGraphType1("Value.Added.per.Hours.of.Supporting.Employees", "Supporting Employees Productivity Measurement: \nDollar Value Added/ Hours of Supporting Employees")
#plot(returnGraph8)
#Page : Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees Data
#plotData("Supporting Employees Productivity Measurement: ","Dollar Value Added/ Hours of Supporting Employees", webCompanyName, 
         #supportingEmployeeDollarValueAddedQuantileList, supportingEmployeeDollarValueAddedMeanList, supportingEmployeeDollarValueAddedCurCompanyList)



#Formula 19
#Page : Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees Plot
#returnGraph8<-plotGraphType1("Net.Profit.per.Hours.of.Supporting.Employees", "Supporting Employees Profitability Measurement: \nDollar Net Profit / Hours of Supporting Employees")
#plot(returnGraph8)
#Page : Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees Data
#plotData("Supporting Employees Profitability Measurement: ","Dollar Net Profit / Hours of Supporting Employees", webCompanyName, 
        # supportingEmployeeDollarNetProfitQuantileList, supportingEmployeeDollarNetProfitMeanList, supportingEmployeeDollarNetProfitCurCompanyList)



#Formula 20
#Page : Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People Plot
#returnGraph8<-plotGraphType1("Revenue.per.Total.FTE.of.People", "Overall Productivity Measurement: \nDollar Revenue/FTEs of Company People")
#plot(returnGraph8)
#Page : Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People Data
#plotData("Overall Productivity Measurement: ","Dollar Revenue/FTEs of Company People", webCompanyName, 
         #overallProductivityDollarRevenueFteQuantileList, overallProductivityDollarRevenueFteMeanList, overallProductivityDollarRevenueFteCurCompanyList)


#Formula 21
#Page : Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People Plot
#returnGraph8<-plotGraphType1("Value.Added.per.Total.FTE.of.People", "Overall Productivity Measurement: \nDollar Value Added/FTEs of Company People")
#plot(returnGraph8)
#Page : Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People Data
#plotData("Overall Productivity Measurement: ","Dollar Value Added/FTEs of Company People", webCompanyName, 
        # overallProductivityDollarValueAddedFteQuantileList, overallProductivityDollarValueAddedFteMeanList, overallProductivityDollarValueAddedFteCurCompanyList)

#Formula 22
#Page : Overall Profitability Measurement – Dollar Net Profit /FTEs of  Company’s People Plot
#returnGraph8<-plotGraphType1("Net.Profit.per.Total.FTE.of.People", "Overall Profitability Measurement: \nDollar Net Profit /FTEs of  Company People")
#plot(returnGraph8)
#Page : Overall Profitability Measurement – Dollar Net Profit /FTEs of  Company’s People Data
#plotData("Overall Profitability Measurement: ","Dollar Net Profit /FTEs of  Company People", webCompanyName, 
         #overallProductivityDollarNetProfitFteQuantileList, overallProductivityDollarNetProfitFteMeanList, overallProductivityDollarNetProfitFteCurCompanyList)

#Formula 29
#Page  - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees Plot
#jpeg_save(plotGraphType1("Revenue.per.FTE.of.Supporting.Employees", "Supporting Employees Productivity Measurement: \nDollar Revenue/ FTEs of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees Data
#plotData("Supporting Employees Productivity Measurement: ","Dollar Revenue/ FTEs of Supporting Employees", webCompanyName, 
        # supportingEmployeeDollarRevenueFteQuantileList, supportingEmployeeDollarRevenueFteMeanList, supportingEmployeeDollarRevenueFteCurCompanyList)

#Formula 30
#Page  - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees Plot
#jpeg_save(plotGraphType1("Value.Added.per.FTE.of.Supporting.Employees", "Supporting Employees Productivity Measurement: \nDollar Value Added/ FTEs of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees Data
#plotData("Supporting Employees Productivity Measurement: ","Dollar Value Added/ FTEs of Supporting Employees", webCompanyName, 
     #    supportingEmployeeDollarValueAddedFteQuantileList, supportingEmployeeDollarValueAddedFteMeanList, supportingEmployeeDollarValueAddedFteCurCompanyList)


#Formula 31
#Page  - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees Plot
#jpeg_save(plotGraphType1("Net.Profit.per.FTE.of.Supporting.Employees", "Supporting Employees Profitability Measurement: \nDollar Net Profit / FTEs of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees Data
#plotData("Supporting Employees Profitability Measurement: ","Dollar Net Profit / FTEs of Supporting Employees", webCompanyName, 
      #   supportingEmployeeDollarNetProfitFteQuantileList, supportingEmployeeDollarNetProfitFteMeanList, supportingEmployeeDollarNetProfitFteCurCompanyList)


#Formula 32
#Page  - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People Plot
#jpeg_save(plotGraphType1("Revenue.per.Total.Cost.of.People", "Overall Cost Effectiveness: \nDollar Revenue/Cost of Company People")
#plot(returnGraph9)
#Page  - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People Data
#plotData("Overall Cost Effectiveness: ","Dollar Revenue/Cost of Company People", webCompanyName, 
  #       overallCostEffectivenessDollarRevenueQuantileList, overallCostEffectivenessDollarRevenueMeanList, overallCostEffectivenessDollarRevenueCurCompanyList)


#Formula 33
#Page  - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People Plot
#jpeg_save(plotGraphType1("Value.Added.per.Total.Cost.of.People", "Overall Cost Effectiveness: \nDollar Value Added/ Cost of Company People")
#plot(returnGraph9)
#Page  - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People Data
#plotData("Overall Cost Effectiveness: ","Dollar Value Added/ Cost of Company People", webCompanyName, 
#         overallCostEffectivenessDollarValueAddedQuantileList, overallCostEffectivenessDollarValueAddedMeanList, overallCostEffectivenessDollarValueAddedCurCompanyList)


#Formula 34
#Page  - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People Plot
#jpeg_save(plotGraphType1("Net.Profit.per.Total.Cost.of.People", "Overall Cost Effectiveness:  \nDollar Net Profit / Cost of Company People")
#plot(returnGraph9)
#Page  - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People Data
#plotData("Overall Cost Effectiveness: ", "Dollar Net Profit / Cost of Company People", webCompanyName, 
         #overallCostEffectivenessDollarNetProfitQuantileList, overallCostEffectivenessDollarNetProfitMeanList, overallCostEffectivenessDollarNetProfitCurCompanyList)


#Formula 41
#Page  - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees Plot
#jpeg_save(plotGraphType1("Revenue.per.Cost.of.Supporting.Employees", "Supporting Employees Cost Effectiveness: \nDollar Revenue/ Cost of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees Data
#plotData("Supporting Employees Cost Effectiveness: ", "Dollar Revenue/ Cost of Supporting Employees", webCompanyName, 
         #supportingEmployeeCostEffectDollarRevenueQuantileList, supportingEmployeeCostEffectDollarRevenueMeanList, supportingEmployeeCostEffectDollarRevenueCurCompanyList)


#Formula 42
#Page  - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees Plot
#jpeg_save(plotGraphType1("Value.Added.per.Cost.of.Supporting.Employees", "Supporting Employees Cost Effectiveness: \nDollar Value Added/ Cost of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees Graph
#plotData("Supporting Employees Cost Effectiveness: ", "Dollar Value Added/ Cost of Supporting Employees", webCompanyName, 
       #  supportingEmployeeCostEffectDollarValueAddedQuantileList, supportingEmployeeCostEffectDollarValueAddedMeanList, supportingEmployeeCostEffectDollarValueAddedCurCompanyList)


#Formula 43
#Page  - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees Plot
#jpeg_save(plotGraphType1("Net.Profit.per.Cost.of.Supporting.Employees", "Supporting Employees Cost Effectiveness: \nDollar Net Profit / Cost of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees Data
#plotData("Supporting Employees Cost Effectiveness: ", "Dollar Net Profit / Cost of Supporting Employees", webCompanyName, 
         #supportingEmployeeCostEffectDollarNetProfitQuantileList, supportingEmployeeCostEffectDollarNetProfitMeanList, supportingEmployeeCostEffectDollarNetProfitCurCompanyList)

#Formula 44
#Page  - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel Plot
#jpeg_save(plotGraphType1("Cost.of.Field.Project.Management.Personnel.per.Hours.of.Field.Project.Management.Personnel", "Cost of Field Project Management Personnel \nper Hours of Field Project Management Personnel")
#plot(returnGraph9)
#Page  - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel Data
#plotData("Cost of Field Project Management Personnel", "per Hours of Field Project Management Personnel", webCompanyName, 
       #  costFieldProjManagementQuantileList, costFieldProjManagementMeanList, costFieldProjManagementCurCompanyList)

#Formula 46
#Page  - Cost of Supporting Employees per Hours of Supporting Employees Plot
#jpeg_save(plotGraphType1("Cost.of.Supporting.Employees.per.Hours.of.Supporting.Employees", "Cost of Supporting Employees \nper Hours of Supporting Employees")
#plot(returnGraph9)
#Page  - Cost of Supporting Employees per Hours of Supporting Employees Data
#plotData("Cost of Supporting Employees", "per Hours of Supporting Employees", webCompanyName, 
        # costSupportingEmployeesQuantileList, costSupportingEmployeesMeanList, costSupportingEmployeesCurCompanyList)

#Formula 48
#Page  - Cost of Supporting Employees per Cost of Bargaining Unit Employees Plot
#jpeg_save(plotGraphType1("Cost.of.Supporting.Employees.per.Cost.of.Bargaining.Unit.Employees", "Cost of Supporting Employees \nper Cost of Bargaining Unit Employees")
#plot(returnGraph9)
#Page  - Cost of Supporting Employees per Cost of Bargaining Unit Employees Data
#plotData("Cost of Supporting Employees", "per Cost of Bargaining Unit Employees", webCompanyName, 
        # costSupportingEmployeeCostBargainingQuantileList, costSupportingEmployeeCostBargainingMeanList, costSupportingEmployeeCostBargainingCurCompanyList)


#Formula 49
#Page  - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees Plot
#jpeg_save(plotGraphType1("Hours.of.Field.Project.Management.Personnel.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Hours of Field Project Management Personnel \nper Hours of Bargaining Unit Employees")
#plot(returnGraph9)
#Page  - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees Data
#plotData("Hours of Field Project Management Personnel", "per Hours of Bargaining Unit Employees", webCompanyName, 
        # hoursFieldProjectManagementQuantileList, hoursFieldProjectManagementMeanList, hoursFieldProjectManagementCurCompanyList)


#Formula 50
#Page  - Hours of Supporting Employees per Hours of Bargaining Unit Employees Plot
#jpeg_save(plotGraphType1("Hours.of.Supporting.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Hours of Supporting Employees \nper Hours of Bargaining Unit Employees")
#plot(returnGraph9)
#Page  - Hours of Supporting Employees per Hours of Bargaining Unit Employees Data
#plotData("Hours of Supporting Employees", "per Hours of Bargaining Unit Employees", webCompanyName, 
         #hoursSupportingEmployeeQuantileList, hoursSupportingEmployeeMeanList, hoursSupportingEmployeeCurCompanyList)










