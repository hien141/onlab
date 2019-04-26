import flask
from flask import request, json

def main():
    req = request.get_json()
    resp = flask.Response("reg.id")
    resp.status_code = 200
    return resp
