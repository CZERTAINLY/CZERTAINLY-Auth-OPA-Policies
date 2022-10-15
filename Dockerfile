FROM nginx:1.20.0-alpine

COPY ./policies /usr/share/nginx/html/bundles/policies

WORKDIR /usr/share/nginx/html/bundles

RUN curl -L -o opa https://openpolicyagent.org/downloads/v0.45.0/opa_linux_amd64_static && chmod 755 ./opa
RUN ./opa build -b policies
RUN rm -r policies && rm opa

