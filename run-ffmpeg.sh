#!/bin/bash
set -e

# env variables
#  RTSP_URL (mandatory)
# optionally
#  TS_URL
#  M3U8_URL
#  HLS_TIME
#  HLS_FLAGS

# exit if no stream parameter has been passed
if [ -z "${RTSP_URL// }" ]; then
    echo "Must set RTSP_URL environment variable"
    exit 1
fi

# output to file.
ts_url=${TS_URL:-"/output/%Y%m%dT%H%M%S.ts"}
m3u8_url=${M3U8_URL:-"/output/camera.m3u8"}
hls_time=${HLS_TIME:-60}
hls_flags=${HLS_FLAGS:-"temp_file+omit_endlist"}

DIR=/output
cd "$DIR"

# start recording with ffmpeg
exec ffmpeg \
    -hide_banner \
    -loglevel info \
    -nostats \
    -rtsp_transport tcp \
    -y \
    -stimeout 1000000 \
    -err_detect ignore_err \
    -i "$RTSP_URL" \
    -c copy \
    -an \
    -f hls \
    -use_wallclock_as_timestamps 1 \
    -avoid_negative_ts disabled \
    -hls_time "$hls_time" \
    -strftime 1 \
    -use_localtime 1 \
    -use_localtime_mkdir 1 \
    -hls_flags "$hls_flags" \
    -hls_segment_filename "$ts_url" \
    -method PUT \
    "$m3u8_url"
