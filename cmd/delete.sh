#!/bin/sh

#for ambassador
kubectl delete -f ambassador/ambassador-service.yaml 
kubectl delete -f ambassador/ambassador-rbac.yaml 
kubectl delete -f example-golang-vue/example-golang.yaml 
kubectl delete -f example-golang-vue/example-jwt-config.yaml
kubectl delete -f example-golang-vue/example-jwt-client.yaml
kubectl delete -f example-golang-vue/example-jwt-server.yaml
#for nginx
#kubectl delete -f example-golang-vue/example-vue-cli.yaml

sleep 30

