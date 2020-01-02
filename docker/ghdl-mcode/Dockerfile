FROM base:1.0.0

COPY ./ghdl_mcode.sh /tmp/install.sh

RUN apt-get update -qq
RUN cd /tmp ;chmod 777 ./install.sh; sync; ./install.sh
