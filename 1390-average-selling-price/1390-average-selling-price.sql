WITH Sales AS (
    SELECT 
        u.product_id, 
        u.units, 
        p.price
    FROM UnitsSold u
    JOIN Prices p
    ON u.product_id = p.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
)
SELECT 
    p.product_id,
    COALESCE(ROUND(SUM(s.units * s.price) / NULLIF(SUM(s.units), 0), 2), 0) AS average_price
FROM Prices p
LEFT JOIN Sales s
ON p.product_id = s.product_id
GROUP BY p.product_id;
