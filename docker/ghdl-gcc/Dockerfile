ARG BASE
FROM $BASE

ADD ./install_ghdl_gcc.sh /tmp/install_ghdl_gcc.sh
ADD ./ghdl_uvvm_libraries.sh /tmp/ghdl_uvvm_libraries.sh

ARG GHDL_VERSION
ARG GCC_VERSION
ARG UVVM_VERSION
ARG UVVM_MODELSIM_LIBRARIES_PATH

RUN apt-get update -qq
RUN cd /tmp ;chmod 777 ./install_ghdl_gcc.sh; sync; ./install_ghdl_gcc.sh ${GHDL_VERSION} ${GCC_VERSION}
RUN cd /tmp ;chmod 777 ./ghdl_uvvm_libraries.sh; sync; ./ghdl_uvvm_libraries.sh ${UVVM_VERSION} ${UVVM_MODELSIM_LIBRARIES_PATH}
