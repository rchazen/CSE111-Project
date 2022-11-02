-- INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
-- SELECT f_foodCategory, f_foodName,f_foodCalories, f_foodSugar, f_foodFat
-- FROM food

INSERT INTO nutrition (nu_category, nu_name, nu_calories, nu_sugar, nu_totalFat)
SELECT d_drinkCategory, d_drinkName,d_drinkCalories, d_drinkSugar, d_drinkFat
FROM drinks