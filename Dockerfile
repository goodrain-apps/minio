FROM minio/minio

RUN apk add --no-cache ca-certificates && \
    apk add --no-cache --virtual .build-deps bash && \
    curl https://dl.minio.io/client/mc/release/linux-amd64/mc > /usr/bin/mc && \
    chmod +x /usr/bin/mc 

COPY docker-entrypoint.sh /run/

RUN chmod +x /run/docker-entrypoint.sh 

ENTRYPOINT [ "bash", "/run/docker-entrypoint.sh" ]

CMD [ "minio","server","/data" ]
