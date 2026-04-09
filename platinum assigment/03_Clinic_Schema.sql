CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50),
    name VARCHAR(100),
    mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50),
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount FLOAT,
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    eid VARCHAR(50),
    cid VARCHAR(50),
    description TEXT,
    amount FLOAT,
    datetime DATETIME
);

-- Sample Data
INSERT INTO clinics VALUES ('c1','Clinic A','City1','State1','India');

INSERT INTO customer VALUES ('u1','John','999');

INSERT INTO clinic_sales VALUES
('o1','u1','c1',5000,'2021-09-10 10:00:00','online'),
('o2','u1','c1',3000,'2021-09-15 12:00:00','offline');

INSERT INTO expenses VALUES
('e1','c1','rent',2000,'2021-09-05 09:00:00'),
('e2','c1','staff',1000,'2021-09-20 09:00:00');