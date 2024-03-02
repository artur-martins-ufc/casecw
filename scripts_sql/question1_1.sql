SELECT
    DATE_TRUNC('month', created_at) AS month_year,
    COUNT(loan_id) AS total_loans,
    SUM(loan_amount) AS total_amount
FROM
    loans
GROUP BY
    month_year
ORDER BY
    total_loans DESC
LIMIT
    1;

-- utilizado para analisar dados de empréstimos em um banco de dados, especificamente para encontrar o mês com o maior número de empréstimos emitidos, 
-- considerando tanto a contagem de empréstimos quanto o montante total emprestado.
-- pode ser útil para análises financeiras, avaliações de desempenho de produtos de empréstimo, planejamento de recursos e estratégias de marketing, entre outros. 