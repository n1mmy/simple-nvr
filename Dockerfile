FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# get ffmpeg
RUN apt-get update && apt-get install -y ffmpeg curl && apt-get clean -y

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "-g", "--"]

WORKDIR /root
COPY *.sh ./
RUN chmod +x ./*.sh
RUN mkdir /output

CMD ["./run-ffmpeg.sh"]
