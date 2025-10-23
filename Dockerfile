# Add build args to allow easy version updates
ARG NGINX_BUILD_IMAGE=nginx:1.29.2-alpine
ARG NGINX_RUN_IMAGE=nginxinc/nginx-unprivileged:1.29.2-alpine

FROM ${NGINX_BUILD_IMAGE} AS build

ARG OPA_VERSION=1.9.0
LABEL org.opencontainers.image.authors="CZERTAINLY <support@czertainly.com>"

COPY ./policies /usr/share/nginx/html/bundles/policies

WORKDIR /usr/share/nginx/html/bundles

ADD https://openpolicyagent.org/downloads/v${OPA_VERSION}/opa_linux_amd64_static ./opa
RUN chmod 755 ./opa && ./opa build -b policies
RUN rm -r policies && rm opa

# package to rootless image
FROM ${NGINX_RUN_IMAGE}

COPY --from=build /usr/share/nginx/html /usr/share/nginx/html
