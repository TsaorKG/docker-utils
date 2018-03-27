# Author : Gabriel Walbron
# Date : 27/03/2018
FROM nginx

LABEL version="0.0.1" \
    author="Gabriel Walbron" \
    release-date="27-03-2018"

ENV HOME /home/
ENV COLOR blue
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y bash \
    && apt-get install -y vim 

COPY ./nginx.conf.blue /etc/nginx/nginx.conf.blue
COPY ./nginx.conf.green /etc/nginx/nginx.conf.green
COPY ./entrypoint.sh $HOME

RUN chmod -R 777 $HOME

ENTRYPOINT ["/home/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]