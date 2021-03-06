#!/bin/sh

#for ambassador
kubectl delete -f ambassador/ambassador-service.yaml 
kubectl delete -f ambassador/ambassador-rbac.yaml 
kubectl delete -f example-golang-vue/example-golang.yaml 

#for nginx
kubectl delete -f example-golang-vue/nginx-example-vue-cli.yaml 

sleep 30

#for ambassador
kubectl apply -f ambassador/ambassador-service.yaml 
kubectl apply -f ambassador/ambassador-rbac.yaml 
sleep 30
kubectl apply -f example-golang-vue/example-golang.yaml 

#for nginx
kubectl apply -f example-golang-vue/nginx-example-vue-cli.yaml