FROM golang:alpine as builder
WORKDIR /go/src/consul-exporter
COPY . .
RUN apk --update --no-cache add git && \
        go build

FROM alpine:latest
WORKDIR /
COPY --from=builder /go/src/consul-exporter/consul-exporter .
RUN apk --update --no-cache add ca-certificates

CMD ["/consul-exporter"]
