#!/bin/sh

kubectl delete -f ambassador/ambassador-service.yaml 
kubectl delete -f ambassador/ambassador-rbac.yaml 
kubectl delete -f example-golang-vue/example-vue-cli.yaml 

sleep 30
