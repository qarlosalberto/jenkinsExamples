ARG BASE_VERSION
FROM base:${BASE_VERSION}

ARG XILINX_PATH
ARG VIVADO_VERSION
ARG VIVADO_TAR_FILE

COPY ./vivado.sh /tmp/install.sh
# COPY ./install_config.txt /tmp/install_config.txt
COPY ./config_vivado_${VIVADO_VERSION}.sh /tmp/config_vivado_${VIVADO_VERSION}.sh
COPY ./${VIVADO_TAR_FILE}.tar.gz /tmp/${VIVADO_TAR_FILE}.tar.gz

RUN cd /tmp ;chmod 777 ./config_vivado_${VIVADO_VERSION}.sh; sync; ./config_vivado_${VIVADO_VERSION}.sh ${XILINX_PATH} ${VIVADO_VERSION}
RUN cd /tmp ;chmod 777 ./install.sh; sync; ./install.sh ${XILINX_PATH} ${VIVADO_VERSION} ${VIVADO_TAR_FILE}
