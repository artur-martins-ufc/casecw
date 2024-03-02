--Este script SQL utiliza Common Table Expressions (CTEs) para calcular a aderência dos clientes aos empréstimos por batch. 
--A aderência é definida como a proporção de clientes em um determinado batch que possuem empréstimos. 

--Calcula o número total de clientes únicos com empréstimos em cada batch.
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


--Calcula o número total de clientes em cada batch.
),
total_clients AS (
    SELECT
        batch,
        COUNT(user_id) AS total_clients_in_batch
    FROM
        clients
    GROUP BY
        batch

--Combina os CTEs loan_counts e total_clients para calcular a aderência.
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

-- Batches com alta aderência podem indicar uma boa aceitação das condições de empréstimo ou eficácia das estratégias de marketing direcionadas a esses grupos.
-- Em contraste, batches com baixa aderência podem necessitar de investigação adicional para entender as razões por trás do baixo engajamento e ajustar as abordagens de marketing ou as condições dos produtos de empréstimo.