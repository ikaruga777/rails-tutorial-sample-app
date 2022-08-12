FROM rubylang/ruby:3.1.0-focal
RUN apt-get update -qq && apt-get upgrade -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --with=production --without=test development
RUN bundle exec rails assets:precompile
ADD . /myapp
