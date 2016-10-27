AVTIVE RECORD OWNER CREDIT CARDS CHALLENGE

--Create a database that reflects the following relationships using psql:
--Inside Terminal:
learn15:~ learn$ psql postgres
postgres=# create database customer_database;
CREATE DATABASE
postgres=# \c customer_database
You are now connected to database "customer_database" as user "learn".

--A credit card has a number, an expiration date, and an owner. An owner has a name and address, and can have multiple credit cards.
customer_database=# create table owners (id serial PRIMARY KEY, name varchar, address varchar);
CREATE TABLE
customer_database=# create table creditcards (id serial PRIMARY KEY, owner_id integer references owners(id) NOT NULL, number numeric, expiration date);
CREATE TABLE


-- Open another Terminal (input into new Terminal)
--learn15:desktop learn$ rails new customer_database -T --database=postgresql


-- Manipulating Data
--
-- Using ActiveRecord in rails console:
--
-- Create an owner and save them in the database
jeannette = Owner.new
 => #<Owner id: nil, name: nil, address: nil>
2.2.2 :005 > jeannette.save
   (0.2ms)  BEGIN
  SQL (0.4ms)  INSERT INTO "owners" DEFAULT VALUES RETURNING "id"
   (15.7ms)  COMMIT
 => true
2.2.2 :006 > jessica = Owner.new
 => #<Owner id: nil, name: nil, address: nil>
2.2.2 :007 > jessica.save
   (0.2ms)  BEGIN
  SQL (0.3ms)  INSERT INTO "owners" DEFAULT VALUES RETURNING "id"
   (1.2ms)  COMMIT
 => true


-- Create a credit card in the database for that owner option 1
visa = creditcard.new
visa.number = 2343
visa.owner = jessica
visa.save

-- Create a credit card in the database for that owner option 2
jeannette = Owner.find_by_name('Jeannette')
visa = creditcard.new
visa.number = 7777
jeannette.creditcards << visa

Using ActiveRecord in rails console, find the total credit extended to the owner with two credit cards
from -e:1:in `<main>'2.2.2 :075 > owner = Owner.find_by_name('Jeannette')
Owner Load (0.2ms)  SELECT  "owners".* FROM "owners" WHERE "owners"."name" = $1 LIMIT 1  [["name", "Jeannette"]]
=> #<Owner id: 1, name: "Jeannette", address: "10823 Pacific Way">
2.2.2 :076 > owner.creditcards
Creditcard Load (0.3ms)  SELECT "creditcards".* FROM "creditcards" WHERE "creditcards"."owner_id" = $1  [["owner_id", 1]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Creditcard id: 8, owner_id: 1, number: #<BigDecimal:7fd5c6068120,'0.777E3',9(18)>, expiration: nil>, #<Creditcard id: 9, owner_id: 1, number: #<BigDecimal:7fd5c605bb50,'0.4567E4',9(18)>, expiration: nil>]>
2.2.2 :077 > total_credit_limit= 0
=> 0
2.2.2 :078 > owner.creditcards.each do |cc|
2.2.2 :079 >     total_credit_limit = total_credit_limit + cc.creditlimit
2.2.2 :080?>   end
=> [#<Creditcard id: 8, owner_id: 1, number: #<BigDecimal:7fd5c6068120,'0.777E3',9(18)>, expiration: nil>, #<Creditcard id: 9, owner_id: 1, number: #<BigDecimal:7fd5c605bb50,'0.4567E4',9(18)>, expiration: nil>]
2.2.2 :081 > total_credit_limit
=> #<BigDecimal:7fd5c603bb70,'0.2E4',9(18)>
2.2.2 :082 > total_credit_limit.to_s
=> "2000.0"
2.2.2 :083 >


^
customer_database=# create table creditcards (id serial PRIMARY KEY, owner_id integer references owners(id) NOT NULL, number numeric, expiration date);
CREATE TABLE
customer_database=# select * from owners
customer_database-# ;
id |   name    |      address
----+-----------+-------------------
1 | Jeannette | 10823 Pacific Way
2 | Jessica   | 123 Garnet
(2 rows)

customer_database=# select * from owners
;
id |   name    |      address
----+-----------+-------------------
1 | Jeannette | 10823 Pacific Way
2 | Jessica   | 123 Garnet
3 | Jeannette | Pacific Way
(3 rows)

customer_database=# select * from creditcards;
;
id | owner_id | number | expiration
----+----------+--------+------------
1 |        3 |        |
(1 row)

customer_database=# select * from creditcards;
;
id | owner_id | number | expiration
----+----------+--------+------------
(0 rows)

customer_database=# select * from owners;
;
id |   name    |      address
----+-----------+-------------------
1 | Jeannette | 10823 Pacific Way
2 | Jessica   | 123 Garnet
(2 rows)

customer_database=# select * from owners;
;
id |   name    |      address
----+-----------+-------------------
1 | Jeannette | 10823 Pacific Way
2 | Jessica   | 123 Garnet
(2 rows)

customer_database=# select * from creditcards;
;
id | owner_id | number | expiration
----+----------+--------+------------
(0 rows)

customer_database=# select * from creditcards;
;
id | owner_id | number | expiration
----+----------+--------+------------
6 |        2 | 2345.0 |
(1 row)

customer_database=# select * from owners;
;
id |   name    |      address
----+-----------+-------------------
1 | Jeannette | 10823 Pacific Way
2 | Jessica   | 123 Garnet
(2 rows)

customer_database=# select * from creditcards;
;
id | owner_id | number  | expiration
----+----------+---------+------------
6 |        2 |  2345.0 |
7 |        2 | 23421.0 |
(2 rows)

customer_database=# select * from owners;
;
id |   name    |      address
----+-----------+-------------------
1 | Jeannette | 10823 Pacific Way
2 | Jessica   | 123 Garnet
(2 rows)

customer_database=# select * from creditcards
customer_database-# ;
id | owner_id | number  | expiration
----+----------+---------+------------
6 |        2 |  2345.0 |
7 |        2 | 23421.0 |
8 |        1 |   777.0 |
(3 rows)

customer_database=# select * from creditcards
;
id | owner_id | number  | expiration
----+----------+---------+------------
6 |        2 |  2345.0 |
7 |        2 | 23421.0 |
8 |        1 |   777.0 |
9 |        1 |  4567.0 |
(4 rows)

customer_database=# alter table creditcards add creditlimit numeric;
ALTER TABLE
customer_database=# select * from creditcards;
id | owner_id | number  | expiration | creditlimit
----+----------+---------+------------+-------------
6 |        2 |  2345.0 |            |
7 |        2 | 23421.0 |            |
8 |        1 |   777.0 |            |
9 |        1 |  4567.0 |            |
(4 rows)

customer_database=# UPDATE creditcards set creditlimit = 3000 where owner_id = 2;
UPDATE 2
customer_database=# select * from creditcards;
id | owner_id | number  | expiration | creditlimit
----+----------+---------+------------+-------------
8 |        1 |   777.0 |            |
9 |        1 |  4567.0 |            |
6 |        2 |  2345.0 |            |        3000
7 |        2 | 23421.0 |            |        3000
(4 rows)

customer_database=# UPDATE creditcards set creditlimit = 1000 where owner_id = 1;
UPDATE 2
customer_database=# select * from creditcards;
id | owner_id | number  | expiration | creditlimit
----+----------+---------+------------+-------------
6 |        2 |  2345.0 |            |        3000
7 |        2 | 23421.0 |            |        3000
8 |        1 |   777.0 |            |        1000
9 |        1 |  4567.0 |            |        1000
(4 rows)

customer_database=# 

ActiveRecord TASK LIST CHALLENGE
-- As a programmer, I can create a new Task record with a title, which is a string, and description, which is a string.
