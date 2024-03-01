SELECT
    DATE_TRUNC('month', created_at) AS month_year,
    COUNT(loan_id) AS total_loans,
    SUM(loan_amount) AS total_amount
FROM
    loans
GROUP BY
    month_year
ORDER BY
    total_amount DESC
LIMIT
    1;
