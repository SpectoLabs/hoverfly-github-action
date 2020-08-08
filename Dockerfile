FROM alpine:3.10

COPY LICENSE README.md entrypoint.sh install-and-trust-hoverfly-default-cert.sh /

ENTRYPOINT ["/entrypoint.sh"]
