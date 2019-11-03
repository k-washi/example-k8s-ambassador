#!/bin/sh

#config map
kubectl apply -f example-golang-vue/example-jwt-config.yaml

#for ambassador
kubectl apply -f ambassador/ambassador-service.yaml 
kubectl apply -f ambassador/ambassador-rbac.yaml 

sleep 30
kubectl apply -f example-golang-vue/example-golang.yaml 
kubectl apply -f example-golang-vue/example-jwt-client.yaml
kubectl apply -f example-golang-vue/example-jwt-server.yaml