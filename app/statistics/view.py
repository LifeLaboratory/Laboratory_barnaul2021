from flask import request, jsonify
from app import app
from app.statistics.processor import Processor
from app.base.helper import session_to_id_user
from app.base.helper import header_option

PREFIX = '/api/statistics'


@app.route(PREFIX, methods=['GET', 'OPTIONS'])
def statistics_admin():
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    id_user = session_to_id_user(request.headers)
    if not id_user:
        return jsonify({}), header_option()
    return jsonify(Processor().get_statistics_admin(id_user)), header_option()


@app.route(PREFIX + '/users', methods=['GET', 'OPTIONS'])
def statistics_users():
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    id_user = session_to_id_user(request.headers)
    if not id_user:
        return jsonify({}), header_option()
    return jsonify(Processor().get_statistics_users(id_user)), header_option()


@app.route(PREFIX + '/today', methods=['GET', 'OPTIONS'])
def statistics_today():
    if request.method == 'OPTIONS':
        return jsonify({}), header_option()
    id_user = session_to_id_user(request.headers)
    if not id_user:
        return jsonify({}), header_option()
    return jsonify(Processor().get_statistics_all_task_today(id_user)), header_option()
