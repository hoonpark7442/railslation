FROM nginx:1.20-alpine

WORKDIR /srv/www

RUN rm -f /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/conf.d/railslation.conf

COPY 404.html /srv/www/404.html
COPY 500.html /srv/www/500.html

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
