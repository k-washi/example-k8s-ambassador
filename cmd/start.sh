#!/bin/sh
kubectl apply -f ambassador/ambassador-service.yaml 
kubectl apply -f ambassador/ambassador-rbac.yaml 

sleep 30
kubectl apply -f example-golang-vue/example-vue-cli.yaml
kubectl apply -f example-golang-vue/example-golang.yaml 