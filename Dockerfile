FROM nginx:stable

LABEL maintainer="maltokyo"

RUN apt-get update && apt-get dist-upgrade -y \
	&& apt-get install -y apache2-utils libnginx-mod-http-dav-ext \
	&& rm -rf /var/lib/apt/lists/*


COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*


RUN mkdir -p "/media/data"

RUN chown -R www-data:www-data "/media/data"

VOLUME /media/data


COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
CMD /entrypoint.sh && nginx -g "daemon off;"