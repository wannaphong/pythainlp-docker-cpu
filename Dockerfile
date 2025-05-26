FROM ubuntu:noble

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends python3-pip python3-venv build-essential libicu-dev pkg-config git software-properties-common && rm -rf /var/lib/apt/lists/*
RUN update-ca-certificates
WORKDIR /workspace
RUN git clone https://github.com/PyThaiNLP/pythainlp.git
RUN cd pythainlp
RUN python3 -m venv .venv
RUN source .venv/bin/activate
RUN pip install --upgrade pip setuptools
RUN if [ -f docker_requirements.txt ]; then pip install -r docker_requirements.txt; fi
RUN pip install -e .[full] && pip3 cache purge
