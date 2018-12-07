FROM jjmerelo/test-perl6:latest
LABEL version="1.0.3" maintainer="JJ Merelo <jjmerelo@GMail.com>"

RUN apk update && apk upgrade && apk add graphviz libssl1.0 && apk add ca-certificates wget && update-ca-certificates
RUN ln -s /lib/libssl.so.1.0.0 /lib/libssl.so
RUN ln -s /var/lib/libssl.so.1.0.0 /var/lib/libssl.so

ADD https://github.com/perl6/doc/raw/master/META6.json /tmp/
RUN cd /tmp/ &&  zef install --deps-only .

# Will run this
ENTRYPOINT P6_DOC_TEST_VERBOSE=1 prove -e perl6 t

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

