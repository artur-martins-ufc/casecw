WITH client_scores AS (
    SELECT
        l.user_id,
        AVG(l.amount_paid / l.due_amount) AS avg_payment_reliability,
        BOOL_OR(l.status = 'default') AS any_default,
        SUM(l.loan_amount) AS total_loan_amount
    FROM
        loans l
    GROUP BY
        l.user_id
),
ranked_clients AS (
    SELECT
        cs.user_id,
        cs.avg_payment_reliability,
        cs.any_default,
        cs.total_loan_amount,
        ROW_NUMBER() OVER (ORDER BY cs.avg_payment_reliability DESC, NOT cs.any_default DESC, cs.total_loan_amount DESC) AS rank_asc,
        ROW_NUMBER() OVER (ORDER BY cs.avg_payment_reliability, cs.any_default, cs.total_loan_amount) AS rank_desc
    FROM
        client_scores cs
),
top_clients AS (
    SELECT
        'Top Clients' AS category,
        user_id,
        avg_payment_reliability,
        any_default,
        total_loan_amount
    FROM
        ranked_clients
    WHERE
        rank_asc <= 10
),
bottom_clients AS (
    SELECT
        'Bottom Clients' AS category,
        user_id,
        avg_payment_reliability,
        any_default,
        total_loan_amount
    FROM
        ranked_clients
    WHERE
        rank_desc <= 10
)
SELECT * FROM top_clients
UNION ALL
SELECT * FROM bottom_clients
ORDER BY category DESC, avg_payment_reliability DESC, any_default, total_loan_amount DESC;
