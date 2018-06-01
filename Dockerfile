FROM ubuntu:16.04

ADD https://s3.amazonaws.com/parsec-build/package/parsec-linux.deb parsec-linux.deb
RUN apt-get update && \
    apt-get -y install pulseaudio && \
    dpkg -i parsec-linux.deb || true && \
    yes | apt-get -f install && \
    apt-get clean && \
    echo enable-shm=no >> /etc/pulse/client.conf

# PulseAudio server.
ENV PULSE_SERVER /run/pulse/native

# Parsec user
RUN useradd -ms /bin/bash parsec
USER parsec
WORKDIR /home/parsec

CMD ["/usr/bin/parsecd"]
