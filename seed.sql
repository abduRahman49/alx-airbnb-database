/* ───────────────────────────────
   USERS
   ─────────────────────────────── */
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash,
                    phone_number, role, created_at)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Sarah',  'Host',  'sarah.host@example.com',
     '$argon2id$v=19$m=65536,t=3,p=1$...', '+221770000001', 'host',  NOW()),   -- hôte
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'John',   'Guest', 'john.guest@example.com',
     '$argon2id$v=19$m=65536,t=3,p=1$...', '+221770000002', 'guest', NOW()),   -- client
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Ada',    'Admin', 'ada.admin@example.com',
     '$argon2id$v=19$m=65536,t=3,p=1$...', NULL,        'admin', NOW());        -- admin

/* ───────────────────────────────
   PROPERTIES
   ─────────────────────────────── */
INSERT INTO property (property_id, host_id, name, description, location,
                      pricepernight, created_at, updated_at)
VALUES
    ('dddddddd-dddd-dddd-dddd-dddddddddddd',
     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
     'Villa Baobab',
     'Jolie villa avec piscine à Saly.',
     'Saly, Sénégal',
     120.00,
     NOW(), NOW()),

    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
     'Studio Almadies',
     'Studio cosy proche plage et restaurants.',
     'Dakar, Sénégal',
     90.00,
     NOW(), NOW());

/* ───────────────────────────────
   BOOKINGS
   ─────────────────────────────── */
INSERT INTO booking (booking_id, property_id, user_id,
                     start_date, end_date, total_price, status, created_at)
VALUES
    -- Réservation confirmée : 4 nuits x 120 € = 480 €
    ('ffffffff-ffff-ffff-ffff-ffffffffffff',
     'dddddddd-dddd-dddd-dddd-dddddddddddd',
     'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '2025-08-01', '2025-08-05', 480.00, 'confirmed', NOW()),

    -- Réservation en attente : 3 nuits x 90 € = 270 €
    ('11112222-3333-4444-5555-666677778888',
     'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
     'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '2025-09-10', '2025-09-13', 270.00, 'pending', NOW());

/* ───────────────────────────────
   PAYMENTS
   ─────────────────────────────── */
INSERT INTO payment (payment_id, booking_id, amount, payment_method, payment_date)
VALUES
    ('99999999-9999-9999-9999-999999999999',
     'ffffffff-ffff-ffff-ffff-ffffffffffff',
     480.00, 'credit_card', NOW());

/* ───────────────────────────────
   REVIEWS
   ─────────────────────────────── */
INSERT INTO review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('aaaabbbb-cccc-dddd-eeee-ffff00001111',
     'dddddddd-dddd-dddd-dddd-dddddddddddd',
     'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     5,
     'Séjour parfait ! Propreté et accueil irréprochables.',
     NOW());

/* ───────────────────────────────
   MESSAGES
   ─────────────────────────────── */
INSERT INTO message (message_id, sender_id, recepient_id, message_body, sent_at)
VALUES
    ('aaaa1111-bbbb-2222-cccc-3333dddd4444',
     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',  -- Sarah → John
     'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'Bonjour John, hâte de vous accueillir à la Villa!',
     NOW()),

    ('bbbb2222-cccc-3333-dddd-4444eeee5555',
     'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',  -- John → Sarah
     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
     'Merci Sarah! Nous sommes impatients.',
     NOW());
