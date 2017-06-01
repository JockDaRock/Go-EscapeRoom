FROM golang:alpine AS build-env

COPY /test-server.go .

RUN go build -o test-server test-server.go && ls && pwd


FROM alpine

WORKDIR /

COPY --from=build-env /go/test-server .

COPY /EscapeButton .

EXPOSE 3000

ENTRYPOINT ./test-server
