# example-k8s-ambassador

API Gateway Ambassadorを用いたk8sクラスタの構築例。
Vueにより作成したstatic fileを配布するPodと、golangにより作成したREST APIのPodで構成される。

Docker for macでのみ確認

```yaml

paths:
  - path: "/:80"
    git: https://github.com/k-washi/example-vue-cli.git
    image: kwashizaki/example-vue-cli
    description: vueにより構築したフロントエンド

  - path: "/api/ex-golang/rest-api/:8080"
      GET: req: /*?name=something, res: {"name": "name", "description": "test", "datas": [{post-data-1}, {post-data-2}] }
      POST: req: {"name": "name", "description": "test", "id": 1, "data": "test1" }}, res: {"name": "name", "message": "create info and store database"}
  - path: /api/ex-golang/health/
        GET: status:200 response and , res:{"health": 200}
    info:
        git: https://github.com/k-washi/example-golang-rest-api.git
        image: kwashizaki/example-golang-rest-api
        description: golangにより構築したREST API

  - path:  "/api/ex-jwt/jwt/ex-jwt-auth"
    GET: res: {"status": 200, "message": "Authorization username / email"} 
    info: "jwt認可"
  - path: "/api/ex-jwt/auth/ex-authentication"
    GET: res: {"status": 200, "message": "Authorization username / email"} 
    info: "ワンタイムjwt認可 /envの配下にex-firebase-auth-firebase-adminsdk.jsonを置く"
  - path: 
    front-image: kwashizaki/example-golang-jwt-auth-client:v1.0.0
    server-image: kwashizaki/example-golang-jwt-auth-server:v1.0.0
    git: https://github.com/k-washi/example-golang-jwt-auth

```

## Sercret

```bash
kubectl create secret generic --save-config firebase-secret --from-env-file ./env/env-secret.txt

kubectl get secret

kubectl delete secret firebase-secret
```

## 実行

```bash
#client
docker run -it -p 80:80 --rm --name example-vue-cli kwashizaki/example-vue-cli:v1.0.0

#server
./cmd/start.sh
```

## 確認

```bash
#config map
kubectl describe configmap ex-jwt-map

#logs
kubectl logs <name>

#get
kubectl get pods
kubectl get svc


## Error

(Firebase Admin Go SDK getting x509 certificate error ONLY when running inside Kubernetes)[https://stackoverflow.com/questions/55435462/firebase-admin-go-sdk-getting-x509-certificate-error-only-when-running-inside-ku]

+ https://medium.com/on-docker/use-multi-stage-builds-to-inject-ca-certs-ad1e8f01de1b