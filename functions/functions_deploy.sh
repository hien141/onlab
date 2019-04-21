#!/bin/bash


## Java környzet
fission env create --name nodejs --image fission/node-env

## Go környzet
fission environment create --name go --image fission/go-env --builder fission/go-builder

## Python környezet
fission environment create --name python --image fission/python-env 

## Java fügvények
fission function create --name hellojava --code ./deploys/js/hellojava.js --env nodejs
fission function create --name primjava --code ./deploys/js/primjava.js --env nodejs

## Go függvények
fission function create --name hellogo --env go --src ./deploys/go/hellogo.go --entrypoint Handler

## Python fügvények
fission function create --name hellopython --env python --code ./deploys/hellopython.py

## HTTP Triggerek
fission httptrigger create --url /hellojava --method GET --function hellojava
fission httptrigger create --url /hellogo --method GET --function hellogo
fission httptrigger create --url /hellopython --method GET --function hellopython

fission httptrigger create --url /primjava --method POST --function primjava
##fission httptrigger create --url /hellogo --method GET --function primgo
##fission httptrigger create --url /hellopython --method GET --function primpython