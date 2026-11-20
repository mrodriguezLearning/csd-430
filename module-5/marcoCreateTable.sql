USE CSD430;

CREATE TABLE IF NOT EXISTS marco_states_data (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL,
    capital_city VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    visitor_rating DECIMAL(2,1) NOT NULL,
    highlights VARCHAR(255) NOT NULL
);