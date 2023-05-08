years <- 2011:2020 #list of years to be used by EVERY loop

oldw <- getOption("warn")
options(warn = -1)

# Get Arguments from web. If performing analytics from website, use args[1]. 
# If manually running script, enter the company ID from the database (e.g. 71 for P&E)
args <- commandArgs(TRUE)
webCompanyId <- 71  

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


# Get Cur Company Name
webCompanyNameStore <- dbGetQuery(con, paste ("SELECT company_name FROM secure_login.Company where id=", webCompanyId));
webCompanyName <- webCompanyNameStore$company_name

#1 Net Profit Percentage Query
netProfitPercentageList <- c()
netProfitPercentageCurCompanyList <- c()

#2 Gross Profit Percentage Query
grossProfitPercentageList <- c()
grossProfitPercentageCurCompanyList <- c()

#3 Overhead Percentage Query
overheadPercentageList <- c()
overheadPercentageCurCompanyList <- c()

#4 Hit Rate Percentage Query
hitRatePercentageList <- c()
hitRatePercentageCurCompanyList <- c()

# Turnover Rate Percentage Query
turnoverRatePercentageList <- c()
turnoverRatePercentageCurCompanyList <- c()

# Absenteeism Percentage Query
absenteeismPercentageList <- c()
absenteeismPercentageCurCompanyList <- c()

# OSHA Query
OSHAList <- c()
OSHACurCompanyList <- c()

# EMR Query
EMRList <- c()
EMRCurCompanyList <- c()

# Repeat Business Customers Query
repeatCustomerPercentageList <- c()
repeatCustomerPercentageCurCompanyList <- c()

#5 Cost of purchased materials by the company as a percentage of the revenue Query
costPurchasedMaterialsList <- c()
costPurchasedMaterialsCurCompanyList <- c()

#6 Payments Disbursed to Subcontractors as a percentage of the Revenue Query
payDisbursedSubContrList <- c()
payDisbursedSubContrCurCompanyList <- c()

#8 Overall Productivity Measurement – Dollar Revenue/Hours of Company’s People Query
overallProductivityMeasurementList <- c()
overallProductivityMeasurementCurCompanyList <- c()

#9 Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People 
overallProductivityMeasurementDollarValueAddedList <- c()
overallProductivityMeasurementDollarValueAddedCurCompanyList <- c()

#10 Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People
overallProductivityMeasurementDollarNetProfitList <- c()
overallProductivityMeasurementDollarNetProfitCurCompanyList <- c()

#11 Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel 
projectManagementDollarRevenueList <- c()
projectManagementDollarRevenueCurCompanyList <- c()

#12 Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel 
projectManagementDollarValueAddedList <- c()
projectManagementDollarValueAddedCurCompanyList <- c()

#13 Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel 
projectManagementDollarNetProfitList <- c()
projectManagementDollarNetProfitCurCompanyList <- c()

#14 Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees 
craftWorkerDollarRevenueList <- c()
craftWorkerDollarRevenueCurCompanyList <- c()

#15 Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit
craftWorkerDollarValueAddedList <- c()
craftWorkerDollarValueAddedCurCompanyList <- c()

#16 Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees 
craftWorkerDollarNetProfitList <- c()
craftWorkerDollarNetProfitCurCompanyList <- c()

#17 Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees 
supportingEmployeeDollarRevenueList <- c()
supportingEmployeeDollarRevenueCurCompanyList <- c()

#18 Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees
supportingEmployeeDollarValueAddedList <- c()
supportingEmployeeDollarValueAddedCurCompanyList <- c()

#19 Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees
supportingEmployeeDollarNetProfitList <- c()
supportingEmployeeDollarNetProfitCurCompanyList <- c()

#20 Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People 
overallProductivityDollarRevenueFteList <- c()
overallProductivityDollarRevenueFteCurCompanyList <- c()

#21 - Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People 
overallProductivityDollarValueAddedFteList <- c()
overallProductivityDollarValueAddedFteCurCompanyList <- c()

#22 - Overall Profitability Measurement – Dollar Net Profit /FTEs of  Company’s People
overallProductivityDollarNetProfitFteList <- c()
overallProductivityDollarNetProfitFteCurCompanyList <- c()

#23 - Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel 
projectManagementDollarRevenuePersonnelFteList <- c()
projectManagementDollarRevenuePersonnelFteCurCompanyList <- c()

#24 - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management 
projectManagementDollarValueAddedPersonnelFteList <- c()
projectManagementDollarValueAddedPersonnelFteCurCompanyList <- c()

#25 - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel 
projectManagementDollarNetProfitPersonnelFteList <- c()
projectManagementDollarNetProfitPersonnelFteCurCompanyList <- c()

#26 - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees 
craftWorkerDollarRevenueFteList <- c()
craftWorkerDollarRevenueFteCurCompanyList <- c()

#27 - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit 
craftWorkerDollarValueAddedFteList <- c()
craftWorkerDollarValueAddedFteCurCompanyList <- c()

#28 - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees
craftWorkerDollarNetProfitFteList <- c()
craftWorkerDollarNetProfitFteCurCompanyList <- c()

#29 - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees 
supportingEmployeeDollarRevenueFteList <- c()
supportingEmployeeDollarRevenueFteCurCompanyList <- c()

#30 - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees
supportingEmployeeDollarValueAddedFteList <- c()
supportingEmployeeDollarValueAddedFteCurCompanyList <- c()

#31 - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees
supportingEmployeeDollarNetProfitFteList <- c()
supportingEmployeeDollarNetProfitFteCurCompanyList <- c()

#32 - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People 
overallCostEffectivenessDollarRevenueList <- c()
overallCostEffectivenessDollarRevenueCurCompanyList <- c()

#33 - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People 
overallCostEffectivenessDollarValueAddedList <- c()
overallCostEffectivenessDollarValueAddedCurCompanyList <- c()

#34 - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People 
overallCostEffectivenessDollarNetProfitList <- c()
overallCostEffectivenessDollarNetProfitCurCompanyList <- c()

#35 - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel 
projectManagementCostDollarRevenueList <- c()
projectManagementCostDollarRevenueCurCompanyList <- c()

#36 - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel 
projectManagementCostDollarValueAddedList <- c()
projectManagementCostDollarValueAddedCurCompanyList <- c()

#37 - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel 
projectManagementCostDollarNetProfitList <- c()
projectManagementCostDollarNetProfitCurCompanyList <- c()

#38 - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees 
craftWorkerCostEffectDollarRevenueList <- c()
craftWorkerCostEffectDollarRevenueCurCompanyList <- c()

#39 - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees
craftWorkerCostEffectDollarValueAddedList <- c()
craftWorkerCostEffectDollarValueAddedCurCompanyList <- c()

#40 - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees 
craftWorkerCostEffectDollarNetProfitList <- c()
craftWorkerCostEffectDollarNetProfitCurCompanyList <- c()

#41 - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees 
supportingEmployeeCostEffectDollarRevenueList <- c()
supportingEmployeeCostEffectDollarRevenueCurCompanyList <- c()

#42 - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees
supportingEmployeeCostEffectDollarValueAddedList <- c()
supportingEmployeeCostEffectDollarValueAddedCurCompanyList <- c()

#43 - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees
supportingEmployeeCostEffectDollarNetProfitList <- c()
supportingEmployeeCostEffectDollarNetProfitCurCompanyList <- c()

#44 - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel
costFieldProjManagementList <- c()
costFieldProjManagementCurCompanyList <- c()

#45 - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees
costBargainingUnitEmployeeList <- c()
costBargainingUnitEmployeeCurCompanyList <- c()

#46 - Cost of Supporting Employees per Hours of Supporting Employees
costSupportingEmployeesList <- c()
costSupportingEmployeesCurCompanyList <- c()

#47 - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees 
costFieldProjManagementPersonnelList <- c()
costFieldProjManagementPersonnelCurCompanyList <- c()

#48 - Cost of Supporting Employees per Cost of Bargaining Unit Employees
costSupportingEmployeeCostBargainingList <- c()
costSupportingEmployeeCostBargainingCurCompanyList <- c()

#49 - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees 
hoursFieldProjectManagementList <- c()
hoursFieldProjectManagementCurCompanyList <- c()

#50 - Hours of Supporting Employees per Hours of Bargaining Unit Employees 
hoursSupportingEmployeeList <- c()
hoursSupportingEmployeeCurCompanyList <- c()



i <- 1
for(yr in years){ #loop through every year in years
  netProfitPercentageList[i] <- dbGetQuery(con, paste("SELECT net_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND net_profit_percentage is not null"));
  netProfitPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT net_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND net_profit_percentage is not null"));
  
  grossProfitPercentageList[i] <- dbGetQuery(con, paste("SELECT gross_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND gross_profit_percentage is not null"));
  grossProfitPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT gross_profit_percentage FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND gross_profit_percentage is not null"));
  
  overheadPercentageList[i] <- dbGetQuery(con, paste("SELECT overhead_percentage FROM secure_login.adminresults WHERE year=", yr, " AND overhead_percentage is not null"));
  overheadPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overhead_percentage FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overhead_percentage is not null"));
  
  hitRatePercentageList[i] <- dbGetQuery(con, paste("SELECT hit_rate FROM secure_login.Year WHERE year=", yr, " AND hit_rate is not null"));
  hitRatePercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT hit_rate FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND hit_rate is not null"));
  
  turnoverRatePercentageList[i] <- dbGetQuery(con, paste("SELECT turnover_rate_bargaining_perc FROM secure_login.Year WHERE year=", yr, " AND turnover_rate_bargaining_perc is not null"));
  turnoverRatePercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT turnover_rate_bargaining_perc FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND turnover_rate_bargaining_perc is not null"));
  
  absenteeismPercentageList[i] <- dbGetQuery(con, paste("SELECT absenteeism_perc FROM secure_login.Year WHERE year=", yr, " AND absenteeism_perc is not null"));
  absenteeismPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT absenteeism_perc FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND absenteeism_perc is not null"));
  
  OSHAList[i] <- dbGetQuery(con, paste("SELECT osha_incident_rate FROM secure_login.Year WHERE year=", yr, " AND osha_incident_rate is not null"));
  OSHACurCompanyList[i] <- dbGetQuery(con, paste ("SELECT osha_incident_rate FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND osha_incident_rate is not null"));
  
  EMRList[i] <- dbGetQuery(con, paste("SELECT emr FROM secure_login.Year WHERE year=", yr, " AND emr is not null"));
  EMRCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT emr FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND emr is not null"));
  
  repeatCustomerPercentageList[i] <- dbGetQuery(con, paste("SELECT repeat_customer_perc FROM secure_login.Year WHERE year=", yr, " AND repeat_customer_perc is not null"));
  repeatCustomerPercentageCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT repeat_customer_perc FROM secure_login.Year WHERE year=", yr, " AND company_id=", webCompanyId," AND repeat_customer_perc is not null"));
  
  costPurchasedMaterialsList[i] <- dbGetQuery(con, paste("SELECT cost_purchased_materials FROM secure_login.adminresults WHERE year=", yr, " AND cost_purchased_materials is not null"));
  costPurchasedMaterialsCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_purchased_materials FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_purchased_materials is not null"));
  
  payDisbursedSubContrList[i] <- dbGetQuery(con, paste("SELECT pay_disbursed_subcontr FROM secure_login.adminresults WHERE year=", yr, " AND pay_disbursed_subcontr is not null"));
  payDisbursedSubContrCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT pay_disbursed_subcontr FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND pay_disbursed_subcontr is not null"));
  
  overallProductivityMeasurementList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_measurement_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_measurement_dollar_revenue is not null"));
  overallProductivityMeasurementCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_measurement_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_measurement_dollar_revenue is not null"));
  
  overallProductivityMeasurementDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_measurement_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_measurement_dollar_value_added is not null"));
  overallProductivityMeasurementDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_measurement_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_measurement_dollar_value_added is not null"));
  
  overallProductivityMeasurementDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_measurement_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_measurement_dollar_net_profit is not null"));
  overallProductivityMeasurementDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_measurement_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_measurement_dollar_net_profit is not null"));
  
  projectManagementDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_revenue is not null"));
  projectManagementDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_revenue is not null"));
  
  projectManagementDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_value_added is not null"));
  projectManagementDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_value_added is not null"));
  
  projectManagementDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_net_profit is not null"));
  projectManagementDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_net_profit is not null"));
  
  craftWorkerDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_revenue is not null"));
  craftWorkerDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_revenue is not null"));
  
  craftWorkerDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_value_added is not null"));
  craftWorkerDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_value_added is not null"));
  
  craftWorkerDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_net_profit is not null"));
  craftWorkerDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_net_profit is not null"));
  
  supportingEmployeeDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_revenue is not null"));
  supportingEmployeeDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_revenue FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_revenue is not null"));
  
  supportingEmployeeDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_value_added is not null"));
  supportingEmployeeDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_value_added FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_value_added is not null"));
  
  supportingEmployeeDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_net_profit is not null"));
  supportingEmployeeDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_net_profit FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_net_profit is not null"));
  
  overallProductivityDollarRevenueFteList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_dollar_revenue_fte is not null"));
  overallProductivityDollarRevenueFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_dollar_revenue_fte is not null"));
  
  overallProductivityDollarValueAddedFteList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_dollar_value_added_fte is not null"));
  overallProductivityDollarValueAddedFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_dollar_value_added_fte is not null"));
  
  overallProductivityDollarNetProfitFteList[i] <- dbGetQuery(con, paste("SELECT overall_productivity_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND overall_productivity_dollar_net_profit_fte is not null"));
  overallProductivityDollarNetProfitFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_productivity_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_productivity_dollar_net_profit_fte is not null"));
  
  projectManagementDollarRevenuePersonnelFteList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_revenue_fte is not null"));
  projectManagementDollarRevenuePersonnelFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_revenue_fte is not null"));
  
  projectManagementDollarValueAddedPersonnelFteList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_value_added_fte is not null"));
  projectManagementDollarValueAddedPersonnelFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_value_added_fte is not null"));
  
  projectManagementDollarNetProfitPersonnelFteList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_net_profit_fte is not null"));
  projectManagementDollarNetProfitPersonnelFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_net_profit_fte is not null"));
  
  craftWorkerDollarRevenueFteList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_revenue_fte is not null"));
  craftWorkerDollarRevenueFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_revenue_fte is not null"));
  
  craftWorkerDollarValueAddedFteList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_value_added_fte is not null"));
  craftWorkerDollarValueAddedFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_value_added_fte is not null"));
  
  craftWorkerDollarNetProfitFteList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_net_profit_fte is not null"));
  craftWorkerDollarNetProfitFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_net_profit_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_net_profit_fte is not null"));
  
  supportingEmployeeDollarRevenueFteList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_revenue_fte is not null"));
  supportingEmployeeDollarRevenueFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_revenue_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_revenue_fte is not null"));
  
  supportingEmployeeDollarValueAddedFteList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_value_added_fte is not null"));
  supportingEmployeeDollarValueAddedFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_value_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_value_added_fte is not null"));
  
  supportingEmployeeDollarNetProfitFteList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_net_profit_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_net_profit_added_fte is not null"));
  supportingEmployeeDollarNetProfitFteCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_net_profit_added_fte FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_net_profit_added_fte is not null"));
  
  overallCostEffectivenessDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT overall_cost_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND overall_cost_dollar_revenue_cost is not null"));
  overallCostEffectivenessDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_cost_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_cost_dollar_revenue_cost is not null"));
  
  overallCostEffectivenessDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT overall_cost_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND overall_cost_dollar_value_added_cost is not null"));
  overallCostEffectivenessDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_cost_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_cost_dollar_value_added_cost is not null"));
  
  overallCostEffectivenessDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT overall_cost_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND overall_cost_dollar_net_profit_cost is not null"));
  overallCostEffectivenessDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT overall_cost_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND overall_cost_dollar_net_profit_cost is not null"));
  
  projectManagementCostDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_revenue_cost is not null"));
  projectManagementCostDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_revenue_cost is not null"));
  
  projectManagementCostDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_value_added_cost is not null"));
  projectManagementCostDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_value_added_cost is not null"));
  
  projectManagementCostDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT project_management_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND project_management_dollar_net_profit_cost is not null"));
  projectManagementCostDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT project_management_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND project_management_dollar_net_profit_cost is not null"));
  
  craftWorkerCostEffectDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_revenue_cost is not null"));
  craftWorkerCostEffectDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_revenue_cost is not null"));
  
  craftWorkerCostEffectDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_value_added_cost is not null"));
  craftWorkerCostEffectDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_value_added_cost is not null"));
  
  craftWorkerCostEffectDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT craft_worker_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND craft_worker_dollar_net_profit_cost is not null"));
  craftWorkerCostEffectDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT craft_worker_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND craft_worker_dollar_net_profit_cost is not null"));
  
  supportingEmployeeCostEffectDollarRevenueList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_revenue_cost is not null"));
  supportingEmployeeCostEffectDollarRevenueCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_revenue_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_revenue_cost is not null"));
  
  supportingEmployeeCostEffectDollarValueAddedList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_value_added_cost is not null"));
  supportingEmployeeCostEffectDollarValueAddedCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_value_added_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_value_added_cost is not null"));
  
  supportingEmployeeCostEffectDollarNetProfitList[i] <- dbGetQuery(con, paste("SELECT supporting_employee_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND supporting_employee_dollar_net_profit_cost is not null"));
  supportingEmployeeCostEffectDollarNetProfitCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT supporting_employee_dollar_net_profit_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND supporting_employee_dollar_net_profit_cost is not null"));
  
  costFieldProjManagementList[i] <- dbGetQuery(con, paste("SELECT cost_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND cost_field_project_management_personnel is not null"));
  costFieldProjManagementCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_field_project_management_personnel is not null"));
  
  costBargainingUnitEmployeeList[i] <- dbGetQuery(con, paste("SELECT cost_bargaining_unit_employee_expended FROM secure_login.adminresults WHERE year=", yr, " AND cost_bargaining_unit_employee_expended is not null"));
  costBargainingUnitEmployeeCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_bargaining_unit_employee_expended FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_bargaining_unit_employee_expended is not null"));
  
  costSupportingEmployeesList[i] <- dbGetQuery(con, paste("SELECT cost_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND cost_supporting_employee_per_hour is not null"));
  costSupportingEmployeesCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_supporting_employee_per_hour is not null"));
  
  costFieldProjManagementPersonnelList[i] <- dbGetQuery(con, paste("SELECT cost_field_project_management_personnel_cost FROM secure_login.adminresults WHERE year=", yr, " AND cost_field_project_management_personnel_cost is not null"));
  costFieldProjManagementPersonnelCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_field_project_management_personnel_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_field_project_management_personnel_cost is not null"));
  
  costSupportingEmployeeCostBargainingList[i] <- dbGetQuery(con, paste("SELECT cost_supp_employee_cost FROM secure_login.adminresults WHERE year=", yr, " AND cost_supp_employee_cost is not null"));
  costSupportingEmployeeCostBargainingCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT cost_supp_employee_cost FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND cost_supp_employee_cost is not null"));
  
  hoursFieldProjectManagementList[i] <- dbGetQuery(con, paste("SELECT hours_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND hours_field_project_management_personnel is not null"));
  hoursFieldProjectManagementCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT hours_field_project_management_personnel FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND hours_field_project_management_personnel is not null"));
  
  hoursSupportingEmployeeList[i] <- dbGetQuery(con, paste("SELECT hours_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND hours_supporting_employee_per_hour is not null"));
  hoursSupportingEmployeeCurCompanyList[i] <- dbGetQuery(con, paste ("SELECT hours_supporting_employee_per_hour FROM secure_login.adminresults WHERE year=", yr, " AND company_id=", webCompanyId," AND hours_supporting_employee_per_hour is not null"));
  
  
  i = i+1 #increment
} 



######################################################################################################################################
# QUANTILE CALCULATION




#50 - Hours of Supporting Employees per Hours of Bargaining Unit Employees 
hoursSupportingEmployeeQuantileList = c()
hoursSupportingEmployeeMeanList = c()
Hours.of.Supporting.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$hours_supporting_employee_per_hour

#49 - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees 
hoursFieldProjectManagementQuantileList = c()
hoursFieldProjectManagementMeanList = c()
Hours.of.Field.Project.Management.Personnel.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$hours_field_project_management_personnel

#48 - Cost of Supporting Employees per Cost of Bargaining Unit Employees
costSupportingEmployeeCostBargainingQuantileList = c()
costSupportingEmployeeCostBargainingMeanList = c()
Cost.of.Supporting.Employees.per.Cost.of.Bargaining.Unit.Employees=comp$cost_supp_employee_cost

#47 - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees 
costFieldProjManagementPersonnelQuantileList = c()
costFieldProjManagementPersonnelMeanList = c()
Cost.of.Field.Project.Management.Personnel.per.Cost.of.Bargaining.Unit.Employees=comp$cost_field_project_management_personnel_cost

#46 - Cost of Supporting Employees per Hours of Supporting Employees
costSupportingEmployeesQuantileList = c()
costSupportingEmployeesMeanList = c()
Cost.of.Supporting.Employees.per.Hours.of.Supporting.Employees=comp$cost_supporting_employee_per_hour

#45 - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees
costBargainingUnitEmployeeQuantileList = c()
costBargainingUnitEmployeeMeanList = c()
Cost.of.Bargaining.Unit.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$cost_bargaining_unit_employee_expended

#44 - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel
costFieldProjManagementQuantileList = c()
costFieldProjManagementMeanList = c()
Cost.of.Field.Project.Management.Personnel.per.Hours.of.Field.Project.Management.Personnel=comp$cost_field_project_management_personnel

#43 - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees
supportingEmployeeCostEffectDollarNetProfitQuantileList = c()
supportingEmployeeCostEffectDollarNetProfitMeanList = c()
Net.Profit.per.Cost.of.Supporting.Employees=comp$supporting_employee_dollar_net_profit_cost

#42 - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees
supportingEmployeeCostEffectDollarValueAddedQuantileList = c()
supportingEmployeeCostEffectDollarValueAddedMeanList = c()
Value.Added.per.Cost.of.Supporting.Employees=comp$supporting_employee_dollar_value_added_cost

#41 - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees 
supportingEmployeeCostEffectDollarRevenueQuantileList = c()
supportingEmployeeCostEffectDollarRevenueMeanList = c()
Revenue.per.Cost.of.Supporting.Employees=comp$supporting_employee_dollar_revenue_cost

#40 - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees 
craftWorkerCostEffectDollarNetProfitQuantileList = c()
craftWorkerCostEffectDollarNetProfitMeanList = c()
Net.Profit.per.Cost.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_net_profit_cost

#39 - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees
craftWorkerCostEffectDollarValueAddedQuantileList = c()
craftWorkerCostEffectDollarValueAddedMeanList = c()
Value.Added.per.Cost.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_value_added_cost

#38 - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees 
craftWorkerCostEffectDollarRevenueQuantileList = c()
craftWorkerCostEffectDollarRevenueMeanList = c()
Revenue.per.Cost.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_revenue_cost

#37 - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel
projectManagementCostDollarNetProfitQuantileList = c()
projectManagementCostDollarNetProfitMeanList = c()
Net.Profit.per.Cost.of.Field.Project.Management.Personnel=comp$project_management_dollar_net_profit_cost

#36 - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel
projectManagementCostDollarValueAddedQuantileList = c()
projectManagementCostDollarValueAddedMeanList = c()
Value.Added.per.Cost.of.Field.Project.Management.Personnel=comp$project_management_dollar_value_added_cost

#35 - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel 
projectManagementCostDollarRevenueQuantileList = c()
projectManagementCostDollarRevenueMeanList = c()
Revenue.per.Cost.of.Field.Project.Management.Personnel=comp$project_management_dollar_revenue_cost

#34 - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People 
overallCostEffectivenessDollarNetProfitQuantileList = c()
overallCostEffectivenessDollarNetProfitMeanList = c()
Net.Profit.per.Total.Cost.of.People=comp$overall_cost_dollar_net_profit_cost

#33 - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People 
overallCostEffectivenessDollarValueAddedQuantileList = c()
overallCostEffectivenessDollarValueAddedMeanList = c()
Value.Added.per.Total.Cost.of.People=comp$overall_cost_dollar_value_added_cost

#32 - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People 
overallCostEffectivenessDollarRevenueQuantileList = c()
overallCostEffectivenessDollarRevenueMeanList = c()
Revenue.per.Total.Cost.of.People=comp$overall_cost_dollar_revenue_cost

#31 - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees
supportingEmployeeDollarNetProfitFteQuantileList = c()
supportingEmployeeDollarNetProfitFteMeanList = c()
Net.Profit.per.FTE.of.Supporting.Employees=comp$supporting_employee_dollar_net_profit_added_fte

#30 - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees
supportingEmployeeDollarValueAddedFteQuantileList = c()
supportingEmployeeDollarValueAddedFteMeanList = c()
Value.Added.per.FTE.of.Supporting.Employees=comp$supporting_employee_dollar_value_added_fte

#29 - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees 
supportingEmployeeDollarRevenueFteQuantileList = c()
supportingEmployeeDollarRevenueFteMeanList = c()
Revenue.per.FTE.of.Supporting.Employees=comp$supporting_employee_dollar_revenue_fte

#28 - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees 
craftWorkerDollarNetProfitFteQuantileList = c()
craftWorkerDollarNetProfitFteMeanList = c()
Net.Profit.per.FTE.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_net_profit_fte

#27 - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit 
craftWorkerDollarValueAddedFteQuantileList = c()
craftWorkerDollarValueAddedFteMeanList = c()
Value.Added.per.FTE.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_value_added_fte

#26 - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees 
craftWorkerDollarRevenueFteQuantileList = c()
craftWorkerDollarRevenueFteMeanList = c()
Revenue.per.FTE.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_revenue_fte

#25 - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel 
projectManagementDollarNetProfitPersonnelFteQuantileList = c()
projectManagementDollarNetProfitPersonnelFteMeanList = c()
Net.Profit.per.FTE.of.Field.Project.Management.Personnel=comp$project_management_dollar_net_profit_fte

#24 - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management 
projectManagementDollarValueAddedPersonnelFteQuantileList = c()
projectManagementDollarValueAddedPersonnelFteMeanList = c()
Value.Added.per.FTE.of.Field.Project.Management.Personnel=comp$project_management_dollar_value_added_fte

#23 - Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel 
projectManagementDollarRevenuePersonnelFteQuantileList = c()
projectManagementDollarRevenuePersonnelFteMeanList = c()
Revenue.per.FTE.of.Field.Project.Management.Personnel=comp$project_management_dollar_revenue_fte

#22 - Overall Profitability Measurement – Dollar Net Profit /FTEs of  Company’s People
overallProductivityDollarNetProfitFteQuantileList = c()
overallProductivityDollarNetProfitFteMeanList = c()
Net.Profit.per.Total.FTE.of.People=comp$overall_productivity_dollar_net_profit_fte

#21 Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People 
overallProductivityDollarValueAddedFteQuantileList = c()
overallProductivityDollarValueAddedFteMeanList = c()
Value.Added.per.Total.FTE.of.People=comp$overall_productivity_dollar_value_added_fte

#20 Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People
overallProductivityDollarRevenueFteQuantileList = c()
overallProductivityDollarRevenueFteMeanList = c()
Revenue.per.Total.FTE.of.People=comp$overall_productivity_dollar_revenue_fte

#19 Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees
supportingEmployeeDollarNetProfitQuantileList = c()
supportingEmployeeDollarNetProfitMeanList = c()
Net.Profit.per.Hours.of.Supporting.Employees=comp$supporting_employee_dollar_net_profit

#18 Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees
supportingEmployeeDollarValueAddedQuantileList = c()
supportingEmployeeDollarValueAddedMeanList = c()
Value.Added.per.Hours.of.Supporting.Employees=comp$supporting_employee_dollar_value_added

#17 Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees 
supportingEmployeeDollarRevenueQuantileList = c()
supportingEmployeeDollarRevenueMeanList = c()
Revenue.per.Hours.of.Supporting.Employees=comp$supporting_employee_dollar_revenue

#16 Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees 
craftWorkerDollarNetProfitQuantileList = c()
craftWorkerDollarNetProfitMeanList = c()
Net.Profit.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_net_profit

#15 Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit  
craftWorkerDollarValueAddedQuantileList = c()
craftWorkerDollarValueAddedMeanList = c()
Value.Added.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_value_added

#14 Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees 
craftWorkerDollarRevenueQuantileList = c()
craftWorkerDollarRevenueMeanList = c()
Revenue.per.Expended.Man.Hours.of.Bargaining.Unit.Employees=comp$craft_worker_dollar_revenue

#13 Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel
projectManagementProductivityDollarNetProfitQuantileList = c()
projectManagementProductivityDollarNetProfitMeanList = c()
Net.Profit.per.Hour.of.Field.Project.Management.Personnel=comp$project_management_dollar_net_profit

#12 Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel 
projectManagementProductivityDollarValueAddedQuantileList = c()
projectManagementProductivityDollarValueAddedMeanList = c()
Value.Added.per.Hour.of.Field.Project.Management.Personnel=comp$project_management_dollar_value_added

#11 Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel 
projectManagementProductivityDollarRevenueQuantileList = c()
projectManagementProductivityDollarRevenueMeanList = c()
Revenue.per.Hour.of.Field.Project.Management.Personnel=comp$project_management_dollar_revenue

#10 Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People
overallProductivityMeasurementDollarNetProfitQuantileList = c()
overallProductivityMeasurementDollarNetProfitMeanList = c()
Net.Profit.per.Total.hours.of.People=comp$overall_productivity_measurement_dollar_net_profit

#9 Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People 
overallProductivityMeasurementDollarValueAddedQuantileList = c()
overallProductivityMeasurementDollarValueAddedMeanList = c()
Value.Added.per.Total.hours.of.People=comp$overall_productivity_measurement_dollar_value_added

#8 Overall Productivity Measurement – Dollar Revenue/Hours of Company’s People
overallProductivityMeasurementDollarRevenueHoursQuantileList = c()
overallProductivityMeasurementDollarRevenueHoursMeanList = c()
Revenue.per.Total.hours.of.People=comp$overall_productivity_measurement_dollar_revenue

#6 Payments Disbursed to Subcontractors as a percentage of the Revenue
payDisbursedSubContrQuantileList = c()
payDisbursedSubContrMeanList = c()
Percentage.of.Revenue.as.Payments.Disbursed.to.Subcontractors=comp$pay_disbursed_subcontr

#Cost of purchased materials by the company as a percentage of the revenue
costPurchasedMaterialsQuantileList = c()
costPurchasedMaterialsMeanList = c()
Percentage.of.Revenue.as.Cost.of.Purchased.Materials=comp$cost_purchased_materials

# Net Profit Percentage
netProfitQuantileList = c()
netProfitMeanList = c()
Net.Profit.Percentage=comp$net_profit_percentage

# Gross Profit Percentage
grossProfitQuantileList = c()
grossProfitMeanList = c()
Gross.Profit.Percentage=comp$gross_profit_percentage

# Overhead Percentage
overheadQuantileList = c()
overheadMeanList = c()
Overhead.Percentage=comp$overhead_percentage

# Hit Rate Percentage
hitRateQuantileList = c()
hitRateMeanList = c()
Hit.Rate=comp$hit_rate

# Turnover Rate Percentage
turnoverRateQuantileList = c()
turnoverRateMeanList = c()
Turnover.Rate.of.Bargaining.Unit.Employees=comp$turnover_rate_bargaining_perc

# Absenteeism Percentage
absenteeismQuantileList = c()
absenteeismMeanList = c()
Absenteeism.Percentage=comp$absenteeism_perc

# OSHA Recordable Incident Rate 
OSHAQuantileList = c()
OSHAMeanList = c()
OSHA.Recordable.Incident.Rate=comp$osha_incident_rate

# EMR 
EMRQuantileList = c()
EMRMeanList = c()
Experience.Modification.Rate=comp$emr

# Repeat Business Customers
repeatCustomerPercentageQuantileList = c()
repeatCustomerPercentageMeanList = c()
Repeat.Business.Customers.Percentage=comp$repeat_customer_perc



i <- 1
for (yr in years)
{
  hoursSupportingEmployeeQuantileList[[i]] = quantile(unlist(hoursSupportingEmployeeList[i][1]),c(.25,.5,.75))
  hoursSupportingEmployeeMeanList[[i]] = mean(unlist(hoursSupportingEmployeeList[i][1]))
  
  hoursFieldProjectManagementQuantileList[[i]] = quantile(unlist(hoursFieldProjectManagementList[i][1]),c(.25,.5,.75))
  hoursFieldProjectManagementMeanList[[i]] = mean(unlist(hoursFieldProjectManagementList[i][1]))
  
  costSupportingEmployeeCostBargainingQuantileList[[i]] = quantile(unlist(costSupportingEmployeeCostBargainingList[i][1]),c(.25,.5,.75))
  costSupportingEmployeeCostBargainingMeanList[[i]] = mean(unlist(costSupportingEmployeeCostBargainingList[i][1]))
  
  costFieldProjManagementPersonnelQuantileList[[i]] = quantile(unlist(costFieldProjManagementPersonnelList[i][1]),c(.25,.5,.75))
  costFieldProjManagementPersonnelMeanList[[i]] = mean(unlist(costFieldProjManagementPersonnelList[i][1]))
  
  costSupportingEmployeesQuantileList[[i]] = quantile(unlist(costSupportingEmployeesList[i][1]),c(.25,.5,.75))
  costSupportingEmployeesMeanList[[i]] = mean(unlist(costSupportingEmployeesList[i][1]))
  
  costBargainingUnitEmployeeQuantileList[[i]] = quantile(unlist(costBargainingUnitEmployeeList[i][1]),c(.25,.5,.75))
  costBargainingUnitEmployeeMeanList[[i]] = mean(unlist(costBargainingUnitEmployeeList[i][1]))
  
  costFieldProjManagementQuantileList[[i]] = quantile(unlist(costFieldProjManagementList[i][1]),c(.25,.5,.75))
  costFieldProjManagementMeanList[[i]] = mean(unlist(costFieldProjManagementList[i][1]))
  
  supportingEmployeeCostEffectDollarNetProfitQuantileList[[i]] = quantile(unlist(supportingEmployeeCostEffectDollarNetProfitList[i][1]),c(.25,.5,.75))
  supportingEmployeeCostEffectDollarNetProfitMeanList[[i]] = mean(unlist(supportingEmployeeCostEffectDollarNetProfitList[i][1]))
  
  supportingEmployeeCostEffectDollarValueAddedQuantileList[[i]] = quantile(unlist(supportingEmployeeCostEffectDollarValueAddedList[i][1]),c(.25,.5,.75))
  supportingEmployeeCostEffectDollarValueAddedMeanList[[i]] = mean(unlist(supportingEmployeeCostEffectDollarValueAddedList[i][1]))
  
  supportingEmployeeCostEffectDollarRevenueQuantileList[[i]] = quantile(unlist(supportingEmployeeCostEffectDollarRevenueList[i][1]),c(.25,.5,.75))
  supportingEmployeeCostEffectDollarRevenueMeanList[[i]] = mean(unlist(supportingEmployeeCostEffectDollarRevenueList[i][1]))
  
  craftWorkerCostEffectDollarNetProfitQuantileList[[i]] = quantile(unlist(craftWorkerCostEffectDollarNetProfitList[i][1]),c(.25,.5,.75))
  craftWorkerCostEffectDollarNetProfitMeanList[[i]] = mean(unlist(craftWorkerCostEffectDollarNetProfitList[i][1]))
  
  craftWorkerCostEffectDollarValueAddedQuantileList[[i]] = quantile(unlist(craftWorkerCostEffectDollarValueAddedList[i][1]),c(.25,.5,.75))
  craftWorkerCostEffectDollarValueAddedMeanList[[i]] = mean(unlist(craftWorkerCostEffectDollarValueAddedList[i][1]))
  
  craftWorkerCostEffectDollarRevenueQuantileList[[i]] = quantile(unlist(craftWorkerCostEffectDollarRevenueList[i][1]),c(.25,.5,.75))
  craftWorkerCostEffectDollarRevenueMeanList[[i]] = mean(unlist(craftWorkerCostEffectDollarRevenueList[i][1]))
  
  projectManagementCostDollarNetProfitQuantileList[[i]] = quantile(unlist(projectManagementCostDollarNetProfitList[i][1]),c(.25,.5,.75))
  projectManagementCostDollarNetProfitMeanList[[i]] = mean(unlist(projectManagementCostDollarNetProfitList[i][1]))
  
  projectManagementCostDollarValueAddedQuantileList[[i]] = quantile(unlist(projectManagementCostDollarValueAddedList[i][1]),c(.25,.5,.75))
  projectManagementCostDollarValueAddedMeanList[[i]] = mean(unlist(projectManagementCostDollarValueAddedList[i][1]))
  
  projectManagementCostDollarRevenueQuantileList[[i]] = quantile(unlist(projectManagementCostDollarRevenueList[i][1]),c(.25,.5,.75))
  projectManagementCostDollarRevenueMeanList[[i]] = mean(unlist(projectManagementCostDollarRevenueList[i][1]))
  
  overallCostEffectivenessDollarNetProfitQuantileList[[i]] = quantile(unlist(overallCostEffectivenessDollarNetProfitList[i][1]),c(.25,.5,.75))
  overallCostEffectivenessDollarNetProfitMeanList[[i]] = mean(unlist(overallCostEffectivenessDollarNetProfitList[i][1]))
  
  overallCostEffectivenessDollarValueAddedQuantileList[[i]] = quantile(unlist(overallCostEffectivenessDollarValueAddedList[i][1]),c(.25,.5,.75))
  overallCostEffectivenessDollarValueAddedMeanList[[i]] = mean(unlist(overallCostEffectivenessDollarValueAddedList[i][1]))
  
  overallCostEffectivenessDollarRevenueQuantileList[[i]] = quantile(unlist(overallCostEffectivenessDollarRevenueList[i][1]),c(.25,.5,.75))
  overallCostEffectivenessDollarRevenueMeanList[[i]] = mean(unlist(overallCostEffectivenessDollarRevenueList[i][1]))
  
  supportingEmployeeDollarNetProfitFteQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarNetProfitFteList[i][1]),c(.25,.5,.75))
  supportingEmployeeDollarNetProfitFteMeanList[[i]] = mean(unlist(supportingEmployeeDollarNetProfitFteList[i][1]))
  
  supportingEmployeeDollarValueAddedFteQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarValueAddedFteList[i][1]),c(.25,.5,.75))
  supportingEmployeeDollarValueAddedFteMeanList[[i]] = mean(unlist(supportingEmployeeDollarValueAddedFteList[i][1]))
  
  supportingEmployeeDollarRevenueFteQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarRevenueFteList[i][1]),c(.25,.5,.75))
  supportingEmployeeDollarRevenueFteMeanList[[i]] = mean(unlist(supportingEmployeeDollarRevenueFteList[i][1]))
  
  craftWorkerDollarNetProfitFteQuantileList[[i]] = quantile(unlist(craftWorkerDollarNetProfitFteList[i][1]),c(.25,.5,.75))
  craftWorkerDollarNetProfitFteMeanList[[i]] = mean(unlist(craftWorkerDollarNetProfitFteList[i][1]))
  
  craftWorkerDollarValueAddedFteQuantileList[[i]] = quantile(unlist(craftWorkerDollarValueAddedFteList[i][1]),c(.25,.5,.75))
  craftWorkerDollarValueAddedFteMeanList[[i]] = mean(unlist(craftWorkerDollarValueAddedFteList[i][1]))
  
  craftWorkerDollarRevenueFteQuantileList[[i]] = quantile(unlist(craftWorkerDollarRevenueFteList[i][1]),c(.25,.5,.75))
  craftWorkerDollarRevenueFteMeanList[[i]] = mean(unlist(craftWorkerDollarRevenueFteList[i][1]))
  
  projectManagementDollarNetProfitPersonnelFteQuantileList[[i]] = quantile(unlist(projectManagementDollarNetProfitPersonnelFteList[i][1]),c(.25,.5,.75))
  projectManagementDollarNetProfitPersonnelFteMeanList[[i]] = mean(unlist(projectManagementDollarNetProfitPersonnelFteList[i][1]))
  
  projectManagementDollarValueAddedPersonnelFteQuantileList[[i]] = quantile(unlist(projectManagementDollarValueAddedPersonnelFteList[i][1]),c(.25,.5,.75))
  projectManagementDollarValueAddedPersonnelFteMeanList[[i]] = mean(unlist(projectManagementDollarValueAddedPersonnelFteList[i][1]))
  
  projectManagementDollarRevenuePersonnelFteQuantileList[[i]] = quantile(unlist(projectManagementDollarRevenuePersonnelFteList[i][1]),c(.25,.5,.75))
  projectManagementDollarRevenuePersonnelFteMeanList[[i]] = mean(unlist(projectManagementDollarRevenuePersonnelFteList[i][1]))
  
  overallProductivityDollarNetProfitFteQuantileList[[i]] = quantile(unlist(overallProductivityDollarNetProfitFteList[i][1]),c(.25,.5,.75))
  overallProductivityDollarNetProfitFteMeanList[[i]] = mean(unlist(overallProductivityDollarNetProfitFteList[i][1]))
  
  overallProductivityDollarValueAddedFteQuantileList[[i]] = quantile(unlist(overallProductivityDollarValueAddedFteList[i][1]),c(.25,.5,.75))
  overallProductivityDollarValueAddedFteMeanList[[i]] = mean(unlist(overallProductivityDollarValueAddedFteList[i][1]))
  
  overallProductivityDollarRevenueFteQuantileList[[i]] = quantile(unlist(overallProductivityDollarRevenueFteList[i][1]),c(.25,.5,.75))
  overallProductivityDollarRevenueFteMeanList[[i]] = mean(unlist(overallProductivityDollarRevenueFteList[i][1]))
  
  supportingEmployeeDollarNetProfitQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarNetProfitList[i][1]),c(.25,.5,.75))
  supportingEmployeeDollarNetProfitMeanList[[i]] = mean(unlist(supportingEmployeeDollarNetProfitList[i][1]))
  
  supportingEmployeeDollarValueAddedQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarValueAddedList[i][1]),c(.25,.5,.75))
  supportingEmployeeDollarValueAddedMeanList[[i]] = mean(unlist(supportingEmployeeDollarValueAddedList[i][1]))
  
  supportingEmployeeDollarRevenueQuantileList[[i]] = quantile(unlist(supportingEmployeeDollarRevenueList[i][1]),c(.25,.5,.75))
  supportingEmployeeDollarRevenueMeanList[[i]] = mean(unlist(supportingEmployeeDollarRevenueList[i][1]))
  
  craftWorkerDollarNetProfitQuantileList[[i]] = quantile(unlist(craftWorkerDollarNetProfitList[i][1]),c(.25,.5,.75))
  craftWorkerDollarNetProfitMeanList[[i]] = mean(unlist(craftWorkerDollarNetProfitList[i][1]))
  
  craftWorkerDollarValueAddedQuantileList[[i]] = quantile(unlist(craftWorkerDollarValueAddedList[i][1]),c(.25,.5,.75))
  craftWorkerDollarValueAddedMeanList[[i]] = mean(unlist(craftWorkerDollarValueAddedList[i][1]))
  
  craftWorkerDollarRevenueQuantileList[[i]] = quantile(unlist(craftWorkerDollarRevenueList[i][1]),c(.25,.5,.75))
  craftWorkerDollarRevenueMeanList[[i]] = mean(unlist(craftWorkerDollarRevenueList[i][1]))
  
  projectManagementProductivityDollarNetProfitQuantileList[[i]] = quantile(unlist(projectManagementDollarNetProfitList[i][1]),c(.25,.5,.75))
  projectManagementProductivityDollarNetProfitMeanList[[i]] = mean(unlist(projectManagementDollarNetProfitList[i][1]))
  
  projectManagementProductivityDollarValueAddedQuantileList[[i]] = quantile(unlist(projectManagementDollarValueAddedList[i][1]),c(.25,.5,.75))
  projectManagementProductivityDollarValueAddedMeanList[[i]] = mean(unlist(projectManagementDollarValueAddedList[i][1]))
  
  projectManagementProductivityDollarRevenueQuantileList[[i]] = quantile(unlist(projectManagementDollarRevenueList[i][1]),c(.25,.5,.75))
  projectManagementProductivityDollarRevenueMeanList[[i]] = mean(unlist(projectManagementDollarRevenueList[i][1]))
  
  overallProductivityMeasurementDollarNetProfitQuantileList[[i]] = quantile(unlist(overallProductivityMeasurementDollarNetProfitList[i][1]),c(.25,.5,.75))
  overallProductivityMeasurementDollarNetProfitMeanList[[i]] = mean(unlist(overallProductivityMeasurementDollarNetProfitList[i][1]))
  
  overallProductivityMeasurementDollarValueAddedQuantileList[[i]] = quantile(unlist(overallProductivityMeasurementDollarValueAddedList[i][1]),c(.25,.5,.75))
  overallProductivityMeasurementDollarValueAddedMeanList[[i]] = mean(unlist(overallProductivityMeasurementDollarValueAddedList[i][1]))
  
  overallProductivityMeasurementDollarRevenueHoursQuantileList[[i]] = quantile(unlist(overallProductivityMeasurementList[i][1]),c(.25,.5,.75))
  overallProductivityMeasurementDollarRevenueHoursMeanList[[i]] = mean(unlist(overallProductivityMeasurementList[i][1]))
  
  payDisbursedSubContrQuantileList[[i]] = quantile(unlist(payDisbursedSubContrList[i][1]),c(.25,.5,.75))
  payDisbursedSubContrMeanList[[i]] = mean(unlist(payDisbursedSubContrList[i][1]))
  
  costPurchasedMaterialsQuantileList[[i]] = quantile(unlist(costPurchasedMaterialsList[i][1]),c(.25,.5,.75))
  costPurchasedMaterialsMeanList[[i]] = mean(unlist(costPurchasedMaterialsList[i][1]))
  
  netProfitQuantileList[[i]] = quantile(unlist(netProfitPercentageList[i][1]),c(.25,.5,.75))
  netProfitMeanList[[i]] = mean(unlist(netProfitPercentageList[i][1]))
  
  grossProfitQuantileList[[i]] = quantile(unlist(grossProfitPercentageList[i][1]),c(.25,.5,.75))
  grossProfitMeanList[[i]] = mean(unlist(grossProfitPercentageList[i][1]))
  
  overheadQuantileList[[i]] = quantile(unlist(overheadPercentageList[i][1]),c(.25,.5,.75))
  overheadMeanList[[i]] = mean(unlist(overheadPercentageList[i][1]))
  
  hitRateQuantileList[[i]] = quantile(unlist(hitRatePercentageList[i][1]),c(.25,.5,.75))
  hitRateMeanList[[i]] = mean(unlist(hitRatePercentageList[i][1]))
  
  turnoverRateQuantileList[[i]] = quantile(unlist(turnoverRatePercentageList[i][1]),c(.25,.5,.75))
  turnoverRateMeanList[[i]] = mean(unlist(turnoverRatePercentageList[i][1]))
  
  absenteeismQuantileList[[i]] = quantile(unlist(absenteeismPercentageList[i][1]),c(.25,.5,.75))
  absenteeismMeanList[[i]] = mean(unlist(absenteeismPercentageList[i][1]))
  
  OSHAQuantileList[[i]] = quantile(unlist(OSHAList[i][1]),c(.25,.5,.75))
  OSHAMeanList[[i]] = mean(unlist(OSHAList[i][1]))
  
  EMRQuantileList[[i]] = quantile(unlist(EMRList[i][1]),c(.25,.5,.75))
  EMRMeanList[[i]] = mean(unlist(EMRList[i][1]))
  
  repeatCustomerPercentageQuantileList[[i]] = quantile(unlist(repeatCustomerPercentageList[i][1]),c(.25,.5,.75))
  repeatCustomerPercentageMeanList[[i]] = mean(unlist(repeatCustomerPercentageList[i][1]))
  
  
  i = i + 1
}


checkNA <- function(x) {
  if(length(x) == 0) {
    result <- NA
  }
  else
  {
    result <- x
  }
  return(result)
}


# BELOW THIS IS FOR PLOTTING

# Renaming the year as well as company name (Eckardt in the previous example) 
year=ordered(comp$year, levels=c("2011","2012","2013","2014","2015","2016","2017","2018","2019","2020"))
Company=comp$company_name


# function that plots pdf output graph
plotGraphType1<-function(yAxis, titleVal)
{
  p <- ggplot(comp, aes_string(x="factor(year)", y=yAxis))
  p + geom_boxplot(outlier.size=NA) + geom_jitter(width=0.25,aes(color=Company),size=30)+
    scale_y_continuous(labels = scales::comma)+
    theme(legend.key.height=unit(30,"line")) + 
    
    stat_summary(fun.y=mean, geom="point", shape="M", size=50)+
    ggtitle(paste("\n",titleVal,"\n")) +
    theme(plot.title = element_text( color="#FF0000", face="bold", size=400, hjust=0.5, vjust=1)) + 
    theme(text=element_text(size=300))
}

# function that plots pdf output graph
plotGraphType2<-function(yAxis, titleVal)
{
  p <- ggplot(comp, aes_string(x="factor(year)", y=yAxis))
  p + geom_boxplot(outlier.size=NA) + geom_jitter(width=0.25,aes(color=Company),size=30)+
    scale_y_continuous(labels = percent)+
    theme(legend.key.height=unit(30,"line")) + 
    
    stat_summary(fun.y=mean, geom="point", shape="M", size=50)+
    ggtitle(paste("\n",titleVal,"\n")) +
    theme(plot.title = element_text(color="#FF0000", face="bold", size=400, hjust=0.5, vjust=1)) + 
    theme(text=element_text(size=300))
}

# Function that plots pdf output data
plotData<-function(pdfTitle, pdfTitle2, pdfCompName, quantileList, meanList, curCompList)
{
  plot(-21:11, type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
  text(17, 11, adj = c( 0.5, NA ),paste("",pdfTitle,""),cex=20.0, col="red", font=2)
  text(17, 9, adj = c( 0.5, NA ),paste("",pdfTitle2,""),cex=20.0, col="red", font=2)
  
  text(1, 7.5, adj = c( 0, 1 ),"2013", col="red",cex=13.0)
  text(1, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[3]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[3]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[3]]["25%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[3]]), 2), nsmall = 2),""),cex=13.0)
  text(1, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[3])), 2), nsmall = 2),""), cex=13.0, col="red")
  
  text(12, 7.5, adj = c( 0, 1 ),"2014", col="red",cex=13.0)
  text(12, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[4]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[4]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[4]]["25%"]))), 2), nsmall = 2),""),cex=13.0)
  text(12, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[4]]), 2), nsmall = 2),""),cex=13.0)
  text(12, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[4])), 2), nsmall = 2),""), col="red",cex=13.0)
  
  text(23, 7.5, adj = c( 0, 1 ),"2015", col="red",cex=13.0)
  text(23, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[5]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(23, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[5]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(23, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[5]]["25%"]))), 2), nsmall = 2),""),cex=13.0)
  text(23, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[5]]), 2), nsmall = 2),""),cex=13.0)
  text(23, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[5])), 2), nsmall = 2),""), col="red",cex=13.0)
  
  text(1, -3, adj = c( 0, 1 ),"2016", col="red",cex=13.0)
  text(1, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[6]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[6]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[6]]["25%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[6]]), 2), nsmall = 2),""),cex=13.0)
  text(1, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[6])), 2), nsmall = 2),""), col="red",cex=13.0)
  
  text(12, -3, adj = c( 0, 1 ),"2017", col="red",cex=13.0)
  text(12, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[7]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[7]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[7]]["25%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[7]]), 2), nsmall = 2),""),cex=13.0)
  text(12, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[7])), 2), nsmall = 2),""), col="red",cex=13.0)
  
  text(23, -3, adj = c( 0, 1 ),"2018", col="red",cex=13.0)
  text(23, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[8]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(23, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[8]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(23, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[8]]["25%"])), 2), nsmall = 2),""),cex=13.0)
  text(23, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[8]]), 2), nsmall = 2),""),cex=13.0)
  text(23, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[8])), 2), nsmall = 2),""), col="red",cex=13.0)
  
  text(1, -13.5, adj = c( 0, 1 ),"2019", col="red",cex=13.0)
  text(1, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[9]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[9]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[9]]["25%"])), 2), nsmall = 2),""),cex=13.0)
  text(1, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[9]]), 2), nsmall = 2),""),cex=13.0)
  text(1, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[9])), 2), nsmall = 2),""), col="red",cex=13.0)
  
  text(12, -13.5, adj = c( 0, 1 ),"2020", col="red",cex=13.0)
  text(12, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[10]]["75%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[10]]["50%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[10]]["25%"])), 2), nsmall = 2),""),cex=13.0)
  text(12, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[10]]), 2), nsmall = 2),""),cex=13.0)
  text(12, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[10])), 2), nsmall = 2),""), col="red",cex=13.0)
}



# Function that plots pdf output data
plotDataType2<-function(pdfTitle, pdfTitle2, pdfCompName, quantileList, meanList, curCompList)
{
  plot(-21:11, type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
  text(17, 11, adj = c( 0.5, NA ),paste("",pdfTitle,""),cex=20.0, col="red", font=2)
  text(17, 9, adj = c( 0.5, NA ),paste("",pdfTitle2,""),cex=20.0, col="red", font=2)
  
  text(1, 7.5, adj = c( 0, 1 ),"2013", col="red",cex=13.0)
  text(1, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA((unlist(quantileList[[3]]["75%"]))*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[3]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[3]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[3]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[3])*100), 2), nsmall = 2),"%"), cex=13.0, col="red")
  
  text(12, 7.5, adj = c( 0, 1 ),"2014", col="red",cex=13.0)
  text(12, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[4]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[4]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[4]]["25%"]))*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[4]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[4])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
  
  text(23, 7.5, adj = c( 0, 1 ),"2015", col="red",cex=13.0)
  text(23, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[5]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[5]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[5]]["25%"]))*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[5]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[5])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
  
  text(1, -3, adj = c( 0, 1 ),"2016", col="red",cex=13.0)
  text(1, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[6]]["75%"])*100), 2), nsmall = 2),"%"),cex=14.0)
  text(1, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[6]]["50%"])*100), 2), nsmall = 2),"%"),cex=14.0)
  text(1, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[6]]["25%"])*100), 2), nsmall = 2),"%"),cex=14.0)
  text(1, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[6]]*100), 2), nsmall = 2),"%"),cex=14.0)
  text(1, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[6])*100), 2), nsmall = 2),"%"), col="red",cex=14.0)
  
  text(12, -3, adj = c( 0, 1 ),"2017", col="red",cex=13.0)
  text(12, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[7]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[7]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[7]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[7]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[7])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
  
  text(23, -3, adj = c( 0, 1 ),"2018", col="red",cex=13.0)
  text(23, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[8]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[8]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[8]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[8]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(23, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[8])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
  
  text(1, -13.5, adj = c( 0, 1 ),"2019", col="red",cex=13.0)
  text(1, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[9]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[9]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[9]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[9]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(1, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[9])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
  
  text(12, -13.5, adj = c( 0, 1 ),"2020", col="red",cex=13.0)
  text(12, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[10]]["75%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[10]]["50%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[10]]["25%"])*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[10]]*100), 2), nsmall = 2),"%"),cex=13.0)
  text(12, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[10])*100), 2), nsmall = 2),"%"), col="red",cex=13.0)
  
}

# Function that plots pdf output data
plotData_noDec<-function(pdfTitle, pdfTitle2, pdfCompName, quantileList, meanList, curCompList)
{
  plot(-21:11, type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
  text(17, 11, adj = c( 0.5, NA ),paste("",pdfTitle,""),cex=20.0, col="red", font=2)
  text(17, 9, adj = c( 0.5, NA ),paste("",pdfTitle2,""),cex=20.0, col="red", font=2)
  
  text(1, 7.5, adj = c( 0, 1 ),"2013", col="red",cex=13.0)
  text(1, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[3]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[3]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[3]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[3]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[3])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), cex=13.0, col="red")
  
  text(12, 7.5, adj = c( 0, 1 ),"2014", col="red",cex=13.0)
  text(12, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[4]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[4]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[4]]["25%"]))), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[4]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[4])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
  
  text(23, 7.5, adj = c( 0, 1 ),"2015", col="red",cex=13.0)
  text(23, 6, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[5]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, 4.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[5]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, 3, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(unlist(quantileList[[5]]["25%"]))), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, 1.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[5]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, 0, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[5])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
  
  text(1, -3, adj = c( 0, 1 ),"2016", col="red",cex=13.0)
  text(1, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[6]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[6]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[6]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[6]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[6])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
  
  text(12, -3, adj = c( 0, 1 ),"2017", col="red",cex=13.0)
  text(12, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[7]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[7]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[7]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[7]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[7])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
  
  text(23, -3, adj = c( 0, 1 ),"2018", col="red",cex=13.0)
  text(23, -4.5, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[8]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, -6, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[8]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, -7.5, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[8]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, -9, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[8]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(23, -10.5, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[8])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
  
  text(1, -13.5, adj = c( 0, 1 ),"2019", col="red",cex=13.0)
  text(1, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[9]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[9]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[9]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[9]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(1, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[9])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
  
  text(12, -13.5, adj = c( 0, 1 ),"2020", col="red",cex=13.0)
  text(12, -15, adj = c( 0, 1 ),paste("75th percentile : ",format(round(checkNA(unlist(quantileList[[10]]["75%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -16.5, adj = c( 0, 1 ),paste("Median 50th percentile:",format(round(checkNA(unlist(quantileList[[10]]["50%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -18, adj = c( 0, 1 ),paste("25th percentile: ",format(round(checkNA(unlist(quantileList[[10]]["25%"])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -19.5, adj = c( 0, 1 ),paste("Mean (average): ",format(round(checkNA(meanList[[10]]), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""),cex=13.0)
  text(12, -21, adj = c( 0, 1 ),paste(pdfCompName,": ",format(round(checkNA(unlist(curCompList[10])), 0), nsmall = 0, big.mark = ",", big.interval = 3L),""), col="red",cex=13.0)
}


jj1 <- readJPEG("updated_Img/Slide1.JPG",native=TRUE)
jj2 <- readJPEG("updated_Img/Slide2.JPG",native=TRUE)
jj3 <- readJPEG("updated_Img/Slide3.JPG",native=TRUE)
jj4 <- readJPEG("updated_Img/Slide4.JPG",native=TRUE)
jj5 <- readJPEG("updated_Img/Slide5.JPG",native=TRUE)
jj6 <- readJPEG("updated_Img/Slide6.JPG",native=TRUE)
jj7 <- readJPEG("updated_Img/Slide7.JPG",native=TRUE)
jj8 <- readJPEG("updated_Img/Slide8.JPG",native=TRUE)
jj9 <- readJPEG("updated_Img/Slide9.JPG",native=TRUE)
jj10 <- readJPEG("updated_Img/Slide10.JPG",native=TRUE)
jj11 <- readJPEG("updated_Img/Slide11.JPG",native=TRUE)
jj12 <- readJPEG("updated_Img/Slide12.JPG",native=TRUE)
jj13 <- readJPEG("updated_Img/Slide13.JPG",native=TRUE)
jj14 <- readJPEG("updated_Img/Slide14.JPG",native=TRUE)


str = paste (webCompanyName ,".pdf")
#pdf(str, paper="a4r")
pdf(str, width=200, height=150, bg="white")

par(family = 'Helvetica', ps=20)


#Page 1: Landing
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj1,1,1,1000,1000)
text(500, 400, adj = c( 0.5, NA ),paste("",webCompanyName,""),cex=25.0, col="grey20", font=2)

plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj2,1,1,1000,1000)

plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj3,1,1,1000,1000)

plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj4,1,1,1000,1000)

plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj5,1,1,1000,1000)


#Formula 1
#Page : Net Profit Percentage Plot 
returnGraph1<-plotGraphType2("Net.Profit.Percentage", "Net Profit Percentage")
plot(returnGraph1)
#Page : Net Profit Percentage Data
plotDataType2("Net Profit Percentage", "", webCompanyName, 
              netProfitQuantileList, netProfitMeanList, netProfitPercentageCurCompanyList)

#Formula 
#Page : Gross Profit Percentage Plot 
returnGraph1<-plotGraphType2("Gross.Profit.Percentage", "Gross Profit Percentage")
plot(returnGraph1)
#Page : Gross Profit Percentage Data
plotDataType2("Gross Profit Percentage", "", webCompanyName, 
              grossProfitQuantileList, grossProfitMeanList, grossProfitPercentageCurCompanyList)

#Formula 
#Page : Overhead Percentage Plot 
returnGraph1<-plotGraphType2("Overhead.Percentage", "Overhead Percentage")
plot(returnGraph1)
#Page : Overhead Percentage Data
plotDataType2("Overhead Percentage", "", webCompanyName, 
              overheadQuantileList, overheadMeanList, overheadPercentageCurCompanyList)

#Formula 
#Page : Hit Rate Percentage Plot 
returnGraph1<-plotGraphType2("Hit.Rate", "Hit Rate")
plot(returnGraph1)
#Page : Hit Rate Percentage Data
plotDataType2("Hit Rate", "", webCompanyName, 
              hitRateQuantileList, hitRateMeanList, hitRatePercentageCurCompanyList )

#Formula 5
#Page : Cost of purchased materials by the company as a percentage of the revenue Plot
returnGraph2<-plotGraphType2("Percentage.of.Revenue.as.Cost.of.Purchased.Materials", "Cost of Purchased Materials by the Company")
plot(returnGraph2)
#Page : Cost of purchased materials by the company as a percentage of the revenue Data
plotDataType2("Cost of Purchased Materials by the Company", "", webCompanyName, 
              costPurchasedMaterialsQuantileList, costPurchasedMaterialsMeanList, costPurchasedMaterialsCurCompanyList)


#Formula 6
#Page : Payments Disbursed to Subcontractors as a percentage of the revenue Plot
returnGraph3<-plotGraphType2("Percentage.of.Revenue.as.Payments.Disbursed.to.Subcontractors", "Payments Disbursed to Subcontractors")
plot(returnGraph3)
#Page : Cost of purchased materials by the company as a percentage of the revenue Data
plotDataType2("Payments Disbursed to Subcontractor", "", webCompanyName, 
              payDisbursedSubContrQuantileList, payDisbursedSubContrMeanList, payDisbursedSubContrCurCompanyList)

#Transition
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj6,1,1,1000,1000)

plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj7,1,1,1000,1000)

#Formula 23
#Page : Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel Plot
returnGraph8<-plotGraphType1("Revenue.per.FTE.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Revenue/FTEs of Project Management Personnel")
plot(returnGraph8)
#Page : Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel Data
plotData_noDec("Project Management Productivity Measurement: ", "Dollar Revenue/FTEs of Project Management Personnel", webCompanyName, 
               projectManagementDollarRevenuePersonnelFteQuantileList, projectManagementDollarRevenuePersonnelFteMeanList, projectManagementDollarRevenuePersonnelFteCurCompanyList)


#Formula 24
#Page  - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management Plot
returnGraph8<-plotGraphType1("Value.Added.per.FTE.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Value Added/FTEs of Project Management")
plot(returnGraph8)
#Page  - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management Data
plotData_noDec("Project Management Productivity Measurement: ", "Dollar Value Added/FTEs of Project Management", webCompanyName, 
               projectManagementDollarValueAddedPersonnelFteQuantileList, projectManagementDollarValueAddedPersonnelFteMeanList, projectManagementDollarValueAddedPersonnelFteCurCompanyList)


#Formula 25
#Page  - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel Plot
returnGraph9<-plotGraphType1("Net.Profit.per.FTE.of.Field.Project.Management.Personnel", "Project Management Profitability Measurement: \nDollar Net Profit /FTEs of Project Management Personnel")
plot(returnGraph9)
#Page  - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel Data
plotData_noDec("Project Management Profitability Measurement: ","Dollar Net Profit /FTEs of Project Management Personnel", webCompanyName, 
               projectManagementDollarNetProfitPersonnelFteQuantileList, projectManagementDollarNetProfitPersonnelFteMeanList, projectManagementDollarNetProfitPersonnelFteCurCompanyList)


#Formula 26
#Page  - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees Plot
returnGraph9<-plotGraphType1("Revenue.per.FTE.of.Bargaining.Unit.Employees", "Craft Worker Productivity Measurement: \nDollar Revenue/ FTEs of Bargaining Unit Employees")
plot(returnGraph9)
#Page  - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees Data
plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Revenue/ FTEs of Bargaining Unit Employees", webCompanyName, 
               craftWorkerDollarRevenueFteQuantileList, craftWorkerDollarRevenueFteMeanList, craftWorkerDollarRevenueFteCurCompanyList)


#Formula 27
#Page  - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit Plot
returnGraph9<-plotGraphType1("Value.Added.per.FTE.of.Bargaining.Unit.Employees", "Craft Worker Productivity Measurement: \nDollar Value Added/ FTEs of Bargaining Unit")
plot(returnGraph9)
#Page  - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit Data
plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Value Added/ FTEs of Bargaining Unit Employees", webCompanyName, 
               craftWorkerDollarValueAddedFteQuantileList, craftWorkerDollarValueAddedFteMeanList, craftWorkerDollarValueAddedFteCurCompanyList)


#Formula 28
#Page  - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees Plot
returnGraph9<-plotGraphType1("Net.Profit.per.FTE.of.Bargaining.Unit.Employees", "Craft Worker Profitability Measurement: \nDollar Net Profit / FTEs of Bargaining Unit Employees")
plot(returnGraph9)
#Page  - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees Data
plotData_noDec("Craft Worker Profitability Measurement: ","Dollar Net Profit / FTEs of Bargaining Unit Employees", webCompanyName, 
               craftWorkerDollarNetProfitFteQuantileList, craftWorkerDollarNetProfitFteMeanList, craftWorkerDollarNetProfitFteCurCompanyList)

#Transition
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj8,1,1,1000,1000)

#Formula 14
#Page : Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees Plot
returnGraph7<-plotGraphType1("Revenue.per.Expended.Man.Hours.of.Bargaining.Unit.Employees","Craft Worker Productivity Measurement: \nDollar Revenue/ Hours of Bargaining Unit Employees")
plot(returnGraph7)
#Page : Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees Data
plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Revenue/ Hours of Bargaining Unit Employees", webCompanyName, 
               craftWorkerDollarRevenueQuantileList, craftWorkerDollarRevenueMeanList, craftWorkerDollarRevenueCurCompanyList)


#Formula 15
#Page : Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit Plot
returnGraph7<-plotGraphType1("Value.Added.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Craft Worker Productivity Measurement: \nDollar Value Added/ Hours of Bargaining Unit")
plot(returnGraph7)
#Page : Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit Data
plotData_noDec("Craft Worker Productivity Measurement: ","Dollar Value Added/ Hours of Bargaining Unit", webCompanyName, 
               craftWorkerDollarValueAddedQuantileList, craftWorkerDollarValueAddedMeanList, craftWorkerDollarValueAddedCurCompanyList)


#Formula 16
#Page : Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees Plot
returnGraph7<-plotGraphType1("Net.Profit.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Craft Worker Profitability Measurement: \nDollar Net Profit / Hours of Bargaining Unit Employees")
plot(returnGraph7)
#Page : Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees Data
plotData("Craft Worker Profitability Measurement: ","Dollar Net Profit / Hours of Bargaining Unit Employees", webCompanyName,
         craftWorkerDollarNetProfitQuantileList, craftWorkerDollarNetProfitMeanList, craftWorkerDollarNetProfitCurCompanyList)

#Transition
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj9,1,1,1000,1000)

plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj10,1,1,1000,1000)

#Formula 35
#Page  - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel Plot
returnGraph9<-plotGraphType1("Revenue.per.Cost.of.Field.Project.Management.Personnel", "Project Management Cost Effectiveness: \nDollar Revenue/ Cost of Project Management Personnel")
plot(returnGraph9)
#Page  - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel Data
plotData("Project Management Cost Effectiveness: ", "Dollar Revenue/ Cost of Project Management Personnel", webCompanyName, 
         projectManagementCostDollarRevenueQuantileList, projectManagementCostDollarRevenueMeanList, projectManagementCostDollarRevenueCurCompanyList)


#Formula 36
#Page  - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel Plot
returnGraph9<-plotGraphType1("Value.Added.per.Cost.of.Field.Project.Management.Personnel", "Project Management Cost Effectiveness: \nDollar Value Added/ Cost of Project Management Personnel")
plot(returnGraph9)
#Page  - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel Data
plotData("Project Management Cost Effectiveness: ", "Dollar Value Added/ Cost of Project Management Personnel", webCompanyName, 
         projectManagementCostDollarValueAddedQuantileList, projectManagementCostDollarValueAddedMeanList, projectManagementCostDollarValueAddedCurCompanyList)


#Formula 37
#Page  - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel Plot
returnGraph9<-plotGraphType1("Net.Profit.per.Cost.of.Field.Project.Management.Personnel", "Project Management Cost Effectiveness: \nDollar Net Profit / Cost of Project Management Personnel")
plot(returnGraph9)
#Page  - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel Data
plotData("Project Management Cost Effectiveness: ", "Dollar Net Profit / Cost of Project Management Personnel", webCompanyName, 
         projectManagementCostDollarNetProfitQuantileList, projectManagementCostDollarNetProfitMeanList, projectManagementCostDollarNetProfitCurCompanyList)


#Formula 38
#Page  - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees Plot
returnGraph9<-plotGraphType1("Revenue.per.Cost.of.Bargaining.Unit.Employees", "Craft Worker Cost Effectiveness: \nDollar Revenue/ Cost of Bargaining Unit Employees")
plot(returnGraph9)
#Page  - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees Data
plotData("Craft Worker Cost Effectiveness: ", "Dollar Revenue/ Cost of Bargaining Unit Employees", webCompanyName, 
         craftWorkerCostEffectDollarRevenueQuantileList, craftWorkerCostEffectDollarRevenueMeanList, craftWorkerCostEffectDollarRevenueCurCompanyList)


#Formula 39
#Page  - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees Plot
returnGraph9<-plotGraphType1("Value.Added.per.Cost.of.Bargaining.Unit.Employees", "Craft Worker Cost Effectiveness: \nDollar Value Added/ Cost of Bargaining Unit Employees")
plot(returnGraph9)
#Page  - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees Data
plotData("Craft Worker Cost Effectiveness: ", "Dollar Value Added/ Cost of Bargaining Unit Employees", webCompanyName, 
         craftWorkerCostEffectDollarValueAddedQuantileList, craftWorkerCostEffectDollarValueAddedMeanList, craftWorkerCostEffectDollarValueAddedCurCompanyList)


#Formula 40
#Page  - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees Plot
returnGraph9<-plotGraphType1("Net.Profit.per.Cost.of.Bargaining.Unit.Employees", "Craft Worker Cost Effectiveness: \nDollar Net Profit / Cost of Bargaining Unit Employees")
plot(returnGraph9)
#Page  - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees Data
plotData("Craft Worker Cost Effectiveness: ", "Dollar Net Profit / Cost of Bargaining Unit Employees", webCompanyName, 
         craftWorkerCostEffectDollarNetProfitQuantileList, craftWorkerCostEffectDollarNetProfitMeanList, craftWorkerCostEffectDollarNetProfitCurCompanyList)

#Transition
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj11,1,1,1000,1000)

#Formula 
#Page : Turnover Rate Percentage Plot 
returnGraph1<-plotGraphType2("Turnover.Rate.of.Bargaining.Unit.Employees", "Turnover Rate of Bargaining Unit Employees")
plot(returnGraph1)
#Page : Turnover Rate Percentage Data
plotDataType2("Turnover Rate of Bargaining Unit Employees", "", webCompanyName, 
              turnoverRateQuantileList, turnoverRateMeanList, turnoverRatePercentageCurCompanyList)

#Formula 47
#Page  - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees Plot
returnGraph9<-plotGraphType1("Cost.of.Field.Project.Management.Personnel.per.Cost.of.Bargaining.Unit.Employees", "Cost of Field Project Management Personnel \nper Cost of Bargaining Unit Employees")
plot(returnGraph9)
#Page  - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees Data
plotData("Cost of Field Project Management Personnel", "per Cost of Bargaining Unit Employees", webCompanyName, 
         costFieldProjManagementPersonnelQuantileList, costFieldProjManagementPersonnelMeanList, costFieldProjManagementPersonnelCurCompanyList)

#Transition
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj12,1,1,1000,1000)

#Formula 
#Page : OSHA Recordable Incident Rate Plot 
returnGraph1<-plotGraphType1("OSHA.Recordable.Incident.Rate", "OSHA Recordable Incident Rate")
plot(returnGraph1)
#Page : OSHA Recordable Incident Rate Data
plotData("OSHA Recordable Incident Rate", "", webCompanyName, 
         OSHAQuantileList, OSHAMeanList, OSHACurCompanyList)

#Transition
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj13,1,1,1000,1000)

#Formula 
#Page : Repeat Business Customers Percentage Plot 
returnGraph1<-plotGraphType2("Repeat.Business.Customers.Percentage", "Repeat Business Customers Percentage")
plot(returnGraph1)
#Page : Repeat Business Customers Percentage Data
plotDataType2("Repeat Business Customers Percentage", "", webCompanyName, 
              repeatCustomerPercentageQuantileList, repeatCustomerPercentageMeanList, repeatCustomerPercentageCurCompanyList)


#end
plot(c(1, 1000), c(1, 1000), type = "n", xaxt="n", yaxt="n", bty="n", xlab = "", ylab = "")
rasterImage(jj14,1,1,1000,1000)

dev.off()

options(warn = oldw)

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
#returnGraph7<-plotGraphType1("Revenue.per.Hour.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Revenue/Hours of Project Management Personnel")
#plot(returnGraph7)
#Page : Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel Data
#plotData("Project Management Productivity Measurement: ", "Dollar Revenue/Hours of Project Management Personnel", webCompanyName,
#projectManagementProductivityDollarRevenueQuantileList, projectManagementProductivityDollarRevenueMeanList, projectManagementDollarRevenueCurCompanyList)


#Formula 12
#Page : Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel  Plot
#returnGraph7<-plotGraphType1("Value.Added.per.Hour.of.Field.Project.Management.Personnel", "Project Management Productivity Measurement: \nDollar Value Added/Hours of Project Management Personnel")
#plot(returnGraph7)
#Page : Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel  Data
#plotData("Project Management Productivity Measurement: ", "Dollar Value Added/Hours of Project Management Personnel", webCompanyName,
#projectManagementProductivityDollarValueAddedQuantileList, projectManagementProductivityDollarValueAddedMeanList, projectManagementDollarValueAddedCurCompanyList)         


#Formula 13
#Page : Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel Plot
#returnGraph7<-plotGraphType1("Value.Added.per.Hour.of.Field.Project.Management.Personnel", "Project Management Profitability Measurement: \nDollar Net Profit /Hours of Project Management Personnel")
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
#returnGraph9<-plotGraphType1("Revenue.per.FTE.of.Supporting.Employees", "Supporting Employees Productivity Measurement: \nDollar Revenue/ FTEs of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees Data
#plotData("Supporting Employees Productivity Measurement: ","Dollar Revenue/ FTEs of Supporting Employees", webCompanyName, 
# supportingEmployeeDollarRevenueFteQuantileList, supportingEmployeeDollarRevenueFteMeanList, supportingEmployeeDollarRevenueFteCurCompanyList)

#Formula 30
#Page  - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees Plot
#returnGraph9<-plotGraphType1("Value.Added.per.FTE.of.Supporting.Employees", "Supporting Employees Productivity Measurement: \nDollar Value Added/ FTEs of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees Data
#plotData("Supporting Employees Productivity Measurement: ","Dollar Value Added/ FTEs of Supporting Employees", webCompanyName, 
#    supportingEmployeeDollarValueAddedFteQuantileList, supportingEmployeeDollarValueAddedFteMeanList, supportingEmployeeDollarValueAddedFteCurCompanyList)


#Formula 31
#Page  - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees Plot
#returnGraph9<-plotGraphType1("Net.Profit.per.FTE.of.Supporting.Employees", "Supporting Employees Profitability Measurement: \nDollar Net Profit / FTEs of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees Data
#plotData("Supporting Employees Profitability Measurement: ","Dollar Net Profit / FTEs of Supporting Employees", webCompanyName, 
#   supportingEmployeeDollarNetProfitFteQuantileList, supportingEmployeeDollarNetProfitFteMeanList, supportingEmployeeDollarNetProfitFteCurCompanyList)


#Formula 32
#Page  - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People Plot
#returnGraph9<-plotGraphType1("Revenue.per.Total.Cost.of.People", "Overall Cost Effectiveness: \nDollar Revenue/Cost of Company People")
#plot(returnGraph9)
#Page  - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People Data
#plotData("Overall Cost Effectiveness: ","Dollar Revenue/Cost of Company People", webCompanyName, 
#       overallCostEffectivenessDollarRevenueQuantileList, overallCostEffectivenessDollarRevenueMeanList, overallCostEffectivenessDollarRevenueCurCompanyList)


#Formula 33
#Page  - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People Plot
#returnGraph9<-plotGraphType1("Value.Added.per.Total.Cost.of.People", "Overall Cost Effectiveness: \nDollar Value Added/ Cost of Company People")
#plot(returnGraph9)
#Page  - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People Data
#plotData("Overall Cost Effectiveness: ","Dollar Value Added/ Cost of Company People", webCompanyName, 
#         overallCostEffectivenessDollarValueAddedQuantileList, overallCostEffectivenessDollarValueAddedMeanList, overallCostEffectivenessDollarValueAddedCurCompanyList)


#Formula 34
#Page  - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People Plot
#returnGraph9<-plotGraphType1("Net.Profit.per.Total.Cost.of.People", "Overall Cost Effectiveness:  \nDollar Net Profit / Cost of Company People")
#plot(returnGraph9)
#Page  - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People Data
#plotData("Overall Cost Effectiveness: ", "Dollar Net Profit / Cost of Company People", webCompanyName, 
#overallCostEffectivenessDollarNetProfitQuantileList, overallCostEffectivenessDollarNetProfitMeanList, overallCostEffectivenessDollarNetProfitCurCompanyList)


#Formula 41
#Page  - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees Plot
#returnGraph9<-plotGraphType1("Revenue.per.Cost.of.Supporting.Employees", "Supporting Employees Cost Effectiveness: \nDollar Revenue/ Cost of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees Data
#plotData("Supporting Employees Cost Effectiveness: ", "Dollar Revenue/ Cost of Supporting Employees", webCompanyName, 
#supportingEmployeeCostEffectDollarRevenueQuantileList, supportingEmployeeCostEffectDollarRevenueMeanList, supportingEmployeeCostEffectDollarRevenueCurCompanyList)


#Formula 42
#Page  - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees Plot
#returnGraph9<-plotGraphType1("Value.Added.per.Cost.of.Supporting.Employees", "Supporting Employees Cost Effectiveness: \nDollar Value Added/ Cost of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees Graph
#plotData("Supporting Employees Cost Effectiveness: ", "Dollar Value Added/ Cost of Supporting Employees", webCompanyName, 
#  supportingEmployeeCostEffectDollarValueAddedQuantileList, supportingEmployeeCostEffectDollarValueAddedMeanList, supportingEmployeeCostEffectDollarValueAddedCurCompanyList)


#Formula 43
#Page  - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees Plot
#returnGraph9<-plotGraphType1("Net.Profit.per.Cost.of.Supporting.Employees", "Supporting Employees Cost Effectiveness: \nDollar Net Profit / Cost of Supporting Employees")
#plot(returnGraph9)
#Page  - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees Data
#plotData("Supporting Employees Cost Effectiveness: ", "Dollar Net Profit / Cost of Supporting Employees", webCompanyName, 
#supportingEmployeeCostEffectDollarNetProfitQuantileList, supportingEmployeeCostEffectDollarNetProfitMeanList, supportingEmployeeCostEffectDollarNetProfitCurCompanyList)

#Formula 44
#Page  - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel Plot
#returnGraph9<-plotGraphType1("Cost.of.Field.Project.Management.Personnel.per.Hours.of.Field.Project.Management.Personnel", "Cost of Field Project Management Personnel \nper Hours of Field Project Management Personnel")
#plot(returnGraph9)
#Page  - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel Data
#plotData("Cost of Field Project Management Personnel", "per Hours of Field Project Management Personnel", webCompanyName, 
#  costFieldProjManagementQuantileList, costFieldProjManagementMeanList, costFieldProjManagementCurCompanyList)

#Formula 46
#Page  - Cost of Supporting Employees per Hours of Supporting Employees Plot
#returnGraph9<-plotGraphType1("Cost.of.Supporting.Employees.per.Hours.of.Supporting.Employees", "Cost of Supporting Employees \nper Hours of Supporting Employees")
#plot(returnGraph9)
#Page  - Cost of Supporting Employees per Hours of Supporting Employees Data
#plotData("Cost of Supporting Employees", "per Hours of Supporting Employees", webCompanyName, 
# costSupportingEmployeesQuantileList, costSupportingEmployeesMeanList, costSupportingEmployeesCurCompanyList)

#Formula 48
#Page  - Cost of Supporting Employees per Cost of Bargaining Unit Employees Plot
#returnGraph9<-plotGraphType1("Cost.of.Supporting.Employees.per.Cost.of.Bargaining.Unit.Employees", "Cost of Supporting Employees \nper Cost of Bargaining Unit Employees")
#plot(returnGraph9)
#Page  - Cost of Supporting Employees per Cost of Bargaining Unit Employees Data
#plotData("Cost of Supporting Employees", "per Cost of Bargaining Unit Employees", webCompanyName, 
# costSupportingEmployeeCostBargainingQuantileList, costSupportingEmployeeCostBargainingMeanList, costSupportingEmployeeCostBargainingCurCompanyList)


#Formula 49
#Page  - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees Plot
#returnGraph9<-plotGraphType1("Hours.of.Field.Project.Management.Personnel.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Hours of Field Project Management Personnel \nper Hours of Bargaining Unit Employees")
#plot(returnGraph9)
#Page  - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees Data
#plotData("Hours of Field Project Management Personnel", "per Hours of Bargaining Unit Employees", webCompanyName, 
# hoursFieldProjectManagementQuantileList, hoursFieldProjectManagementMeanList, hoursFieldProjectManagementCurCompanyList)


#Formula 50
#Page  - Hours of Supporting Employees per Hours of Bargaining Unit Employees Plot
#returnGraph9<-plotGraphType1("Hours.of.Supporting.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Hours of Supporting Employees \nper Hours of Bargaining Unit Employees")
#plot(returnGraph9)
#Page  - Hours of Supporting Employees per Hours of Bargaining Unit Employees Data
#plotData("Hours of Supporting Employees", "per Hours of Bargaining Unit Employees", webCompanyName, 
#hoursSupportingEmployeeQuantileList, hoursSupportingEmployeeMeanList, hoursSupportingEmployeeCurCompanyList)

#Formula 45
#Page  - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees Plot
# returnGraph9<-plotGraphType1("Cost.of.Bargaining.Unit.Employees.per.Expended.Man.Hours.of.Bargaining.Unit.Employees", "Cost of Bargaining Unit Employees \nper Expended Man Hours of Bargaining Unit Employees")
# plot(returnGraph9)
# #Page  - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees Data
# plotData("Cost of Bargaining Unit Employees", "per Expended Man Hours of Bargaining Unit Employees", webCompanyName, 
#          costBargainingUnitEmployeeQuantileList, costBargainingUnitEmployeeMeanList, costBargainingUnitEmployeeCurCompanyList)