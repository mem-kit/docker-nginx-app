FROM ubuntu:22.04

WORKDIR /home/app

# Install Python 3.12 and pip
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update  \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.12 python3.12-venv python3-pip \
    && rm -rf /usr/bin/python3 /usr/bin/pip \
    && ln -s /usr/bin/python3.12 /usr/bin/python3 \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates curl git tini nginx \
    && python3.12 -m ensurepip --upgrade \
    && python3.12 -m pip install --no-cache --upgrade pip setuptools wheel

# Set python3.12 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
COPY api.py requirements.txt start.sh ./

RUN pip install -r requirements.txt && chmod +x /start.sh
EXPOSE 8880
ENTRYPOINT ["/usr/bin/tini", "--", "/start.sh"]