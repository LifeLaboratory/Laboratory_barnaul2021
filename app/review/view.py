from flask import request, jsonify
from app import app
from app.review.processor import Processor
from app.base.helper import session_to_id_user
from app.base.helper import header_option

PREFIX = '/api/review'


@app.route(PREFIX, methods=['GET'])
def get_review():
    id_user = session_to_id_user(request.headers)
    if not id_user:
        return jsonify({}), header_option()
    return jsonify(Processor().get_review(id_user)), header_option()


@app.route(PREFIX, methods=['POST'])
def post_review():
    id_user = session_to_id_user(request.headers)
    if not id_user:
        return jsonify({}), header_option()
    return jsonify(Processor().get_statistics_users(id_user)), header_option()
