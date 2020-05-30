from flask import Blueprint, render_template
import os

mod_ui = Blueprint('mod_ui',__name__,template_folder='templates',static_folder='static')

@mod_ui.route('/welcome')
def welcome_page():
    return render_template('basefile.html')

@mod_ui.route('/homepage',methods=['GET'])
def home_page():
    return render_template('homepage.html')

