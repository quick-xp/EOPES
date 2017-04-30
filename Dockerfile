FROM ruby:2.1

RUN mkdir -p /var/www/eopes
WORKDIR /var/www/eopes

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y cron rsyslog supervisor vim locales locales-all --no-install-recommends
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# timezone
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN git clone https://github.com/quick-xp/eopes.git ./current
WORKDIR /var/www/eopes/current

ENV RAILS_VERSION 4.2
RUN gem install rails --version "$RAILS_VERSION"
RUN bundle install --without development test

ADD .git/index /data/dummy_eopes
COPY supervisord.conf /etc/

ARG gitbranch="master"
RUN git fetch
RUN git checkout $gitbranch
RUN git pull origin HEAD
RUN bundle install

ENV EOPES_ROOT=/var/www/eopes/current
ENV RAILS_ENV=production
RUN ln -s /data/eopes/config/database.yml config/database.yml
RUN rm config/secrets.yml && ln -s /data/eopes/config/secrets.yml config/secrets.yml
RUN ln -s /data/eopes/config/.env .env

# Cron
COPY /config/cron/cron.txt /var/crontab.txt
RUN crontab /var/crontab.txt
RUN chmod 600 /etc/crontab

CMD ["/usr/bin/supervisord"]
