# nuxtjs-docker-sample

nuxt.js の簡単なアプリをDockerコンテナ上で立ち上げるまでのサンプル

## 手順
### clone

```
git clone https://github.com/kazuki-hayakawa/nuxtjs-docker-sample.git
cd nuxtjs-docker-sample
```

### start nuxt.js project

```
vue init nuxt-community/starter-template sample-app
cd sample-app
npm install
```

動作確認は

```
num run dev
```

### docker build

Dockerfileのあるパスに戻ります。

```
cd ..
```

buildの動作は `Dockerfile` を見てください。

```
docker build -t nuxtjs-sample:1.0 .
```

### run container

```
docker run -d -p 3000:3000  nuxtjs-sample:1.0
```

コンテナが立ち上がったら http://localhost:3000 にアクセスしてサンプルアプリが表示出来ることを確認してください。

## clean up

`docker ps -a` で動いているコンテナを確認できます。該当の CONTAINER ID を見つけたら

```
docker rm -g [CONTAINER_ID]
```

しておいてください。

# 参考文献

[Nuxt.js v2.0.0 を Docker Multi-stage build を使って Docker化 ハンズオン](https://qiita.com/po3rin/items/0cef246755aa655ce53d)
