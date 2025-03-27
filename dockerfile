FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y \
  curl \
  libjemalloc2 \
  postgresql-client \
  build-essential \
  libpq-dev \
  nodejs \
  yarn
ARG RUBY_VERSION=3.2.2
RUN apt-get update -qq && apt-get install -y curl libjemalloc2 postgresql-client build-essential libpq-dev
WORKDIR /myapp
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v $(grep -A1 "BUNDLED WITH" Gemfile.lock | tail -n1)
RUN bundle install
COPY . .
ENV PORT=3000
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-b", "tcp://0.0.0.0:3000"]
