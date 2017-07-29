FROM resin/rpi-raspbian:jessie
MAINTAINER Steven Lazidis, https://github.com/the1laz


RUN     apt-get update && \
        apt-get -y install perl adduser iproute iputils-ping curl wget faad flac lame sox libio-socket-ssl-perl


ENV    SQUEEZE_VOL_PERSIST /var/lib/squeezeboxserver
ENV    SQUEEZE_VOL_LOG /var/log/squeezeboxserver

ENV 	LANG C.UTF-8
ENV	LMS_URL http://downloads.slimdevices.com/LogitechMediaServer_v7.9.0/logitechmediaserver_7.9.0_arm.deb
RUN	curl -Lf -o /tmp/lms.deb $LMS_URL && \
	dpkg -i /tmp/lms.deb && \
	rm -f /tmp/lms.deb && \
	apt-get clean

VOLUME 	$SQUEEZE_VOL_PERSIST $SQUEEZE_VOL_LOG
EXPOSE 	3483 3483/udp 9000 9090

COPY entrypoint.sh.txt /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

