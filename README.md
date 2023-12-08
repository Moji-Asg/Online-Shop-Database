# Design Document

By [Mojtaba Asgari](https://github.com/Moji-Asg)

## Table of Content

* [Scope](#scope)
* [Functional Requirements](#functional-requirements)
* [Representation](#representation)
  * [Entities](#entities)
  * [Relationships](#relationships)
* [Optimizations](#optimizations)

## Scope

The purpose of the database is to manage a online shop system. It will store information about users, products, and orders.

The tables included in the scope of the database are:
* **Users**: Represents online shop users. It includes attributes like ID, first name, last name, bio, and username.
* **Products**: Represents individual products in the online shop. It includes attributes like ID, name, properties, price, inventory.
* **Orders**: Represents the orders of the online shop. It includes attributes like date, address, user, products.

## Functional Requirements

* Add, update, and delete products, users, and orders.
* Search for products and users by various criteria such as ID, name, etc.
* Check the availability of products for order.
* Register new users and manage them.
* Record orders history, including date and is done.

## Representation

### Entities

The entities represented in the database are:
1. Users:
   * Attributes: 
     * id* (INT) (auto-incremented)
     * username* (VARCHAR) (length >= 5)
     * password* (VARCHAR)
     * is_staff* (BOOL) (default: false)
     * is_superuser* (BOOL) (default: false)
     * is_active* (BOOL) (default: true)
     * last_login_date* (TIMESTAMP)
     * join_date* (TIMESTAMP) (default: CURRENT_TIMESTAMP),
   * Indexes:
     * username and password
   * Constraints
     * Primary key on id
     * Unique on username
2. Profiles:
   * Attributes:
     * user_id* (INT)
     * first_name* (VARCHAR 32)
     * last_name (VARCHAR 32)
     * bio (VARCHAR 128)
     * picture (BLOB)
   * Constraints:
     * Primary key on user_id
     * Foreign key on user_id references users.id
3. Categories:
   * Attributes:
     * id* (INT) (auto-incremented)
     * name* (VARCHAR 32)
     * slug* (VARCHAR 128)
     * is_active* (BOOL) (default: true)
   * Constraints:
     * Primary key on id
     * Unique on name
     * Unique on slug
4. Products:
   * Attributes:
     * id* (INT) (auto-incremented)
     * name* (TEXT)
     * description* (LONGTEXT)
     * category_id (INT)
     * is_active* (BOOL) (default: true)
   * Constraints:
     * Primary key on id
     * Foreign key on category_id references categories.id
5. Properties:
   * Attributes:
     * product_id* (INT)
     * property_name* (VARCHAR 16)
     * property_value* (TEXT)
     * price* (FLOAT)
     * count* (INT)
   * Indexes:
     * product_id
   * Constraints:
     * Foreign key on product_id references products.id
6. Addresses:
   * Attributes:
     * id* (INT)
     * address* (TEXT)
   * Constraints:
     * Primary key on id
7. Orders:
   * Attributes:
     * user_id* (INT)
     * product_id* (INT)
     * date* (TIMESTAMP)
     * address_id* (INT)
     * is_done (BOOL) (default: false)
   * Indexes:
     * user_id
   * Constraints:
   * Foreign key on user_id references users.id
   * Foreign key on product_id references products.id
   * Foreign key on address_id references addresses.id

### Relationships

![alt Diagram](https://github.com/Moji-Asg/Online-Shop-Database/blob/main/diagram.png?raw=true)

## Optimizations

The following optimizations have been implemented:
* Indexes have been created on frequently queried columns such as users username and password to improve search performance.