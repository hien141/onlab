#!/bin/bash

## Java környzet
fission environment create --name nodejs --image fission/node-env --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 4

## Go környzet
fission environment create --name go --image fission/go-env --builder fission/go-builder --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 4

## Python környezet
fission environment create --name python --image fission/python-env --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 4

## Java fügvények
fission function create --name hellojava --code ./deploys/js/hellojava.js --env nodejs --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name primjava --code ./deploys/js/primjava.js --env nodejs --minscale 1 --maxscale 5  --executortype newdeploy

## Go függvények
fission function create --name hellogo --src ./deploys/go/hellogo.go --entrypoint Handler --env go --minscale 1 --maxscale 5  --executortype newdeploy

## Python fügvények
fission function create --name hellopython --code ./deploys/hellopython.py --env python --minscale 1 --maxscale 5  --executortype newdeploy

## HTTP Triggerek
fission httptrigger create --url /hellojava --method GET --function hellojava
fission httptrigger create --url /hellogo --method GET --function hellogo
fission httptrigger create --url /hellopython --method GET --function hellopython

fission httptrigger create --url /primjava --method POST --function primjava
##fission httptrigger create --url /hellogo --method POST --function primgo
##fission httptrigger create --url /hellopython --method POST --function primpython