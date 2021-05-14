from flask import request, jsonify
from app import app
from app.tasks.processor import Processor
from app.base.helper import session_to_id_user
from app.base.helper import header_option
from app.base.helper import is_admin

PREFIX = '/api/tasks'


@app.route(PREFIX, methods=['GET'])
def all_tasks_user():
    id_user = session_to_id_user(request.headers)
    if not id_user:
        return jsonify({}), header_option()
    answer = {}
    if is_admin(id_user):
        answer = Processor().get_all_tasks_users(id_user)
    else:
        answer = Processor().get_tasks_user(id_user)
    return jsonify(answer), header_option()


@app.route(PREFIX, methods=['POST', 'PUT', 'OPTIONS'])
def tasks():
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    if request.method == 'POST':
        id_user = session_to_id_user(request.headers)
        if not id_user:
            return jsonify({}), header_option()
        data = request.json or dict(request.form)
        data['id_user'] = id_user
        print(data)
        res = Processor().create(data)
        return jsonify(res), header_option()
    if request.method == 'PUT':
        id_user = session_to_id_user(request.headers)
        if not id_user:
            return jsonify({}), header_option()
        data = request.json or dict(request.form)
        data['id_user'] = id_user
        print(data)
        res = Processor().tasks_update(data)
        return jsonify(res), header_option()
