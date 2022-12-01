import flask
from flask import Flask, redirect, url_for, jsonify
from flask import request, flash
from flask import abort, render_template
from flask_sqlalchemy import SQLAlchemy
import json
import pandas as pd
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView
from flask_login import LoginManager, UserMixin, login_user, logout_user, current_user, login_required
from sqlalchemy import text


app = Flask(__name__)
app.secret_key = 'shhh'

with app.app_context():
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///db.sqlite3"

    # Instantiate the database.
    db = SQLAlchemy(app)
    #db.init_app(app)
    admin = Admin(app)
    #Sets up login manager
    login_manager = LoginManager()
    login_manager.login_view = 'logIn'
    login_manager.init_app(app)

    #from models import *
    class Customer(UserMixin, db.Model):
        c_custKey         = db.Column(db.Integer, primary_key = True)
        c_custUser        = db.Column(db.String, unique = True, nullable = False)
        c_custPass        = db.Column(db.String, unique = False, nullable = False)
        c_custCity        = db.Column(db.String, unique = False, nullable = False)
        c_custNation      = db.Column(db.String, unique = False, nullable = False)
        c_custEmail       = db.Column(db.String, unique = True, nullable = False)
        c_custPhoneNumber = db.Column(db.String, unique = True, nullable = False)
        c_custAdminStatus = db.Column(db.Boolean, unique = False, nullable = False)

        # Adds a new user to database
        def addCustomer(c_custUser, c_custPass, c_custCity, c_custNation, c_custEmail, c_custPhoneNumber):
            db.session.add(Customer(c_custUser = c_custUser, c_custPass = c_custPass, c_custCity = c_custCity, c_custNation = c_custNation, c_custEmail = c_custEmail, c_custPhoneNumber = c_custPhoneNumber, c_custAdminStatus = False))
            db.session.commit()
        #For the login we need get_id
        def get_id(self):
           return (self.c_custKey)
    
    @login_manager.user_loader
    def load_user(user_id):
        return Customer.query.get(int(user_id))
    class Nutrition(db.Model):
        nu_nutritionKey = db.Column(db.Integer, primary_key = True)
        nu_category     = db.Column(db.String, unique = False, nullable = False)
        nu_name         = db.Column(db.String, unique = True, nullable = False)
        nu_calories     = db.Column(db.String, unique = False, nullable = False)
        nu_sugar        = db.Column(db.String, unique = False, nullable = False)
        nu_totalFat     = db.Column(db.String, unique = False, nullable = False)

    class Rating(db.Model):
        r_ratingKey     = db.Column(db.Integer, primary_key = True)
        r_ratingScore   = db.Column(db.Integer, unique = False, nullable = False)
        r_ratingComment = db.Column(db.String, unique = False, nullable = False)
        r_custKey       = db.Column(db.Integer, unique = False, nullable = False)
        r_itemName      = db.Column(db.String, unique = False, nullable = False)

        # Adds new rating to database
        def addRating(r_ratingKey, r_ratingScore, r_ratingComment, r_custKey, r_itemName):
            db.session.add(Customer(r_ratingKey = r_ratingKey, r_ratingScore = r_ratingScore, r_ratingComment = r_ratingComment, r_custKey = r_custKey, r_itemName = r_itemName))
            db.session.commit()

    db.create_all()
    admin.add_view(ModelView(Customer, db.session))
    admin.add_view(ModelView(Rating, db.session))

@app.route('/')
def index():
    return redirect(url_for('logIn'))

# Log In Method
@app.route('/login') 
def logIn():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_post():
    #Get login information from the form
    username = request.form.get('uname')
    password = request.form.get('password')
    
    #get user information
    user = Customer.query.filter_by(c_custUser=username).first()


    #check if user exists
    #print(user.c_custKey)
    print(user.c_custUser)
    
    if not user.c_custUser or not user.c_custPass == password:
        flash('Please check your login details and try again.')
        return redirect(url_for('logIn'))
    elif user.c_custUser and user.c_custPass == password:
        login_user(user)
        return redirect(url_for('home_menu'))
    return "Can not log in"

@app.route('/logout')
@login_required
def logOut():
    logout_user()
    return redirect(url_for('logIn'))

@app.route('/home')
@login_required
def home_menu():
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()
    return render_template('home.html', person = user)


# Sign Up Method
@app.route('/signup')
def signUp():
    return render_template('signup.html')

@app.route('/signup', methods =['GET','POST'])
def signup_post():
    username = request.form['uname']
    password = request.form['password']
    city     = request.form['ucity']
    nation   = request.form['unation']
    email    = request.form['uemail']
    phone    = request.form['uphone']

    if username and password and city and nation and email and phone:
        # Checks if user already exists, if so, don't allow them to register with same name
        if Customer.query.filter_by(c_custUser = username).first():
            flash('Username already being used: login or use a different name')
            return render_template('signup.html')
        
        # Checks if email in use, if so, use a different one of login
        if Customer.query.filter_by(c_custEmail = email).first():
            flash('Email already being used: login or use a different email')
            return render_template('signup.html')

        # Checks if phone number in use, is so, login
        if Customer.query.filter_by(c_custPhoneNumber = phone).first():
            flash('Phone number already being used, please login')
            return render_template('signup.html')
    else:
        flash('Fill in the form')
        return render_template('signup.html')
    
    # Checks if all fields are filled, if so, add to database, if not, fill in form
    if username and password and city and nation and email and phone:
        # Admin status defaults to 0
        db.session.add(Customer(c_custUser = username, c_custPass = password, c_custCity = city, c_custNation = nation, c_custEmail = email, c_custPhoneNumber = phone, c_custAdminStatus = False))
        db.session.commit()
        flash('Successfully Signed Up!')
        return redirect(url_for('home_menu'))
    else:
        flash('Fill in the form')
        return render_template('signup.html')

@app.route('/FoodReccomendation' ,methods=["GET", "POST"])
@login_required
def foodReccomendation():
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()
    if request.method == 'POST':
        calories = request.form['Calories']
        fat = request.form['Fat']
        cholesterol = request.form['Cholesterol']
        sodium = request.form['Sodium']
        carbs = request.form['Carbs']
        sugar = request.form['Sugar']
        protein = request.form['Protein']

        return redirect(url_for('foodReccomendation_post', calories=calories, fat=fat,cholesterol=cholesterol,sodium=sodium,carbs=carbs,sugar=sugar,protein=protein))
        #return render_template('FoodRec.html', person = user) 

    return render_template('FoodRec.html', person = user)

@app.route('/FoodReccomendationResult/<calories>/<fat>/<cholesterol>/<sodium>/<carbs>/<sugar>/<protein>', methods = ["GET","POST"])
@login_required
def foodReccomendation_post(calories,fat,cholesterol,sodium,carbs,sugar,protein):
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()

    if request.method == 'POST':
        itemname = request.form['ItemName']
        comment  = request.form['Comment']
        rating   = request.form['FoodRating']

        rating = int(rating)

        user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()
        user = user.c_custKey

        db.session.add(Rating(r_ratingScore = rating, r_ratingComment = comment, r_custKey = user, r_itemName = itemname))
        db.session.commit()
        flash('Ratings Created!')
        return render_template('Home.html', person = user)


    calories = int(calories)
    fat = int(fat)
    cholesterol = int(cholesterol)
    sodium = int(sodium)
    carbs = int(carbs)
    sugar = int(sugar)
    protein = int(protein)
    sql = text('''
    SELECT f_foodName
    FROM food
    WHERE f_foodCalories < :a
    AND f_foodFat < :b
    AND f_foodCholesterol < :c
    AND f_foodSodium < :d
    AND f_foodCarbs < :e
    AND f_foodSugar < :f
    AND f_foodProtein < :g
    ORDER BY RANDOM()
    LIMIT 1
    '''
    )
    param = {'a' : calories, 'b' : fat, 'c' : cholesterol, 'd' : sodium, 'e' : carbs, 'f' : sugar, 'g' : protein}
    # b = {'b' : fat}
    # c = {'c' : cholesterol}
    # d = {'d' : sodium}
    # e = {'e' : carbs}
    # f = {'f' : sugar}
    # g = {'g' : protein}
    result = db.session.execute(sql,param)
    results = result.mappings().all()
    # print(results)
    return render_template('FoodRecRes.html', person = user, results = results)


@app.route('/DrinkRecommendation', methods=["GET", "POST"])
@login_required
def drinkRecommendation():
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()

    if request.method == 'POST':
        calories = request.form['Calories']
        totalfat = request.form['TotalFat']
        sugar = request.form['Sugar']
        caffeine = request.form['Caffeine']
        drinksize = request.form['DrinkSize']

        return redirect(url_for('drinkRecommendation_post', calories = calories, totalfat = totalfat, sugar = sugar, caffeine = caffeine, drinksize = drinksize))

    return render_template('DrinkRec.html', person = user)

@app.route('/DrinkRecommendationResult/<calories>/<totalfat>/<sugar>/<caffeine>/<drinksize>', methods = ["GET", "POST"])
@login_required
def drinkRecommendation_post(calories,totalfat,sugar,caffeine,drinksize):
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()

    if request.method == 'POST':
        itemname = request.form['ItemName']
        comment  = request.form['Comment']
        rating   = request.form['DrinkRating']

        rating = int(rating)

        user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()
        user = user.c_custKey

        db.session.add(Rating(r_ratingScore = rating, r_ratingComment = comment, r_custKey = user, r_itemName = itemname))
        db.session.commit()
        flash('Ratings Created!')
        return render_template('Home.html', person = user)

    calories = int(calories)
    totalfat = int(totalfat)
    sugar = int(sugar)
    caffeine = int(caffeine)
    drinksize = str(drinksize)

    sql = text('''
    SELECT d_drinkName
    FROM drinks
    WHERE d_drinkCalories < :a
    AND d_drinkFat < :b
    AND d_drinkSugar < :c
    AND d_drinkCaffeine < :d
    AND d_drinkSize = :e
    ORDER BY RANDOM()
    LIMIT 1
    '''
    )

    param = {'a' : calories, 'b' : totalfat, 'c' : sugar, 'd' : caffeine, 'e' : drinksize}

    result = db.session.execute(sql,param)
    results = result.mappings().all()

    return render_template('drinksuggestions.html', person = user, results = results)

@app.route('/Reviews', methods=["GET", "POST"])
@login_required
def reviews():
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()

    sql = text('''
    select f_foodName, ROUND(AVG(r_ratingScore),2) AS avgscore, r_ratingComment
    FROM food, rating
    WHERE r_itemName = f_foodName
    GROUP BY f_foodName
    '''
    )

    f_result = db.session.execute(sql)
    f_results = f_result.mappings().all()
    
    sql = text('''
    select d_drinkName, ROUND(AVG(r_ratingScore),2) AS avgscore, r_ratingComment
    FROM drinks, rating
    WHERE r_itemName = d_drinkName
    GROUP BY d_drinkName
    '''
    )

    d_result = db.session.execute(sql)
    d_results = d_result.mappings().all()

    return render_template('Reviews.html', person = user, d_results = d_results, f_results = f_results)

@app.route('/Locations', methods=["GET", "POST"])
@login_required
def locations():
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()

    if request.method == 'POST':
        search = request.form['search']

        return redirect(url_for('locations_post', search = search))
    
    sql = text('''
    SELECT n_name, r_regionName, s_storeAddress
    FROM stores, nation, region
    WHERE n_nationCountryCode = s_storeCountryCode
    AND r_regionKey = n_regionKey
    '''
    )

    result = db.session.execute(sql)
    results = result.mappings().all()

    return render_template('locations.html', person = user, results = results)


@app.route('/LocationsResult/<search>', methods=["GET","POST"])
@login_required
def locations_post(search):
    user = Customer.query.filter_by(c_custKey=current_user.c_custKey).first()

    if request.method == 'POST':
        search = request.form['search']

        sql = text('''
        SELECT n_name, r_regionName, s_storeAddress
        FROM stores, nation, region
        WHERE n_name = :a
        AND n_nationCountryCode = s_storeCountryCode
        AND r_regionKey = n_regionKey
        '''
        )

        param = {'a' : search}

        result = db.session.execute(sql,param)
        results = result.mappings().all()

        return render_template('locationresults.html', person = user, results = results)

    sql = text('''
    SELECT n_name, r_regionName, s_storeAddress
    FROM stores, nation, region
    WHERE n_name = :a
    AND n_nationCountryCode = s_storeCountryCode
    AND r_regionKey = n_regionKey
    '''
    )
    param = {'a' : search}

    result = db.session.execute(sql,param)
    results = result.mappings().all()

    return render_template('locationresults.html', person = user, results = results)


if __name__ == '__main__':
    app.run()