-- Q1 Last booked room per user
SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) rn
    FROM bookings
) t
WHERE rn = 1;

-- Q2 Total billing Nov 2021
SELECT b.booking_id,
       SUM(i.item_rate * bc.item_quantity) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(b.booking_date, '%Y-%m') = '2021-11'
GROUP BY b.booking_id;

-- Q3 Bills >1000 Oct 2021
SELECT bc.bill_id,
       SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-10'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- Q4 Most & least ordered items
WITH item_counts AS (
    SELECT DATE_FORMAT(bill_date, '%Y-%m') AS month,
           item_id,
           SUM(item_quantity) AS total_qty
    FROM booking_commercials
    WHERE YEAR(bill_date) = 2021
    GROUP BY month, item_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) r_desc,
           RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) r_asc
    FROM item_counts
)
SELECT * FROM ranked WHERE r_desc = 1 OR r_asc = 1;

-- Q5 Second highest bill per month
WITH bills AS (
    SELECT DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
           b.user_id,
           bc.bill_id,
           SUM(i.item_rate * bc.item_quantity) AS bill_amount
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, b.user_id, bc.bill_id
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) rnk
    FROM bills
)
SELECT * FROM ranked WHERE rnk = 2;