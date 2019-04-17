#!/bin/bash

sudo add-apt-repository ppa:gophers/archive

sudo apt-get install golang-go
sudo apt-get install golang-1.11-go

go get -u github.com/rakyll/hey