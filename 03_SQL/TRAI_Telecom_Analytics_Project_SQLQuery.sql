--Project: TRAI_Telecom_Analytics
--Creating Database TRAI_Telecom_Analytics
CREATE DATABASE TRAI_Telecom_Analytics;
GO

--Switching to the Database
USE TRAI_Telecom_Analytics;
GO

--Creating all 3 Tables
CREATE TABLE Network_QoS (
    ReportingMonth DATE NOT NULL,
    S_No INT NOT NULL,
    ServiceProvider VARCHAR(50) NOT NULL,
    LSA VARCHAR(10) NOT NULL,
    NetworkMapAvailability_Pct DECIMAL(10,2),
    CumulativeDowntime_Pct DECIMAL(10,2),
    WorstAffectedCells_Pct DECIMAL(10,2),
    SignificantOutageReporting_Pct DECIMAL(10,2),
    IntraProviderCallSetupSuccess_Pct DECIMAL(10,2),
    InterProviderCallSetupSuccess_Pct DECIMAL(10,2),
    POICongestion_Pct DECIMAL(10,2),
    DCR_CS_Pct DECIMAL(10,2),
    DCR_PS_Pct DECIMAL(10,2),
    DownlinkPacketDrop_Pct DECIMAL(10,2),
    UplinkPacketDrop_Pct DECIMAL(10,2),
    Latency_ms DECIMAL(10,2),
    PacketDropRate_Pct DECIMAL(10,2),

    CONSTRAINT PK_Network_QoS
        PRIMARY KEY (ReportingMonth, ServiceProvider, LSA)
);
GO


CREATE TABLE Customer_QoS (
    ReportingMonth DATE NOT NULL,
    S_No INT NOT NULL,
    ServiceProvider VARCHAR(50) NOT NULL,
    LSA VARCHAR(10) NOT NULL,
    BillingChargingComplaints_Pct DECIMAL(10,2),
    BillingChargingResolution_4Weeks_Pct DECIMAL(10,2),
    CustomerAccountAdjustment_1Week_Pct DECIMAL(10,2),
    CustomerCareAccessibility_Pct DECIMAL(10,2),
    CallsAnswered_90Sec_Pct DECIMAL(10,2),
    ComplaintClosure_7WorkingDays_Pct DECIMAL(10,2),
    DepositRefund_45Days_Pct DECIMAL(10,2),

    CONSTRAINT PK_Customer_QoS
        PRIMARY KEY (ReportingMonth, ServiceProvider, LSA)
);
GO


CREATE TABLE SpeedTarrif_QoS (
    ReportingMonth DATE NOT NULL,
    S_No INT NOT NULL,
    ServiceProvider VARCHAR(50) NOT NULL,
    LSA VARCHAR(10) NOT NULL,
    TariffOffering VARCHAR(255) NOT NULL,
    TypicalDownloadSpeed_Mbps DECIMAL(12,2),
    DownloadSpeed_P80_Mbps DECIMAL(12,2),
    TypicalUploadSpeed_Mbps DECIMAL(12,2),
    UploadSpeed_P80_Mbps DECIMAL(12,2),

    CONSTRAINT PK_SpeedTarrif_QoS
        PRIMARY KEY (ReportingMonth, ServiceProvider, LSA, TariffOffering)
);
GO

--Verify that the tables were created
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

/*Imported Excel data from Database (TRAI_Telecom_Analytics) > Right Click > Task > Import Data > Next > 
  Choose Data Source (Microsoft Excel) > Select File Path > Select Excel Version > Next > Destination SQL Server selction page >
  Microsoft OLE DB Provider for SQL Server > Windows Authentication > Next > Selct Tables > Next > Finsh*/

--Verify the actual SQL row counts of imported tables
SELECT 'Network_QoS' AS TableName, COUNT(*) AS Row_Count
FROM dbo.Network_QoS

UNION ALL

SELECT 'Customer_QoS', COUNT(*)
FROM dbo.Customer_QoS

UNION ALL

SELECT 'SpeedTarrif_QoS', COUNT(*)
FROM dbo.SpeedTarrif_QoS;

--It shows 0 rows because Excel Import Wizard fetched data from sheets so it added extra $ sign after each table and created new tables.
USE TRAI_Telecom_Analytics;
GO

SELECT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

--Since our created tables have schema as per our r equirement so we will move data from accidently created tables ($) to our tables
INSERT INTO dbo.Network_QoS (
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    NetworkMapAvailability_Pct,
    CumulativeDowntime_Pct,
    WorstAffectedCells_Pct,
    SignificantOutageReporting_Pct,
    IntraProviderCallSetupSuccess_Pct,
    InterProviderCallSetupSuccess_Pct,
    POICongestion_Pct,
    DCR_CS_Pct,
    DCR_PS_Pct,
    DownlinkPacketDrop_Pct,
    UplinkPacketDrop_Pct,
    Latency_ms,
    PacketDropRate_Pct
)
SELECT
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    NetworkMapAvailability_Pct,
    CumulativeDowntime_Pct,
    WorstAffectedCells_Pct,
    SignificantOutageReporting_Pct,
    IntraProviderCallSetupSuccess_Pct,
    InterProviderCallSetupSuccess_Pct,
    POICongestion_Pct,
    DCR_CS_Pct,
    DCR_PS_Pct,
    DownlinkPacketDrop_Pct,
    UplinkPacketDrop_Pct,
    Latency_ms,
    PacketDropRate_Pct
FROM dbo.Network_QoS$;
GO

--Let's verify the data after above command
SELECT COUNT(*) AS Network_Rows
FROM dbo.Network_QoS;

--Let's do the same steps for next table
INSERT INTO dbo.Customer_QoS (
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    BillingChargingComplaints_Pct,
    BillingChargingResolution_4Weeks_Pct,
    CustomerAccountAdjustment_1Week_Pct,
    CustomerCareAccessibility_Pct,
    CallsAnswered_90Sec_Pct,
    ComplaintClosure_7WorkingDays_Pct,
    DepositRefund_45Days_Pct
)
SELECT
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    BillingChargingComplaints_Pct,
    BillingChargingResolution_4Weeks_Pct,
    CustomerAccountAdjustment_1Week_Pct,
    CustomerCareAccessibility_Pct,
    CallsAnswered_90Sec_Pct,
    ComplaintClosure_7WorkingDays_Pct,
    DepositRefund_45Days_Pct
FROM dbo.Customer_QoS$;
GO

--Let's do the same steps for last table
INSERT INTO dbo.SpeedTarrif_QoS (
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    TariffOffering,
    TypicalDownloadSpeed_Mbps,
    DownloadSpeed_P80_Mbps,
    TypicalUploadSpeed_Mbps,
    UploadSpeed_P80_Mbps
)
SELECT
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    TariffOffering,
    TypicalDownloadSpeed_Mbps,
    DownloadSpeed_P80_Mbps,
    TypicalUploadSpeed_Mbps,
    UploadSpeed_P80_Mbps
FROM dbo.SpeedTarrif_QoS$;
GO

/*Got error in this file while transferring data because of duplicates in original files so we need to fix our schema (primary key)
  in destination table*/
--Verifying if we have duplicates
SELECT
    ReportingMonth,
    ServiceProvider,
    LSA,
    TariffOffering,
    COUNT(*) AS DuplicateCount
FROM dbo.SpeedTarrif_QoS$
GROUP BY
    ReportingMonth,
    ServiceProvider,
    LSA,
    TariffOffering
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;

/*Following SQL script will:
Remove the incorrect primary key.
Create the correct primary key including S_No.
Import all 2,618 rows from the staging table.
Verify the count.*/

USE TRAI_Telecom_Analytics;
GO

-- 1. Remove current primary key
ALTER TABLE dbo.SpeedTarrif_QoS
DROP CONSTRAINT PK_SpeedTarrif_QoS;
GO

-- 2. Create corrected primary key
ALTER TABLE dbo.SpeedTarrif_QoS
ADD CONSTRAINT PK_SpeedTarrif_QoS
PRIMARY KEY (
    ReportingMonth,
    ServiceProvider,
    LSA,
    TariffOffering,
    S_No
);
GO

-- 3. Import all source rows
INSERT INTO dbo.SpeedTarrif_QoS (
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    TariffOffering,
    TypicalDownloadSpeed_Mbps,
    DownloadSpeed_P80_Mbps,
    TypicalUploadSpeed_Mbps,
    UploadSpeed_P80_Mbps
)
SELECT
    ReportingMonth,
    S_No,
    ServiceProvider,
    LSA,
    TariffOffering,
    TypicalDownloadSpeed_Mbps,
    DownloadSpeed_P80_Mbps,
    TypicalUploadSpeed_Mbps,
    UploadSpeed_P80_Mbps
FROM dbo.SpeedTarrif_QoS$;
GO

-- 4. Verify
SELECT COUNT(*) AS Row_Count
FROM dbo.SpeedTarrif_QoS;
GO


--Validation of all files to match data
USE TRAI_Telecom_Analytics;
GO

SELECT 'Network_QoS' AS Table_Name, COUNT(*) AS Row_Count
FROM dbo.Network_QoS
UNION ALL
SELECT 'Network_QoS$', COUNT(*)
FROM dbo.Network_QoS$
UNION ALL
SELECT 'Customer_QoS', COUNT(*)
FROM dbo.Customer_QoS
UNION ALL
SELECT 'Customer_QoS$', COUNT(*)
FROM dbo.Customer_QoS$
UNION ALL
SELECT 'SpeedTarrif_QoS', COUNT(*)
FROM dbo.SpeedTarrif_QoS
UNION ALL
SELECT 'SpeedTarrif_QoS$', COUNT(*)
FROM dbo.SpeedTarrif_QoS$;

--Matched successfully, let's drop the $ tables
DROP TABLE dbo.Network_QoS$;
DROP TABLE dbo.Customer_QoS$;
DROP TABLE dbo.SpeedTarrif_QoS$;

--Let's validate the SQL data now

USE TRAI_Telecom_Analytics;
GO

-- 1. Row counts
SELECT 'Network_QoS' AS Table_Name, COUNT(*) AS Row_Count
FROM dbo.Network_QoS
UNION ALL
SELECT 'Customer_QoS', COUNT(*)
FROM dbo.Customer_QoS
UNION ALL
SELECT 'SpeedTarrif_QoS', COUNT(*)
FROM dbo.SpeedTarrif_QoS;


-- 2. Date range
SELECT
    MIN(ReportingMonth) AS Min_Month,
    MAX(ReportingMonth) AS Max_Month
FROM dbo.Network_QoS;


-- 3. Service providers
SELECT DISTINCT ServiceProvider
FROM dbo.Network_QoS
ORDER BY ServiceProvider;


-- 4. LSAs
SELECT DISTINCT LSA
FROM dbo.Network_QoS
ORDER BY LSA;


-- 5. NULL check - Network
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN NetworkMapAvailability_Pct IS NULL THEN 1 ELSE 0 END) AS Missing_NetworkMap,
    SUM(CASE WHEN Latency_ms IS NULL THEN 1 ELSE 0 END) AS Missing_Latency
FROM dbo.Network_QoS;


-- 6. NULL check - Customer
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN BillingChargingComplaints_Pct IS NULL THEN 1 ELSE 0 END) AS Missing_BillingComplaints,
    SUM(CASE WHEN CallsAnswered_90Sec_Pct IS NULL THEN 1 ELSE 0 END) AS Missing_CallsAnswered
FROM dbo.Customer_QoS;


-- 7. NULL check - Speed/Tariff
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN TypicalDownloadSpeed_Mbps IS NULL THEN 1 ELSE 0 END) AS Missing_Download,
    SUM(CASE WHEN TypicalUploadSpeed_Mbps IS NULL THEN 1 ELSE 0 END) AS Missing_Upload
FROM dbo.SpeedTarrif_QoS;

/*Find the null values (there were NA values in original data and we replaced them with blank, these Null values are those same blanks.)
  The 286 DCR-CS NULLs deserve attention because that's a substantial amount, but it doesn't mean the data is bad.
  We should investigate why TRAI didn't report that metric for those records.
  303 missing Billing Charging Resolution values is significant and should be documented.

Our decision:
Do nothing to the NULLs. ✅
Our data-cleaning rule will be:
Original NA/blank → SQL NULL; never convert missing values to zero.
This is actually an important part of our project methodology because it preserves the distinction between "not reported" and "zero."
We can handle NULLs appropriately later in SQL/Power BI using measures that ignore missing observations rather than treating them as
failures.*/

USE TRAI_Telecom_Analytics;
GO

-- Network NULLs
SELECT
    SUM(CASE WHEN NetworkMapAvailability_Pct IS NULL THEN 1 ELSE 0 END) AS NetworkMapAvailability,
    SUM(CASE WHEN CumulativeDowntime_Pct IS NULL THEN 1 ELSE 0 END) AS CumulativeDowntime,
    SUM(CASE WHEN WorstAffectedCells_Pct IS NULL THEN 1 ELSE 0 END) AS WorstAffectedCells,
    SUM(CASE WHEN SignificantOutageReporting_Pct IS NULL THEN 1 ELSE 0 END) AS SignificantOutageReporting,
    SUM(CASE WHEN IntraProviderCallSetupSuccess_Pct IS NULL THEN 1 ELSE 0 END) AS IntraProviderCallSetupSuccess,
    SUM(CASE WHEN InterProviderCallSetupSuccess_Pct IS NULL THEN 1 ELSE 0 END) AS InterProviderCallSetupSuccess,
    SUM(CASE WHEN POICongestion_Pct IS NULL THEN 1 ELSE 0 END) AS POICongestion,
    SUM(CASE WHEN DCR_CS_Pct IS NULL THEN 1 ELSE 0 END) AS DCR_CS,
    SUM(CASE WHEN DCR_PS_Pct IS NULL THEN 1 ELSE 0 END) AS DCR_PS,
    SUM(CASE WHEN DownlinkPacketDrop_Pct IS NULL THEN 1 ELSE 0 END) AS DownlinkPacketDrop,
    SUM(CASE WHEN UplinkPacketDrop_Pct IS NULL THEN 1 ELSE 0 END) AS UplinkPacketDrop,
    SUM(CASE WHEN Latency_ms IS NULL THEN 1 ELSE 0 END) AS Latency,
    SUM(CASE WHEN PacketDropRate_Pct IS NULL THEN 1 ELSE 0 END) AS PacketDropRate
FROM dbo.Network_QoS;


-- Customer NULLs
SELECT
    SUM(CASE WHEN BillingChargingComplaints_Pct IS NULL THEN 1 ELSE 0 END) AS BillingComplaints,
    SUM(CASE WHEN BillingChargingResolution_4Weeks_Pct IS NULL THEN 1 ELSE 0 END) AS BillingResolution,
    SUM(CASE WHEN CustomerAccountAdjustment_1Week_Pct IS NULL THEN 1 ELSE 0 END) AS AccountAdjustment,
    SUM(CASE WHEN CustomerCareAccessibility_Pct IS NULL THEN 1 ELSE 0 END) AS CustomerCareAccessibility,
    SUM(CASE WHEN CallsAnswered_90Sec_Pct IS NULL THEN 1 ELSE 0 END) AS CallsAnswered,
    SUM(CASE WHEN ComplaintClosure_7WorkingDays_Pct IS NULL THEN 1 ELSE 0 END) AS ComplaintClosure,
    SUM(CASE WHEN DepositRefund_45Days_Pct IS NULL THEN 1 ELSE 0 END) AS DepositRefund
FROM dbo.Customer_QoS;

/*SQL ANALYSIS

We'll build the business questions first, such as:

Which telecom provider performs best overall?
Which provider performs best/worst by LSA?
How does QoS change month-to-month?
Which network KPIs are causing poor performance?
Which providers have the best customer-service performance?
Which tariff plans offer the best speeds?
Are there persistent regional performance problems?
Which provider/LSA combinations need attention?*/


/*Phase 1 — Provider performance
Our first business question:
Which telecom provider performs best overall across the network QoS metrics?
We'll start with a simple provider-level summary*/

--Network QoS metrics

USE TRAI_Telecom_Analytics;
GO

SELECT
    ServiceProvider,

    ROUND(AVG(NetworkMapAvailability_Pct), 2) AS Avg_NetworkAvailability,
    ROUND(AVG(CumulativeDowntime_Pct), 2) AS Avg_CumulativeDowntime,
    ROUND(AVG(WorstAffectedCells_Pct), 2) AS Avg_WorstAffectedCells,
    ROUND(AVG(SignificantOutageReporting_Pct), 2) AS Avg_OutageReporting,
    ROUND(AVG(IntraProviderCallSetupSuccess_Pct), 2) AS Avg_IntraCallSetupSuccess,
    ROUND(AVG(InterProviderCallSetupSuccess_Pct), 2) AS Avg_InterCallSetupSuccess,
    ROUND(AVG(POICongestion_Pct), 2) AS Avg_POICongestion,
    ROUND(AVG(DCR_CS_Pct), 2) AS Avg_DCR_CS,
    ROUND(AVG(DCR_PS_Pct), 2) AS Avg_DCR_PS,
    ROUND(AVG(DownlinkPacketDrop_Pct), 2) AS Avg_DownlinkPacketDrop,
    ROUND(AVG(UplinkPacketDrop_Pct), 2) AS Avg_UplinkPacketDrop,
    ROUND(AVG(Latency_ms), 2) AS Avg_Latency_ms,
    ROUND(AVG(PacketDropRate_Pct), 2) AS Avg_PacketDropRate

FROM dbo.Network_QoS

GROUP BY ServiceProvider
ORDER BY ServiceProvider;

--Next query: data coverage by provider

SELECT
    ServiceProvider,
    COUNT(*) AS Total_Rows,

    COUNT(DCR_CS_Pct) AS DCR_CS_Reported,
    COUNT(DCR_PS_Pct) AS DCR_PS_Reported,
    COUNT(DownlinkPacketDrop_Pct) AS DownlinkPacketDrop_Reported,
    COUNT(UplinkPacketDrop_Pct) AS UplinkPacketDrop_Reported,
    COUNT(Latency_ms) AS Latency_Reported,
    COUNT(PacketDropRate_Pct) AS PacketDropRate_Reported

FROM dbo.Network_QoS
GROUP BY ServiceProvider
ORDER BY ServiceProvider;

/*Next: First real business analysis

Let's determine how many records each provider has by month. This will tell us whether MTNL's 26 records are because it genuinely
had fewer observations or because of something else.*/

SELECT
    ReportingMonth,
    ServiceProvider,
    COUNT(*) AS Record_Count
FROM dbo.Network_QoS
GROUP BY
    ReportingMonth,
    ServiceProvider
ORDER BY
    ReportingMonth,
    ServiceProvider;
/*We have 13 months × 5 providers, with:

AIRTEL: 22 LSAs/month
BSNL: 20 LSAs/month
MTNL: 2 LSAs/month
RJIL: 22 LSAs/month
VIL: 22 LSAs/month

So the lower MTNL count is not missing data. MTNL simply has 2 LSAs in this dataset.*/

--Network Availability
USE TRAI_Telecom_Analytics;
GO

SELECT
    ServiceProvider,
    ROUND(AVG(NetworkMapAvailability_Pct), 2) AS Avg_Network_Availability,
    MIN(NetworkMapAvailability_Pct) AS Worst_Network_Availability,
    MAX(NetworkMapAvailability_Pct) AS Best_Network_Availability
FROM dbo.Network_QoS
GROUP BY ServiceProvider
ORDER BY Avg_Network_Availability DESC;

/*AIRTEL, MTNL, RJIL, VIL: 100% average network availability across their reported records.
  BSNL: 99.54% average, with a minimum of 99%.
  So Network Availability alone doesn't meaningfully differentiate 4 of the 5 providers.*/

--Call Setup Success
SELECT
    ServiceProvider,
    ROUND(AVG(IntraProviderCallSetupSuccess_Pct), 2) AS Avg_IntraProvider_CallSetup,
    ROUND(AVG(InterProviderCallSetupSuccess_Pct), 2) AS Avg_InterProvider_CallSetup
FROM dbo.Network_QoS
GROUP BY ServiceProvider
ORDER BY Avg_IntraProvider_CallSetup DESC;

/*🥇 VIL has the best intra-provider call setup success at 99.83%.
  🥇 AIRTEL has the best inter-provider performance at 99.19%, although the difference from VIL/RJIL is tiny.
  MTNL is the weakest on both measures, particularly inter-provider calls at 96.91%.
  BSNL is also below the other three major providers.
  Overall, VIL, RJIL and AIRTEL are very close to 99%+, so this metric strongly differentiates MTNL more than the others.*/

--Call Drop Rate
SELECT
    ServiceProvider,
    ROUND(AVG(DCR_CS_Pct), 2) AS Avg_DCR_CS,
    ROUND(AVG(DCR_PS_Pct), 2) AS Avg_DCR_PS
FROM dbo.Network_QoS
GROUP BY ServiceProvider
ORDER BY Avg_DCR_CS;

/*  RJIL has the lowest reported DCR-PS at 0.52% → strongest among providers with DCR-PS data.
    AIRTEL has the lowest DCR-CS at 1.35% among providers reporting it.
    VIL has the highest reported DCR-CS (1.66%) and DCR-PS (1.34%).
    MTNL and RJIL have missing metrics by design/source reporting: MTNL has no DCR-PS data, while RJIL has no DCR-CS data.
    Lower DCR is better.*/

--Network Congestion & Packet Loss
SELECT
    ServiceProvider,
    ROUND(AVG(POICongestion_Pct), 2) AS Avg_POI_Congestion,
    ROUND(AVG(DownlinkPacketDrop_Pct), 2) AS Avg_Downlink_PacketDrop,
    ROUND(AVG(UplinkPacketDrop_Pct), 2) AS Avg_Uplink_PacketDrop,
    ROUND(AVG(PacketDropRate_Pct), 2) AS Avg_PacketDropRate
FROM dbo.Network_QoS
GROUP BY ServiceProvider
ORDER BY Avg_POI_Congestion;

/*  RJIL looks strongest overall for packet-loss performance, with 0% downlink drop and 0% packet-drop rate. Its uplink drop is also relatively low at 0.72%.
    VIL is also strong, particularly with only 0.18% packet-drop rate and the lowest reported uplink drop among providers with data.
    AIRTEL has noticeably higher packet loss, especially 1.39% uplink drop.
    BSNL has the highest POI congestion (0.04%) but relatively low downlink drop.
    MTNL cannot be compared on packet-loss metrics because those values were not reported at all.*/

--Latency
SELECT
    ServiceProvider,
    ROUND(AVG(Latency_ms), 2) AS Avg_Latency_ms
FROM dbo.Network_QoS
GROUP BY ServiceProvider
ORDER BY Avg_Latency_ms;

/*  🥇 RJIL is clearly the strongest with just 10.40 ms average latency.
    AIRTEL is second at 27.82 ms.
    VIL follows at 35.02 ms.
    BSNL has the highest reported latency at 48.22 ms, indicating slower network response.
    MTNL has no latency data, so we should not rank it.*/

/*  Current Network QoS picture

    We're starting to see a meaningful story:

    RJIL

    Excellent call setup
    Lowest DCR-PS
    Lowest packet loss
    Lowest latency
    → Very strong network-performance profile.

    AIRTEL

    Excellent call setup
    Best DCR-CS
    Good latency
    Somewhat higher packet loss
    → Strong and balanced, but packet loss is an area to watch.

    VIL

    Best intra-provider call setup
    Good packet-loss performance
    Higher DCR and latency
    → Strong in some QoS areas, weaker in others.

    BSNL

    Lower call setup success
    Higher latency
    Mixed packet-loss results
    → More noticeable performance gaps.

    MTNL

    Lower call setup success
    No data for several network metrics
    → Limited comparability because of reporting coverage.
*/

--Customer QoS metrics
--Customer complaints and service accessibility

SELECT
    ServiceProvider,
    ROUND(AVG(BillingChargingComplaints_Pct), 2) AS Avg_Billing_Complaints,
    ROUND(AVG(BillingChargingResolution_4Weeks_Pct), 2) AS Avg_Billing_Resolution,
    ROUND(AVG(CustomerAccountAdjustment_1Week_Pct), 2) AS Avg_Account_Adjustment,
    ROUND(AVG(CustomerCareAccessibility_Pct), 2) AS Avg_CustomerCare_Accessibility
FROM dbo.Customer_QoS
GROUP BY ServiceProvider
ORDER BY Avg_Billing_Complaints;

/*  RJIL has zero average billing/charging complaints in the dataset.
    All five providers show 100% billing complaint resolution within 4 weeks and 100% account adjustment within 1 week.
    AIRTEL and MTNL have the highest customer-care accessibility at 99.62%.
    BSNL is noticeably lower at 98.44%, making it the weakest on this measure.
    Because billing resolution and account adjustment are 100% for every provider, they won't help differentiate providers,
    but they are still useful as compliance/service-quality KPIs.
*/

--Calls answered within 90 seconds, complaint closure, and deposit refunds:
SELECT
    ServiceProvider,
    ROUND(AVG(CallsAnswered_90Sec_Pct), 2) AS Avg_Calls_Answered_90Sec,
    ROUND(AVG(ComplaintClosure_7WorkingDays_Pct), 2) AS Avg_Complaint_Closure,
    ROUND(AVG(DepositRefund_45Days_Pct), 2) AS Avg_Deposit_Refund
FROM dbo.Customer_QoS
GROUP BY ServiceProvider
ORDER BY Avg_Calls_Answered_90Sec DESC;

/*  🥇 VIL is the clear leader in call-answer responsiveness at 99.90%.
    RJIL is also very strong at 99.36%.
    BSNL is the weakest at 95.67%, a gap of 4.23 percentage points versus VIL.
    Complaint closure and deposit refunds are 100% for every provider, so again they are compliance indicators rather than differentiators.

    This is actually shaping into a strong project story:

    Network performance and customer-service performance tell different stories.

    For example, RJIL looks strongest on network metrics, while VIL is strongest on customer-service responsiveness.
*/

--SpeedTariff QoS
--Speed & Tariff data
SELECT
    ServiceProvider,
    ROUND(AVG(TypicalDownloadSpeed_Mbps), 2) AS Avg_Typical_Download,
    ROUND(AVG(DownloadSpeed_P80_Mbps), 2) AS Avg_Download_P80,
    ROUND(AVG(TypicalUploadSpeed_Mbps), 2) AS Avg_Typical_Upload,
    ROUND(AVG(UploadSpeed_P80_Mbps), 2) AS Avg_Upload_P80
FROM dbo.SpeedTarrif_QoS
GROUP BY ServiceProvider
ORDER BY Avg_Typical_Download DESC;

/*  Key findings
    🥇 RJIL dominates download performance:
    Typical download: 28.21 Mbps
    P80 download: 277.92 Mbps
    AIRTEL is the closest competitor on download speed.
    VIL has strong typical upload speed (8.00 Mbps) and is close to RJIL.
    AIRTEL has the highest P80 upload speed at 38.99 Mbps, narrowly ahead of RJIL.
    BSNL and MTNL are substantially behind the other providers on both download and upload performance.
    MTNL's typical download speed is only about 10% of RJIL's (2.94 vs 28.21 Mbps).
    One important analytical point

    Don't treat P80 as "average speed."

    Think of it like this:

    Metric	Simple meaning
    Typical Speed	What users generally experience
    P80 Speed	Speed at the 80th percentile — shows the upper-performance side of the distribution

    This gives our dashboard a much richer story than simply saying "Provider X is fastest."
*/


/*  We have now completed the core provider-level analysis.

    Before we start building the final SQL analytical layer, I want to calculate one more thing: provider performance by month.

    That will allow us to answer the recruiter-level questions:

    Is performance improving or deteriorating?
    Which provider is consistently strong?
    Were there months with unusual performance?
    Are speed improvements consistent or temporary?
*/
--Monthly speed trend
SELECT
    ReportingMonth,
    ServiceProvider,
    ROUND(AVG(TypicalDownloadSpeed_Mbps), 2) AS Avg_Typical_Download,
    ROUND(AVG(TypicalUploadSpeed_Mbps), 2) AS Avg_Typical_Upload
FROM dbo.SpeedTarrif_QoS
GROUP BY
    ReportingMonth,
    ServiceProvider
ORDER BY
    ReportingMonth,
    Avg_Typical_Download DESC;

/*  Monthly speed trend — what we found

    RJIL's July 2025 value of 107.50 Mbps is a major outlier. From August 2025 onward, RJIL's typical download speed is consistently 15 Mbps.

    That means its overall average of 28.21 Mbps is being heavily pulled upward by July:

    July 2025: 107.50 Mbps
    Aug 2025–Jul 2026: 15.00 Mbps every month

    So we should not simply conclude that RJIL's typical download speed was 28.21 Mbps throughout the period. The monthly view exposes the underlying pattern.

    Typical download speed by provider (Chart/Graph)

    Monthly average typical download speed from July 2025 to July 2026.

    RJIL
    AIRTEL
    VIL
    BSNL
    MTNL
    0Mbps
    30Mbps
    60Mbps
    90Mbps
    120Mbps
    Jul 2025
    Sep 2025
    Nov 2025
    Jan 2026
    Mar 2026
    May 2026
    Jul 2026

    RJIL's July 2025 value is a pronounced one-month spike.

    More useful observations
    AIRTEL shows the clearest sustained improvement: ~16.15 Mbps → 20.50 Mbps.
    BSNL gradually improves: 4.41 → 5.65 Mbps.
    MTNL is volatile but improves from 2.79 → 3.57 Mbps, despite some dips.
    VIL remains exactly 15 Mbps every month.
    RJIL remains exactly 15 Mbps after its July spike.

    This is exactly why we needed the monthly analysis before building the dashboard.

*/

--RJIL July 2025 spike is caused by particular tariff offerings
SELECT
    TariffOffering,
    TypicalDownloadSpeed_Mbps,
    TypicalUploadSpeed_Mbps,
    DownloadSpeed_P80_Mbps,
    UploadSpeed_P80_Mbps
FROM dbo.SpeedTarrif_QoS
WHERE ReportingMonth = '2025-07-01'
  AND ServiceProvider = 'RJIL'
ORDER BY TypicalDownloadSpeed_Mbps DESC;

/*  RJIL had two groups of plans in July 2025:

5G plans: Typical download = 200 Mbps
4G plans: Typical download = 15 Mbps

Because the 5G records are included in the monthly average, RJIL's July average becomes 107.50 Mbps. From August onward,
the dataset reports RJIL at 15 Mbps, so the change is real in the source data.

Important project decision

We should not remove the July value as an outlier.

Instead, we'll flag it as an important business/data insight:

RJIL's July 2025 speed performance was elevated by the presence of 5G plans; from August 2025 onward, the reported typical
download speed stabilised at 15 Mbps.

This is actually a great interview talking point because you didn't blindly trust an aggregate—you drilled into the underlying
records to explain the anomaly.
*/

--whether 5G/4G plan mix exists for other providers too.
SELECT
    ReportingMonth,
    ServiceProvider,
    TariffOffering,
    COUNT(*) AS Plan_Record_Count,
    ROUND(AVG(TypicalDownloadSpeed_Mbps), 2) AS Avg_Typical_Download
FROM dbo.SpeedTarrif_QoS
GROUP BY
    ReportingMonth,
    ServiceProvider,
    TariffOffering
ORDER BY
    ReportingMonth,
    ServiceProvider,
    Avg_Typical_Download DESC;

--let's identify how many tariff records each provider has and how they vary by month.
SELECT
    ServiceProvider,
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT TariffOffering) AS Distinct_Tariff_Offerings
FROM dbo.SpeedTarrif_QoS
GROUP BY ServiceProvider
ORDER BY Total_Records DESC;

/*  MTNL is the outlier in data structure, not necessarily in performance.

    MTNL contributes 1,434 of 2,618 records (~55%), despite having only 26 provider-LSA-month records in the Network/Customer tables.

    That means the Speed/Tariff dataset is not directly comparable at tariff-record level across providers.

    So I recommend we do not spend time cleaning 188 MTNL tariff names. For our capstone, we'll use:

    Provider + Month → primary comparison
    Typical Download/Upload Speed → primary speed KPIs
    P80 Download/Upload → supporting KPIs
    TariffOffering → drill-down/context, not the main KPI dimension
*/

--monthly speed trend by provider
SELECT
    ReportingMonth,
    ServiceProvider,
    ROUND(AVG(TypicalDownloadSpeed_Mbps), 2) AS Avg_Typical_Download,
    ROUND(AVG(TypicalUploadSpeed_Mbps), 2) AS Avg_Typical_Upload,
    ROUND(AVG(DownloadSpeed_P80_Mbps), 2) AS Avg_Download_P80,
    ROUND(AVG(UploadSpeed_P80_Mbps), 2) AS Avg_Upload_P80
FROM dbo.SpeedTarrif_QoS
GROUP BY
    ReportingMonth,
    ServiceProvider
ORDER BY
    ReportingMonth,
    ServiceProvider;

/*  Key findings
    RJIL
    July 2025 is a genuine spike: 107.5 Mbps typical download.
    From Aug 2025 onward it is consistently 15 Mbps.
    So we should not treat July as an error; it reflects the 5G/4G plan mix we already verified.
    RJIL has the strongest P80 download throughout, around 294–302 Mbps.
    AIRTEL
    Strongest improvement in typical download: 16.15 → 20.50 Mbps.
    Upload improved significantly: 4.61 → 9.00 Mbps.
    June–July 2026 shows particularly strong P80 performance: 232–240 Mbps download / 52–56 Mbps upload.
    VIL
    Typical download is remarkably stable at 15 Mbps every month.
    Upload is also consistently 8 Mbps.
    P80 download steadily rises from 50.5 → 75.56 Mbps.
    BSNL
    Slow but consistent improvement: 4.41 → 5.65 Mbps download.
    Upload remains around 3.0–3.5 Mbps.
    P80 download improves from 11.51 → 14.50 Mbps.
    MTNL
    Lowest speeds overall.
    Typical download fluctuates but improves from 2.79 → 3.57 Mbps.
    Upload remains extremely low at roughly 0.32–0.35 Mbps.
    Again, this should be interpreted alongside its limited reporting coverage.
    Most important analytical insight

    We now have two different stories:

    Typical speed = consumer-facing baseline performance

    P80 speed = higher-end performance / upper distribution

    That's valuable for our dashboard because AIRTEL, RJIL and VIL can look very different depending on which metric we use.
*/

--let's quantify improvement
SELECT
    ServiceProvider,
    MIN(ReportingMonth) AS Start_Month,
    MAX(ReportingMonth) AS End_Month,
    MAX(CASE WHEN ReportingMonth = '2025-07-01'
        THEN Avg_Download END) AS Start_Download,
    MAX(CASE WHEN ReportingMonth = '2026-07-01'
        THEN Avg_Download END) AS End_Download
FROM (
    SELECT
        ReportingMonth,
        ServiceProvider,
        AVG(TypicalDownloadSpeed_Mbps) AS Avg_Download
    FROM dbo.SpeedTarrif_QoS
    GROUP BY ReportingMonth, ServiceProvider
) x
GROUP BY ServiceProvider
ORDER BY (MAX(CASE WHEN ReportingMonth = '2026-07-01'
        THEN Avg_Download END)
        - MAX(CASE WHEN ReportingMonth = '2025-07-01'
        THEN Avg_Download END)) DESC;

/*  Important: We should not conclude that RJIL's network deteriorated by 92.5 Mbps. We already established that July-25 contained
    5G and 4G plan offerings, producing that unusual aggregate. From Aug-25 onward, its typical download is consistently 15 Mbps.

    What we can now say in the project

    AIRTEL demonstrated the strongest sustained improvement in typical download speed, while VIL remained highly stable. BSNL and MTNL
    showed gradual improvement. RJIL's July 2025 result was an exceptional plan-mix effect rather than a sustained performance level.

    That's a solid portfolio insight because we're investigating anomalies instead of blindly ranking numbers.
*/

--let's analyze Customer QoS
SELECT
    ServiceProvider,
    ROUND(AVG(BillingChargingComplaints_Pct), 2) AS Avg_Billing_Complaints,
    ROUND(AVG(BillingChargingResolution_4Weeks_Pct), 2) AS Avg_Billing_Resolution,
    ROUND(AVG(CustomerAccountAdjustment_1Week_Pct), 2) AS Avg_Account_Adjustment,
    ROUND(AVG(CustomerCareAccessibility_Pct), 2) AS Avg_Care_Accessibility,
    ROUND(AVG(CallsAnswered_90Sec_Pct), 2) AS Avg_Calls_Answered_90Sec,
    ROUND(AVG(ComplaintClosure_7WorkingDays_Pct), 2) AS Avg_Complaint_Closure,
    ROUND(AVG(DepositRefund_45Days_Pct), 2) AS Avg_Deposit_Refund
FROM dbo.Customer_QoS
GROUP BY ServiceProvider
ORDER BY ServiceProvider;

/*  The other three customer-service compliance metrics—billing resolution, account adjustment, complaint closure, and deposit
    refund—are 100% for every provider, so they are useful as compliance checks but not useful for differentiating providers.

    Strongest customer-service stories
    VIL: best call responsiveness — 99.90%
    RJIL: lowest billing complaints — 0%
    AIRTEL / MTNL: highest care accessibility — 99.62%
    BSNL: weakest across the differentiating customer-service measures
    RJIL: second-best call responsiveness at 99.36%

    So we now have three analytical areas:

    Network QoS → reliability, calls, packet loss, latency
    Customer QoS → complaints and service responsiveness
    Speed/Tariff QoS → download/upload performance and trends
    One important project decision

    I don't recommend creating a single "Best Telecom Provider" score yet. The metrics have different meanings, different directions
    (higher/lower is better), and different reporting coverage.

    Instead, our Power BI dashboard can answer:

    Who performs best in each dimension, and where are the major performance gaps?

    That's much more defensible analytically.
*/

--Provider Performance Summary
USE TRAI_Telecom_Analytics;
GO

CREATE OR ALTER VIEW dbo.vw_Provider_Performance_Summary
AS
SELECT
    n.ServiceProvider,

    -- Network QoS
    ROUND(AVG(n.NetworkMapAvailability_Pct), 2) AS Avg_Network_Availability,
    ROUND(AVG(n.IntraProviderCallSetupSuccess_Pct), 2) AS Avg_Intra_Call_Setup,
    ROUND(AVG(n.InterProviderCallSetupSuccess_Pct), 2) AS Avg_Inter_Call_Setup,
    ROUND(AVG(n.DCR_CS_Pct), 2) AS Avg_DCR_CS,
    ROUND(AVG(n.DCR_PS_Pct), 2) AS Avg_DCR_PS,
    ROUND(AVG(n.Latency_ms), 2) AS Avg_Latency_ms,
    ROUND(AVG(n.PacketDropRate_Pct), 2) AS Avg_Packet_Drop_Rate,

    -- Customer QoS
    ROUND(AVG(c.BillingChargingComplaints_Pct), 2) AS Avg_Billing_Complaints,
    ROUND(AVG(c.CustomerCareAccessibility_Pct), 2) AS Avg_Care_Accessibility,
    ROUND(AVG(c.CallsAnswered_90Sec_Pct), 2) AS Avg_Calls_Answered_90Sec,

    -- Speed QoS
    ROUND(AVG(s.TypicalDownloadSpeed_Mbps), 2) AS Avg_Typical_Download_Mbps,
    ROUND(AVG(s.TypicalUploadSpeed_Mbps), 2) AS Avg_Typical_Upload_Mbps,
    ROUND(AVG(s.DownloadSpeed_P80_Mbps), 2) AS Avg_Download_P80_Mbps,
    ROUND(AVG(s.UploadSpeed_P80_Mbps), 2) AS Avg_Upload_P80_Mbps

FROM dbo.Network_QoS n
LEFT JOIN dbo.Customer_QoS c
    ON n.ReportingMonth = c.ReportingMonth
    AND n.ServiceProvider = c.ServiceProvider
    AND n.LSA = c.LSA

LEFT JOIN dbo.SpeedTarrif_QoS s
    ON n.ReportingMonth = s.ReportingMonth
    AND n.ServiceProvider = s.ServiceProvider
    AND n.LSA = s.LSA

GROUP BY
    n.ServiceProvider;
GO

--Validate:
SELECT *
FROM dbo.vw_Provider_Performance_Summary
ORDER BY ServiceProvider;

/*  we found exactly the issue I warned about. The view's numbers are slightly distorted because Speed/Tariff has multiple rows per
    LSA/month, which duplicates Network and Customer records during the join.

    For example, AIRTEL latency should be 27.82 ms, but the view gives 27.64 ms. So do not use this view for Power BI yet.

    Step 2 — Fix the view properly

    We will first aggregate each table to the same grain:

    Provider + Month + LSA

    Then join them. This prevents tariff-level rows from multiplying the Network/Customer data.*/

--Run this:
USE TRAI_Telecom_Analytics;
GO

CREATE OR ALTER VIEW dbo.vw_Provider_Performance_Summary
AS

WITH Network AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(NetworkMapAvailability_Pct) AS Network_Availability,
        AVG(IntraProviderCallSetupSuccess_Pct) AS Intra_Call_Setup,
        AVG(InterProviderCallSetupSuccess_Pct) AS Inter_Call_Setup,
        AVG(DCR_CS_Pct) AS DCR_CS,
        AVG(DCR_PS_Pct) AS DCR_PS,
        AVG(Latency_ms) AS Latency_ms,
        AVG(PacketDropRate_Pct) AS Packet_Drop_Rate
    FROM dbo.Network_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
),

Customer AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(BillingChargingComplaints_Pct) AS Billing_Complaints,
        AVG(CustomerCareAccessibility_Pct) AS Care_Accessibility,
        AVG(CallsAnswered_90Sec_Pct) AS Calls_Answered_90Sec
    FROM dbo.Customer_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
),

Speed AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(TypicalDownloadSpeed_Mbps) AS Typical_Download,
        AVG(TypicalUploadSpeed_Mbps) AS Typical_Upload,
        AVG(DownloadSpeed_P80_Mbps) AS Download_P80,
        AVG(UploadSpeed_P80_Mbps) AS Upload_P80
    FROM dbo.SpeedTarrif_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
)

SELECT
    n.ServiceProvider,

    -- Network QoS
    ROUND(AVG(n.Network_Availability), 2) AS Avg_Network_Availability,
    ROUND(AVG(n.Intra_Call_Setup), 2) AS Avg_Intra_Call_Setup,
    ROUND(AVG(n.Inter_Call_Setup), 2) AS Avg_Inter_Call_Setup,
    ROUND(AVG(n.DCR_CS), 2) AS Avg_DCR_CS,
    ROUND(AVG(n.DCR_PS), 2) AS Avg_DCR_PS,
    ROUND(AVG(n.Latency_ms), 2) AS Avg_Latency_ms,
    ROUND(AVG(n.Packet_Drop_Rate), 2) AS Avg_Packet_Drop_Rate,

    -- Customer QoS
    ROUND(AVG(c.Billing_Complaints), 2) AS Avg_Billing_Complaints,
    ROUND(AVG(c.Care_Accessibility), 2) AS Avg_Care_Accessibility,
    ROUND(AVG(c.Calls_Answered_90Sec), 2) AS Avg_Calls_Answered_90Sec,

    -- Speed QoS
    ROUND(AVG(s.Typical_Download), 2) AS Avg_Typical_Download_Mbps,
    ROUND(AVG(s.Typical_Upload), 2) AS Avg_Typical_Upload_Mbps,
    ROUND(AVG(s.Download_P80), 2) AS Avg_Download_P80_Mbps,
    ROUND(AVG(s.Upload_P80), 2) AS Avg_Upload_P80_Mbps

FROM Network n

LEFT JOIN Customer c
    ON n.ReportingMonth = c.ReportingMonth
    AND n.ServiceProvider = c.ServiceProvider
    AND n.LSA = c.LSA

LEFT JOIN Speed s
    ON n.ReportingMonth = s.ReportingMonth
    AND n.ServiceProvider = s.ServiceProvider
    AND n.LSA = s.LSA

GROUP BY
    n.ServiceProvider;
GO

--Validate:
SELECT *
FROM dbo.vw_Provider_Performance_Summary
ORDER BY ServiceProvider;

/*  Yes — the view is now working correctly for Network and Customer QoS, but we uncovered one more important issue.

    What matches

    The corrected view now matches our independently validated results for:

    Network availability
    Call setup
    DCR
    Latency
    Packet drop
    Customer QoS

    For example, AIRTEL latency is back to 27.82 ms, RJIL 10.40 ms, and BSNL 48.22 ms. ✅

    But Speed is still different

    Compare our previously validated provider averages:

    Provider	Previous Download	View Download
    AIRTEL	18.34	18.01
    RJIL	28.21	22.12
    MTNL	2.94	5.19
    VIL	15.00	15.00
    BSNL	5.19	5.19

    This happens because we're averaging LSA-level averages equally, whereas our original calculation averaged all tariff records.

    Neither is necessarily "wrong" — they answer different questions.

    For the capstone, I recommend the LSA-month approach because it prevents MTNL's unusually large number of tariff records from
    dominating the provider comparison. It gives each LSA-month equal weight, which is much more defensible for comparing telecom
    operators.

    However, we should make that methodology explicit.

    One correction to our view

    Our current view is called Provider_Performance_Summary, but it mixes two grains conceptually:

    Network/Customer → provider + LSA + month
    Speed → provider + LSA + month after tariff averaging

    That's actually okay if we define it as an LSA-weighted provider summary.

    So let's keep it. */

--Step 3 — Create the monthly analytical view
--This is going to be more important for Power BI than the provider summary because it enables trend analysis.
USE TRAI_Telecom_Analytics;
GO

CREATE OR ALTER VIEW dbo.vw_Monthly_Provider_Performance
AS

WITH Network AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(NetworkMapAvailability_Pct) AS Network_Availability,
        AVG(IntraProviderCallSetupSuccess_Pct) AS Intra_Call_Setup,
        AVG(InterProviderCallSetupSuccess_Pct) AS Inter_Call_Setup,
        AVG(DCR_CS_Pct) AS DCR_CS,
        AVG(DCR_PS_Pct) AS DCR_PS,
        AVG(Latency_ms) AS Latency_ms,
        AVG(PacketDropRate_Pct) AS Packet_Drop_Rate
    FROM dbo.Network_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
),

Customer AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(BillingChargingComplaints_Pct) AS Billing_Complaints,
        AVG(CustomerCareAccessibility_Pct) AS Care_Accessibility,
        AVG(CallsAnswered_90Sec_Pct) AS Calls_Answered_90Sec
    FROM dbo.Customer_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
),

Speed AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(TypicalDownloadSpeed_Mbps) AS Typical_Download,
        AVG(TypicalUploadSpeed_Mbps) AS Typical_Upload,
        AVG(DownloadSpeed_P80_Mbps) AS Download_P80,
        AVG(UploadSpeed_P80_Mbps) AS Upload_P80
    FROM dbo.SpeedTarrif_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
)

SELECT
    n.ReportingMonth,
    n.ServiceProvider,

    ROUND(AVG(n.Network_Availability), 2) AS Network_Availability,
    ROUND(AVG(n.Intra_Call_Setup), 2) AS Intra_Call_Setup,
    ROUND(AVG(n.Inter_Call_Setup), 2) AS Inter_Call_Setup,
    ROUND(AVG(n.DCR_CS), 2) AS DCR_CS,
    ROUND(AVG(n.DCR_PS), 2) AS DCR_PS,
    ROUND(AVG(n.Latency_ms), 2) AS Latency_ms,
    ROUND(AVG(n.Packet_Drop_Rate), 2) AS Packet_Drop_Rate,

    ROUND(AVG(c.Billing_Complaints), 2) AS Billing_Complaints,
    ROUND(AVG(c.Care_Accessibility), 2) AS Care_Accessibility,
    ROUND(AVG(c.Calls_Answered_90Sec), 2) AS Calls_Answered_90Sec,

    ROUND(AVG(s.Typical_Download), 2) AS Typical_Download_Mbps,
    ROUND(AVG(s.Typical_Upload), 2) AS Typical_Upload_Mbps,
    ROUND(AVG(s.Download_P80), 2) AS Download_P80_Mbps,
    ROUND(AVG(s.Upload_P80), 2) AS Upload_P80_Mbps

FROM Network n

LEFT JOIN Customer c
    ON n.ReportingMonth = c.ReportingMonth
    AND n.ServiceProvider = c.ServiceProvider
    AND n.LSA = c.LSA

LEFT JOIN Speed s
    ON n.ReportingMonth = s.ReportingMonth
    AND n.ServiceProvider = s.ServiceProvider
    AND n.LSA = s.LSA

GROUP BY
    n.ReportingMonth,
    n.ServiceProvider;
GO

--Validate:
SELECT *
FROM dbo.vw_Monthly_Provider_Performance
ORDER BY ReportingMonth, ServiceProvider;

/*  Excellent. 65 rows confirmed (13 months × 5 providers), and the monthly view is working. ✅

    One important methodological point: the monthly speed values here are LSA-weighted, because we first average tariff records
    within each LSA. That's intentional and avoids MTNL's 1,434 tariff records overwhelming the other providers.

    One thing I want to fix before we build more views

    Notice MTNL July typical download is 5.12 Mbps here, whereas the earlier raw tariff-record average was 2.79 Mbps. That's because
    MTNL has very different numbers of tariff records across LSAs, so weighting every LSA equally changes the result substantially.

    For our project, that's actually a better analytical approach, but we need to document it:

    Speed metrics are calculated at LSA-month level first, then averaged across LSAs to prevent providers with disproportionately many
    tariff records from dominating the comparison.

    That is a strong data-analytics methodology point to mention in the portfolio.
*/

--Next step: create a data-quality/coverage view
--Because we discovered genuine NULLs and different reporting coverage,
--this is important for our dashboard and demonstrates that we didn't blindly aggregate incomplete data.
--Run:
USE TRAI_Telecom_Analytics;
GO

CREATE OR ALTER VIEW dbo.vw_Provider_Data_Coverage
AS
SELECT
    ReportingMonth,
    ServiceProvider,

    COUNT(*) AS Total_Network_Records,

    COUNT(DCR_CS_Pct) AS DCR_CS_Reported,
    COUNT(DCR_PS_Pct) AS DCR_PS_Reported,
    COUNT(Latency_ms) AS Latency_Reported,
    COUNT(PacketDropRate_Pct) AS Packet_Drop_Reported

FROM dbo.Network_QoS
GROUP BY
    ReportingMonth,
    ServiceProvider;
GO

--Validate:
SELECT *
FROM dbo.vw_Provider_Data_Coverage
ORDER BY ServiceProvider;

/*  
    Key analytical point: MTNL does not report DCR-PS, latency, or packet-drop metrics, while RJIL does not report DCR-CS. BSNL has a
    small number of missing observations. These are coverage differences in the source data, not data-cleaning errors.

    So our analytical layer is now robust enough to proceed.
*/

--Next step — create LSA-level performance view
--This will let us later drill down in Power BI from:
--Provider → Month → LSA
--Run this:

USE TRAI_Telecom_Analytics;
GO

CREATE OR ALTER VIEW dbo.vw_LSA_Provider_Performance
AS

WITH Network AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(NetworkMapAvailability_Pct) AS Network_Availability,
        AVG(IntraProviderCallSetupSuccess_Pct) AS Intra_Call_Setup,
        AVG(InterProviderCallSetupSuccess_Pct) AS Inter_Call_Setup,
        AVG(DCR_CS_Pct) AS DCR_CS,
        AVG(DCR_PS_Pct) AS DCR_PS,
        AVG(Latency_ms) AS Latency_ms,
        AVG(PacketDropRate_Pct) AS Packet_Drop_Rate
    FROM dbo.Network_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
),

Customer AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(BillingChargingComplaints_Pct) AS Billing_Complaints,
        AVG(CustomerCareAccessibility_Pct) AS Care_Accessibility,
        AVG(CallsAnswered_90Sec_Pct) AS Calls_Answered_90Sec
    FROM dbo.Customer_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
),

Speed AS
(
    SELECT
        ReportingMonth,
        ServiceProvider,
        LSA,
        AVG(TypicalDownloadSpeed_Mbps) AS Typical_Download,
        AVG(TypicalUploadSpeed_Mbps) AS Typical_Upload,
        AVG(DownloadSpeed_P80_Mbps) AS Download_P80,
        AVG(UploadSpeed_P80_Mbps) AS Upload_P80
    FROM dbo.SpeedTarrif_QoS
    GROUP BY ReportingMonth, ServiceProvider, LSA
)

SELECT
    n.ReportingMonth,
    n.ServiceProvider,
    n.LSA,

    ROUND(n.Network_Availability, 2) AS Network_Availability,
    ROUND(n.Intra_Call_Setup, 2) AS Intra_Call_Setup,
    ROUND(n.Inter_Call_Setup, 2) AS Inter_Call_Setup,
    ROUND(n.DCR_CS, 2) AS DCR_CS,
    ROUND(n.DCR_PS, 2) AS DCR_PS,
    ROUND(n.Latency_ms, 2) AS Latency_ms,
    ROUND(n.Packet_Drop_Rate, 2) AS Packet_Drop_Rate,

    ROUND(c.Billing_Complaints, 2) AS Billing_Complaints,
    ROUND(c.Care_Accessibility, 2) AS Care_Accessibility,
    ROUND(c.Calls_Answered_90Sec, 2) AS Calls_Answered_90Sec,

    ROUND(s.Typical_Download, 2) AS Typical_Download_Mbps,
    ROUND(s.Typical_Upload, 2) AS Typical_Upload_Mbps,
    ROUND(s.Download_P80, 2) AS Download_P80_Mbps,
    ROUND(s.Upload_P80, 2) AS Upload_P80_Mbps

FROM Network n

LEFT JOIN Customer c
    ON n.ReportingMonth = c.ReportingMonth
    AND n.ServiceProvider = c.ServiceProvider
    AND n.LSA = c.LSA

LEFT JOIN Speed s
    ON n.ReportingMonth = s.ReportingMonth
    AND n.ServiceProvider = s.ServiceProvider
    AND n.LSA = s.LSA;
GO

--Validate:
SELECT COUNT(*) AS Total_Rows
FROM dbo.vw_LSA_Provider_Performance;

/*  
Perfect. ✅ 1,144 rows is exactly what we expect — 13 months × the provider/LSA combinations represented in Network_QoS.

Our three analytical views are now validated:

vw_Provider_Performance_Summary → provider-level comparison
vw_Monthly_Provider_Performance → monthly trends
vw_LSA_Provider_Performance → provider + LSA drill-down
Next: final validation

Let's check that the LSA view has no duplicate Provider + Month + LSA combinations.

Run:
*/

SELECT
    ReportingMonth,
    ServiceProvider,
    LSA,
    COUNT(*) AS Record_Count
FROM dbo.vw_LSA_Provider_Performance
GROUP BY
    ReportingMonth,
    ServiceProvider,
    LSA
HAVING COUNT(*) > 1;

/*
Excellent. ✅ 0 duplicate rows confirms the LSA-level analytical view is structurally clean.

SQL analytical layer is now ready

We have:

View	Purpose
vw_Provider_Performance_Summary	Overall provider comparison
vw_Monthly_Provider_Performance	Monthly trends
vw_LSA_Provider_Performance	LSA-level drill-down
vw_Provider_Data_Coverage	Data availability / reporting gaps

The important part is that we've also handled the major analytical risks:

✅ Duplicate tariff records preserved
✅ NULLs preserved correctly
✅ Speed aggregation prevents MTNL's large tariff-record volume from distorting provider comparisons
✅ Network/Customer/Speed joins don't multiply rows
✅ LSA-level uniqueness confirmed

Next step: we should build the Power BI-ready data model. Before that, I want to do one final SQL integrity check on the three
analytical views so we don't carry a hidden issue into Power BI.

Run:
*/

SELECT
    'Provider Summary' AS View_Name,
    COUNT(*) AS Row_Count
FROM dbo.vw_Provider_Performance_Summary

UNION ALL

SELECT
    'Monthly Performance',
    COUNT(*)
FROM dbo.vw_Monthly_Provider_Performance

UNION ALL

SELECT
    'LSA Performance',
    COUNT(*)
FROM dbo.vw_LSA_Provider_Performance

UNION ALL

SELECT
    'Data Coverage',
    COUNT(*)
FROM dbo.vw_Provider_Data_Coverage;

/*
Perfect. ✅ All four analytical views have the expected row counts:

Provider Summary: 5 providers
Monthly Performance: 65 rows = 13 months × 5 providers
LSA Performance: 1,144 rows
Data Coverage: 5 providers
🎯 SQL layer is officially complete

We can now move to Power BI without needing to touch the raw SQL tables again.

The next step is to connect Power BI to SQL Server and import only these four analytical views—not the raw tables.
*/

--You will need server name
SELECT @@SERVERNAME;
--Database name which is TRAI_Telecom_Analytics


