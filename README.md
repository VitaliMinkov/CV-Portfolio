# SQL Portfolio

This project is built on transactional retail data (orders, returns, customers, and products) and focuses on solving key product and business analytics tasks using PostgreSQL.

The main objective of the project is to demonstrate a clear understanding and practical application of core SQL techniques, including CTEs, window functions, aggregations, joins (INNER, LEFT), subqueries (including correlated subqueries), CASE expressions, COALESCE, NULL handling (NULLIF), date functions (DATE_TRUNC, intervals), ranking functions (DENSE_RANK, NTILE), filtering with HAVING, and cumulative calculations; 
and also to show the practical use of these tools for analytical problem-solving, including KPI development, time-series analysis, cohort-style logic, customer segmentation, and business performance evaluation in real-world retail scenarios.

# The analysis covers
1. KPI and time-series analysis:
Built monthly metrics by region, including orders, customers, revenue, profit, and profit margin. Calculated MoM and YoY growth using window functions, with safeguards against division by zero.

2. User activity metrics:
Computed DAU (Daily Active Users) and new users over a rolling 90-day window, identifying user acquisition dynamics and engagement patterns.

3. Product performance analysis:
Identified top-3 products by profit margin per region using ranking (DENSE_RANK) and multi-level sorting (margin, profit, sales).

4. Pricing and discount impact:
Analyzed how discount levels affect profitability and return rate, using bucketization and aggregated metrics (avg sales, avg profit, margin, return rate).

5. Operational efficiency (logistics):
Measured shipping performance (average delivery time) by region and ship mode, filtering invalid data and small samples.

6. Manager and regional performance:
Evaluated regional managers across categories using revenue, profit, return rate, and share of returned sales, with minimum sample thresholds.

7. Customer analytics (segmentation):
Performed RFM segmentation (Recency, Frequency, Monetary), assigning customers into behavioral segments (loyal, active, stable, at risk).

8. Revenue concentration (Pareto analysis):
Validated the 80/20 principle, identifying customers generating 80% of total revenue via cumulative share calculations.

9. Profitability diagnostics:
Detected loss-making orders and compared them to each customer’s average margin to identify structurally unprofitable relationships.

10. Cross-sell behavior:
Identified customers purchasing across key categories and tracked their entry point in the analysis period.

