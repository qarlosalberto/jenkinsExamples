ARG VIVADO_VERSION
FROM vivado:${VIVADO_VERSION}

ARG MODELSIM_PATH
ARG MODELSIM_INSTALL_FILE
ARG VIVADO_PATH
ARG VIVADO_MODELSIM_LIBRARIES_PATH
ARG UVVM_VERSION
ARG UVVM_MODELSIM_LIBRARIES_PATH

ENV HOME /home

ADD ./modelsim_install.sh /tmp/modelsim_install.sh
ADD ./modelsim_vivado_libraries.sh /tmp/modelsim_vivado_libraries.sh
ADD ./modelsim_uvvm_libraries.sh /tmp/modelsim_uvvm_libraries.sh
ADD ./${MODELSIM_INSTALL_FILE} /tmp/${MODELSIM_INSTALL_FILE}

RUN apt-get update -qq
RUN apt-get install -y apt-utils
RUN cd /tmp ;chmod 777 ./modelsim_install.sh; sync; ./modelsim_install.sh ${MODELSIM_PATH} ${MODELSIM_INSTALL_FILE}
RUN cd /tmp ;chmod 777 ./modelsim_vivado_libraries.sh; sync; ./modelsim_vivado_libraries.sh ${VIVADO_PATH} ${MODELSIM_PATH} ${VIVADO_MODELSIM_LIBRARIES_PATH}
RUN cd /tmp ;chmod 777 ./modelsim_uvvm_libraries.sh; sync; ./modelsim_uvvm_libraries.sh ${UVVM_VERSION} ${UVVM_MODELSIM_LIBRARIES_PATH} ${MODELSIM_PATH}
