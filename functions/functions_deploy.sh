#!/bin/bash

echo "4 min wait time to pods start"
sleep 4m

## Java kornyzet
fission env create --name hnodejs --image fission/node-env

## Go kornyzet
fission env create --name hgo --image fission/go-env --builder fission/go-builder

## Python kornyezet
fission env create --name hpython --image fission/python-env

## Java fugvenyek
fission function create --name hhellojava --code ./functions/js/hellojava.js --env hnodejs 
fission function create --name hprimjava --code ./functions/js/primjava.js --env hnodejs 
fission function create --name hmatrixjava --code ./functions/js/matrixjava.js --env hnodejs

## Go fuggvenyek
fission function create --name hhellogo --src ./functions/go/hellogo.go --entrypoint Handler
fission function create --name hprimgo --src ./functions/go/primgo.go --entrypoint Handler 

## Python fugvenyek
fission function create --name hhellopython --code ./functions/python/hellopython.py --env hpython
fission function create --name hprimpython --code ./functions/python/primpython.py --env hpython 
fission function create --name hmatrixpython --code ./functions/python/matrixpython.py --env hpython

## HTTP Triggerek
fission httptrigger create --url /hhellojava --method GET --function hhellojava
fission httptrigger create --url /hhellogo --method GET --function hhellogo
fission httptrigger create --url /hhellopython --method GET --function hhellopython

fission httptrigger create --url /hmatrixjava --method GET --function hmatrixjava
fission httptrigger create --url /hmatrixgo --method GET --function hmatrixgo
fission httptrigger create --url /hmatrixpython --method GET --function hmatrixpython

fission httptrigger create --url /hprimjava --method POST --function hprimjava
fission httptrigger create --url /hprimgo --method POST --function hprimgo
fission httptrigger create --url /hprimpython --method POST --function hprimpython
