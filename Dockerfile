FROM ubuntu:14.04

MAINTAINER Yan Mosyagin <ymo@sandsiv.com>
#MAINTAINER Kyle Anderson <kyle@xkyle.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -y install \
        xvfb \
        x11vnc \
        wget \
        supervisor \
        fluxbox \
        icedtea-7-plugin \
        net-tools \
        chromium-browser
RUN sed -e '/^jdk.jar.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security \
    && sed -e '/^jdk.certpath.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security \
    && sed -e '/^    RSA keySize/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security \
    && sed -e '/^jdk.tls.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security \
    && sed -e '/^    EC keySize/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /root/
ADD novnc /root/novnc/

ENV DISPLAY :0
EXPOSE 8080 5900
CMD ["/usr/bin/supervisord"]
