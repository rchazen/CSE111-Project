
/* Insert Values To customer */
INSERT INTO customer (c_custKey, c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber, c_custAdminStatus)
VALUES (1,'JaneDoe', 'idk', 'California', 'BRAZIL', 'jdoe@gmail.com', '314-321-3515', False);

/* Deletes Row From customer Where c_custkey = # */
DELETE FROM customer WHERE c_custKey = 1;

/* Finding Ratings Made By Certain Customer 
   And Displaying User, AdminStatus, City,
   And Nation The Customer Is From */
SELECT c_custUser, c_custCity, c_custNation, c_custAdminStatus
FROM customer
WHERE c_custkey = (SELECT c_custKey
                    FROM rating, customer
                    WHERE c_custKey = r_custKey);

/* Updating A Customers Email And Phone Number */
UPDATE customer
SET c_custEmail = 'changed@ucmerced.edu', c_custPhoneNumber = '123-456-7890'
WHERE c_custKey = 2;

/* Showing The Store Locations To All Starbucks In Their Nation */
SELECT n_name, s_storeAddress
FROM stores, customer, nation
WHERE c_custNation = n_name
AND s_storeCountryCode = n_nationCountryCode;

/* When A Customer Wants To Find A Starbucks Location When They Are On Vacation */
SELECT n_name, s_storeAddress 
FROM stores, customer, nation
WHERE n_nationCountryCode = 'CA'
AND s_storeCountryCode = n_nationCountryCode;

/* Insert New Store Location */
INSERT INTO stores (s_storeKey, s_storeCountryCode, s_storeAddress)
VALUES ((SELECT COUNT(s_storeKey) FROM stores),'US', '3232 North St')

/* Update A Store Location */
UPDATE stores
SET s_storeAddess = '5400 North Lake Rd'
WHERE s_storeKey = 28389;

/* Delete Store Location Since Closed */
DELETE FROM stores WHERE s_storeKey = 28289;

/* Insert New Values For food */
INSERT INTO food (f_foodCategory, f_foodName, f_foodCalories, f_foodFat, f_foodCholesterol, f_foodSodium, f_foodCarbs, f_foodFiber, f_foodSugar, f_foodProtein)
VALUES ('Bakery', 'Testing', 350, 25, 5, 3, 5, 8, 12, 3);

/* Update Certain Values For food */
UPDATE food
SET f_foodName = 'Strawberry Cheesecake', f_foodSugar = 15
WHERE f_foodCategory = 'Bakery' AND f_foodName = 'Test';

/* Delete The Value That's Updated */
DELETE FROM food WHERE f_foodName = 'Strawberry Cheesecake';

/* Searching For Items In Category Protein Boxes w/ Sugar Less Than 10 */
SELECT *
FROM food
WHERE f_foodSugar <= 10 
AND f_foodCategory = 'Protein Boxes';

/* Querying Nutrition Data For Food To Find Items That Are < Than Something */
SELECT nu_name, nu_category, nu_calories, nu_sugar, nu_totalFat
FROM nutrition, food
WHERE nu_category = 'Bakery'
AND nu_name = f_foodName
AND nu_calories < 300
AND nu_sugar < 12
AND nu_totalFat < 15;

/* Select Drinks Based On Category, Milk Type, And Amount Of Sugar For Food And Drinks
   Where Combined Items Should Be Less Than Certain Amount */
/* What Drink Items Go With What Food Produce A Sugar Amount < Desired Level */
SELECT d_drinkCategory, d_drinkName, d_drinkMilk, d_drinkSugar, f_foodCategory, f_foodName, f_foodSugar
FROM drinks, food
WHERE d_drinkCategory = 'tea'
AND d_drinkMilk = 'Nonfat milk'
AND d_drinkSugar <= 20
AND f_foodSugar <= 10
GROUP BY f_foodName
HAVING d_drinkSugar + f_foodSugar <= 30;

/*
SELECT d_drinkCategory, d_drinkName, d_drinkSugar, f_foodCategory, f_foodName, f_foodSugar
FROM drinks, food
WHERE d_drinkSugar <= 20
AND f_foodSugar <= 10
GROUP BY f_foodName
HAVING d_drinkSugar + f_foodSugar <= 30;
*/

/* Insert New Values To drinks */
INSERT INTO drinks (d_drinkCategory, d_drinkName, d_drinkPortion, d_drinkCalories, d_drinkFat, d_drinkSugar, d_drinkCaffeine, d_drinkSize, d_drinkMilk, d_drinkWhippedCream)
VALUES ('Test', 'Test', 12, 320, 10, 15, 21, 'Tall', 'Sweetened', 'Unsweetened');

/* Updating drinks */
UPDATE drinks
SET d_drinkCalories = 123, d_drinkFat = 10, d_drinkSugar = 14, d_drinkSize = 'Grande'
WHERE d_drinkCategory = 'Test' AND d_drinkName = 'Test';

/* Deletes Row From drinks */
DELETE FROM drinks WHERE d_drinkName = 'Test';

/* Select ratings based on highest ratingScore and which customer made that rating */
SELECT r_custKey, r_ratingScore, r_ratingComment
FROM rating, customer
WHERE r_ratingScore = 4
AND c_custkey = r_custkey;

/* Insert New Customer Ratings Into rating */
/* Customer 1 */
INSERT INTO rating (r_ratingKey, r_ratingScore, r_ratingComment, r_custKey, r_itemName)
VALUES (1, 5, 'Testing', 1, 'Testing');

/* Customer 2 */
INSERT INTO rating (r_ratingKey, r_ratingScore, r_ratingComment, r_custKey, r_itemName)
VALUES (3, 5, 'Love this!', 2, 'Testing');

/* Update Certain Values For rating: when a user wants to change their ratings */
UPDATE rating
SET r_ratingScore = 4, r_ratingComment = 'Not bad.', r_itemName = "Strawberry Cheesecake"
WHERE r_ratingKey = 1;

/* Deletes A Certain Rating From rating */
DELETE FROM rating WHERE r_ratingKey = 3;

INSERT INTO customer(c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber, c_custAdminStatus)
VALUES ("rchazen", "pass", "San Diego", "UNITED STATES", "rchazen@gmail.com", "8587294104", TRUE) 

INSERT INTO customer(c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber, c_custAdminStatus)
VALUES ("jarmenta", "ucmiscool", "Merced", "UNITED STATES", "jarmenta@ucmerced.edu", "2094314029", FALSE) 

/* Adds a rating into the ratings table */
INSERT INTO rating(r_ratingScore, r_ratingComment, r_custKey, r_itemName)
VALUES(5, "Tasted very good", 1, "Chonga Bagel")

/* Adds a rating into the ratings table */
INSERT INTO rating(r_ratingScore, r_ratingComment, r_custKey, r_itemName)
VALUES(2, "Tasted too cheesy", 2, "Cheese Danish")

/* Selects customers username and shows what country they are from*/
SELECT c_custUser, n_name
FROM customer, nation
WHERE c_custNation = n_name

/* Selects drink that has more than 500 calories and < 80 grams of sugar*/
SELECT d_drinkName
FROM drinks, nutrition
WHERE d_drinkCalories >500
AND nu_name = d_drinkName
AND d_drinkSugar <80
ORDER BY nu_sugar DESC
LIMIT 1

/*Selects food with more than 500 calories and less than 10 grams of sugar */
SELECT f_foodName
FROM food, nutrition
WHERE f_foodCalories >500
AND nu_name = f_foodName
AND nu_sugar <10
ORDER BY nu_sugar DESC
LIMIT 1

/*Selects food with rating greater than 3 */

SELECT r_ratingScore, f_foodName
FROM rating, food
WHERE r_itemName = f_foodName
AND r_ratingScore >3

/* Counts the number of starbucks in each region */
SELECT r_regionName, COUNT(*) AS num_sbux
FROM stores, nation, region
WHERE s_storeCountryCode = n_nationCountryCode
AND r_regionKey = n_regionkey
GROUP BY r_regionName

/*Grabs a food item and shows details */
SELECT *
FROM food
WHERE f_foodFat <10
AND f_foodCalories <250
AND f_foodSugar = 0
LIMIT 1

/*Grabs a large drink item and shows details */
SELECT *
FROM drinks
WHERE d_drinkCalories = 0
AND d_drinkSize = "Venti"
LIMIT 1

/*Inserts everything into nutrition */
INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
SELECT f_foodCategory, f_foodName,f_foodCalories, f_foodSugar, f_foodFat
FROM food

/*Inserts everything into nutrition */
INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
SELECT d_drinkCategory, d_drinkName,d_drinkCalories, d_drinkSugar, d_drinkFat
FROM drinks
