FROM ruby:3.0.2

ENV RACK_ENV production
ENV MAIN_APP_FILE /usr/src/app/app.rb

RUN mkdir -p /usr/src/app

COPY . /usr/src/app

ADD startup.sh /

WORKDIR /usr/src/app

EXPOSE 5666

CMD ["/bin/bash", "/startup.sh"]