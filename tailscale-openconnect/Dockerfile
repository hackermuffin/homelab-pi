FROM alpine:3.16

RUN apk add --no-cache tzdata
RUN apk add --no-cache openconnect

COPY ./init.sh /init.sh
RUN chmod +x /init.sh

ENTRYPOINT ["/init.sh"]
