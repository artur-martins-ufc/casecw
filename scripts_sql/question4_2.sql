WITH client_details AS (
    SELECT
        l.user_id,
        BOOL_OR(l.status = 'default') AS any_default,
        AVG(l.amount_paid / l.due_amount) AS avg_payment_reliability,
        COUNT(l.loan_id) > 1 AS is_recurrent_client,
        BOOL_OR(l.loan_amount > 20000) AS is_profile_a,
        BOOL_OR(l.loan_amount BETWEEN 5000 AND 20000) AS is_profile_b,
        BOOL_OR(l.loan_amount < 5000) AS is_profile_c,
        SUM(l.loan_amount) AS total_loan_amount,
        SUM(l.due_amount - l.amount_paid) AS total_unpaid,
        BOOL_OR(l.amount_paid < l.due_amount AND l.paid_at IS NOT NULL) AS has_partial_payments
    FROM
        loans l
    GROUP BY
        l.user_id
),
client_scores AS (
    SELECT
        cd.user_id,
        cd.any_default,
        cd.avg_payment_reliability,
        cd.is_recurrent_client,
        cd.total_loan_amount,
        cd.total_unpaid,
        cd.has_partial_payments,
        CASE 
            WHEN cd.is_profile_a THEN 'A'
            WHEN cd.is_profile_b THEN 'B'
            WHEN cd.is_profile_c THEN 'C'
            ELSE 'Unknown'
        END AS loan_profile,
        (
            (CASE WHEN NOT cd.any_default THEN 0.4 ELSE 0 END) +
            (CASE WHEN cd.avg_payment_reliability >= 0.95 THEN 0.3 ELSE 0 END) +
            (CASE WHEN cd.is_recurrent_client THEN 0.2 ELSE 0 END) +
            (CASE WHEN cd.has_partial_payments THEN -0.1 ELSE 0.1 END)
        ) - 
        (CASE WHEN cd.total_unpaid > 0 THEN 0.2 ELSE 0 END) AS score
    FROM
        client_details cd
),
ranked_clients AS (
    SELECT
        cs.*,
        ROW_NUMBER() OVER (ORDER BY cs.score DESC) AS rank_asc,
        ROW_NUMBER() OVER (ORDER BY cs.score ASC) AS rank_desc,
        COUNT(*) OVER() AS total_count
    FROM
        client_scores cs
)
SELECT
    user_id,
    loan_profile,
    avg_payment_reliability,
    any_default,
    is_recurrent_client,
    has_partial_payments,
    total_loan_amount,
    score,
    CASE
        WHEN rank_asc <= 10 THEN 'Top Clients'
        WHEN rank_desc <= 10 THEN 'Bottom Clients'
        ELSE 'Middle Clients'
    END AS category
FROM
    ranked_clients
WHERE
    rank_asc <= 10 OR rank_desc <= 10
ORDER BY
    score DESC, rank_asc;
