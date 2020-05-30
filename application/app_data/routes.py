from flask import Blueprint, render_template
from application import db
import os
from application.app_data.database import User_db

mod_data = Blueprint('mod_data',__name__,template_folder='/app_ui/templates')

@mod_data.route('/shoplist',methods=['GET','POST'])
def shop_list():
    items = {}
    db_data = User_db.query.all()
    print(db_data[0].itemname)
    return render_template('shoplist.html',items=db_data)

