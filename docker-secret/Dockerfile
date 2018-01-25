FROM ubuntu:16.04

LABEL version="0.0.1" \
    author="Gabriel Walbron" \
    release-date="19-01-2018"

ENV HOME /home/lambda/

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y python2.7 \
    && mkdir $HOME

COPY ./replace_dicovar.py $HOME 
COPY ./entrypoint.sh $HOME
COPY ./index-origin.html $HOME
COPY ./index.html.ref $HOME
COPY ./style.css $HOME

RUN groupadd -r -g 808 lambda \
    && useradd -r -g 808 -u 808 -d $HOME lambda \
    && chown -R 808:808 $HOME \
    && chmod -R 777 $HOME

WORKDIR $HOME
USER 808:808

ENTRYPOINT ["/home/lambda/entrypoint.sh"]
CMD ["python2.7","-m","SimpleHTTPServer","8080"]