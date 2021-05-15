from flask import Flask


app = Flask(__name__, static_folder='static')


UPLOAD_FOLDER = r'C:\project\Laboratory_barnaul2021\app\static'
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

