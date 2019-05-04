from flask import Flask, session, redirect, url_for, escape, request, json


def is_prime(n):
    for i in range(3, n):
        if n % i == 0:
            return False
    return True


def main():
    id = int(json.loads(request.data)['id'])
    eredmeny = 0
    for i in range(1, id):
        if is_prime(i):
            eredmeny = i
    return str(eredmeny)
