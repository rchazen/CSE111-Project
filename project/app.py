import flask
from flask import Flask, redirect, url_for, jsonify
from flask import request
from flask import abort, render_template
from flask_sqlalchemy import SQLAlchemy
import json
import pandas as pd

df = pd.read_csv('nation.csv')


app = Flask(__name__)

with app.app_context():
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///db.sqlite3"
    db = SQLAlchemy(app)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run()