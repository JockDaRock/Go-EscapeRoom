FROM golang:alpine AS build-env

COPY /test-server.go .

RUN go build -o test-server test-server.go && ls && pwd


FROM alpine

WORKDIR /

COPY --from=build-env /go/test-server .

COPY /EscapeButton .

EXPOSE 3000

ENTRYPOINT ./test-server

LABEL "cisco.cpuarch"="x86_64"
LABEL "cisco.resources.cpu"="50"
LABEL "cisco.resources.memory"="50"
LABEL "cisco.resources.network.0.ports.tcp"="[9000]"
