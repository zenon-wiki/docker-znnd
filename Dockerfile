FROM golang:1.18 as build-env

WORKDIR /go/src/znnd
COPY go-zenon .

RUN go get -d -v ./...
RUN go build -o /go/bin/znnd main.go

FROM gcr.io/distroless/base

COPY --from=build-env /go/bin/znnd /
CMD ["/znnd"]

VOLUME /root/.znn

EXPOSE 35995/tcp
EXPOSE 35995/udp
EXPOSE 35997/tcp
EXPOSE 35998/tcp
