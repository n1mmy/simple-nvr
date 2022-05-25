FROM alpine:3.15

ENV TZ=UTC

RUN apk add curl bash ffmpeg tini

WORKDIR /root
COPY *.sh ./
RUN chmod +x ./*.sh && mkdir /output

ENTRYPOINT ["tini", "-g", "--"]
CMD ["./run-ffmpeg.sh"]
