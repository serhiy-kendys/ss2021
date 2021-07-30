FROM alpine:latest

RUN  apk update && apk upgrade && \
     apk add apache2 && \
     apk add apache2-proxy && \
     apk add apache2-ssl && \
     rm -rf /var/cache/apk/*

COPY index.html /var/www/localhost/htdocs/

CMD  [ "/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
EXPOSE 443
