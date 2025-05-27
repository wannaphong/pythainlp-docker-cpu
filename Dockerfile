FROM python:3.12

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends wget python3-pip python3-venv build-essential libicu-dev pkg-config git software-properties-common && rm -rf /var/lib/apt/lists/*
RUN update-ca-certificates
WORKDIR /workspace
RUN git clone https://github.com/PyThaiNLP/pythainlp.git
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN wget https://github.com/wannaphong/pythainlp-docker-cpu/raw/refs/heads/main/docker_requirements.txt
RUN pip install -r docker_requirements.txt
WORKDIR /workspace/pythainlp
RUN pip install -e .[full] && pip cache purge
