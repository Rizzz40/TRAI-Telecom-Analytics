# TRAI Telecom Analytics

An end-to-end telecom analytics project built from **TRAI Performance
Monitoring Report (PMR)** data to analyze network performance, customer
experience, Licensed Service Area (LSA) performance, and reporting
completeness across Indian telecom service providers.

## Project Overview

This project creates a traceable analytics workflow from semi-structured
telecom reporting to an interactive business intelligence solution.

**Reporting period:** July 2025 -- July 2026\
**Service providers:** AIRTEL, BSNL, MTNL, RJIL, VIL\
**Licensed Service Areas:** 22\
**Network QoS records:** 1,144\
**Speed/Tariff records:** 2,618

## Business Questions

-   How do providers compare on availability, latency, packet drop,
    dropped calls, and speed?
-   How does customer-service performance vary across providers and
    months?
-   Which LSAs show stronger or weaker network performance?
-   Are important network KPIs consistently reported?
-   Which findings warrant operational or data-governance investigation?

## Technology Stack

  -----------------------------------------------------------------------
  Layer                   Technology              Purpose
  ----------------------- ----------------------- -----------------------
  Data preparation        Microsoft Excel + Power PDF extraction,
                          Query                   consolidation,
                                                  cleaning,
                                                  reconciliation,
                                                  validation

  Data layer              Microsoft SQL Server +  Structured tables,
                          SSMS                    validation queries,
                                                  transformations,
                                                  analytical views

  Visualization           Microsoft Power BI +    Data modeling, KPI
                          DAX                     calculations,
                                                  interactive analysis,
                                                  dashboards
  -----------------------------------------------------------------------

## End-to-End Workflow

1.  Collected TRAI PMR source reports.
2.  Extracted and consolidated semi-structured PDF tables using Power
    Query.
3.  Validated missing rows, `NA` values, providers, LSAs, reporting
    months, and record counts.
4.  Loaded the cleaned datasets into SQL Server.
5.  Created analytical SQL views for monthly, provider, LSA, and
    reporting-completeness analysis.
6.  Connected Power BI to the analytical layer and created the reporting
    model.
7.  Developed DAX measures, KPI benchmarks, and four dashboard pages.
8.  Investigated provider, monthly, geographic, and data-quality
    patterns.
9.  Converted the analysis into business findings and recommendations.

## Power BI Dashboards

### 1. Network Performance & Service Quality

Network availability, typical/P80 speed, latency, packet drop,
dropped-call rates, and service accessibility.

### 2. Customer Experience & Service Quality

Billing complaints, complaint trends, call connection quality,
customer-care accessibility, and calls answered within 90 seconds.

### 3. LSA & Geographic Performance

Performance comparison across 22 LSAs, geographic network-quality
mapping, and regional/provider drill-down.

### 4. Data Quality & Reporting Completeness

Provider reporting completeness, monthly completeness trends, missing
network-performance records, and overall metric reporting status.

## Key Findings

-   Average latency improved from **31.69 ms** in July 2025 to **26.63
    ms** in July 2026.
-   Average packet drop declined from **0.76%** to **0.50%**.
-   Average network availability remained around **99.9%**.
-   **RJIL** led average typical download speed at **28.21 Mbps**,
    followed by AIRTEL at **18.34 Mbps** and VIL at **15.00 Mbps**.
-   **VIL** recorded the highest average calls answered within 90
    seconds at **99.90%**.
-   **BSNL** contributed **15 of 18** individual observations below the
    95% call-answering benchmark.
-   **NE, AS, and WB** showed the highest average latency, while **BR,
    UPE, and GJ** were among the strongest LSAs for typical download
    speed.
-   DCR-CS was missing for all **286 RJIL network records**, resulting
    in **75% overall DCR-CS reporting completeness**.
-   MTNL also had missing DCR-PS, latency, and packet-drop values.

## Data Quality Approach

Missing data was treated as an analytical issue rather than
automatically converted to zero or estimated.

**Issue → Detection → Investigation → Decision → Correction →
Validation**

Examples include reconciliation of PDF extraction gaps, correct
treatment of `NA` values, investigation of the RJIL DCR-CS reporting
gap, and identification of sparse MTNL network reporting.

## SQL Analytical Layer

-   `vw_Monthly_Provider_Performance`
-   `vw_LSA_Provider_Performance`
-   `vw_Provider_Performance_Summary`
-   `vw_Provider_Data_Coverage`

These views support provider, monthly, geographic, and
reporting-completeness analysis in Power BI.

## Selected Analytical Benchmarks

  Metric                               Reference Direction
  ---------------------------------- ----------- ------------------
  Network Availability                     ≥ 99% Higher is better
  Latency                                ≤ 75 ms Lower is better
  Packet Drop Rate                          ≤ 3% Lower is better
  DCR-CS / DCR-PS                           ≤ 2% Lower is better
  Billing Complaints                      ≤ 0.1% Lower is better
  Customer Care Accessibility              ≥ 95% Higher is better
  Calls Answered Within 90 Seconds         ≥ 95% Higher is better
  Inter-provider Call Setup                ≥ 95% Higher is better

Typical download/upload speed is analyzed descriptively rather than
treated as a formal regulatory threshold in this project.

## Public Repository Structure

TRAI-Telecom-Analytics
├── 01_Raw_Data
│   └── README.md
├── 03_SQL
│   └── final SQL script
├── 04_Excel
│   └── final analytical workbook
├── 05_PowerBI
│   └── final Power BI report
├── 06_Analysis
│   └── analysis report
├── 07_Documentation
│   └── technical/project documentation
├── 08_Final_Portfolio
│   └── recruiter-facing case study
├── README.md
└── .gitignore

Internal working material and source files excluded from the final
analytical model are intentionally omitted from the public repository.

## Business Recommendations

-   Prioritize drill-down analysis for higher-latency LSAs such as NE,
    AS, and WB.
-   Investigate BSNL customer-care queue, staffing, and peak-demand
    patterns behind below-benchmark call-answering observations.
-   Use provider-level speed differences to investigate capacity, tariff
    mix, and service-plan composition.
-   Treat reporting completeness as a governance KPI before direct
    provider comparisons.
-   Resolve recurring source-reporting gaps rather than replacing
    missing telecom KPI values with estimates.
-   Retain Excel/Power Query and SQL as an auditable preparation and
    transformation trail behind Power BI.

## Skills Demonstrated

**Data Preparation:** Excel, Power Query, semi-structured PDF
extraction, cleaning, reconciliation, validation\
**Database & Analysis:** SQL Server, SSMS, SQL views, aggregation,
data-quality validation\
**Business Intelligence:** Power BI, DAX, data modeling, KPI design,
geographic analysis, dashboard development\
**Analytics:** Trend analysis, provider benchmarking, LSA analysis,
root-cause investigation, reporting completeness\
**Business Communication:** Executive reporting, insight generation,
recommendations, technical documentation

## Project Documentation

-   `06_Analysis` --- validated findings, insights, recommendations, and
    limitations
-   `07_Documentation` --- methodology, data inventory, model
    documentation, data-quality log, benchmarks, and workflow
-   `08_Final_Portfolio` --- recruiter-facing project case study

## Data & Usage Note

This portfolio project is based on publicly available telecom reporting
data. Source reports remain attributable to their original publisher.
Repository contents should be used for analytical/portfolio
demonstration, and source data should not be represented as original
work.

## Project Status

**Complete** --- data preparation, SQL modeling, Power BI reporting,
analysis, documentation, and portfolio packaging have been finalized.
**Complete** --- data preparation, SQL modeling, Power BI reporting,
analysis, documentation, and portfolio packaging have been finalized.
