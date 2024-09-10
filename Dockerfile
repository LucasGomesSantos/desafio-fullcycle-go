#Cria o builder para lidar com o build do go
FROM golang:alpine3.14 AS builder 

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o main main.go

#Cria o para lidar com binario e diminuir o tamanho da imagem com arquivos relevantes
FROM scratch

WORKDIR /

#Faz download do build multi stage do builder para dentro do scratch
COPY --from=builder /app/main /main

EXPOSE 8080

ENTRYPOINT ["/main"]
