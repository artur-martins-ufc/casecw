SELECT
    c.interest_rate,
    COUNT(l.loan_id) AS total_loans,
    SUM(CASE WHEN l.status = 'default' THEN 1 ELSE 0 END) AS defaults,
    SUM(CASE WHEN l.status = 'default' THEN 1 ELSE 0 END)::FLOAT / COUNT(l.loan_id) AS default_rate
FROM
    loans l
JOIN
    clients c ON l.user_id = c.user_id
GROUP BY
    c.interest_rate
ORDER BY
    c.interest_rate;