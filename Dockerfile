FROM golang:1.21 AS builder

WORKDIR /app 
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM alpine:3.21.3  

WORKDIR /app 
COPY --from=builder /app/main . 
COPY config/ /app/config
COPY db/ /app/db
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -D appuser
RUN chown -R appuser:appgroup /app/
USER appuser
ENTRYPOINT ["./main"]
