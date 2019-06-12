FROM andrewnk/turtlecoin:base as turtlecoind-bin

FROM alpine:latest as turtlecoind

# s6-overlay configuration
ENV S6_KEEP_ENV=1
ENV S6_KILL_GRACETIME=6000
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1

# Build and some of image configuration
ARG TRTL_USER=turtle
ENV TRTL_USER=${TRTL_USER}
ARG TRTL_HOME="/home/${TRTL_USER}"
ENV TRTL_HOME=${TRTL_HOME}
ARG TRTL_CHECKPOINTS=https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints.csv
ARG TRTL_CHECKPOINTS_1M=https://raw.githubusercontent.com/turtlecoin/checkpoints/master/checkpoints-1M.csv
ENV TRTL_CHECKPOINTS=${TRTL_CHECKPOINTS}
ENV TRTL_CHECKPOINTS_1M=${TRTL_CHECKPOINTS_1M}
ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz


# Get turtlecoind binaries
COPY --from=turtlecoind-bin /TurtleCoind /usr/local/bin

# Download s6-overlay and TurtleCoin releases
ADD ${S6_OVERLAY_RELEASE} /tmp/s6-overlay-rel.tar.gz
ADD rootfs /

# Unpack downloaded archives and make sure that TRTL_PATH exists
RUN apk add --update --no-cache curl bash libucontext-dev \
    && adduser --shell /bin/false --disabled-password --gecos "TurtleCoin User" --home "${TRTL_HOME}" "${TRTL_USER}" \
    && gunzip -c /tmp/s6-overlay-rel.tar.gz | tar -xf - -C / \
    && mkdir -p "${TRTL_HOME}" \
    && rm /tmp/*-rel.tar.gz -rf

WORKDIR "${TRTL_HOME}"

# Make sure to create at least remporary volume for TurtleCoin
VOLUME ["${TRTL_HOME}"]

# Expose
EXPOSE 11898:11898

# s6-overlay entrypoint
ENTRYPOINT ["/init"]
