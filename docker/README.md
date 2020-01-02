# Commands

- Download image
```shell
docker pull ubuntu:18.04
```
- Images:
```shell
docker images
```
- Run container:
```shell
docker run -i -v /home/carlos/repo/:/home/ -t ghdl:4.0.0 /bin/bash
```
- Delete image:
```shell
docker rmi IMAGEN
```
- Build image:
```shell
docker build -t "ghdl-0.35:1.0.0" .
```
- Clean
```
docker system prune
```

# Others

```shell
docker build --build-arg VIVADO_VERSION=2019.2 --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_2019.2_1106_2127 -t vivado:2019.2 .
```

```shell
docker build -t ghdl:1.0.0 --target GHDL .
```
