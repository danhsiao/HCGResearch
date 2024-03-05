import pandas as pd
import mysql.connector

# Define the list of years
years = list(range(2011, 2021))

# Suppress warning messages
import warnings
warnings.filterwarnings("ignore")

# Set the web company ID (e.g., 71 for P&E)
web_company_id = 71

# Downloading libraries for analysis
import matplotlib.pyplot as plt
import seaborn as sns

# Accessing images
from PIL import Image

# Connect to the MySQL database
db_connection = mysql.connector.connect(
    host="localhost",
    user="sec_user",
    password="eKcGZr59zAa2BEWUXP",
    database="secure_login"
)

# Create a cursor for database operations
cursor = db_connection.cursor()

# Fetch the company data
cursor.execute("SELECT * FROM secure_login.adminresults")
result = cursor.fetchall()
columns = [desc[0] for desc in cursor.description]
comp = pd.DataFrame(result, columns=columns)

# Get the current company name
cursor.execute(f"SELECT company_name FROM secure_login.Company where id = {web_company_id}")
web_company_name_store = cursor.fetchone()
web_company_name = web_company_name_store[0]

# Close the database connection
cursor.close()
db_connection.close()

# 1 Net Profit Percentage Query
net_profit_percentage_list = []
net_profit_percentage_cur_company_list = []

# 2 Gross Profit Percentage Query
gross_profit_percentage_list = []
gross_profit_percentage_cur_company_list = []

# 3 Overhead Percentage Query
overhead_percentage_list = []
overhead_percentage_cur_company_list = []

# 4 Hit Rate Percentage Query
hit_rate_percentage_list = []
hit_rate_percentage_cur_company_list = []

# Turnover Rate Percentage Query
turnover_rate_percentage_list = []
turnover_rate_percentage_cur_company_list = []

# Absenteeism Percentage Query
absenteeism_percentage_list = []
absenteeism_percentage_cur_company_list = []

# OSHA Query
osha_list = []
osha_cur_company_list = []

# EMR Query
emr_list = []
emr_cur_company_list = []

# Repeat Business Customers Query
repeat_customer_percentage_list = []
repeat_customer_percentage_cur_company_list = []

# 5 Cost of purchased materials by the company as a percentage of the revenue Query
cost_purchased_materials_list = []
cost_purchased_materials_cur_company_list = []

# 6 Payments Disbursed to Subcontractors as a percentage of the Revenue Query
pay_disbursed_subcontr_list = []
pay_disbursed_subcontr_cur_company_list = []

# 8 Overall Productivity Measurement – Dollar Revenue/Hours of Company’s People Query
overall_productivity_measurement_list = []
overall_productivity_measurement_cur_company_list = []

# 9 Overall Productivity Measurement – Dollar Value Added/Hours of Company’s People
overall_productivity_measurement_dollar_value_added_list = []
overall_productivity_measurement_dollar_value_added_cur_company_list = []

# 10 Overall Profitability Measurement – Dollar Net Profit /Hours of Company’s People
overall_profitability_measurement_dollar_net_profit_list = []
overall_profitability_measurement_dollar_net_profit_cur_company_list = []

# 11 Project Management Productivity Measurement: Dollar Revenue/Hours of Project Management Personnel 
project_management_dollar_revenue_list = []
project_management_dollar_revenue_cur_company_list = []

# 12 Project Management Productivity Measurement: Dollar Value Added/Hours of Project Management Personnel 
project_management_dollar_value_added_list = []
project_management_dollar_value_added_cur_company_list = []

# 13 Project Management Profitability Measurement: Dollar Net Profit /Hours of Project Management Personnel
project_management_dollar_net_profit_list = []
project_management_dollar_net_profit_cur_company_list = []

# 14 Craft Worker Productivity Measurement: Dollar Revenue/ Hours of Bargaining Unit Employees
craft_worker_dollar_revenue_list = []
craft_worker_dollar_revenue_cur_company_list = []

# 15 Craft Worker Productivity Measurement: Dollar Value Added/ Hours of Bargaining Unit
craft_worker_dollar_value_added_list = []
craft_worker_dollar_value_added_cur_company_list = []

# 16 Craft Worker Profitability Measurement: Dollar Net Profit / Hours of Bargaining Unit Employees 
craft_wroker_dollar_net_profit_list = []
craft_wroker_dollar_net_profit_cur_company_list = []

# 17 Supporting Employees Productivity Measurement: Dollar Revenue/ Hours of Supporting Employees 
supporting_employee_dollar_revenue_list = []
supporting_employee_dollar_revenue_cur_company_list = []

# 18 Supporting Employees Productivity Measurement: Dollar Value Added/ Hours of Supporting Employees
supporting_employee_dollar_value_added_list = []
supporting_employee_dollar_value_added_cur_company_list = []

# 19 Supporting Employees Profitability Measurement: Dollar Net Profit / Hours of Supporting Employees
supporting_employee_dollar_net_profit_list = []
supporting_employee_dollar_net_profit_cur_company_list = []

# 20 Overall Productivity Measurement – Dollar Revenue/FTEs of Company’s People 
overall_productivity_dollar_revenue_fte_list = []
overall_productivity_dollar_revenue_fte_cur_company_list = []

# 21 Overall Productivity Measurement – Dollar Value Added/FTEs of Company’s People
overall_productivity_dollar_value_added_fte_list = []
overall_productivity_dollar_value_added_fte_cur_company_list = []

# 22 Overall Profitability Measurement – Dollar Net Profit /FTEs of Company’s People
overall_profitability_dollar_net_profit_fte_list = []
overall_profitability_dollar_net_profit_fte_cur_company_list = []

# 23 Project Management Productivity Measurement: Dollar Revenue/FTEs of Project Management Personnel
project_management_dollar_revenue_personnel_fte_list = []
project_management_dollar_revenue_personnel_fte_cur_company_list = []

# 24 Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management
project_management_dollar_value_added_personnel_fte_list = []
project_management_dollar_value_added_personnel_fte_cur_company_list = []

# 25 Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel
project_management_dollar_net_profit_personnel_fte_list = []
project_management_dollar_net_profit_personnel_fte_cur_company_list = []

# 26 Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees
craft_worker_dollar_revenue_fte_list = []
craft_worker_dollar_revenue_fte_cur_company_list = []

# 27 Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit
craft_worker_dollar_value_added_fte_list = []
craft_worker_dollar_value_added_fte_cur_company_list = []

# 28 Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees
craft_worker_dollar_net_profit_fte_list = []
craft_worker_dollar_net_profit_fte_cur_company_list = []

# 29 Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees
supporting_employee_dollar_revenue_fte_list = []
supporting_employee_dollar_revenue_fte_cur_company_list = []

# 30 Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees
supporting_employee_dollar_value_added_fte_list = []
supporting_employee_dollar_value_added_fte_cur_company_list = []

# 31 Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees
supporting_employee_dollar_net_profit_fte_list = []
supporting_employee_dollar_net_profit_fte_cur_company_list = []

# 32 Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People
overall_cost_effectiveness_dollar_revenue_list = []
overall_cost_effectiveness_dollar_revenue_cur_company_list = []

# 33 Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People
overall_cost_effectiveness_dollar_value_added_list = []
overall_cost_effectiveness_dollar_value_added_cur_company_list = []

# 34 Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People
overall_cost_effectiveness_dollar_net_profit_list = []
overall_cost_effectiveness_dollar_net_profit_cur_company_list = []

# 35 Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel
project_management_cost_dollar_revenue_list = []
project_management_cost_dollar_revenue_cur_company_list = []

# 36 Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel
project_management_cost_dollar_value_added_list = []
project_management_cost_dollar_value_added_cur_company_list = []

# 37 Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel
project_management_cost_dollar_net_profit_list = []
project_management_cost_dollar_net_profit_cur_company_list = []

# 38 Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees
craft_worker_cost_effect_dollar_revenue_list = []
craft_worker_cost_effect_dollar_revenue_cur_company_list = []

# 39 Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees
craft_worker_cost_effect_dollar_value_added_list = []
craft_worker_cost_effect_dollar_value_added_cur_company_list = []

# 40 Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees
craft_worker_cost_effect_dollar_net_profit_list = []
craft_worker_cost_effect_dollar_net_profit_cur_company_list = []

# 41 Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees
supporting_employee_cost_effect_dollar_revenue_list = []
supporting_employee_cost_effect_dollar_revenue_cur_company_list = []

# 42 Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees
supporting_employee_cost_effect_dollar_value_added_list = []
supporting_employee_cost_effect_dollar_value_added_cur_company_list = []

# 43 Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees
supporting_employee_cost_effect_dollar_net_profit_list = []
supporting_employee_cost_effect_dollar_net_profit_cur_company_list = []

# 44 Cost of Field Project Management Personnel per Hours of Field Project Management Personnel
cost_field_project_management_list = []
cost_field_project_management_cur_company_list = []

# 45 Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees
cost_bargaining_unit_employee_list = []
cost_bargaining_unit_employee_cur_company_list = []

# 46 Cost of Supporting Employees per Hours of Supporting Employees
cost_supporting_employees_list = []
cost_supporting_employees_cur_company_list = []

# 47 Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees
cost_field_project_management_personnel_list = []
cost_field_project_management_personnel_cur_company_list = []

# 48 Cost of Supporting Employees per Cost of Bargaining Unit Employees
cost_supporting_employee_cost_bargaining_list = []
cost_supporting_employee_cost_bargaining_cur_company_list = []

# 49 Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees
hours_field_project_management_list = []
hours_field_project_management_cur_company_list = []

# 50 Hours of Supporting Employees per Hours of Bargaining Unit Employees
hours_supporting_employee_list = []
hours_supporting_employee_cur_company_list = []

# Loop through each year
for yr in years:
    # Query for net profit percentage for all companies for the current year
    query_net_profit_all_companies = f"SELECT net_profit_percentage FROM secure_login.adminresults WHERE year = {yr} AND net_profit_percentage IS NOT NULL"
    cursor.execute(query_net_profit_all_companies)
    net_profit_percentage_all = cursor.fetchall()
    net_profit_percentage_list.append(net_profit_percentage_all)

    # Query for net profit percentage for the specified company (web_company_id) for the current year
    query_net_profit_cur_company = f"SELECT net_profit_percentage FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND net_profit_percentage IS NOT NULL"
    cursor.execute(query_net_profit_cur_company)
    net_profit_percentage_cur_company = cursor.fetchall()
    net_profit_percentage_cur_company_list.append(net_profit_percentage_cur_company)

    # Query for gross profit percentage for all companies for the current year
    query_gross_profit_all_companies = f"SELECT gross_profit_percentage FROM secure_login.adminresults WHERE year = {yr} AND gross_profit_percentage IS NOT NULL"
    cursor.execute(query_gross_profit_all_companies)
    gross_profit_percentage_all = cursor.fetchall()
    gross_profit_percentage_list.append(gross_profit_percentage_all)

    # Query for gross profit percentage for the specified company (web_company_id) for the current year
    query_gross_profit_cur_company = f"SELECT gross_profit_percentage FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND gross_profit_percentage IS NOT NULL"
    cursor.execute(query_gross_profit_cur_company)
    gross_profit_percentage_cur_company = cursor.fetchall()
    gross_profit_percentage_cur_company_list.append(gross_profit_percentage_cur_company)

    # Query for overhead percentage for all companies for the current year
    query_overhead_all_companies = f"SELECT overhead_percentage FROM secure_login.adminresults WHERE year = {yr} AND overhead_percentage IS NOT NULL"
    cursor.execute(query_overhead_all_companies)
    overhead_percentage_all = cursor.fetchall()
    overhead_percentage_list.append(overhead_percentage_all)

    # Query for overhead percentage for the specified company (web_company_id) for the current year
    query_overhead_cur_company = f"SELECT overhead_percentage FROM secure_login.adminresults WHERE year= {yr} AND company_id= {web_company_id} AND overhead_percentage IS NOT NULL"
    cursor.execute(query_overhead_cur_company)
    overhead_percentage_cur_company = cursor.fetchall()
    overhead_percentage_cur_company_list.append(overhead_percentage_cur_company)

    # Query for hit rate percentage for all companies for the current year
    query_hit_rate_all_companies = f"SELECT hit_rate FROM secure_login.Year WHERE year= {yr} AND hit_rate IS NOT NULL"
    cursor.execute(query_hit_rate_all_companies)
    hit_rate_percentage_all = cursor.fetchall()
    hit_rate_percentage_list.append(hit_rate_percentage_all)

    # Query for hit rate percentage for the specified company (web_company_id) for the current year
    query_hit_rate_cur_company = f"SELECT hit_rate FROM secure_login.Year WHERE year= {yr} AND company_id= {web_company_id} AND hit_rate is not null"
    cursor.execute(query_hit_rate_cur_company)
    hit_rate_percentage_cur_company = cursor.fetchall()
    hit_rate_percentage_cur_company_list.append(hit_rate_percentage_cur_company)

    # Query for turnover rate percentage for all companies for the current year
    query_turnover_rate_all_companies = f"SELECT turnover_rate_bargaining_perc FROM secure_login.Year WHERE year = {yr} AND turnover_rate_bargaining_perc IS NOT NULL"
    cursor.execute(query_turnover_rate_all_companies)
    turnover_rate_percentage_all = cursor.fetchall()
    turnover_rate_percentage_list.append(turnover_rate_percentage_all)

    # Query for turnover rate percentage for the specified company (webCompanyId) for the current year
    query_turnover_rate_cur_company = f"SELECT turnover_rate_bargaining_perc FROM secure_login.Year WHERE year = {yr} AND company_id = {web_company_id} AND turnover_rate_bargaining_perc IS NOT NULL"
    cursor.execute(query_turnover_rate_cur_company)
    turnover_rate_percentage_cur_company = cursor.fetchall()
    turnover_rate_percentage_cur_company_list.append(turnover_rate_percentage_cur_company)

    # Query for absenteeism percentage for all companies for the current year
    query_absenteeism_all_companies = f"SELECT absenteeism_perc FROM secure_login.Year WHERE year = {yr} AND absenteeism_perc IS NOT NULL"
    cursor.execute(query_absenteeism_all_companies)
    absenteeism_percentage_all = cursor.fetchall()
    absenteeism_percentage_list.append(absenteeism_percentage_all)

    # Query for absenteeism percentage for the specified company (webCompanyId) for the current year
    query_absenteeism_cur_company = f"SELECT absenteeism_perc FROM secure_login.Year WHERE year = {yr} AND company_id = {web_company_id} AND absenteeism_perc IS NOT NULL"
    cursor.execute(query_absenteeism_cur_company)
    absenteeism_percentage_cur_company = cursor.fetchall()
    absenteeism_percentage_cur_company_list.append(absenteeism_percentage_cur_company)

    # Query for OSHA incident rate for all companies for the current year
    query_osha_all_companies = f"SELECT osha_incident_rate FROM secure_login.Year WHERE year = {yr} AND osha_incident_rate IS NOT NULL"
    cursor.execute(query_osha_all_companies)
    osha_all = cursor.fetchall()
    osha_list.append(osha_all)

    # Query for OSHA incident rate for the specified company (web_company_id) for the current year
    query_osha_cur_company = f"SELECT osha_incident_rate FROM secure_login.Year WHERE year = {yr} AND company_id = {web_company_id} AND osha_incident_rate IS NOT NULL"
    cursor.execute(query_osha_cur_company)
    osha_cur_company = cursor.fetchall()
    osha_cur_company_list.append(osha_cur_company)

    # Query for EMR (Experience Modification Rate) for all companies for the current year
    query_emr_all_companies = f"SELECT emr FROM secure_login.Year WHERE year = {yr} AND emr IS NOT NULL"
    cursor.execute(query_emr_all_companies)
    emr_all = cursor.fetchall()
    emr_list.append(emr_all)

    # Query for EMR (Experience Modification Rate) for the specified company (web_company_id) for the current year
    query_emr_cur_company = f"SELECT emr FROM secure_login.Year WHERE year = {yr} AND company_id = {web_company_id} AND emr IS NOT NULL"
    cursor.execute(query_emr_cur_company)
    emr_cur_company = cursor.fetchall()
    emr_cur_company_list.append(emr_cur_company)

    # Query for repeat customer percentage for all companies for the current year
    query_repeat_customer_all_companies = f"SELECT repeat_customer_perc FROM secure_login.Year WHERE year = {yr} AND repeat_customer_perc IS NOT NULL"
    cursor.execute(query_repeat_customer_all_companies)
    repeat_customer_all = cursor.fetchall()
    repeat_customer_percentage_list.append(repeat_customer_all)

    # Query for repeat customer percentage for the specified company (web_company_id) for the current year
    query_repeat_customer_cur_company = f"SELECT repeat_customer_perc FROM secure_login.Year WHERE year = {yr} AND company_id = {web_company_id} AND repeat_customer_perc IS NOT NULL"
    cursor.execute(query_repeat_customer_cur_company)
    repeat_customer_cur_company = cursor.fetchall()
    repeat_customer_percentage_cur_company_list.append(repeat_customer_cur_company)

    # Query for cost of purchased materials for all companies for the current year
    query_cost_purchased_materials_all_companies = f"SELECT cost_purchased_materials FROM secure_login.adminresults WHERE year = {yr} AND cost_purchased_materials IS NOT NULL"
    cursor.execute(query_cost_purchased_materials_all_companies)
    cost_purchased_materials_all = cursor.fetchall()
    cost_purchased_materials_list.append(cost_purchased_materials_all)

    # Query for cost of purchased materials for the specified company (web_company_id) for the current year
    query_cost_purchased_materials_cur_company = f"SELECT cost_purchased_materials FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND cost_purchased_materials IS NOT NULL"
    cursor.execute(query_cost_purchased_materials_cur_company)
    cost_purchased_materials_cur_company = cursor.fetchall()
    cost_purchased_materials_cur_company_list.append(cost_purchased_materials_cur_company)

    # Query for payments disbursed to subcontractors for all companies for the current year
    query_pay_disbursed_subcontr_all_companies = f"SELECT pay_disbursed_subcontr FROM secure_login.adminresults WHERE year = {yr} AND pay_disbursed_subcontr IS NOT NULL"
    cursor.execute(query_pay_disbursed_subcontr_all_companies)
    pay_disbursed_subcontr_all = cursor.fetchall()
    pay_disbursed_subcontr_list.append(pay_disbursed_subcontr_all)

    # Query for payments disbursed to subcontractors for the specified company (web_company_id) for the current year
    query_pay_disbursed_subcontr_cur_company = f"SELECT pay_disbursed_subcontr FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND pay_disbursed_subcontr IS NOT NULL"
    cursor.execute(query_pay_disbursed_subcontr_cur_company)
    pay_disbursed_subcontr_cur_company = cursor.fetchall()
    pay_disbursed_subcontr_cur_company_list.append(pay_disbursed_subcontr_cur_company)

    # Query for overall productivity measurement (Dollar Revenue) for all companies for the current year
    query_overall_productivity_dollar_revenue_all_companies = f"SELECT overall_productivity_measurement_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND overall_productivity_measurement_dollar_revenue IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_revenue_all_companies)
    overall_productivity_dollar_revenue_all = cursor.fetchall()
    overall_productivity_measurement_list.append(overall_productivity_dollar_revenue_all)

    # Query for overall productivity measurement (Dollar Revenue) for the specified company (web_company_id) for the current year
    query_overall_productivity_dollar_revenue_cur_company = f"SELECT overall_productivity_measurement_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_productivity_measurement_dollar_revenue IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_revenue_cur_company)
    overall_productivity_dollar_revenue_cur_company = cursor.fetchall()
    overall_productivity_measurement_cur_company_list.append(overall_productivity_dollar_revenue_cur_company)

    # Query for overall productivity measurement (Dollar Value Added) for all companies for the current year
    query_overall_productivity_dollar_value_added_all_companies = f"SELECT overall_productivity_measurement_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND overall_productivity_measurement_dollar_value_added IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_value_added_all_companies)
    overall_productivity_dollar_value_added_all = cursor.fetchall()
    overall_productivity_measurement_dollar_value_added_list.append(overall_productivity_dollar_value_added_all)

    # Query for overall productivity measurement (Dollar Value Added) for the specified company (web_company_id) for the current year
    query_overall_productivity_dollar_value_added_cur_company = f"SELECT overall_productivity_measurement_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_productivity_measurement_dollar_value_added IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_value_added_cur_company)
    overall_productivity_dollar_value_added_cur_company = cursor.fetchall()
    overall_productivity_measurement_dollar_value_added_cur_company_list.append(overall_productivity_dollar_value_added_cur_company)

    # Query for overall productivity measurement (Dollar Net Profit) for all companies for the current year
    query_overall_productivity_dollar_net_profit_all_companies = f"SELECT overall_productivity_measurement_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND overall_productivity_measurement_dollar_net_profit IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_net_profit_all_companies)
    overall_productivity_dollar_net_profit_all = cursor.fetchall()
    overall_profitability_dollar_net_profit_fte_list.append(overall_productivity_dollar_net_profit_all)

    # Query for overall productivity measurement (Dollar Net Profit) for the specified company (web_company_id) for the current year
    query_overall_productivity_dollar_net_profit_cur_company = f"SELECT overall_productivity_measurement_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_productivity_measurement_dollar_net_profit IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_net_profit_cur_company)
    overall_productivity_dollar_net_profit_cur_company = cursor.fetchall()
    overall_profitability_dollar_net_profit_fte_cur_company_list.append(overall_productivity_dollar_net_profit_cur_company)
   
# Query for project management dollar revenue for all companies for the current year
    query_project_management_dollar_revenue_all_companies = f"SELECT project_management_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_revenue IS NOT NULL"
    cursor.execute(query_project_management_dollar_revenue_all_companies)
    project_management_dollar_revenue_all = cursor.fetchall()
    project_management_dollar_revenue_list.append(project_management_dollar_revenue_all)

    # Query for project management dollar revenue for the specified company (web_company_id) for the current year
    query_project_management_dollar_revenue_cur_company = f"SELECT project_management_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_revenue IS NOT NULL"
    cursor.execute(query_project_management_dollar_revenue_cur_company)
    project_management_dollar_revenue_cur_company = cursor.fetchall()
    project_management_dollar_revenue_cur_company_list.append(project_management_dollar_revenue_cur_company)

    # Query for project management dollar value added for all companies for the current year
    query_project_management_dollar_value_added_all_companies = f"SELECT project_management_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_value_added IS NOT NULL"
    cursor.execute(query_project_management_dollar_value_added_all_companies)
    project_management_dollar_value_added_all = cursor.fetchall()
    project_management_dollar_value_added_list.append(project_management_dollar_value_added_all)

    # Query for project management dollar value added for the specified company (web_company_id) for the current year
    query_project_management_dollar_value_added_cur_company = f"SELECT project_management_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_value_added IS NOT NULL"
    cursor.execute(query_project_management_dollar_value_added_cur_company)
    project_management_dollar_value_added_cur_company = cursor.fetchall()
    project_management_dollar_value_added_cur_company_list.append(project_management_dollar_value_added_cur_company)

    # Query for project management dollar net profit for all companies for the current year
    query_project_management_dollar_net_profit_all_companies = f"SELECT project_management_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_net_profit IS NOT NULL"
    cursor.execute(query_project_management_dollar_net_profit_all_companies)
    project_management_dollar_net_profit_all = cursor.fetchall()
    project_management_dollar_net_profit_list.append(project_management_dollar_net_profit_all)

    # Query for project management dollar net profit for the specified company (web_company_id) for the current year
    query_project_management_dollar_net_profit_cur_company = f"SELECT project_management_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_net_profit IS NOT NULL"
    cursor.execute(query_project_management_dollar_net_profit_cur_company)
    project_management_dollar_net_profit_cur_company = cursor.fetchall()
    project_management_dollar_net_profit_cur_company_list.append(project_management_dollar_net_profit_cur_company)

    # Query for craft worker dollar revenue for all companies for the current year
    query_craft_worker_dollar_revenue_all_companies = f"SELECT craft_worker_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_revenue IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_revenue_all_companies)
    craft_worker_dollar_revenue_all = cursor.fetchall()
    craft_worker_dollar_revenue_list.append(craft_worker_dollar_revenue_all)

    # Query for craft worker dollar revenue for the specified company (web_company_id) for the current year
    query_craft_worker_dollar_revenue_cur_company = f"SELECT craft_worker_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_revenue IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_revenue_cur_company)
    craft_worker_dollar_revenue_cur_company = cursor.fetchall()
    craft_worker_dollar_revenue_cur_company_list.append(craft_worker_dollar_revenue_cur_company)

    # Query for craft worker dollar value added for all companies for the current year
    query_craft_worker_dollar_value_added_all_companies = f"SELECT craft_worker_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_value_added IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_value_added_all_companies)
    craft_worker_dollar_value_added_all = cursor.fetchall()
    craft_worker_dollar_value_added_list.append(craft_worker_dollar_value_added_all)

    # Query for craft worker dollar value added for the specified company (web_company_id) for the current year
    query_craft_worker_dollar_value_added_cur_company = f"SELECT craft_worker_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_value_added IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_value_added_cur_company)
    craft_worker_dollar_value_added_cur_company = cursor.fetchall()
    craft_worker_dollar_value_added_cur_company_list.append(craft_worker_dollar_value_added_cur_company)

    # Query for craft worker dollar net profit for all companies for the current year
    query_craft_worker_dollar_net_profit_all_companies = f"SELECT craft_worker_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_net_profit IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_net_profit_all_companies)
    craft_worker_dollar_net_profit_all = cursor.fetchall()
    craft_worker_dollar_net_profit_fte_list.append(craft_worker_dollar_net_profit_all)

    # Query for craft worker dollar net profit for the specified company (web_company_id) for the current year
    query_craft_worker_dollar_net_profit_cur_company = f"SELECT craft_worker_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_net_profit IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_net_profit_cur_company)
    craft_worker_dollar_net_profit_cur_company = cursor.fetchall()
    craft_worker_dollar_net_profit_fte_cur_company_list.append(craft_worker_dollar_net_profit_cur_company)

    # Query for supporting employee dollar revenue for all companies for the current year
    query_supporting_employee_dollar_revenue_all_companies = f"SELECT supporting_employee_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_revenue IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_revenue_all_companies)
    supporting_employee_dollar_revenue_all = cursor.fetchall()
    supporting_employee_dollar_revenue_list.append(supporting_employee_dollar_revenue_all)

    # Query for supporting employee dollar revenue for the specified company (web_company_id) for the current year
    query_supporting_employee_dollar_revenue_cur_company = f"SELECT supporting_employee_dollar_revenue FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_revenue IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_revenue_cur_company)
    supporting_employee_dollar_revenue_cur_company = cursor.fetchall()
    supporting_employee_dollar_revenue_cur_company_list.append(supporting_employee_dollar_revenue_cur_company)

    # Query for supporting employee dollar value added for all companies for the current year
    query_supporting_employee_dollar_value_added_all_companies = f"SELECT supporting_employee_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_value_added IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_value_added_all_companies)
    supporting_employee_dollar_value_added_all = cursor.fetchall()
    supporting_employee_dollar_value_added_list.append(supporting_employee_dollar_value_added_all)

    # Query for supporting employee dollar value added for the specified company (web_company_id) for the current year
    query_supporting_employee_dollar_value_added_cur_company = f"SELECT supporting_employee_dollar_value_added FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_value_added IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_value_added_cur_company)
    supporting_employee_dollar_value_added_cur_company = cursor.fetchall()
    supporting_employee_dollar_value_added_cur_company_list.append(supporting_employee_dollar_value_added_cur_company)

    # Query for supporting employee dollar net profit for all companies for the current year
    query_supporting_employee_dollar_net_profit_all_companies = f"SELECT supporting_employee_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_net_profit IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_net_profit_all_companies)
    supporting_employee_dollar_net_profit_all = cursor.fetchall()
    supporting_employee_dollar_net_profit_list.append(supporting_employee_dollar_net_profit_all)

    # Query for supporting employee dollar net profit for the specified company (web_company_id) for the current year
    query_supporting_employee_dollar_net_profit_cur_company = f"SELECT supporting_employee_dollar_net_profit FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_net_profit IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_net_profit_cur_company)
    supporting_employee_dollar_net_profit_cur_company = cursor.fetchall()
    supporting_employee_dollar_net_profit_cur_company_list.append(supporting_employee_dollar_net_profit_cur_company)

    # Query for overall productivity dollar revenue FTE for all companies for the current year
    query_overall_productivity_dollar_revenue_fte_all_companies = f"SELECT overall_productivity_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND overall_productivity_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_revenue_fte_all_companies)
    overall_productivity_dollar_revenue_fte_all = cursor.fetchall()
    overall_productivity_dollar_revenue_fte_list.append(overall_productivity_dollar_revenue_fte_all)

    # Query for overall productivity dollar revenue FTE for the specified company (web_company_id) for the current year
    query_overall_productivity_dollar_revenue_fte_cur_company = f"SELECT overall_productivity_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_productivity_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_revenue_fte_cur_company)
    overall_productivity_dollar_revenue_fte_cur_company = cursor.fetchall()
    overall_productivity_dollar_revenue_fte_cur_company_list.append(overall_productivity_dollar_revenue_fte_cur_company)

    # Query for overall productivity dollar value added FTE for all companies for the current year
    query_overall_productivity_dollar_value_added_fte_all_companies = f"SELECT overall_productivity_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND overall_productivity_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_value_added_fte_all_companies)
    overall_productivity_dollar_value_added_fte_all = cursor.fetchall()
    overall_productivity_dollar_value_added_fte_list.append(overall_productivity_dollar_value_added_fte_all)

    # Query for overall productivity dollar value added FTE for the specified company (web_company_id) for the current year
    query_overall_productivity_dollar_value_added_fte_cur_company = f"SELECT overall_productivity_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_productivity_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_value_added_fte_cur_company)
    overall_productivity_dollar_value_added_fte_cur_company = cursor.fetchall()
    overall_productivity_dollar_value_added_fte_cur_company_list.append(overall_productivity_dollar_value_added_fte_cur_company)

    # Query for overall productivity dollar net profit FTE for all companies for the current year
    query_overall_productivity_dollar_net_profit_fte_all_companies = f"SELECT overall_productivity_dollar_net_profit_fte FROM secure_login.adminresults WHERE year = {yr} AND overall_productivity_dollar_net_profit_fte IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_net_profit_fte_all_companies)
    overall_productivity_dollar_net_profit_fte_all = cursor.fetchall()
    overall_profitability_dollar_net_profit_fte_list.append(overall_productivity_dollar_net_profit_fte_all)

    # Query for overall productivity dollar net profit FTE for the specified company (web_company_id) for the current year
    query_overall_productivity_dollar_net_profit_fte_cur_company = f"SELECT overall_productivity_dollar_net_profit_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_productivity_dollar_net_profit_fte IS NOT NULL"
    cursor.execute(query_overall_productivity_dollar_net_profit_fte_cur_company)
    overall_productivity_dollar_net_profit_fte_cur_company = cursor.fetchall()
    overall_profitability_dollar_net_profit_fte_cur_company_list.append(overall_productivity_dollar_net_profit_fte_cur_company)

    # Query for project management dollar revenue personnel FTE for all companies for the current year
    query_project_management_dollar_revenue_personnel_fte_all_companies = f"SELECT project_management_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_project_management_dollar_revenue_personnel_fte_all_companies)
    project_management_dollar_revenue_personnel_fte_all = cursor.fetchall()
    project_management_dollar_revenue_personnel_fte_list.append(project_management_dollar_revenue_personnel_fte_all)

    # Query for project management dollar revenue personnel FTE for the specified company (web_company_id) for the current year
    query_project_management_dollar_revenue_personnel_fte_cur_company = f"SELECT project_management_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_project_management_dollar_revenue_personnel_fte_cur_company)
    project_management_dollar_revenue_personnel_fte_cur_company = cursor.fetchall()
    project_management_dollar_revenue_personnel_fte_cur_company_list.append(project_management_dollar_revenue_personnel_fte_cur_company)

    # Query for project management dollar value added personnel FTE for all companies for the current year
    query_project_management_dollar_value_added_personnel_fte_all_companies = f"SELECT project_management_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_project_management_dollar_value_added_personnel_fte_all_companies)
    project_management_dollar_value_added_personnel_fte_all = cursor.fetchall()
    project_management_dollar_value_added_personnel_fte_list.append(project_management_dollar_value_added_personnel_fte_all)

    # Query for project management dollar value added personnel FTE for the specified company (web_company_id) for the current year
    query_project_management_dollar_value_added_personnel_fte_cur_company = f"SELECT project_management_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_project_management_dollar_value_added_personnel_fte_cur_company)
    project_management_dollar_value_added_personnel_fte_cur_company = cursor.fetchall()
    project_management_dollar_value_added_personnel_fte_cur_company_list.append(project_management_dollar_value_added_personnel_fte_cur_company)

    # Query for project management dollar net profit personnel FTE for all companies for the current year
    query_project_management_dollar_net_profit_personnel_fte_all_companies = f"SELECT project_management_dollar_net_profit_fte FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_net_profit_fte IS NOT NULL"
    cursor.execute(query_project_management_dollar_net_profit_personnel_fte_all_companies)
    project_management_dollar_net_profit_personnel_fte_all = cursor.fetchall()
    project_management_dollar_net_profit_personnel_fte_list.append(project_management_dollar_net_profit_personnel_fte_all)

    # Craft Worker Dollar Revenue FTE
    query_craft_worker_dollar_revenue_fte_all_companies = f"SELECT craft_worker_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_revenue_fte_all_companies)
    craft_worker_dollar_revenue_fte_all = cursor.fetchall()
    craft_worker_dollar_revenue_fte_list.append(craft_worker_dollar_revenue_fte_all)

    query_craft_worker_dollar_revenue_fte_cur_company = f"SELECT craft_worker_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_revenue_fte_cur_company)
    craft_worker_dollar_revenue_fte_cur_company = cursor.fetchall()
    craft_worker_dollar_revenue_fte_cur_company_list.append(craft_worker_dollar_revenue_fte_cur_company)

    # Craft Worker Dollar Value Added FTE
    query_craft_worker_dollar_value_added_fte_all_companies = f"SELECT craft_worker_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_value_added_fte_all_companies)
    craft_worker_dollar_value_added_fte_all = cursor.fetchall()
    craft_worker_dollar_value_added_fte_list.append(craft_worker_dollar_value_added_fte_all)

    query_craft_worker_dollar_value_added_fte_cur_company = f"SELECT craft_worker_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_value_added_fte_cur_company)
    craft_worker_dollar_value_added_fte_cur_company = cursor.fetchall()
    craft_worker_dollar_value_added_fte_cur_company_list.append(craft_worker_dollar_value_added_fte_cur_company)

    # Craft Worker Dollar Net Profit FTE
    query_craft_worker_dollar_net_profit_fte_all_companies = f"SELECT craft_worker_dollar_net_profit_fte FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_net_profit_fte IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_net_profit_fte_all_companies)
    craft_worker_dollar_net_profit_fte_all = cursor.fetchall()
    craft_worker_dollar_net_profit_fte_list.append(craft_worker_dollar_net_profit_fte_all)

    query_craft_worker_dollar_net_profit_fte_cur_company = f"SELECT craft_worker_dollar_net_profit_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_net_profit_fte IS NOT NULL"
    cursor.execute(query_craft_worker_dollar_net_profit_fte_cur_company)
    craft_worker_dollar_net_profit_fte_cur_company = cursor.fetchall()
    craft_worker_dollar_net_profit_fte_cur_company_list.append(craft_worker_dollar_net_profit_fte_cur_company)

    # Supporting Employee Dollar Revenue FTE
    query_supporting_employee_dollar_revenue_fte_all_companies = f"SELECT supporting_employee_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_revenue_fte_all_companies)
    supporting_employee_dollar_revenue_fte_all = cursor.fetchall()
    supporting_employee_dollar_revenue_fte_list.append(supporting_employee_dollar_revenue_fte_all)

    query_supporting_employee_dollar_revenue_fte_cur_company = f"SELECT supporting_employee_dollar_revenue_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_revenue_fte IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_revenue_fte_cur_company)
    supporting_employee_dollar_revenue_fte_cur_company = cursor.fetchall()
    supporting_employee_dollar_revenue_fte_cur_company_list.append(supporting_employee_dollar_revenue_fte_cur_company)

    # Supporting Employee Dollar Value Added FTE
    query_supporting_employee_dollar_value_added_fte_all_companies = f"SELECT supporting_employee_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_value_added_fte_all_companies)
    supporting_employee_dollar_value_added_fte_all = cursor.fetchall()
    supporting_employee_dollar_value_added_fte_list.append(supporting_employee_dollar_value_added_fte_all)

    query_supporting_employee_dollar_value_added_fte_cur_company = f"SELECT supporting_employee_dollar_value_added_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_value_added_fte IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_value_added_fte_cur_company)
    supporting_employee_dollar_value_added_fte_cur_company = cursor.fetchall()
    supporting_employee_dollar_value_added_fte_cur_company_list.append(supporting_employee_dollar_value_added_fte_cur_company)

    # Supporting Employee Dollar Net Profit FTE for all companies
    query_supporting_employee_dollar_net_profit_fte_all_companies = f"SELECT supporting_employee_dollar_net_profit_added_fte FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_net_profit_added_fte IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_net_profit_fte_all_companies)
    supporting_employee_dollar_net_profit_fte_all = cursor.fetchall()
    supporting_employee_dollar_net_profit_fte_list.append(supporting_employee_dollar_net_profit_fte_all)

    # Supporting Employee Dollar Net Profit FTE for the specified company (web_company_id)
    query_supporting_employee_dollar_net_profit_fte_cur_company = f"SELECT supporting_employee_dollar_net_profit_added_fte FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_net_profit_added_fte IS NOT NULL"
    cursor.execute(query_supporting_employee_dollar_net_profit_fte_cur_company)
    supporting_employee_dollar_net_profit_fte_cur_company = cursor.fetchall()
    supporting_employee_dollar_net_profit_fte_cur_company_list.append(supporting_employee_dollar_net_profit_fte_cur_company)

    # Overall Cost Effectiveness Dollar Revenue for all companies
    query_overall_cost_effectiveness_dollar_revenue_all_companies = f"SELECT overall_cost_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND overall_cost_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_overall_cost_effectiveness_dollar_revenue_all_companies)
    overall_cost_effectiveness_dollar_revenue_all = cursor.fetchall()
    overall_cost_effectiveness_dollar_revenue_list.append(overall_cost_effectiveness_dollar_revenue_all)

    # Overall Cost Effectiveness Dollar Revenue for the specified company (web_company_id)
    query_overall_cost_effectiveness_dollar_revenue_cur_company = f"SELECT overall_cost_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_cost_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_overall_cost_effectiveness_dollar_revenue_cur_company)
    overall_cost_effectiveness_dollar_revenue_cur_company = cursor.fetchall()
    overall_cost_effectiveness_dollar_revenue_cur_company_list.append(overall_cost_effectiveness_dollar_revenue_cur_company)

    # Overall Cost Effectiveness Dollar Value Added for all companies
    query_overall_cost_effectiveness_dollar_value_added_all_companies = f"SELECT overall_cost_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND overall_cost_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_overall_cost_effectiveness_dollar_value_added_all_companies)
    overall_cost_effectiveness_dollar_value_added_all = cursor.fetchall()
    overall_cost_effectiveness_dollar_value_added_list.append(overall_cost_effectiveness_dollar_value_added_all)

    # Overall Cost Effectiveness Dollar Value Added for the specified company (web_company_id)
    query_overall_cost_effectiveness_dollar_value_added_cur_company = f"SELECT overall_cost_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_cost_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_overall_cost_effectiveness_dollar_value_added_cur_company)
    overall_cost_effectiveness_dollar_value_added_cur_company = cursor.fetchall()
    overall_cost_effectiveness_dollar_value_added_cur_company_list.append(overall_cost_effectiveness_dollar_value_added_cur_company)

    # Overall Cost Effectiveness Dollar Net Profit for all companies
    query_overall_cost_effectiveness_dollar_net_profit_all_companies = f"SELECT overall_cost_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND overall_cost_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_overall_cost_effectiveness_dollar_net_profit_all_companies)
    overall_cost_effectiveness_dollar_net_profit_all = cursor.fetchall()
    overall_cost_effectiveness_dollar_net_profit_list.append(overall_cost_effectiveness_dollar_net_profit_all)

    # Overall Cost Effectiveness Dollar Net Profit for the specified company (web_company_id)
    query_overall_cost_effectiveness_dollar_net_profit_cur_company = f"SELECT overall_cost_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND overall_cost_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_overall_cost_effectiveness_dollar_net_profit_cur_company)
    overall_cost_effectiveness_dollar_net_profit_cur_company = cursor.fetchall()
    overall_cost_effectiveness_dollar_net_profit_cur_company_list.append(overall_cost_effectiveness_dollar_net_profit_cur_company)

    # Project Management Cost Dollar Revenue for all companies
    query_project_management_cost_dollar_revenue_all_companies = f"SELECT project_management_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_project_management_cost_dollar_revenue_all_companies)
    project_management_cost_dollar_revenue_all = cursor.fetchall()
    project_management_cost_dollar_revenue_list.append(project_management_cost_dollar_revenue_all)

    # Project Management Cost Dollar Revenue for the specified company (web_company_id)
    query_project_management_cost_dollar_revenue_cur_company = f"SELECT project_management_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_project_management_cost_dollar_revenue_cur_company)
    project_management_cost_dollar_revenue_cur_company = cursor.fetchall()
    project_management_cost_dollar_revenue_cur_company_list.append(project_management_cost_dollar_revenue_cur_company)

    # Project Management Cost Dollar Value Added for all companies
    query_project_management_cost_dollar_value_added_all_companies = f"SELECT project_management_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_project_management_cost_dollar_value_added_all_companies)
    project_management_cost_dollar_value_added_all = cursor.fetchall()
    project_management_cost_dollar_value_added_list.append(project_management_cost_dollar_value_added_all)

    # Project Management Cost Dollar Value Added for the specified company (web_company_id)
    query_project_management_cost_dollar_value_added_cur_company = f"SELECT project_management_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND project_management_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_project_management_cost_dollar_value_added_cur_company)
    project_management_cost_dollar_value_added_cur_company = cursor.fetchall()
    project_management_cost_dollar_value_added_cur_company_list.append(project_management_cost_dollar_value_added_cur_company)

    # Project Management Cost Dollar Net Profit for all companies
    query_project_management_cost_dollar_net_profit_all_companies = f"SELECT project_management_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND project_management_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_project_management_cost_dollar_net_profit_all_companies)
    project_management_cost_dollar_net_profit_all = cursor.fetchall()
    project_management_cost_dollar_net_profit_list.append(project_management_cost_dollar_net_profit_all)

    # Craft Worker Cost Effect Dollar Revenue for all companies
    query_craft_worker_cost_effect_dollar_revenue_all_companies = f"SELECT craft_worker_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_craft_worker_cost_effect_dollar_revenue_all_companies)
    craft_worker_cost_effect_dollar_revenue_all = cursor.fetchall()
    craft_worker_cost_effect_dollar_revenue_list.append(craft_worker_cost_effect_dollar_revenue_all)

    # Craft Worker Cost Effect Dollar Revenue for the specified company (web_company_id)
    query_craft_worker_cost_effect_dollar_revenue_cur_company = f"SELECT craft_worker_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_craft_worker_cost_effect_dollar_revenue_cur_company)
    craft_worker_cost_effect_dollar_revenue_cur_company = cursor.fetchall()
    craft_worker_cost_effect_dollar_revenue_cur_company_list.append(craft_worker_cost_effect_dollar_revenue_cur_company)

    # Craft Worker Cost Effect Dollar Value Added for all companies
    query_craft_worker_cost_effect_dollar_value_added_all_companies = f"SELECT craft_worker_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_craft_worker_cost_effect_dollar_value_added_all_companies)
    craft_worker_cost_effect_dollar_value_added_all = cursor.fetchall()
    craft_worker_cost_effect_dollar_value_added_list.append(craft_worker_cost_effect_dollar_value_added_all)

    # Craft Worker Cost Effect Dollar Value Added for the specified company (web_company_id)
    query_craft_worker_cost_effect_dollar_value_added_cur_company = f"SELECT craft_worker_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_craft_worker_cost_effect_dollar_value_added_cur_company)
    craft_worker_cost_effect_dollar_value_added_cur_company = cursor.fetchall()
    craft_worker_cost_effect_dollar_value_added_cur_company_list.append(craft_worker_cost_effect_dollar_value_added_cur_company)

    # Craft Worker Cost Effect Dollar Net Profit for all companies
    query_craft_worker_cost_effect_dollar_net_profit_all_companies = f"SELECT craft_worker_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND craft_worker_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_craft_worker_cost_effect_dollar_net_profit_all_companies)
    craft_worker_cost_effect_dollar_net_profit_all = cursor.fetchall()
    craft_worker_cost_effect_dollar_net_profit_list.append(craft_worker_cost_effect_dollar_net_profit_all)

    # Craft Worker Cost Effect Dollar Net Profit for the specified company (web_company_id)
    query_craft_worker_cost_effect_dollar_net_profit_cur_company = f"SELECT craft_worker_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND craft_worker_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_craft_worker_cost_effect_dollar_net_profit_cur_company)
    craft_worker_cost_effect_dollar_net_profit_cur_company = cursor.fetchall()
    craft_worker_cost_effect_dollar_net_profit_cur_company_list.append(craft_worker_cost_effect_dollar_net_profit_cur_company)

    # Supporting Employee Cost Effect Dollar Revenue for all companies
    query_supporting_employee_cost_effect_dollar_revenue_all_companies = f"SELECT supporting_employee_dollar_revenue_cost FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_revenue_cost IS NOT NULL"
    cursor.execute(query_supporting_employee_cost_effect_dollar_revenue_all_companies)
    supporting_employee_cost_effect_dollar_revenue_all = cursor.fetchall()
    supporting_employee_cost_effect_dollar_revenue_cur_company_list.append(supporting_employee_cost_effect_dollar_revenue_all)

    # Supporting Employee Cost Effect Dollar Value Added for all companies
    query_supporting_employee_cost_effect_dollar_value_added_all_companies = f"SELECT supporting_employee_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_supporting_employee_cost_effect_dollar_value_added_all_companies)
    supporting_employee_cost_effect_dollar_value_added_all = cursor.fetchall()
    supporting_employee_cost_effect_dollar_value_added_list.append(supporting_employee_cost_effect_dollar_value_added_all)

    # Supporting Employee Cost Effect Dollar Value Added for the specified company (web_company_id)
    query_supporting_employee_cost_effect_dollar_value_added_cur_company = f"SELECT supporting_employee_dollar_value_added_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_value_added_cost IS NOT NULL"
    cursor.execute(query_supporting_employee_cost_effect_dollar_value_added_cur_company)
    supporting_employee_cost_effect_dollar_value_added_cur_company = cursor.fetchall()
    supporting_employee_cost_effect_dollar_value_added_cur_company_list.append(supporting_employee_cost_effect_dollar_value_added_cur_company)

    # Supporting Employee Cost Effect Dollar Net Profit for all companies
    query_supporting_employee_cost_effect_dollar_net_profit_all_companies = f"SELECT supporting_employee_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND supporting_employee_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_supporting_employee_cost_effect_dollar_net_profit_all_companies)
    supporting_employee_cost_effect_dollar_net_profit_all = cursor.fetchall()
    supporting_employee_cost_effect_dollar_net_profit_list.append(supporting_employee_cost_effect_dollar_net_profit_all)

    # Supporting Employee Cost Effect Dollar Net Profit for the specified company (web_company_id)
    query_supporting_employee_cost_effect_dollar_net_profit_cur_company = f"SELECT supporting_employee_dollar_net_profit_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND supporting_employee_dollar_net_profit_cost IS NOT NULL"
    cursor.execute(query_supporting_employee_cost_effect_dollar_net_profit_cur_company)
    supporting_employee_cost_effect_dollar_net_profit_cur_company = cursor.fetchall()
    supporting_employee_cost_effect_dollar_net_profit_cur_company_list.append(supporting_employee_cost_effect_dollar_net_profit_cur_company)

    # Cost Field Project Management for all companies
    query_cost_field_proj_management_all_companies = f"SELECT cost_field_project_management_personnel FROM secure_login.adminresults WHERE year = {yr} AND cost_field_project_management_personnel IS NOT NULL"
    cursor.execute(query_cost_field_proj_management_all_companies)
    cost_field_proj_management_all = cursor.fetchall()
    cost_field_project_management_list.append(cost_field_proj_management_all)

    # Cost Field Project Management for the specified company (web_company_id)
    query_cost_field_proj_management_cur_company = f"SELECT cost_field_project_management_personnel FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND cost_field_project_management_personnel IS NOT NULL"
    cursor.execute(query_cost_field_proj_management_cur_company)
    cost_field_proj_management_cur_company = cursor.fetchall()
    cost_field_project_management_cur_company_list.append(cost_field_proj_management_cur_company)

    # Cost Bargaining Unit Employee for all companies
    query_cost_bargaining_unit_employee_all_companies = f"SELECT cost_bargaining_unit_employee_expended FROM secure_login.adminresults WHERE year = {yr} AND cost_bargaining_unit_employee_expended IS NOT NULL"
    cursor.execute(query_cost_bargaining_unit_employee_all_companies)
    cost_bargaining_unit_employee_all = cursor.fetchall()
    cost_bargaining_unit_employee_list.append(cost_bargaining_unit_employee_all)

    # Cost Bargaining Unit Employee for the specified company (web_company_id)
    query_cost_bargaining_unit_employee_cur_company = f"SELECT cost_bargaining_unit_employee_expended FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND cost_bargaining_unit_employee_expended IS NOT NULL"
    cursor.execute(query_cost_bargaining_unit_employee_cur_company)
    cost_bargaining_unit_employee_cur_company = cursor.fetchall()
    cost_bargaining_unit_employee_cur_company_list.append(cost_bargaining_unit_employee_cur_company)

    # Cost of Supporting Employees for all companies
    query_cost_supporting_employees_all_companies = f"SELECT cost_supporting_employee_per_hour FROM secure_login.adminresults WHERE year = {yr} AND cost_supporting_employee_per_hour IS NOT NULL"
    cursor.execute(query_cost_supporting_employees_all_companies)
    cost_supporting_employees_all = cursor.fetchall()
    cost_supporting_employees_list.append(cost_supporting_employees_all)

    # Cost of Supporting Employees for the specified company (web_company_id)
    query_cost_supporting_employees_cur_company = f"SELECT cost_supporting_employee_per_hour FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND cost_supporting_employee_per_hour IS NOT NULL"
    cursor.execute(query_cost_supporting_employees_cur_company)
    cost_supporting_employees_cur_company = cursor.fetchall()
    cost_supporting_employees_cur_company_list.append(cost_supporting_employees_cur_company)

    # Cost of Field Project Management Personnel for all companies
    query_cost_field_proj_management_personnel_all_companies = f"SELECT cost_field_project_management_personnel_cost FROM secure_login.adminresults WHERE year = {yr} AND cost_field_project_management_personnel_cost IS NOT NULL"
    cursor.execute(query_cost_field_proj_management_personnel_all_companies)
    cost_field_proj_management_personnel_all = cursor.fetchall()
    cost_field_project_management_personnel_list.append(cost_field_proj_management_personnel_all)

    # Cost of Field Project Management Personnel for the specified company (web_company_id)
    query_cost_field_proj_management_personnel_cur_company = f"SELECT cost_field_project_management_personnel_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND cost_field_project_management_personnel_cost IS NOT NULL"
    cursor.execute(query_cost_field_proj_management_personnel_cur_company)
    cost_field_proj_management_personnel_cur_company = cursor.fetchall()
    cost_field_project_management_personnel_cur_company_list.append(cost_field_proj_management_personnel_cur_company)

    # Cost of Supporting Employee Cost Bargaining for all companies
    query_cost_supporting_employee_cost_bargaining_all_companies = f"SELECT cost_supp_employee_cost FROM secure_login.adminresults WHERE year = {yr} AND cost_supp_employee_cost IS NOT NULL"
    cursor.execute(query_cost_supporting_employee_cost_bargaining_all_companies)
    cost_supporting_employee_cost_bargaining_all = cursor.fetchall()
    cost_supporting_employee_cost_bargaining_list.append(cost_supporting_employee_cost_bargaining_all)

    # Cost of Supporting Employee Cost Bargaining for the specified company (web_company_id)
    query_cost_supporting_employee_cost_bargaining_cur_company = f"SELECT cost_supp_employee_cost FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND cost_supp_employee_cost IS NOT NULL"
    cursor.execute(query_cost_supporting_employee_cost_bargaining_cur_company)
    cost_supporting_employee_cost_bargaining_cur_company = cursor.fetchall()
    cost_supporting_employee_cost_bargaining_cur_company_list.append(cost_supporting_employee_cost_bargaining_cur_company)

    # Hours of Field Project Management Personnel for all companies
    query_hours_field_project_management_all_companies = f"SELECT hours_field_project_management_personnel FROM secure_login.adminresults WHERE year = {yr} AND hours_field_project_management_personnel IS NOT NULL"
    cursor.execute(query_hours_field_project_management_all_companies)
    hours_field_project_management_all = cursor.fetchall()
    hours_field_project_management_list.append(hours_field_project_management_all)

    # Hours of Field Project Management Personnel for the specified company (web_company_id)
    query_hours_field_project_management_cur_company = f"SELECT hours_field_project_management_personnel FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND hours_field_project_management_personnel IS NOT NULL"
    cursor.execute(query_hours_field_project_management_cur_company)
    hours_field_project_management_cur_company = cursor.fetchall()
    hours_field_project_management_cur_company_list.append(hours_field_project_management_cur_company)

    # Hours of Supporting Employees for all companies
    query_hours_supporting_employee_all_companies = f"SELECT hours_supporting_employee_per_hour FROM secure_login.adminresults WHERE year = {yr} AND hours_supporting_employee_per_hour IS NOT NULL"
    cursor.execute(query_hours_supporting_employee_all_companies)
    hours_supporting_employee_all = cursor.fetchall()
    hours_supporting_employee_list.append(hours_supporting_employee_all)

    # Hours of Supporting Employees for the specified company (web_company_id)
    query_hours_supporting_employee_cur_company = f"SELECT hours_supporting_employee_per_hour FROM secure_login.adminresults WHERE year = {yr} AND company_id = {web_company_id} AND hours_supporting_employee_per_hour IS NOT NULL"
    cursor.execute(query_hours_supporting_employee_cur_company)
    hours_supporting_employee_cur_company = cursor.fetchall()
    hours_supporting_employee_cur_company_list.append(hours_supporting_employee_cur_company)

    # increment
    yr += 1

######################################################################################################################################
# QUANTILE CALCULATION


# 50 - Hours of Supporting Employees per Hours of Bargaining Unit Employees
Hours_of_Supporting_Employees_per_Expended_Man_Hours_of_Bargaining_Unit_Employees = comp['hours_supporting_employee_per_hour']
hoursSupportingEmployeeQuantileList = Hours_of_Supporting_Employees_per_Expended_Man_Hours_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
hoursSupportingEmployeeMeanList = Hours_of_Supporting_Employees_per_Expended_Man_Hours_of_Bargaining_Unit_Employees.mean()

# 49 - Hours of Field Project Management Personnel per Hours of Bargaining Unit Employees
Hours_of_Field_Project_Management_Personnel_per_Expended_Man_Hours_of_Bargaining_Unit_Employees = comp['hours_field_project_management_personnel']
hoursFieldProjectManagementQuantileList = Hours_of_Field_Project_Management_Personnel_per_Expended_Man_Hours_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
hoursFieldProjectManagementMeanList = Hours_of_Field_Project_Management_Personnel_per_Expended_Man_Hours_of_Bargaining_Unit_Employees.mean()

# 48 - Cost of Supporting Employees per Cost of Bargaining Unit Employees
Cost_of_Supporting_Employees_per_Cost_of_Bargaining_Unit_Employees = comp['cost_supp_employee_cost']
costSupportingEmployeeCostBargainingQuantileList = Cost_of_Supporting_Employees_per_Cost_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
costSupportingEmployeeCostBargainingMeanList = Cost_of_Supporting_Employees_per_Cost_of_Bargaining_Unit_Employees.mean()

# 47 - Cost of Field Project Management Personnel per Cost of Bargaining Unit Employees
Cost_of_Field_Project_Management_Personnel_per_Cost_of_Bargaining_Unit_Employees = comp['cost_field_project_management_personnel_cost']
costFieldProjManagementPersonnelQuantileList = Cost_of_Field_Project_Management_Personnel_per_Cost_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
costFieldProjManagementPersonnelMeanList = Cost_of_Field_Project_Management_Personnel_per_Cost_of_Bargaining_Unit_Employees.mean()

# 46 - Cost of Supporting Employees per Hours of Supporting Employees
Cost_of_Supporting_Employees_per_Hours_of_Supporting_Employees = comp['cost_supporting_employee_per_hour']
costSupportingEmployeesQuantileList = Cost_of_Supporting_Employees_per_Hours_of_Supporting_Employees.quantile([0.25, 0.5, 0.75]).tolist()
costSupportingEmployeesMeanList = Cost_of_Supporting_Employees_per_Hours_of_Supporting_Employees.mean()

# 45 - Cost of Bargaining Unit Employees per Expended Man Hours of Bargaining Unit Employees
Cost_of_Bargaining_Unit_Employees_per_Expended_Man_Hours_of_Bargaining_Unit_Employees = comp['cost_bargaining_unit_employee_expended']
costBargainingUnitEmployeeQuantileList = Cost_of_Bargaining_Unit_Employees_per_Expended_Man_Hours_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
costBargainingUnitEmployeeMeanList = Cost_of_Bargaining_Unit_Employees_per_Expended_Man_Hours_of_Bargaining_Unit_Employees.mean()

# 44 - Cost of Field Project Management Personnel per Hours of Field Project Management Personnel
Cost_of_Field_Project_Management_Personnel_per_Hours = comp['cost_field_project_management_personnel']
costFieldProjManagementQuantileList = Cost_of_Field_Project_Management_Personnel_per_Hours.quantile([0.25, 0.5, 0.75]).tolist()
costFieldProjManagementMeanList = Cost_of_Field_Project_Management_Personnel_per_Hours.mean()

# 43 - Supporting Employees Cost Effectiveness: Dollar Net Profit / Cost of Supporting Employees
Net_Profit_per_Cost_of_Supporting_Employees = comp['supporting_employee_dollar_net_profit_cost']
supportingEmployeeCostEffectDollarNetProfitQuantileList = Net_Profit_per_Cost_of_Supporting_Employees.quantile([0.25, 0.5, 0.75]).tolist()
supportingEmployeeCostEffectDollarNetProfitMeanList = Net_Profit_per_Cost_of_Supporting_Employees.mean()

# 42 - Supporting Employees Cost Effectiveness: Dollar Value Added/ Cost of Supporting Employees
Value_Added_per_Cost_of_Supporting_Employees = comp['supporting_employee_dollar_value_added_cost']
supportingEmployeeCostEffectDollarValueAddedQuantileList = Value_Added_per_Cost_of_Supporting_Employees.quantile([0.25, 0.5, 0.75]).tolist()
supportingEmployeeCostEffectDollarValueAddedMeanList = Value_Added_per_Cost_of_Supporting_Employees.mean()

# 41 - Supporting Employees Cost Effectiveness: Dollar Revenue/ Cost of Supporting Employees
Revenue_per_Cost_of_Supporting_Employees = comp['supporting_employee_dollar_revenue_cost']
supportingEmployeeCostEffectDollarRevenueQuantileList = Revenue_per_Cost_of_Supporting_Employees.quantile([0.25, 0.5, 0.75]).tolist()
supportingEmployeeCostEffectDollarRevenueMeanList = Revenue_per_Cost_of_Supporting_Employees.mean()

# 40 - Craft Worker Cost Effectiveness: Dollar Net Profit / Cost of Bargaining Unit Employees
Net_Profit_per_Cost_of_Bargaining_Unit_Employees = comp['craft_worker_dollar_net_profit_cost']
craftWorkerCostEffectDollarNetProfitQuantileList = Net_Profit_per_Cost_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
craftWorkerCostEffectDollarNetProfitMeanList = Net_Profit_per_Cost_of_Bargaining_Unit_Employees.mean()

# 39 - Craft Worker Cost Effectiveness: Dollar Value Added/ Cost of Bargaining Unit Employees
Value_Added_per_Cost_of_Bargaining_Unit_Employees = comp['craft_worker_dollar_value_added_cost']
craftWorkerCostEffectDollarValueAddedQuantileList = Value_Added_per_Cost_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
craftWorkerCostEffectDollarValueAddedMeanList = Value_Added_per_Cost_of_Bargaining_Unit_Employees.mean()

# 38 - Craft Worker Cost Effectiveness: Dollar Revenue/ Cost of Bargaining Unit Employees
Revenue_per_Cost_of_Bargaining_Unit_Employees = comp['craft_worker_dollar_revenue_cost']
craftWorkerCostEffectDollarRevenueQuantileList = Revenue_per_Cost_of_Bargaining_Unit_Employees.quantile([0.25, 0.5, 0.75]).tolist()
craftWorkerCostEffectDollarRevenueMeanList = Revenue_per_Cost_of_Bargaining_Unit_Employees.mean()

# 37 - Project Management Cost Effectiveness: Dollar Net Profit / Cost of Project Management Personnel
Net_Profit_per_Cost_of_Field_Project_Management_Personnel = comp['project_management_dollar_net_profit_cost']
projectManagementCostDollarNetProfitQuantileList = Net_Profit_per_Cost_of_Field_Project_Management_Personnel.quantile([0.25, 0.5, 0.75]).tolist()
projectManagementCostDollarNetProfitMeanList = Net_Profit_per_Cost_of_Field_Project_Management_Personnel.mean()

# 36 - Project Management Cost Effectiveness: Dollar Value Added/ Cost of Project Management Personnel
Value_Added_per_Cost_of_Field_Project_Management_Personnel = comp['project_management_dollar_value_added_cost']
projectManagementCostDollarValueAddedQuantileList = Value_Added_per_Cost_of_Field_Project_Management_Personnel.quantile([0.25, 0.5, 0.75]).tolist()
projectManagementCostDollarValueAddedMeanList = Value_Added_per_Cost_of_Field_Project_Management_Personnel.mean()

# 35 - Project Management Cost Effectiveness: Dollar Revenue/ Cost of Project Management Personnel
Revenue_per_Cost_of_Field_Project_Management_Personnel = comp['project_management_dollar_revenue_cost']
projectManagementCostDollarRevenueQuantileList = Revenue_per_Cost_of_Field_Project_Management_Personnel.quantile([0.25, 0.5, 0.75]).tolist()
projectManagementCostDollarRevenueMeanList = Revenue_per_Cost_of_Field_Project_Management_Personnel.mean()

# 34 - Overall Cost Effectiveness – Dollar Net Profit / Cost of Company’s People
Net_Profit_per_Total_Cost_of_People = comp['overall_cost_dollar_net_profit_cost']
overallCostEffectivenessDollarNetProfitQuantileList = Net_Profit_per_Total_Cost_of_People.quantile([0.25, 0.5, 0.75]).tolist()
overallCostEffectivenessDollarNetProfitMeanList = Net_Profit_per_Total_Cost_of_People.mean()

# 33 - Overall Cost Effectiveness – Dollar Value Added/ Cost of Company’s People
Value_Added_per_Total_Cost_of_People = comp['overall_cost_dollar_value_added_cost']
overallCostEffectivenessDollarValueAddedQuantileList = Value_Added_per_Total_Cost_of_People.quantile([0.25, 0.5, 0.75]).tolist()
overallCostEffectivenessDollarValueAddedMeanList = Value_Added_per_Total_Cost_of_People.mean()

# 32 - Overall Cost Effectiveness – Dollar Revenue/Cost of Company’s People
Revenue_per_Total_Cost_of_People = comp['overall_cost_dollar_revenue_cost']
overallCostEffectivenessDollarRevenueQuantileList = Revenue_per_Total_Cost_of_People.quantile([0.25, 0.5, 0.75]).tolist()
overallCostEffectivenessDollarRevenueMeanList = Revenue_per_Total_Cost_of_People.mean()

# 31 - Supporting Employees Profitability Measurement: Dollar Net Profit / FTEs of Supporting Employees
Net_Profit_per_FTE_of_Supporting_Employees = comp['supporting_employee_dollar_net_profit_added_fte']
supportingEmployeeDollarNetProfitFteQuantileList = Net_Profit_per_FTE_of_Supporting_Employees.quantile([0.25, 0.5, 0.75]).tolist()
supportingEmployeeDollarNetProfitFteMeanList = Net_Profit_per_FTE_of_Supporting_Employees.mean()

#30 - Supporting Employees Productivity Measurement: Dollar Value Added/ FTEs of Supporting Employees

#29 - Supporting Employees Productivity Measurement: Dollar Revenue/ FTEs of Supporting Employees 

#28 - Craft Worker Profitability Measurement: Dollar Net Profit / FTEs of Bargaining Unit Employees 

#27 - Craft Worker Productivity Measurement: Dollar Value Added/ FTEs of Bargaining Unit 

#26 - Craft Worker Productivity Measurement: Dollar Revenue/ FTEs of Bargaining Unit Employees 

#25 - Project Management Profitability Measurement: Dollar Net Profit /FTEs of Project Management Personnel 

#24 - Project Management Productivity Measurement: Dollar Value Added/FTEs of Project Management
