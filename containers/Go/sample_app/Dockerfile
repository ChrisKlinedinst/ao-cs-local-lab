FROM golang:1.9

# Based on https://hub.docker.com/_/golang/
WORKDIR /go/src/app
COPY . .
RUN go-wrapper download
RUN go-wrapper install
ENV APPOPTICS_SERVICE_KEY=c6260446e584d80f9d5f79be0ad8d95234334247db1128e68ef4ea3f2b289d50:sample_app

# Start app. APPOPTICS_SERVICE_KEY must be set to enable AppOptics.
CMD /go/bin/app -testClients true -addr :8899
EXPOSE 8899
