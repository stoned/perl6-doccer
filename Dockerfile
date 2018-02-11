FROM jjmerelo/test-perl6:latest
LABEL version="1.0" maintainer="JJ Merelo <jjmerelo@GMail.com>"


RUN apk update && apk upgrade && apk add libssl1.0
RUN ln -s /lib/libssl.so.1.0.0 /lib/libssl.so
RUN ln -s /var/lib/libssl.so.1.0.0 /var/lib/libssl.so

WORKDIR /test
RUN wget https://raw.githubusercontent.com/perl6/doc/master/META6.json
RUN ls -alt
RUN zef install --deps-only .
RUN zef install LWP::Simple

# Will run this
ENTRYPOINT perl6 -v && zef install --deps-only . && zef test .

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

