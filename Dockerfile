# ubuntu LTS image
FROM ubuntu:latest

# install system dependencies
RUN apt update && apt-get install -y --no-install-recommends build-essential \
        cpanminus \
        r-base \
        python3 \
        python3-dev \
        python3-pip \
        python3-numpy \
        python3-networkx \
        perl \
        pari-gp \
        libpari-dev \
        git \
        wget && rm -rf /var/lib/apt/lists/*

# install math::pari using cpanm
RUN cpanm Math::Pari

# workspace
RUN mkdir ~/NetNC
WORKDIR ~/NetNC

# copy files into workspace
COPY . .
RUN cp -r /~/NetNC /usr/local/bin/

# Run NetNC with test dataset
RUN  perl /usr/local/bin/NetNC/NetNC_v2pt2.pl -n test/network/test_net.txt -i test/test_genelist.txt -o test/exampleOutput/testrun -z 100 -F -M -l test/test_background_genelist.txt
