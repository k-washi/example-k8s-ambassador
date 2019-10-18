# example-k8s-ambassador

API Gateway Ambassadorを用いたk8sクラスタの構築例。
Vueにより作成したstatic fileを配布するPodと、golangにより作成したREST APIのPodで構成される。

```yaml

paths:
  - path: "/:80"
    git: https://github.com/k-washi/example-vue-cli.git
    image: kwashizaki/example-vue-cli
    description: vueにより構築したフロントエンド

  - path: "/example-golang-rest-api/:8080"
      GET: req: {"name": "name"}, res: {"name": "name", "description": "test", "datas": [{post-data-1}, {post-data-2}] }
      POST: req: {"name": "name", "description": "test", "data": {"id": 1, "name": "test1" }}, res: {"name": "name", "message": "create info and store database"}
  - path: /health/
        GET: status:200 response and , res:{"health": 200}
  - info:
        git: https://github.com/k-washi/example-golang-rest-api.git
        image: kwashizaki/example-golang-rest-api
        description: golangにより構築したREST API

```