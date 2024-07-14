# Build app tracker
FROM golang:1.22 AS builder

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./
COPY *.db ./

RUN go build -o /tracker_app

# Container with app
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /tracker_app .
COPY --from=builder /app/*.db .

CMD ["/app/tracker_app"]