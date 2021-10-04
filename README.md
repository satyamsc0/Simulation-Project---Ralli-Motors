# Simulation-Project---Ralli-Motors
This project is all about Data Integration. It involved all the ETL (Extract, Transform and Load) operations. In this project, the ETL was done once by using SQL queries and once by using SSIS (SQL Server Integration Services)


TABLE OF CONTENTS

1.Summary:

1.1. Company Overview
1.2.  Models
1.3.  Service Policy
1.4.  Project Overview

2.Business Requirements:

2.1.  Business Pain
2.2.  Reports
2.3.  Summary

------------------------------------------


1SUMMARY

1.1Company Overview


Rally Motors, Inc. is an American automotive  that designs, manufactures, and sells electric cars. It has base across North America, Europe and Asia. 
 

Rally Motors has been proud to state its focus is on selling cars and not trying to make profit from their service centers


1.2Models

The models are:

1.Model 1
2.Model 2
3.Model 3


Service Policy
      Rally vehicle is protected by a 4 year, 50,000 miles (whichever comes first) new vehicle limited warranty and 8 year, unlimited mile battery and drive unit warranty. 

3 year prepaid service
4 year prepaid service
8 year prepaid service

RALLY Annual Service Inspection:
      Unlike gasoline cars, Rally vehicles requires no oil changes, fuel filter, spark plug replacements, or emission checks. As an electric car, 
      even brake pad replacements are rare because most braking energy is re-generatively captured by the motor and returned to the battery. 
      Our inspections instead focuses on checking wheel alignment and tire condition, replacement parts like key batteries, windshield wiper blades, and software updates.



Project Overview

Scope:  
      In the first phase of project, the objective is to design and develop Service DataMart that supports key operations and management reports 
      and related analysis identified by the business groups in decision making. Source data resides across systems. Our primary scope is to develop 
      a single system with holds entire data to manage key operations of the business. Data extraction, transformation and loading (ETL) process to populate 
      Service data mart will also be built using Informatica as the ETL tool. The source and target Database will be SQL server. Flat files can also be source for the database. 

The data mart should support adhoc querying, drill paths, hierarchies with a solid foundation.

The key Tables are 

Customer
Location
Part
User
Vehicle
Order
Orderjob
Orderjobservicecorrection
Orderjobservicecorrectionpart
CustomerComplaint
CustomerComplaintdetail

The time dimension week is defined as Sunday through Saturday.  
Fiscal and accounting year are treated as same.


Business Pains:

Address the Service duration delay.
Track the performance of Service Centers and provide best customer service (Customer Satisfaction)
Identify repeated Symptoms to do a permanent fix.

Reports

This section provides set of reports, categorized by relevant subject area, to solve the business pain areas.

Service Center Wise/Weekly Daily Turnaround. Consolidated at Region and Market level.
Critical Symptoms (VOR) cars list daily.
Repeat Visits in a period of week/month.
Order Aging.
Orders Created within 3 days of delivery.
Repetitive critical symptoms/Complaints.
Top 20 Parts with frequent issues.

Summary
      The objective of the company is to track the performance of the Service Centers and Customer Satisfaction. 
      The users have provided requirements for set of reports that would provide them with necessary information and analysis, 
      to identify the performance in respective localities that helps in decision making. 
