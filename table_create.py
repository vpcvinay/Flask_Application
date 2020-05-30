import psycopg2
import sys
import json

def create_table():
    tables = ['''create table shopping_list (itemid serial not null primary key,itemname varchar(50) not null,item varchar(50));''']
    with conn.cursor() as cur:
        for table in tables:
            try:
                cur.execute(table)
            except:
                print("execute error")

    return

def data_populate():
    with conn.cursor() as cur:
        psqls = '''INSERT INTO shopping_list (itemname, item) VALUES (%s, %s);'''
        with open('productlist.json','r') as File:
            Data = json.load(File)
            for product in Data:
                image_data = Data[product]
                try:
                    cur.execute(psqls,(image_data["name"],image_data["image"]))

                except:
                    print("execute error")

def read_json():
    with open('productlist.json','r') as File:
        data = json.load(File)
        for d in data:
            print(data[d])


def get_data_from_db():
    with conn.cursor() as cur:
        psqls = '''SELECT * from shopping_list;'''
        data = []
        try:
            cur.execute(psqls)
            products = cur.fetchall()
            for product in products:
                data.append(product)

            return data
        except:
            print("execute error")


def get_data():
    data_list = get_data_from_db()
    for data in data_list:
        print(data)

def drop_table():
    with conn.cursor() as cur:
        psqls = '''DROP table shopping_list;'''
        try:
            cur.execute(psqls)

        except:
            print("execute error")


if __name__=="__main__":
    conn = psycopg2.connect(host="192.168.99.100", database='vinaydb', user='postgres', password='vinay')
    cur = conn.cursor()
    conn.autocommit = True
    for arg in sys.argv[1:]:
        if(arg=="data"):
            data_populate()

        elif(arg=="create"):
            create_table()

        elif(arg=="getdata"):
            get_data()

        elif(arg=="drop"):
            drop_table()

    conn.commit()
    conn.close()



