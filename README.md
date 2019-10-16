# example-k8s-ambassador

API Gateway Ambassadorを用いたk8sクラスタの構築例。
Vueにより作成したstatic fileを配布するPodと、golangにより作成したREST APIのPodで構成される。

```yaml

paths:
  - path: "/"
    git: https://github.com/k-washi/example-vue-cli.git
    image: kwashizaki/example-vue-cli
    description: vueにより構築したフロントエンド

  - path: "/example-golang-rest-api/"
      - GET: {name: "nema", description: "test"}
      - /health/: status:200 response
    git: https://github.com/k-washi/example-golang-rest-api.git
    image:
    description: golangにより構築したREST API

```