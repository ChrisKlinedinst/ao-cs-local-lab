{% set ao_token = salt['pillar.get']('ao_token') %}

booking-service:
  docker_container.running:
    - name: booking-service
    - image: appoptics/demo-booking-service:with-data
    - hostname: booking-service
    - environment:
      - APPOPTICS_SERVICE_KEY: {{ ao_token }}:demo-booking-service
    - extra_hosts:
      - booking.neta-suites.com:127.0.0.1
      - db.neta-suites.com:127.0.0.1

web-tier:
  docker_container.running:
    - name: web-tier
    - image: appoptics/demo-web-tier
    - hostname: client-frontend
    - port_bindings:
      - 3000:3000/tcp
    - links:
      - booking-service:booking.neta-suites.com
    - depends_on:
      - booking-service
    - environment:
      - ROBBOSS_SERVICE_BOOKING_URL: http://booking.neta-suites.com:8080
      - APPOPTICS_SERVICE_KEY: {{ ao_token }}:demo-web-tier
    - extra_hosts:
      - neta-suites.com:127.0.0.1

  #
  #demo.api (Golang)
  #
api:
  docker_container.running:
    - name: api
    - image: appoptics/demo-api
    - hostname: demo-api-1
    - port_bindings:
      - 8082:3005/tcp
    - links:
      - booking-service:booking.neta-suites.com
    - depends_on:
      - booking-service
    - environment:
      - APPOPTICS_SERVICE_KEY: {{ ao_token }}:demo-api

  #
  #demo.load-gen (uses cron and apache bench to generate traffic)
  #
load-gen:
  docker_container.running:
    - image: appoptics/demo-load-gen
    - name: load-gen
    - hostname: load_gen_1
    - links:
      - web-tier:example-suites.com
      - api:api.example-suites.com
    - depends_on:
      - api
      - web-tier
