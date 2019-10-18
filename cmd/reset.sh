#!/bin/sh

kubectl delete -f ambassador/ambassador-service.yaml 
kubectl delete -f ambassador/ambassador-rbac.yaml 
kubectl delete -f example-golang-vue/example-vue-cli.yaml 
kubectl delete -f example-golang-vue/example-golang.yaml 

sleep 30

kubectl apply -f ambassador/ambassador-service.yaml 
kubectl apply -f ambassador/ambassador-rbac.yaml 

sleep 30
kubectl apply -f example-golang-vue/example-vue-cli.yaml
kubectl apply -f example-golang-vue/example-golang.yaml 