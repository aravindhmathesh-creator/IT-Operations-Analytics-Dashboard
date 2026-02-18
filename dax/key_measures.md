# 📊 Key DAX Measures – IT Operations Dashboard

---

## 1️⃣ Total Tickets

```DAX
Total Tickets =
COUNT(Tickets[Ticket_ID])
Counts all tickets.

2️⃣ Open Tickets
Open Tickets =
CALCULATE(
    COUNT(Tickets[Ticket_ID]),
    Tickets[Status] <> "Closed"
)
Tracks unresolved workload.

3️⃣ MTTR (Hours)
MTTR Hours =
AVERAGE(Tickets[Resolution_Time_Minutes]) / 60
Mean Time to Resolution.

4️⃣ SLA Breach %
SLA Breach % =
DIVIDE(
    CALCULATE(
        COUNTROWS(Tickets),
        Tickets[SLA_Breach] = "Yes"
    ),
    COUNTROWS(Tickets)
)
Calculates percentage of breached tickets.

5️⃣ SLA Compliance %
SLA Compliance % =
1 - [SLA Breach %]
6️⃣ MTTR vs SLA Target
Avg SLA Target Hours =
AVERAGE(Tickets[SLA_Target_Hours])
MTTR vs SLA Variance =
[MTTR Hours] - [Avg SLA Target Hours]
Used for conditional formatting risk logic.

7️⃣ Agent MTTR
Agent MTTR Hours =
AVERAGE(Tickets[Resolution_Time_Minutes]) / 60
Auto-filters by agent context.

8️⃣ Agent SLA Breach %
Agent SLA Breach % =
[SLA Breach %]
Context-aware SLA calculation.

9️⃣ Agent Reopen Rate
Agent Reopen Rate =
DIVIDE(
    SUM(Tickets[Reopen_Count]),
    COUNT(Tickets[Ticket_ID])
)
🔟 Agent Performance Category
Agent Performance Category =
VAR AgentAvgMTTR =
    CALCULATE(
        AVERAGE(Tickets[Resolution_Time_Minutes]) / 60,
        ALLEXCEPT(Tickets, Tickets[Agent_Name])
    )

VAR AgentAvgCSAT =
    CALCULATE(
        AVERAGE(Tickets[CSAT_Score]),
        ALLEXCEPT(Tickets, Tickets[Agent_Name])
    )

VAR GlobalAvgMTTR =
    CALCULATE(
        AVERAGE(Tickets[Resolution_Time_Minutes]) / 60,
        ALL(Tickets)
    )

VAR GlobalAvgCSAT =
    CALCULATE(
        AVERAGE(Tickets[CSAT_Score]),
        ALL(Tickets)
    )

RETURN
SWITCH(
    TRUE(),
    AgentAvgMTTR <= GlobalAvgMTTR && AgentAvgCSAT >= GlobalAvgCSAT, "High Performer",
    AgentAvgMTTR > GlobalAvgMTTR && AgentAvgCSAT >= GlobalAvgCSAT, "Efficient but Busy",
    AgentAvgMTTR <= GlobalAvgMTTR && AgentAvgCSAT < GlobalAvgCSAT, "Quality Risk",
    "Performance Risk"
)
🔟 Dynamic Drill-Through Title
Agent Detail Title =
"Agent Performance Details – " &
SELECTEDVALUE(Tickets[Agent_Name])
🎯 Advanced Concepts Used
CALCULATE()

Filter Context

ALL()

ALLEXCEPT()

SWITCH()

DIVIDE()

Time Intelligence

Context-aware drill-through

Conditional formatting logic
