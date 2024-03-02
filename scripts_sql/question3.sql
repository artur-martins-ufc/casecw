--Este script SQL é projetado para analisar a relação entre a taxa de juros aplicada aos clientes e a inadimplência nos empréstimos. 
--O objetivo é entender como diferentes taxas de juros afetam a probabilidade de os empréstimos entrarem em default (inadimplência).

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

--A análise busca identificar se taxas de juros mais altas estão correlacionadas com maiores taxas de inadimplência, 
--o que pode indicar que empréstimos com juros mais elevados representam um risco maior para a instituição financeira. 
--Por outro lado, taxas de juros mais baixas podem ou não apresentar menores taxas de inadimplência, dependendo de outros fatores como o perfil de crédito do cliente, 
--o prazo do empréstimo, entre outros.