FROM jjmerelo/perl6-test-openssl:latest
LABEL version="3.2" maintainer="JJ Merelo <jjmerelo@GMail.com>"

RUN apk update && apk upgrade && apk add graphviz  && apk add ca-certificates wget && update-ca-certificates

ADD https://github.com/perl6/doc/raw/master/META6.json /tmp/
RUN cd /tmp/ && zef update && zef install --deps-only .

# Will run this
ENTRYPOINT P6_DOC_TEST_VERBOSE=1 prove6 t

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

