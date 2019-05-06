#!/bin/bash

echo "4 min wait time to pods start"
sleep 4m

## Java kornyzet
fission env create --name knodejs --image fission/node-env --mincpu 40 --maxcpu 80 --poolsize 4

## Go kornyzet
fission env create --name kgo --image fission/go-env --builder fission/go-builder --mincpu 40 --maxcpu 80 --poolsize 4

## Python kornyezet
fission env create --name kpython --image fission/python-env:latest --builder fission/python-builder:latest --mincpu 40 --maxcpu 80 --poolsize 4

## Java fugvenyek
fission function create --name khellojava --code ./functions/js/hellojava.js --env knodejs --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name kprimjava --code ./functions/js/primjava.js --env knodejs --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name kmatrixjava --code ./functions/js/matrixjava.js --env knodejs --minscale 1 --maxscale 5  --executortype newdeploy

## Go fuggvenyek
fission function create --name khellogo --src ./functions/go/hellogo.go --entrypoint Handler --env kgo --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name kprimgo --src ./functions/go/primgo.go --entrypoint Handler --env kgo --minscale 1 --maxscale 5  --executortype newdeploy

## Python fugvenyek
fission function create --name khellopython --code ./functions/python/hellopython.py --env kpython --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name kprimpython --code ./functions/python/primpython.py --env kpython --minscale 1 --maxscale 5  --executortype newdeploy
fission function create --name kmatrixpython --code ./functions/python/matrixpython.py --env kpython --minscale 1 --maxscale 5  --executortype newdeploy

## HTTP Triggerek
fission httptrigger create --url /khellojava --method GET --function khellojava
fission httptrigger create --url /khellogo --method GET --function khellogo
fission httptrigger create --url /khellopython --method GET --function khellopython

fission httptrigger create --url /kmatrixjava --method GET --function kmatrixjava
fission httptrigger create --url /kmatrixgo --method GET --function kmatrixgo
fission httptrigger create --url /kmatrixpython --method GET --function kmatrixpython

fission httptrigger create --url /kprimjava --method POST --function kprimjava
fission httptrigger create --url /kprimgo --method POST --function kprimgo
fission httptrigger create --url /kprimpython --method POST --function kprimpython