from flask import request, jsonify
from app import app
from app.users.processor import Processor
from app.base.helper import session_to_id_user
from app.base.helper import header_option

PREFIX = '/api/user'


@app.route(PREFIX, methods=['GET'])
def all_user():
    return jsonify(Processor().users()), header_option()


def profile_user_get():
    id_user = session_to_id_user(request.headers)
    answer = Processor().profile(id_user)
    if answer:
        answer = answer[0]
    else:
        answer = {}
    return answer


def profile_user_post():
    id_user = session_to_id_user(request.headers)
    data = request.json or dict(request.form)
    data['id_user'] = id_user
    answer = Processor().profile_update(data)
    if answer:
        answer = answer[0]
    else:
        answer = {}
    return answer


@app.route(PREFIX + '/profile', methods=['GET', 'POST', 'OPTIONS'])
def profile_user():
    answer = {}
    if request.method == 'OPTIONS':
        answer = {}
    elif request.method == 'GET':
        answer = profile_user_get()
    elif request.method == 'POST':
        answer = profile_user_post()
    return jsonify(answer), header_option()


@app.route(PREFIX + '/<int:id_user>', methods=['GET', 'OPTIONS'])
def profile(id_user):
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    answer = Processor().profile(id_user)
    if answer:
        answer = answer[0]
    else:
        answer = {}
    return jsonify(answer), header_option()


@app.route(PREFIX + '/login', methods=['POST', 'OPTIONS'])
def login():
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    data = request.json or dict(request.form)
    res = Processor().login(data)
    return jsonify(res), header_option()


@app.route(PREFIX + '/register', methods=['POST', 'OPTIONS'])
def register():
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    data = request.json or dict(request.form)
    res = Processor().create(data)
    return jsonify(res), header_option()
