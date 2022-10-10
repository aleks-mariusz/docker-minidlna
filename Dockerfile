FROM alpine:3

LABEL author="Vincent BESANCON <besancon.vincent@gmail.com>"
LABEL description="Serve media through an UPNP AV server using minidlna."

ENV LANG=C.UTF-8

RUN \
  apk add minidlna supervisor

RUN mkdir /run/minidlna && chown minidlna:minidlna /run/minidlna && touch /var/log/minidlna.log && chown minidlna:minidlna /var/log/minidlna.log

ADD supervisord.conf /
ADD minidlna.conf /etc

VOLUME ["/Media"]

EXPOSE 1900/udp 8200/tcp

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
