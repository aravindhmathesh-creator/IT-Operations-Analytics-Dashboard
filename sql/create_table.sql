-- ============================================
-- IT OPERATIONS TICKET TABLE CREATION SCRIPT
-- ============================================

CREATE DATABASE IF NOT EXISTS it_operations;
USE it_operations;

DROP TABLE IF EXISTS tickets;

CREATE TABLE tickets (
    Ticket_ID VARCHAR(20) PRIMARY KEY,
    Created_Date DATETIME,
    Resolved_Date DATETIME,
    Priority VARCHAR(10),
    Category VARCHAR(50),
    Subcategory VARCHAR(50),
    Assignment_Group VARCHAR(50),
    Agent_Name VARCHAR(50),
    Status VARCHAR(20),
    Resolution_Time_Minutes INT,
    SLA_Target_Hours INT,
    SLA_Breach VARCHAR(5),
    CSAT_Score DECIMAL(3,2),
    Reopen_Count INT
);

-- ============================================
-- SAMPLE INSERT STRUCTURE
-- ============================================

INSERT INTO tickets (
    Ticket_ID,
    Created_Date,
    Resolved_Date,
    Priority,
    Category,
    Subcategory,
    Assignment_Group,
    Agent_Name,
    Status,
    Resolution_Time_Minutes,
    SLA_Target_Hours,
    SLA_Breach,
    CSAT_Score,
    Reopen_Count
) VALUES
('INC00001', '2024-01-01 09:00:00', '2024-01-01 11:00:00', 'P1', 'Network', 'Router', 'Infra Team', 'Agent_01', 'Closed', 120, 2, 'Yes', 3.5, 1),
('INC00002', '2024-01-02 10:30:00', '2024-01-02 12:00:00', 'P3', 'Software', 'Application', 'App Support', 'Agent_02', 'Closed', 90, 4, 'No', 4.2, 0);

-- ============================================
-- USEFUL ANALYTICAL QUERIES
-- ============================================

-- Monthly Ticket Volume
SELECT 
    DATE_FORMAT(Created_Date, '%Y-%m') AS Month,
    COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Month
ORDER BY Month;

-- SLA Breach %
SELECT 
    (SUM(CASE WHEN SLA_Breach = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS SLA_Breach_Percentage
FROM tickets;

-- MTTR in Hours
SELECT 
    AVG(Resolution_Time_Minutes) / 60 AS MTTR_Hours
FROM tickets;
