-- Q1 Revenue per channel
SELECT sales_channel,
       SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-- Q2 Top 10 customers
SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Q3 Monthly revenue, expense, profit
WITH rev AS (
    SELECT DATE_FORMAT(datetime, '%Y-%m') mth,
           SUM(amount) revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY mth
),
exp AS (
    SELECT DATE_FORMAT(datetime, '%Y-%m') mth,
           SUM(amount) expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY mth
)
SELECT r.mth,
       r.revenue,
       e.expense,
       (r.revenue - e.expense) AS profit,
       CASE WHEN (r.revenue - e.expense) > 0 THEN 'profitable'
            ELSE 'not-profitable' END AS status
FROM rev r
JOIN exp e ON r.mth = e.mth;

-- Q4 Most profitable clinic per city
WITH profit_calc AS (
    SELECT c.city, c.cid,
           SUM(cs.amount) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid
    LEFT JOIN expenses e ON c.cid = e.cid
    WHERE MONTH(cs.datetime)=9 AND YEAR(cs.datetime)=2021
    GROUP BY c.city, c.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) rnk
    FROM profit_calc
)
SELECT * FROM ranked WHERE rnk = 1;

-- Q5 Second least profitable clinic per state
WITH profit_calc AS (
    SELECT c.state, c.cid,
           SUM(cs.amount) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid
    LEFT JOIN expenses e ON c.cid = e.cid
    WHERE MONTH(cs.datetime)=9 AND YEAR(cs.datetime)=2021
    GROUP BY c.state, c.cid
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) rnk
    FROM profit_calc
)
SELECT * FROM ranked WHERE rnk = 2;