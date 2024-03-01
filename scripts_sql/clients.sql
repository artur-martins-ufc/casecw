CREATE TABLE clients (
    user_id SERIAL PRIMARY KEY,
    created_at TIMESTAMP,
    status VARCHAR(20),
    batch INTEGER,
    credit_limit INTEGER,
    interest_rate INTEGER,
    denied_reason VARCHAR(100),
    denied_at TIMESTAMP
);