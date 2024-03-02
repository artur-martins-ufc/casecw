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

-- Este script SQL é utilizado para identificar o mês em que o montante total de empréstimos emitidos foi o mais alto.
-- O propósito desta consulta é descobrir qual mês registrou o maior volume de empréstimos em termos de valor total emprestado.
--entender em que período houve maior movimentação financeira na concessão de empréstimos, o que pode indicar períodos de alta demanda, 
--campanhas promocionais bem-sucedidas, ou outras condições de mercado que favoreceram o aumento do volume de empréstimos. 
--Com base nessas informações, a instituição financeira pode tomar decisões estratégicas, como ajustar ofertas de empréstimos, 
--planejar campanhas futuras, ou alocar recursos de forma mais eficaz para atender à demanda esperada em períodos semelhantes.