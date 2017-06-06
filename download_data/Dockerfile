FROM debian:jessie

RUN apt-get update
RUN apt-get -f install
RUN apt-get install -y \
    wget \
    curl \
    bzip2

CMD bash download_data/main.sh; touch /tmp/downloaded_data
