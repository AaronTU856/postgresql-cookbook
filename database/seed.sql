-- Seed data for the PostgreSQL Cookbook online store.
-- The dataset is intentionally small enough for beginners to inspect manually.

INSERT INTO users (first_name, last_name, email, city, country, created_at)
VALUES
    ('Amelia', 'Clark', 'amelia.clark@example.com', 'Manchester', 'United Kingdom', '2026-01-05 09:15:00+00'),
    ('Noah', 'Patel', 'noah.patel@example.com', 'Birmingham', 'United Kingdom', '2026-01-08 14:20:00+00'),
    ('Olivia', 'Hughes', 'olivia.hughes@example.com', 'Cardiff', 'United Kingdom', '2026-01-12 11:05:00+00'),
    ('Liam', 'Wilson', 'liam.wilson@example.com', 'Edinburgh', 'United Kingdom', '2026-01-19 16:45:00+00'),
    ('Ava', 'Morris', 'ava.morris@example.com', 'Bristol', 'United Kingdom', '2026-02-01 10:30:00+00'),
    ('Ethan', 'Taylor', 'ethan.taylor@example.com', 'London', 'United Kingdom', '2026-02-04 13:10:00+00');

INSERT INTO categories (name, description)
VALUES
    ('Books', 'Technical books and practical learning guides'),
    ('Stationery', 'Notebooks, planners, and desk supplies'),
    ('Electronics', 'Small electronics and development accessories'),
    ('Home Office', 'Equipment for remote and hybrid work');

INSERT INTO products (category_id, name, description, price, stock_quantity, is_active, created_at)
VALUES
    (1, 'PostgreSQL Pocket Guide', 'Compact guide for everyday PostgreSQL work', 18.99, 40, TRUE, '2026-01-03 08:00:00+00'),
    (1, 'Django APIs Handbook', 'Practical backend development with Django REST patterns', 29.50, 25, TRUE, '2026-01-04 08:00:00+00'),
    (2, 'Developer Notebook', 'Dot-grid notebook for planning features and schemas', 7.99, 120, TRUE, '2026-01-05 08:00:00+00'),
    (2, 'Kanban Sticky Notes', 'Reusable notes for task planning', 4.50, 200, TRUE, '2026-01-06 08:00:00+00'),
    (3, 'USB-C Dock', 'Compact dock for laptops and external monitors', 54.99, 15, TRUE, '2026-01-07 08:00:00+00'),
    (3, 'Mechanical Keyboard', 'Quiet mechanical keyboard for office use', 89.00, 10, TRUE, '2026-01-08 08:00:00+00'),
    (4, 'Laptop Stand', 'Adjustable aluminium laptop stand', 32.00, 30, TRUE, '2026-01-09 08:00:00+00'),
    (4, 'Desk Lamp', 'LED desk lamp with adjustable brightness', 24.75, 18, TRUE, '2026-01-10 08:00:00+00');

INSERT INTO orders (user_id, status, order_date, shipping_city, shipping_country)
VALUES
    (1, 'delivered', '2026-02-10 10:00:00+00', 'Manchester', 'United Kingdom'),
    (2, 'shipped', '2026-02-12 15:30:00+00', 'Birmingham', 'United Kingdom'),
    (3, 'paid', '2026-02-13 09:45:00+00', 'Cardiff', 'United Kingdom'),
    (4, 'pending', '2026-02-15 18:20:00+00', 'Edinburgh', 'United Kingdom'),
    (5, 'cancelled', '2026-02-17 12:05:00+00', 'Bristol', 'United Kingdom'),
    (6, 'delivered', '2026-02-20 08:40:00+00', 'London', 'United Kingdom'),
    (1, 'paid', '2026-03-01 11:25:00+00', 'Manchester', 'United Kingdom');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 18.99),
    (1, 3, 2, 7.99),
    (2, 5, 1, 54.99),
    (2, 7, 1, 32.00),
    (3, 2, 1, 29.50),
    (3, 4, 3, 4.50),
    (4, 6, 1, 89.00),
    (5, 8, 1, 24.75),
    (6, 5, 1, 54.99),
    (6, 6, 1, 89.00),
    (7, 1, 1, 18.99),
    (7, 7, 1, 32.00);

INSERT INTO payments (order_id, amount, payment_method, status, paid_at)
VALUES
    (1, 34.97, 'card', 'completed', '2026-02-10 10:03:00+00'),
    (2, 86.99, 'paypal', 'completed', '2026-02-12 15:35:00+00'),
    (3, 43.00, 'card', 'completed', '2026-02-13 09:48:00+00'),
    (4, 89.00, 'bank_transfer', 'pending', NULL),
    (5, 24.75, 'card', 'refunded', '2026-02-17 12:07:00+00'),
    (6, 143.99, 'card', 'completed', '2026-02-20 08:44:00+00'),
    (7, 50.99, 'gift_card', 'completed', '2026-03-01 11:28:00+00');
