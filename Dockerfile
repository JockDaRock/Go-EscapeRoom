FROM golang:alpine AS build-env

COPY /escape-button-server.go .

RUN go build -o escape-button-server escape-button-server.go && ls && pwd


FROM alpine

WORKDIR /etc

WORKDIR /


COPY --from=build-env /go/escape-button-server .

COPY /EscapeButton ./EscapeButton

EXPOSE 3000

CMD  ["./escape-button-server"]
