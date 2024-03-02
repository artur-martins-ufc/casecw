SELECT
    TO_CHAR(l.created_at, 'YYYY-MM') AS month_year,
    c.batch,
    COUNT(l.loan_id) AS total_emprestimos,
    SUM(CASE WHEN l.status = 'default' THEN 1 ELSE 0 END) AS inadimplentes,
    SUM(CASE WHEN l.status = 'default' THEN 1 ELSE 0 END)::FLOAT / COUNT(l.loan_id) AS taxa_inadimplencia
FROM
    loans l
JOIN
    clients c ON l.user_id = c.user_id
GROUP BY
    month_year,
    c.batch
ORDER BY
	month_year ASC,  -- Primeiro por mês de forma ascendente
	taxa_inadimplencia DESC,
    c.batch ASC;     -- Depois por lote de forma ascendente

-- Este script SQL é projetado para analisar a performance dos empréstimos, especificamente observando a quantidade de empréstimos emitidos, 
-- o número de empréstimos inadimplentes, e a taxa de inadimplência, agrupados por mês e por batch (lote) de clientes.