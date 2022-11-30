-- INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
-- SELECT f_foodCategory, f_foodName,f_foodCalories, f_foodSugar, f_foodFat
-- FROM food

-- INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
-- SELECT d_drinkCategory, d_drinkName,d_drinkCalories, d_drinkSugar, d_drinkFat
-- FROM drinks

-- INSERT INTO customer(c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber, c_custAdminStatus)
-- VALUES ("rchazen", "pass", "San Diego", "UNITED STATES", "rchazen@gmail.com", "8587294104", TRUE) 

-- INSERT INTO customer(c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber, c_custAdminStatus)
-- VALUES ("jarmenta", "ucmiscool", "Merced", "UNITED STATES", "jarmenta@ucmerced.edu", "2094314029", FALSE) 

-- INSERT INTO rating(r_ratingScore, r_ratingComment, r_custKey, r_itemName)
-- VALUES(5, "Tasted very good", 1, "Chonga Bagel")

-- INSERT INTO rating(r_ratingScore, r_ratingComment, r_custKey, r_itemName)
-- VALUES(2, "Tasted too cheesy", 2, "Cheese Danish")

-- SELECT c_custUser
-- FROM customer, nation
-- WHERE c_custNation = n_name

-- SELECT *
-- FROM drinks, nutrition
-- WHERE d_drinkCalories >500
-- AND nu_name = d_drinkName
-- AND d_drinkSugar <80
-- ORDER BY nu_sugar DESC
-- LIMIT 1

-- SELECT *
-- FROM food, nutrition
-- WHERE f_foodCalories >500
-- AND nu_name = f_foodName
-- AND nu_sugar <10
-- ORDER BY nu_sugar DESC
-- LIMIT 1

SELECT f_foodName, r_ratingScore, r_ratingComment
FROM food, rating
WHERE f_foodCalories < 1000
AND f_foodFat < 1000
AND f_foodCholesterol < 1000
AND f_foodSodium < 1000
AND f_foodCarbs < 1000
AND f_foodSugar < 1000
AND f_foodProtein < 1000
WHERE
ORDER BY RANDOM()
LIMIT 3

select f_foodName, r_ratingScore, r_ratingComment
FROM food, rating
WHERE r_itemName = f_foodName

-- SELECT r_ratingScore, f_foodName,  nu_calories, nu_sugar
-- FROM rating, food, nutrition
-- WHERE r_itemName = f_foodName
-- AND nu_name= f_foodName
-- AND r_ratingScore>3

-- SELECT r_regionName, COUNT(*) AS num_sbux
-- FROM stores, nation, region
-- WHERE s_storeCountryCode = n_nationCountryCode
-- AND r_regionKey = n_regionkey
-- GROUP BY r_regionName

-- SELECT *
-- FROM food
-- WHERE f_foodFat <10
-- AND f_foodCalories <250
-- AND f_foodSugar = 0
-- LIMIT 1

-- SELECT *
-- FROM drinks
-- WHERE d_drinkCalories = 0
-- AND d_drinkSize = "Venti"
-- LIMIT 1

