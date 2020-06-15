#from application import db
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
db = SQLAlchemy(app)

class User_db(db.Model):
    __tablename__ = 'shopping_list'
    itemid = db.Column('itemid', db.Integer, primary_key=True)
    itemname = db.Column('itemname',db.String(200), nullable=False)
    item = db.Column('item',db.String(200))
