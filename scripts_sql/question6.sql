SELECT
    SUM(l.loan_amount) AS total_emprestado,
    SUM(l.amount_paid) AS total_recebido,
    SUM(CASE WHEN l.status = 'default' THEN l.due_amount ELSE 0 END) AS total_inadimplencia,
    (SUM(l.amount_paid) - SUM(CASE WHEN l.status = 'default' THEN l.due_amount ELSE 0 END)) AS lucro_operacional
FROM
    loans l;

