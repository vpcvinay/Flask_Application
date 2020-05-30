from application import db

class User_db(db.Model):
    __tablename__ = 'shopping_list'

    itemid = db.Column('itemid', db.Integer, primary_key=True)
    itemname = db.Column('itemname',db.String)
    item = db.Column('item',db.String)
