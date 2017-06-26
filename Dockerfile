FROM golang:alpine AS build-env

COPY /escape-button-server.go .

RUN go build -o escape-button-server escape-button-server.go && ls && pwd


FROM alpine

WORKDIR /etc

WORKDIR /


COPY --from=build-env /go/escape-button-server .

COPY /EscapeButton ./EscapeButton

LABEL "cisco.cpuarch"="x86_64" \
      "cisco.resources.profile"="custom" \
      "cisco.resources.cpu"="50" \
      "cisco.resources.memory"="50" \
      #cisco.resources.disk=50 \
      "cisco.resources.network.0.interface-name"="eth0"
      #"cisco.resources.network.0.network-name"="iox-bridge0"
      #"cisco.resources.network.0.ports.tcp"="{3000:3000}"

EXPOSE 3000

CMD  ["./escape-button-server"]
