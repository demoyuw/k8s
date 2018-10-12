FROM ubuntu:16.04
LABEL version="0.1"
ENV USERIS='yuweichou'
#COPY cirros-0.3.4-x86_64-disk.img /
RUN ["/bin/bash", "-c", "apt update"]
RUN ["/bin/bash", "-c", "apt install nginx -y"]
RUN ["/bin/bash", "-c", "echo hellow >> hellow.txt"]
CMD ["/bin/bash", "-c", "echo $USERIS > hellow.txt"]
