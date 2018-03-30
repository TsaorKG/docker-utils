# Author : Gabriel Walbron
# Date : 27/03/2018
FROM ubuntu:16.04

LABEL version="0.0.1" \
    author="Gabriel Walbron" \
    release-date="19-01-2018"

ENV HOME /home/
ENV COLOR blue

RUN apt-get update \
    && apt-get install -y python2.7 \
    && apt-get install -y curl 

COPY ./replace_dicovar.py $HOME 
COPY ./entrypoint.sh $HOME
COPY ./index.html.ref $HOME
COPY ./color.html.ref $HOME
COPY ./style.css.ref $HOME

RUN chmod -R 777 $HOME

WORKDIR $HOME

ENTRYPOINT ["/home/entrypoint.sh"]
CMD ["python2.7","-m","SimpleHTTPServer","8080"]