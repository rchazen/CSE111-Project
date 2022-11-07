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


-- SELECT c_custUser
-- FROM customer, nation
-- WHERE c_custNation = n_name

-- SELECT *
-- FROM drinks, nutrition
-- WHERE d_drinkCalories >500
-- AND nu_name = d_drinkName
-- AND nu_sugar <50
-- ORDER BY nu_sugar DESC
-- LIMIT 1

-- SELECT *
-- FROM food, nutrition
-- WHERE f_foodCalories >500
-- AND nu_name = f_foodName
-- AND nu_sugar <10
-- ORDER BY nu_sugar DESC
-- LIMIT 1


