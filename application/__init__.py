from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from config import Config

app = Flask(__name__)
db = SQLAlchemy(app)

if Config.params:
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = Config.db + "://" + Config.user + ":" + Config.password + "@" + Config.host + "/" + Config.db_name

from application.app_data.routes import mod_data
from application.app_ui.ui_routes import mod_ui

app.register_blueprint(mod_data,url_prefix='/app')
app.register_blueprint(mod_ui,url_prefix='/app')