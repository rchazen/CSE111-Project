from app import db

class Customer(db.Model):
    c_custKey         = db.Column(db.Integer, primary_key = True)
    c_custUser        = db.Column(db.String, unique = True, nullable = False)
    c_custPass        = db.Column(db.String, unique = False, nullable = False)
    c_custCity        = db.Column(db.String, unique = False, nullable = False)
    c_custNation      = db.Column(db.String, unique = False, nullable = False)
    c_custEmail       = db.Column(db.String, unique = True, nullable = False)
    c_custPhoneNumber = db.Column(db.String, unique = True, nullable = False)
    c_custAdminStatus = db.Column(db.Boolean, unique = False, nullable = False)

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
    r_custKey       = db.Column(db.Integer, unique = True, nullable = False)
    r_itemName       = db.Column(db.String, unique = False, nullable = False)

