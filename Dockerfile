FROM ubuntu:18.04

LABEL author="Vincent BESANCON <besancon.vincent@gmail.com>"
LABEL description="Serve media through an UPNP AV server using minidlna."

ENV LANG=C.UTF-8

RUN \
  set -xe \
  && apt-get update \
  && apt-get install -y minidlna supervisor

RUN mkdir /run/minidlna && chown minidlna:minidlna /run/minidlna

ADD supervisord.conf /
ADD minidlna.conf /etc

VOLUME ["/Media"]

EXPOSE 1900/udp 8200/tcp

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
