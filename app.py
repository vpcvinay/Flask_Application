from config import Config

import json
import sys

def Run():
    if(config_file):
        with open(config_file,'r') as file:
            data = json.load(file)

    else:
        data = None
    return data

if __name__=='__main__':
    if(sys.argv[1:]):
        config_file = sys.argv[1]
        data = Run()
        host_conf = data['host_config']
        Config.params = True
        data = data['remote']
        Config.db = data['db']
        Config.user = data['db_user_name']
        Config.password = data['db_password']
        Config.host = data['db_host']
        Config.db_name = data['db_name']
        from application import app
        import table_create as tbl_cr
        tbl_cr.create_table()
        tbl_cr.data_populate()
        app.run(debug=True, host=host_conf['host'], port=host_conf['port'])

    else:
        print("No Database Configured")