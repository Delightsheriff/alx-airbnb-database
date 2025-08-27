# AirBnB Database Schema

This folder contains the SQL schema for the AirBnB database, designed to support core features such as user management, property listings, bookings, payments, reviews, and messaging.

## Entities

- **User**: Hosts, guests, and admins.
- **Property**: Listings owned by hosts.
- **Booking**: Reservations made by users for properties.
- **Payment**: Payments for bookings.
- **Review**: User reviews for properties.
- **Message**: Communication between users.

## Features

- Proper primary and foreign key constraints.
- Data integrity via checks and non-null constraints.
- Indexes for optimal query performance.
- ENUM-like constraints for roles, booking status, and payment methods.

## Usage

1. Run `schema.sql` in your PostgreSQL-compatible database.
2. Tables will be created with all constraints and indexes.
3. Ready for data insertion and application integration.

## Indexing

- Primary keys are indexed automatically.
- Additional indexes on frequently queried columns (email, property_id, booking_id, etc.).

## ER Diagram

See the ER diagram in the parent folder for
