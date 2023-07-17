FROM alpine:3.15.4

LABEL maintainer="CT" \
    description="Tinyproxy" \
    version="1.0"

ENV TINYPROXY_VERSION=tp-1.10.x

RUN adduser -D -u 2000 -h /var/run/tinyproxy -s /sbin/nologin tinyproxy tinyproxy \
  && apk --update add -t build-dependencies \
    make \
    automake \
    autoconf \
    g++ \
    asciidoc \
    git \
  && rm -rf /var/cache/apk/* \
  && git clone -b ${TINYPROXY_VERSION} --depth=1 https://github.com/tinyproxy/tinyproxy.git /tmp/tinyproxy \
  && cd /tmp/tinyproxy \
  && ./autogen.sh \
  && ./configure --enable-transparent --prefix="" \
  && make \
  && make install \
  && mkdir -p /var/log/tinyproxy \
  && chown tinyproxy:tinyproxy /var/log/tinyproxy \
  && cd / \
  && rm -rf /tmp/tinyproxy \
  && apk del build-dependencies \
  && apk add --no-cache curl

USER tinyproxy

COPY ./tinyproxy.conf /etc/tinyproxy.conf

EXPOSE 6666

ENTRYPOINT ["tinyproxy"]

CMD ["-d"]
