# example-k8s-ambassador

フロント(Vue)の認証によりFirebaseからJWT情報を取得し、そのJWTを用いてサーバ側(Golang)で認可を行うことで、個人情報を処理している。
システムの構成は、マイクロサービスを意識している。
サーバ側の各サービスはDocker Imageで隔離しており、GRPCでつないでいる。それらのイメージの管理は、k8sで行っており、 API GatewayにAmbassadorを用いることでURLを管理している。

Docker for macでのみ確認

```yaml

paths:
  - path: "/:80"
    git: https://github.com/k-washi/example-vue-cli.git
    image: kwashizaki/example-vue-cli
    msg: vueにより構築したフロントエンド

  - path: "/api/ex-golang/rest-api/:8080"
      GET: req: /*?name=anything, res: {"name": "name", "description": "test", "datas": [{post-data-1}, {post-data-2}] }
      POST: req: {"name": "name", "description": "test", "id": 1, "data": "test1" }}, res: {"name": "name", "message": "create info and store database"}
  - path: /api/ex-golang/health/
      GET: status:200 response and , res:{"health": 200}
  - info:
      git: https://github.com/k-washi/example-golang-rest-api.git
      image: kwashizaki/example-golang-rest-api
      msg: golangにより構築したREST API

  - path:  "/api/ex-jwt/jwt/ex-jwt-auth"
      GET: res: {"status": 200, "message": "Authorization username / email"} 
      msg: "jwt認可"
  - path: "/api/ex-jwt/auth/ex-authentication"
      GET: res: {"status": 200, "message": "Authorization username / email"} 
      msg: "ワンタイムjwt認可 /envの配下にex-firebase-auth-firebase-adminsdk.jsonを置く"
  - info: 
    front-image: kwashizaki/example-golang-jwt-auth-client:v1.0.0
    server-image: kwashizaki/example-golang-jwt-auth-server:v1.0.0
    git: https://github.com/k-washi/example-golang-jwt-auth

```

## Sercret

./env/env-secret.txtにfirebaseのadminsdk情報
google_app_creds=/tmp/ex-firebase-auth-firebase-adminsdk-xxxxxxxxxx.json
を記載.

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
```

## Debug 

k8sデバック用のポッド

```bash

kubectl apply -f debug/pod.yml
kubectl exec -it debug sh
```

## Error

(Firebase Admin Go SDK getting x509 certificate error ONLY when running inside Kubernetes)[https://stackoverflow.com/questions/55435462/firebase-admin-go-sdk-getting-x509-certificate-error-only-when-running-inside-ku]

+ https://medium.com/on-docker/use-multi-stage-builds-to-inject-ca-certs-ad1e8f01de1b