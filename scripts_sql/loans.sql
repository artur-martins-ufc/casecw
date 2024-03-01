CREATE TABLE loans (
    user_id INT,
    loan_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    due_at TIMESTAMP,
    paid_at TIMESTAMP,
    status VARCHAR(20),
    loan_amount FLOAT,
    tax FLOAT,
    due_amount FLOAT,
    amount_paid FLOAT,
    FOREIGN KEY (user_id) REFERENCES clients(user_id)
);