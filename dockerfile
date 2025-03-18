FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y curl libjemalloc2 postgresql-client build-essential libpq-dev
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . /myapp
