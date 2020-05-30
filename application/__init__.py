from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://postgres:vinay@192.168.99.100/vinaydb"
db = SQLAlchemy(app)


from application.app_data.routes import mod_data
from application.app_ui.ui_routes import mod_ui

app.register_blueprint(mod_data,url_prefix='/app')
app.register_blueprint(mod_ui,url_prefix='/app')