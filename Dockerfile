FROM python:3.13-slim

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends build-essential libicu-dev libicu63 pkg-config git && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
RUN git clone https://github.com/PyThaiNLP/pythainlp.git
RUN cd pythainlp
RUN pip3 install --upgrade pip setuptools
RUN if [ -f docker_requirements.txt ]; then pip3 install -r docker_requirements.txt; fi
RUN pip3 install -e .[full] && pip3 cache purge
