FROM ruby:3.2.2
#必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  curl \
  libjemalloc2 \
  postgresql-client \
  build-essential \
  libpq-dev \
  nodejs \
  yarn
#作業ディレクトリとして/myappを指定、移行"./"と指す
WORKDIR /myapp
COPY Gemfile Gemfile.lock ./
#Gemfile.lock ファイルから、使用するBundlerのバージョンを自動的に取得
RUN gem install bundler -v $(grep -A1 "BUNDLED WITH" Gemfile.lock | tail -n1)
#コンテナがビルドされる際に、アプリケーションの依存関係がインストール
RUN bundle install
#ホストマシン（ローカル環境）のディレクトリ内のファイルをDockerコンテナ内の指定した場所にコピーする処理
COPY . .
#環境変数でポート番号を指定
RUN bundle exec rails assets:precompile
ENV PORT=3000
#ポート3000を開放
EXPOSE 3000
#コンテナ内で Rails アプリケーションを起動するためのコマンド
CMD ["rails", "server", "-b", "0.0.0.0"]

