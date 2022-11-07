-- INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
-- SELECT f_foodCategory, f_foodName,f_foodCalories, f_foodSugar, f_foodFat
-- FROM food

-- INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
-- SELECT d_drinkCategory, d_drinkName,d_drinkCalories, d_drinkSugar, d_drinkFat
-- FROM drinks

/* Insert Values To customer */
INSERT INTO customer (c_custKey, c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber, c_custAdminStatus)
VALUES (1,'JaneDoe', 'idk', 'California', 'AL', 'jdoe@gmail.com', '314-321-3515', False);

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

/* Showing The Store Locations To All Starbucks In Their Nation */
SELECT s_storeAddress
FROM stores, customer, nation
WHERE c_custNation = n_nationCountryCode
AND s_storeCountryCode = n_nationCountryCode;

/* When A Customer Wants To Find A Starbucks Location When They Are On Vacation */
SELECT s_storeAddress 
FROM stores, customer, nation
WHERE n_nationCountryCode = 'CA'
AND s_storeCountryCode = n_nationCountryCode;

/* Insert New Store Location */
INSERT INTO stores (s_storeKey, s_storeCountryCode, s_storeAddress)
VALUES ((SELECT COUNT(s_storeKey) FROM stores),'US', '3232 North St')

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

/* Querying Nutrition To Find Items That Are < Than Something */
/* *** DOESN'T WORK AS EXPECTED */
/*
SELECT *
FROM nutrition
WHERE nu_category = 'Bakery'
AND nu_sugar < 5;
*/

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

/* Deletes Row From drinks */
DELETE FROM drinks WHERE d_drinkName = 'Test';

/* Select ratings based on highest ratingScore and which customer made that rating */
SELECT r_custKey, r_ratingScore, r_ratingComment
FROM rating, customer
WHERE r_ratingScore = 4
AND c_custkey = r_custkey;

/* Insert New Customer Ratings Into rating */
/* Customer 1 */
INSERT INTO rating (r_ratingKey, r_ratingScore, r_ratingComment, r_custKey)
VALUES (2, 5, 'Testing', 1);

/* Customer 2 */
INSERT INTO rating (r_ratingKey, r_ratingScore, r_ratingComment, r_custKey)
VALUES (3, 5, 'Love this!', 2);

/* Update Certain Values For rating: when a user wants to change their ratings */
UPDATE rating
SET r_ratingScore = 4, r_ratingComment = 'Not bad.'
WHERE r_ratingKey = 1;

/* Deletes A Certain Rating From rating */
DELETE FROM rating WHERE r_ratingKey = 1;