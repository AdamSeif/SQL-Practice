# SQL Practice Example

This repository contains SQL practice exercises aimed at reinforcing SQL concepts and skills. The exercises cover various SQL operations, including updates, inserts, and queries, performed on a sample database schema.

## Database Schema

The practice exercises are based on a database schema consisting of the following tables:

- **Course**: Contains information about different courses offered.
- **CourseOffer**: Stores details about course offerings, including course ID, term, year, and number of students.
- **TA**: Holds data about teaching assistants, such as their IDs, names, and degree types.
- **HasWorkedOn**: Records TA assignments for course offerings, including TA ID, course offering ID, and hours worked.
- **Loves**: Indicates TAs' preferences for specific courses.

## Practice Exercises

### Part 1: SQL Updates

In this section, SQL UPDATE statements are used to modify existing data in the database. The exercises involve updating course names and adjusting TA hours based on specific criteria.

### Part 2: SQL Inserts

The INSERT statements in this section add new records to the database tables. New courses, course offerings, TAs, and TA-course preferences are inserted into their respective tables.

### Part 3: SQL Queries

This section contains a series of SQL queries designed to extract specific information from the database. The queries cover a range of topics, including basic SELECT operations, filtering, sorting, aggregation, joins, and the creation of views.

## Files

- **assignment2.sql**: Contains the SQL commands for the practice exercises.
- **README.md**: This README file describing the practice example.

## Usage

To practice SQL queries using this example:
1. Set up a database system (e.g., MySQL, PostgreSQL).
2. Create a database and execute the SQL commands from `initialize.sql`.
3. Run SQL queries against the populated database to practice SQL concepts.

## Acknowledgments

This SQL practice example is for educational purposes and is inspired by real-world database scenarios. The exercises are designed to help learners reinforce their SQL skills through hands-on practice.
