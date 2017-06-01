FROM golang:alpine AS build-env

COPY /escape-button-server.go .

RUN go build -o escape-button-server escape-button-server.go && ls && pwd


FROM alpine

WORKDIR /

COPY --from=build-env /go/escape-button-server .

COPY /EscapeButton .

EXPOSE 3000

ENTRYPOINT ./escape-button-server

LABEL "cisco.cpuarch"="x86_64"
LABEL "cisco.resources.cpu"="50"
LABEL "cisco.resources.memory"="50"
LABEL "cisco.resources.network.0.ports.tcp"="[3000]"
