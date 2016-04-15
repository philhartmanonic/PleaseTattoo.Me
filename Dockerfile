FROM ruby:2.2.1
MAINTAINER Galen Burghardt <galen.w.burghardt@gmail.com>
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends
RUN wget http://download.redis.io/redis-stable.tar.gz
RUN tar xvzf redis-stable.tar.gz
RUN cd redis-stable
CMD ["make"]
RUN cd ..
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install -j4
ADD . /app
RUN useradd --create-home --home-dir /app --shell /bin/bash tattoo
RUN chown -R tattoo:tattoo /app
USER tattoo
CMD ["redis-server"]
CMD ["rails", "server"]