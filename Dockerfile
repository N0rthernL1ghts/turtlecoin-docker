FROM debian:latest

ENV S6_KEEP_ENV=1
ARG TRTL_VERSION=0.14.6
ENV TRTL_VERSION=${TRTL_VERSION}
ARG TRTL_RELEASE=https://github.com/turtlecoin/turtlecoin/releases/download/v${TRTL_VERSION}/turtlecoin-v${TRTL_VERSION}-linux.tar.gz
ARG TRTL_PATH=/turtlecoin
ENV TRTL_PATH=${TRTL_PATH}
ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz

# Download s6-overlay and TurtleCoin releases
ADD ${S6_OVERLAY_RELEASE} /tmp/s6-overlay-rel.tar.gz
ADD ${TRTL_RELEASE} /tmp/turtlecoin-rel.tar.gz
ADD rootfs /

# Unpack downloaded archives and make sure that TRTL_PATH exists
RUN gunzip -c /tmp/s6-overlay-rel.tar.gz | tar -xf - -C / \
    && mkdir -p ${TRTL_PATH} \
    && tar -zxf /tmp/turtlecoin-rel.tar.gz --strip-components=1 -C ${TRTL_PATH} \
    && rm /tmp/*-rel.tar.gz -rf

# Make sure to create at least remporary volume for TurtleCoin
VOLUME ["/root/.TurtleCoin"]

# s6-overlay entrypoint
ENTRYPOINT ["/init"]
