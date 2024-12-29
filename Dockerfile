# openSUSE Leap image
FROM opensuse/leap:latest

# Install system dependencies
RUN zypper refresh && zypper --non-interactive install --no-recommends -y \
    gcc \
    gcc-c++ \
    make \
    cmake \
    python3 \
    python3-devel \
    python3-pip \
    python3-numpy \
    python3-networkx \
    R-base \
    R-devel \
    perl \
    pari-devel \
    git \
    wget \
    && zypper clean -a

# Install Math::Pari
RUN cpan Math::Pari

# create workspace 
RUN mkdir ~/NetNC
WORKDIR ~/NetNC

# Install Python packages
#RUN python3 -m venv netnc && source netnc/bin/activate
#RUN pip3 install --no-cache-dir numpy networkx==1.8

# Copy files into workspace
COPY . .
RUN cp -r /~/NetNC /usr/local/bin/

# Run NetNC with test dataset
RUN  perl /usr/local/bin/NetNC/NetNC_v2pt2.pl -n test/network/test_net.txt -i test/test_genelist.txt -o test/exampleOutput/testrun -z 100 -F -M -l test/test_background_genelist.txt
