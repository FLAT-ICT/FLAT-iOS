# FLAT-iOS

localhost で立てたDockerサーバーに接続する方法

1. システム環境設定 -> 共有 -> `xxx.local` という値をコピーする
1. `FLAT-iOS/FLATApp/FLATApp/API/API.swift` の `Api` クラスの `baseUrl` を `http://xxx.local:3000` に書き換える 
1. Docker for Mac を起動する
1. サーバーを起動する
    ```
    cd FLAT-backend
    docker compose up flat-backend
    ```
1. アプリを起動する