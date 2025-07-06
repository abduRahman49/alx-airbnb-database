-- ENUM CREATION
CREATE TYPE role_type
AS
ENUM('guest', 'host', 'admin');

CREATE TYPE status_type
AS
ENUM('confirmed', 'canceled', 'pending');

CREATE TYPE payment_type
AS
ENUM('credit_card', 'paypal', 'stripe');

-- TABLES CREATION
CREATE TABLE user(
    user_id UUID PRIMARY KEY,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    password_hash varchar(100) NOT NULL,
    phone_number varchar(100) NULL,
    role role_type NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE property(
    property_id UUID PRIMARY KEY,
    host_id UUID,
    name varchar(100) NOT NULL,
    description TEXT NOT NULL,
    location varchar(100) NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(host_id) REFERENCES "user"(user_id)
)

CREATE TABLE booking(
    booking_id UUID PRIMARY KEY,
    property_id UUID,
    user_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status status_type NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(property_id) REFERENCES "property"(property_id),
    FOREIGN KEY(user_id) REFERENCES "user"(user_id),
)

CREATE TABLE payment(
    payment_id UUID PRIMARY KEY,
    booking_id UUID,
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_type NOT NULL,
    FOREIGN KEY(booking_id) REFERENCES "booking"(booking_id)
)

CREATE TABLE review(
    review_id UUID PRIMARY KEY,
    property_id UUID,
    user_id UUID,
    rating INTEGER CHECK(rating >= 1 AND rating <= 5) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(property_id) REFERENCES "property"(property_id),
    FOREIGN KEY(user_id) REFERENCES "user"(user_id)
)

CREATE TABLE message(
    message_id UUID PRIMARY KEY,
    sender_id UUID,
    recepient_id UUID,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(sender_id) REFERENCES "user"(user_id),
    FOREIGN KEY(recepient_id) REFERENCES "user"(user_id)
)

-- INDEXES DEFINITION
CREATE INDEX [IF NOT EXISTS] email_index
ON user(email);

CREATE INDEX [IF NOT EXISTS] property_index
ON property(property_id);

CREATE INDEX [IF NOT EXISTS] property_booking_index
ON booking(property_id);

CREATE INDEX [IF NOT EXISTS] booking_index
ON booking(booking_id);

CREATE INDEX [IF NOT EXISTS] booking_payment_index
ON payment(booking_id);
