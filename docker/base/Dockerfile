ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

ARG VUNIT_VERSION
ARG COCOTB_VERSION

COPY ./base.sh /tmp/base.sh

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt install -y sudo
RUN cd /tmp ;chmod 777 ./base.sh; sync; ./base.sh ${VUNIT_VERSION} ${COCOTB_VERSION}
