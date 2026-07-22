Запросы для нужных метрик для анализа продаж интернет-магазина

1. Общая выручка и базовые KPI:

sql
SELECT 
    COUNT(DISTINCT invoiceno) AS total_orders,
    COUNT(DISTINCT customerid) AS unique_customers,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_order_value,
    ROUND(SUM(revenue) / COUNT(DISTINCT customerid), 2) AS revenue_per_customer
FROM clean_orders;

 total_orders | unique_customers | total_revenue | avg_order_value | revenue_per_customer
--------------+------------------+---------------+-----------------+----------------------
        18532 |             4338 |   8911407.904 |           22.40 |              2054.27

2. Топ-10 товаров по выручке:

sql
SELECT 
    stockcode,
    description,
    COUNT(*) AS order_count,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM clean_orders
GROUP BY stockcode, description
ORDER BY total_revenue DESC
LIMIT 10;

 stockcode |            description             | order_count | total_quantity | total_revenue
-----------+------------------------------------+-------------+----------------+---------------
 23843     | PAPER CRAFT , LITTLE BIRDIE        |           1 |          80995 |     168469.60
 22423     | REGENCY CAKESTAND 3 TIER           |        1723 |          12402 |     142592.95
 85123A    | WHITE HANGING HEART T-LIGHT HOLDER |        2028 |          36725 |     100448.15
 85099B    | JUMBO BAG RED RETROSPOT            |        1618 |          46181 |      85220.78
 23166     | MEDIUM CERAMIC TOP STORAGE JAR     |         198 |          77916 |      81416.73
 POST      | POSTAGE                            |        1099 |           3120 |      77803.96
 47566     | PARTY BUNTING                      |        1396 |          15291 |      68844.33
 84879     | ASSORTED COLOUR BIRD ORNAMENT      |        1408 |          35362 |      56580.34
 M         | Manual                             |         284 |           7173 |      53779.93
 23084     | RABBIT NIGHT LIGHT                 |         842 |          27202 |      51346.20

3. Динамика выручки по месяцам:

sql
SELECT 
    TO_CHAR(month, 'YYYY-MM') AS month,
    COUNT(DISTINCT invoiceno) AS orders,
    COUNT(DISTINCT customerid) AS customers,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(AVG(revenue), 2) AS avg_check
FROM clean_orders
GROUP BY month
ORDER BY month;

  month  | orders | customers |  revenue   | avg_check
---------+--------+-----------+------------+-----------
 2010-12 |   1400 |       885 |  572713.89 |     21.90
 2011-01 |    987 |       741 |  569445.04 |     26.82
 2011-02 |    997 |       758 |  447137.35 |     22.44
 2011-03 |   1321 |       974 |  595500.76 |     21.91
 2011-04 |   1149 |       856 |  469200.36 |     20.72
 2011-05 |   1555 |      1056 |  678594.56 |     23.96
 2011-06 |   1393 |       991 |  661213.69 |     24.32
 2011-07 |   1331 |       949 |  600091.01 |     22.37
 2011-08 |   1280 |       935 |  645343.90 |     23.90
 2011-09 |   1755 |      1266 |  952838.38 |     23.80
 2011-10 |   1929 |      1364 | 1039318.79 |     20.97
 2011-11 |   2657 |      1664 | 1161817.38 |     18.00
 2011-12 |    778 |       615 |  518192.79 |     29.95

4. Выручка по дням недели:

sql
SELECT 
    CASE day_of_week
        WHEN 0 THEN 'Воскресенье'
        WHEN 1 THEN 'Понедельник'
        WHEN 2 THEN 'Вторник'
        WHEN 3 THEN 'Среда'
        WHEN 4 THEN 'Четверг'
        WHEN 5 THEN 'Пятница'
        WHEN 6 THEN 'Суббота'
    END AS day_name,
    ROUND(SUM(revenue), 2) AS revenue,
    COUNT(DISTINCT invoiceno) AS orders,
    ROUND(AVG(revenue), 2) AS avg_check
FROM clean_orders
GROUP BY day_of_week
ORDER BY day_of_week;

  day_name   |  revenue   | orders | avg_check
-------------+------------+--------+-----------
 Воскресенье |  792514.22 |   2169 |     12.63
 Понедельник | 1367146.41 |   2863 |     21.07
 Вторник     | 1700634.63 |   3184 |     25.58
 Среда       | 1588336.17 |   3455 |     23.06
 Четверг     | 1976859.07 |   4032 |     24.70
 Пятница     | 1485917.40 |   2829 |     27.10

5. Топ-5 стран по выручке:

sql
SELECT 
    country,
    COUNT(DISTINCT customerid) AS customers,
    COUNT(DISTINCT invoiceno) AS orders,
    ROUND(SUM(revenue), 2) AS revenue
FROM clean_orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 5;

    country     | customers | orders |  revenue
----------------+-----------+--------+------------
 United Kingdom |      3920 |  16646 | 7308391.55
 Netherlands    |         9 |     94 |  285446.34
 EIRE           |         3 |    260 |  265545.90
 Germany        |        94 |    457 |  228867.14
 France         |        87 |    389 |  209024.05