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


app = Flask(__name__)
app.secret_key = 'shhh'

with app.app_context():
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///db.sqlite3"

    # Instantiate the database.
    db = SQLAlchemy(app)
    #db.init_app(app)
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
        r_itemName       = db.Column(db.String, unique = False, nullable = False)

    db.create_all()

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
    print(user)
    if not user or not user.c_custPass == password:
        flash('Please check your login details and try again.')
        return redirect(url_for('logIn'))
    elif user and user.c_custPass == password:
        return redirect(url_for('home_menu'))
    return "Can not log in"

@app.route('/home')
@login_required
def home_menu():
    return render_template('home.html')

if __name__ == '__main__':
    app.run()