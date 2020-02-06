"""User details"""
from flask_restful import Resource, abort
from bson.objectid import ObjectId
from bson import json_util
from flask import jsonify
import zeus_api
import json


# def missing_user_id(id):
#     if id not in zeus_api.user.find_one({"_id": id}):
#         abort(404, message="User {} doesn't exist".format(id))


class User_details(Resource):
    def get(self, userid):
        # identifier = JSONEncoder(userid)
        user_data = zeus_api.user.find_one({'_id': ObjectId(userid)})
        email = user_data['email']
        return jsonify(email)