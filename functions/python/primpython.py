import flask
from flask import request, json


def is_prime(n):
    for i in range(3, n):
        if n % i == 0:
            return False
    return True


def main():
        # req = request.get_json()
        eredmeny = 100
        # number = flask.Response("reg.id")
        number = 100
        for i in range(1, number):
                if is_prime(i):
                        eredmeny = i
        return eredmeny


szam = main()
print(szam)
