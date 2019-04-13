#!/bin/bash


## Java környzet
fission environment create --name nodejs --image fission/node-env

## Go környzet
fission environment create --name go --image fission/go-env --builder fission/go-builder

## Python környezet
fission environment create --name python --image fission/python-env 

## Java fügvények
fission function create --name hellojava --code ./js/hellojava.js --env nodejs
fission function create --name primjava --code ./js/primjava.js --env nodejs

## Go függvények
fission function create --name hellogo --env go --src ./go/hellogo.go --entrypoint Handler

## Python fügvények
fission function create --name hellopython --env python --code hellopython.js 

## HTTP Triggerek
fission httptrigger create --url /hellojava --method GET --function hellojava
fission httptrigger create --url /hellogo --method GET --function hellogo
fission httptrigger create --url /hellopython --method GET --function hellopython

fission httptrigger create --url /primjava --method GET --function prim
##fission httptrigger create --url /hellogo --method GET --function hellogo
##fission httptrigger create --url /hellopython --method GET --function hellopython