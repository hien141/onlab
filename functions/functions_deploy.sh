#!/bin/bash

echo "4 min wait time to pods start"
sleep 4m

## sososososo
## apt install python-pip


## Java környzet
fission environment create --name nodejs --image fission/node-env --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 4

## Go környzet
fission environment create --name go --image fission/go-env --builder fission/go-builder --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 4

## Python környezet
fission environment create --name python --image fission/python-env --mincpu 40 --maxcpu 80 --minmemory 64 --maxmemory 128 --poolsize 4

## Java fügvények
fission function create --name hellojava --code ./functions/js/hellojava.js --env nodejs --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name primjava --code ./functions/js/primjava.js --env nodejs --minscale 1 --maxscale 5  --executortype newdeploy

## Go függvények
fission function create --name hellogo --src ./functions/go/hellogo.go --entrypoint Handler --env go --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name primgo --src ./functions/go/primgo.go --entrypoint Handler --env go --minscale 1 --maxscale 5  --executortype newdeploy


## Python fügvények
fission function create --name hellopython --code ./functions/python/hellopython.py --env python --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name primpython --code ./functions/python/primpython.py --env python --minscale 1 --maxscale 5  --executortype newdeploy

## HTTP Triggerek
fission httptrigger create --url /hellojava --method GET --function hellojava
fission httptrigger create --url /hellogo --method GET --function hellogo
fission httptrigger create --url /hellopython --method GET --function hellopython

fission httptrigger create --url /primjava --method POST --function primjava
fission httptrigger create --url /primgo --method POST --function primgo
fission httptrigger create --url /primpython --method POST --function primpython