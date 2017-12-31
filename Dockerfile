FROM debian:8
MAINTAINER Dominique Barton

#
# Create user and group for utorrent.
#


#
# Add utorrent init script.
#
RUN mkdir /utorrent
ADD utorrent.sh /utorrent.sh
#RUN chown utorrent: /utorrent.sh \
#    && chmod 755 /utorrent.sh

#
# Install utorrent and all required dependencies.
#

RUN apt-get -q update \
    && apt-get install -qy curl libssl1.0.0 \
    && curl -s http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 | tar xzf - --strip-components 1 -C utorrent \
#    && chown -R utorrent: utorrent \
    && apt-get -y remove curl \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

#ADD webui.zip /utorrent/webui.zip
#
# Define container settings.
#

VOLUME ["/settings", "/media"]

ADD utserver.conf /utorrent/utserver.conf

EXPOSE 7777 1254

#
# Start utorrent.
#
RUN chmod 777 -R /utorrent
RUN chmod 777 /utorrent.sh

RUN mkdir -p "/mnt/FS/Movies"
RUN mkdir -p "/mnt/FS/Movies"
RUN mkdir -p "/mnt/FS/Series"
RUN mkdir -p "/mnt/FS/Clips"
RUN mkdir -p "/mnt/FS/Kids movies"
RUN mkdir -p "/mnt/FS/Music"
RUN mkdir -p "/mnt/FS/tosort"



RUN chmod 777 -R /mnt/FS

WORKDIR /utorrent


CMD ["/utorrent.sh"]
