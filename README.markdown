Individual PostgreSQL dockerfile
=========================


## Postgres  
PostgreSQL 9.4.xのDockerイメージ。  

### Port
PostgreSQLのデフォルトポート5432で起動します。Portsも自動で設定されないので
手動で設定してください。  

### Volumes  
自動でvolumeは設定されません。  

#### /var/lib/postgresql
PGDATAディレクトリが置かれるディレクトリ。データを永続化させるためにvolumeに指定してください。  

#### /var/log/pg_log
ログをテキストファイルに書き出す設定になっているので、このディレクトリもvolumeに指定してください。
pg_logは自動でパーミッションを書き換えないので、アクセス権に注意してください。

### Environemnt
#### POSTGRES_PASSWORD
postgresユーザー(スーパーユーザー)のパスワード。デフォルト値postgres

