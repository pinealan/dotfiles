---
name: sql-schema
description: Use when writing SQL schema, CREATE TABLE statements, defining columns, naming tables or columns, writing JOINs in Postgres, or designing relational database structure.
---

# SQL Schema Conventions

## Table Naming

Use **singular** table names.

```sql
-- correct
CREATE TABLE user (...);
CREATE TABLE order (...);
CREATE TABLE product (...);

-- wrong
CREATE TABLE users (...);
CREATE TABLE orders (...);
```

## ID Column Naming

Name ID columns as `id`.

```sql
CREATE TABLE user (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    ...
);

CREATE TABLE order (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id  BIGINT NOT NULL REFERENCES user,
    ...
);
```

Foreign key columns follows pattern of `<table>_id`, referencing the table they point to: `user_id` references `user.id`.

## JOINs in Postgres

Use `USING` when joining on a simple foreign key to primary key (same column name on both sides). Fall back to `ON` only when column names differ or the join condition is more complex.

```sql
-- preferred: USING when column name matches on both sides
SELECT *
FROM order
JOIN user USING (user_id);

-- fall back to ON when column names differ or condition is complex
SELECT *
FROM order o
JOIN address a ON o.shipping_address_id = a.address_id;
```

`USING` deduplications the join column in `SELECT *` output and is more concise — prefer it whenever the column names align.
