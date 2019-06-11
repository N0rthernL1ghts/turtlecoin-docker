FROM debian:latest

# s6-overlay configuration
ENV S6_KEEP_ENV=1
ENV S6_KILL_GRACETIME=6000
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1

# Build and some of image configuration
ARG TRTL_VERSION=0.14.6
ENV TRTL_VERSION=${TRTL_VERSION}
ARG TRTL_RELEASE=https://github.com/turtlecoin/turtlecoin/releases/download/v${TRTL_VERSION}/turtlecoin-v${TRTL_VERSION}-linux.tar.gz
ARG TRTL_PATH=/turtlecoin
ENV TRTL_PATH=${TRTL_PATH}
ARG TRTL_USER=turtle
ENV TRTL_USER=${TRTL_USER}
ARG TRTL_HOME="/home/${TRTL_USER}"
ENV TRTL_HOME=${TRTL_HOME}
ARG TRTL_CHECKPOINTS=https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints.csv
ARG TRTL_CHECKPOINTS_1M=https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints-1M.csv
ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz

# Download s6-overlay and TurtleCoin releases
ADD ${S6_OVERLAY_RELEASE} /tmp/s6-overlay-rel.tar.gz
ADD ${TRTL_RELEASE} /tmp/turtlecoin-rel.tar.gz
ADD ${TRTL_CHECKPOINTS} /tmp/trtl-checkpoints.csv
ADD ${TRTL_CHECKPOINTS_1M} /tmp/trtl-1m-checkpoints.csv
ADD rootfs /

# Unpack downloaded archives and make sure that TRTL_PATH exists
RUN adduser --shell /bin/false --disabled-password --gecos "TurtleCoin User" --home "${TRTL_HOME}" "${TRTL_USER}" \
    && gunzip -c /tmp/s6-overlay-rel.tar.gz | tar -xf - -C / \
    && mkdir -p ${TRTL_PATH} \
    && tar -zxf /tmp/turtlecoin-rel.tar.gz --strip-components=1 -C ${TRTL_PATH} \
    && cat /tmp/trtl-checkpoints.csv /tmp/trtl-1m-checkpoints.csv > "${TRTL_HOME}/checkpoints.csv" \
    && rm /tmp/*checkpoints.csv -rf \
    && rm /tmp/*-rel.tar.gz -rf


# Make sure to create at least remporary volume for TurtleCoin
VOLUME ["${TRTL_HOME}"]

# Expose
EXPOSE 11897

# s6-overlay entrypoint
ENTRYPOINT ["/init"]
