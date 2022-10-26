/* Customer */
CREATE TABLE Customer (
    c_custKey INTEGER PRIMARY KEY,
    c_custUser VARCHAR(25) NOT NULL,
    c_custPass VARCHAR(25) NOT NULL,
    c_custCity VARCHAR(50) NOT NULL,
    c_custNation VARCHAR(50) NOT NULL,
    c_custEmail VARCHAR(50) NOT NULL,
    c_custPhoneNumber VARCHAR(25) NOT NULL,
    c_custAdminStatus BOOLEAN NOT NULL
)

/* Food */
/*
CREATE TABLE Food (
    f_foodKey INTEGER PRIMARY KEY,
    f_foodCategory VARCHAR(50) NOT NULL,
    f_foodName VARCHAR(50) NOT NULL,
    f_foodCholesterol INTEGER NOT NULL,
    f_foodSodium INTEGER NOT NULL,
    f_foodCarbs INTEGER NOT NULL,
    f_foodFiber INTEGER NOT NULL,
    f_foodProtein INTEGER NOT NULL,
)   
*/

/* Drinks */
/*
CREATE TABLE Drinks (
    d_drinkKey INTEGER PRIMARY KEY,
    d_drinkCategory VARCHAR(50) NOT NULL,
    d_drinkName VARCHAR(50) NOT NULL,
    d_drinkPortion INTEGER NOT NULL,
    d_drinkCaffeine INTEGER NOT NULL,
    d_drinkSize VARCHAR(25) NOT NULL,
    d_drinkMilk VARCHAR(50) NOT NULL,
    d_drinkWhippedCream VARCHAR(50) NOT NULL
)
*/

/* Nutrition */
CREATE TABLE Nutrition (
    nu_category VARCHAR(50) NOT NULL,
    nu_name VARCHAR(50) NOT NULL,
    nu_calories INTEGER NOT NULL,
    nu_sugar INTEGER NOT NULL,
    nu_totalFat INTEGER NOT NULL
)

/* Ratings */
CREATE TABLE Ratings (
    r_ratingScore INTEGER NOT NULL,
    r_ratingComment VARCHAR(1000) NOT NULL,
    r_custKey INTEGER NOT NULL
)

/* Store */
/*
CREATE TABLE Store (
    s_storeKey INTEGER PRIMARY KEY,
    s_storeCountryCode INTEGER NOT NULL,
    s_storeAddress VARCHAR(50) NOT NULL
)
*/

/* Nation */
/*
CREATE TABLE Nation (
    n_nationKey INTEGER PRIMARY KEY,
    n_nationName VARCHAR(50) NOT NULL,
    n_regionKey INTEGER NOT NULL,
    n_nationCountryCode INTEGER NOT NULL
)
*/

/* Region */
/*
CREATE TABLE Region (
    r_regionKey INTEGER PRIMARY KEY,
    r_regionName VARCHAR(50) NOT NULL,
    r_comment VARCHAR(500) NOT NULL
)
*/