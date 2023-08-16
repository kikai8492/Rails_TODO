### model名:User　name:string email:string password_digest:string
### model名:Task not_started_yet:string content:string(外部キーは後からつける)
### model名:Label label_name:string user:references

# herokuへのデプロイ手順
1.heroku loginを行う
2.heroku createを行う
3.以下のgemを追加する
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
4.git add .とgit commit -mを行う
5.以下3つのHeroku buildpackを追加する
heroku buildpacks:set heroku/ruby
heroku buildpacks:add --index 1 heroku/nodejs
heroku addons:create heroku-postgresql
7.git push heroku masterでデプロイする
8.heroku run rails db:migrateでデータベースの移行を行う
9.heroku openでアプリケーションにアクセスする
