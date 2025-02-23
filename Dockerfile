FROM nginx:1.27.4-alpine AS build

LABEL org.opencontainers.image.authors="CZERTAINLY <support@czertainly.com>"

COPY ./policies /usr/share/nginx/html/bundles/policies

WORKDIR /usr/share/nginx/html/bundles

RUN curl -L -o opa https://openpolicyagent.org/downloads/v0.53.1/opa_linux_amd64_static && chmod 755 ./opa
RUN ./opa build -b policies
RUN rm -r policies && rm opa

# package to rootless image
FROM nginxinc/nginx-unprivileged:1.27.4-alpine

COPY --from=build /usr/share/nginx/html /usr/share/nginx/html