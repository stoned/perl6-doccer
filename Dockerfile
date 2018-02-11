FROM jjmerelo/test-perl6:latest
LABEL version="1.0" maintainer="JJ Merelo <jjmerelo@GMail.com>"


RUN apk update && apk upgrade && apk add aspell libssl1.0 && apk add ca-certificates wget && update-ca-certificates
RUN ln -s /lib/libssl.so.1.0.0 /lib/libssl.so
RUN ln -s /var/lib/libssl.so.1.0.0 /var/lib/libssl.so

WORKDIR cd /tmp/ && wget https://github.com/perl6/doc/raw/master/META6.json &&  ls -alt && zef install --deps-only . && zef install LWP::Simple

# Will run this
ENTRYPOINT prove -e perl6 xt t

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

