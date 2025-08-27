-- Sample Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Smith', 'alice@example.com', 'hash1', '1234567890', 'host', CURRENT_TIMESTAMP),
('22222222-2222-2222-2222-222222222222', 'Bob', 'Johnson', 'bob@example.com', 'hash2', NULL, 'guest', CURRENT_TIMESTAMP),
('33333333-3333-3333-3333-333333333333', 'Carol', 'Williams', 'carol@example.com', 'hash3', '0987654321', 'admin', CURRENT_TIMESTAMP);

-- Sample Properties
INSERT INTO "Property" (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 'Cozy Cottage', 'A small cozy cottage in the woods.', 'Springfield', 120.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111', 'Urban Apartment', 'Modern apartment in the city center.', 'Metropolis', 200.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Sample Bookings
INSERT INTO "Booking" (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', '2025-09-01', '2025-09-05', 480.00, 'confirmed', CURRENT_TIMESTAMP),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '22222222-2222-2222-2222-222222222222', '2025-10-10', '2025-10-12', 400.00, 'pending', CURRENT_TIMESTAMP);

-- Sample Payments
INSERT INTO "Payment" (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 480.00, CURRENT_TIMESTAMP, 'credit_card'),
('ccccccc2-cccc-cccc-cccc-ccccccccccc2', 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 400.00, CURRENT_TIMESTAMP, 'paypal');

-- Sample Reviews
INSERT INTO "Review" (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('ddddddd1-dddd-dddd-dddd-dddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', 5, 'Amazing stay, highly recommended!', CURRENT_TIMESTAMP),
('ddddddd2-dddd-dddd-dddd-dddddddddddd2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '22222222-2222-2222-2222-222222222222', 4, 'Great location, clean apartment.', CURRENT_TIMESTAMP);

-- Sample Messages
INSERT INTO "Message" (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi, is the cottage available for next weekend?', CURRENT_TIMESTAMP),
('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Yes, it is available!', CURRENT_TIMESTAMP);
