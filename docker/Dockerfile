FROM alpine:3.15
RUN apk add -U --no-cache ca-certificates

WORKDIR /data
ENV HOME=/data
COPY ./bin/deposd /usr/bin/deposd
COPY ./docker/entry-point.sh ./entry-point.sh
EXPOSE 26657

CMD ["deposd", "start", "--pruning", "nothing", "--log_format", "json"]
