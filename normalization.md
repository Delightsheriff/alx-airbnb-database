# Database Normalization to Third Normal Form (3NF)

## Property Booking System

### Original Schema Analysis

From the provided ER diagram, I identified the following entities and their relationships:

- **USER** (owns properties, makes bookings, writes reviews, sends messages)
- **PROPERTY** (owned by users, booked by users, reviewed)
- **BOOKING** (made by users for properties, generates payments)
- **REVIEW** (written by users for properties, generates messages)
- **MESSAGE** (sent by users, paid for)
- **PAYMENT** (made by users for bookings)

### Normalization Process

#### Step 1: First Normal Form (1NF)

**Requirement**: Eliminate repeating groups and ensure atomic values.

**Issues Identified**:

- Need to ensure all attributes contain only atomic (indivisible) values
- Remove any multi-valued attributes

**Normalized Tables**:

```sql
-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    date_created TIMESTAMP,
    is_active BOOLEAN
);

-- Properties table
CREATE TABLE properties (
    property_id INT PRIMARY KEY,
    owner_id INT,
    property_name VARCHAR(100),
    description TEXT,
    address_line1 VARCHAR(100),
    address_line2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    country VARCHAR(50),
    property_type VARCHAR(30),
    max_guests INT,
    bedrooms INT,
    bathrooms DECIMAL(2,1),
    price_per_night DECIMAL(10,2),
    is_available BOOLEAN,
    date_created TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id)
);
```

#### Step 2: Second Normal Form (2NF)

**Requirement**: Must be in 1NF and eliminate partial dependencies (non-key attributes must depend on the entire primary key).

**Issues Identified**:

- Composite keys need examination for partial dependencies
- Booking-related attributes that depend only on part of composite keys

**Normalized Tables**:

```sql
-- Bookings table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    property_id INT,
    guest_id INT,
    check_in_date DATE,
    check_out_date DATE,
    total_guests INT,
    total_amount DECIMAL(10,2),
    booking_status VARCHAR(20),
    date_created TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (guest_id) REFERENCES users(user_id)
);

-- Reviews table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    property_id INT,
    reviewer_id INT,
    booking_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    date_created TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (reviewer_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
```

#### Step 3: Third Normal Form (3NF)

**Requirement**: Must be in 2NF and eliminate transitive dependencies (non-key attributes should not depend on other non-key attributes).

**Issues Identified and Resolved**:

1. **Address Information**: City, state, country information could have dependencies
2. **Payment Methods**: Credit card details might have transitive dependencies
3. **Property Categories**: Property types could be normalized further
4. **User Roles**: User types/roles might need separate handling

**Final 3NF Schema**:

```sql
-- Property types lookup table (eliminates transitive dependency)
CREATE TABLE property_types (
    type_id INT PRIMARY KEY,
    type_name VARCHAR(30) UNIQUE,
    description TEXT
);

-- Location information (eliminates transitive dependencies in address)
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    zip_code VARCHAR(10)
);

-- Updated properties table
CREATE TABLE properties (
    property_id INT PRIMARY KEY,
    owner_id INT,
    property_name VARCHAR(100),
    description TEXT,
    address_line1 VARCHAR(100),
    address_line2 VARCHAR(100),
    location_id INT,
    property_type_id INT,
    max_guests INT,
    bedrooms INT,
    bathrooms DECIMAL(2,1),
    price_per_night DECIMAL(10,2),
    is_available BOOLEAN,
    date_created TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (property_type_id) REFERENCES property_types(type_id)
);

-- Payment methods table (eliminates transitive dependencies)
CREATE TABLE payment_methods (
    payment_method_id INT PRIMARY KEY,
    user_id INT,
    method_type VARCHAR(20), -- 'credit_card', 'paypal', 'bank_transfer'
    is_default BOOLEAN,
    date_added TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    payment_method_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    transaction_id VARCHAR(100),
    payment_date TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id)
);

-- Messages table
CREATE TABLE messages (
    message_id INT PRIMARY KEY,
    sender_id INT,
    recipient_id INT,
    booking_id INT NULL, -- Optional relation to booking
    review_id INT NULL,  -- Optional relation to review
    subject VARCHAR(200),
    message_body TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    date_sent TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (review_id) REFERENCES reviews(review_id)
);

-- Property amenities (many-to-many relationship)
CREATE TABLE amenities (
    amenity_id INT PRIMARY KEY,
    amenity_name VARCHAR(50) UNIQUE,
    description TEXT
);

CREATE TABLE property_amenities (
    property_id INT,
    amenity_id INT,
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id)
);
```

### Normalization Violations Resolved

#### 1. **Transitive Dependencies Eliminated**:

- **Location Data**: Separated city, state, country into a locations table
- **Property Types**: Created a separate property_types table
- **Payment Methods**: Extracted payment method details from payments

#### 2. **Redundancy Reduction**:

- Property type names no longer repeated across multiple properties
- Location information normalized to prevent data duplication
- Payment method information separated from individual payments

#### 3. **Data Integrity Improvements**:

- Added appropriate constraints and foreign key relationships
- Ensured referential integrity between related entities
- Added check constraints for data validation (e.g., rating range)

### Benefits of 3NF Implementation

1. **Eliminated Data Redundancy**: No duplicate storage of property types, locations, or payment methods
2. **Improved Data Integrity**: Changes to property types or locations only need to be made in one place
3. **Reduced Storage Space**: Less duplicate data means more efficient storage
4. **Easier Maintenance**: Updates to reference data (types, locations) are centralized
5. **Better Query Performance**: Normalized structure often leads to more efficient queries
6. **Scalability**: Structure can easily accommodate new property types, locations, and amenities

### Verification of 3NF Compliance

**First Normal Form**: ✅

- All attributes contain atomic values
- No repeating groups
- Each table has a primary key

**Second Normal Form**: ✅

- All non-key attributes are fully dependent on the primary key
- No partial dependencies exist

**Third Normal Form**: ✅

- No transitive dependencies remain
- Non-key attributes depend only on the primary key
- Reference data has been properly separated

This normalized database design ensures data integrity, reduces redundancy, and provides a solid foundation for the property booking system while maintaining all necessary relationships between entities.
