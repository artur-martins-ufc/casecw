WITH loan_counts AS (
    SELECT
        c.batch,
        COUNT(DISTINCT l.user_id) AS total_clients_with_loans
    FROM
        loans l
    JOIN
        clients c ON l.user_id = c.user_id
    GROUP BY
        c.batch
),
total_clients AS (
    SELECT
        batch,
        COUNT(user_id) AS total_clients_in_batch
    FROM
        clients
    GROUP BY
        batch
),
adherence AS (
    SELECT
        lc.batch,
        tc.total_clients_in_batch,
        lc.total_clients_with_loans,
        (CAST(lc.total_clients_with_loans AS FLOAT) / tc.total_clients_in_batch) AS adherence
    FROM
        loan_counts lc
    JOIN
        total_clients tc ON lc.batch = tc.batch
)
SELECT
    batch,
    total_clients_in_batch,
    total_clients_with_loans,
    adherence
FROM
    adherence
ORDER BY
    adherence DESC;