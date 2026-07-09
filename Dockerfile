FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    openssl \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    netcat \
    telnet \
    vim \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m appuser && echo "appuser:password123" | chpasswd
RUN echo "root:root123" | chpasswd

RUN mkdir -p /app /secrets
WORKDIR /app

COPY requirements.txt /app/requirements.txt
#RUN pip3 install --no-cache-dir -r requirements.txt

COPY app.py /app/app.py
COPY secrets.txt /secrets/secrets.txt

EXPOSE 5000

CMD ["python3", "app.py"]
