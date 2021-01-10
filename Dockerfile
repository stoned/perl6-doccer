FROM jjmerelo/alpine-raku:2020.11
LABEL version="3.2.1" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ARG DIR="/test"

USER root
RUN apk update && apk upgrade && apk add openssl-dev graphviz  && apk add ca-certificates wget && update-ca-certificates

USER raku
RUN zef install OpenSSL

RUN cd /tmp/ && wget https://github.com/stoned/doc/raw/master/META6.json && zef update && zef install --deps-only .

VOLUME $DIR
WORKDIR $DIR

# Will run this
ENTRYPOINT P6_DOC_TEST_VERBOSE=1 prove6 t

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

