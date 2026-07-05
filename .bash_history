sudo su -
mkdir -p ~/chola-phase2-vuln-image
ls
cd ~/chola-phase2-vuln-image
ls
cat > Dockerfile <<'EOF'
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
RUN pip3 install --no-cache-dir -r requirements.txt

COPY app.py /app/app.py
COPY secrets.txt /secrets/secrets.txt

EXPOSE 5000

CMD ["python3", "app.py"]
EOF

ls
vim Dockerfile 
cat > requirements.txt <<'EOF'
Flask==0.12.2
Jinja2==2.10
Werkzeug==0.14.1
requests==2.19.1
urllib3==1.22
PyYAML==3.13
Django==1.11.29
cryptography==2.1.4
Pillow==6.2.0
EOF

ls
cat > app.py <<'EOF'
from flask import Flask, request
import os
import subprocess
import yaml

app = Flask(__name__)

@app.route("/")
def home():
    return "Chola Phase 2 Vulnerable Container Image Demo"

@app.route("/cmd")
def command_injection():
    cmd = request.args.get("cmd", "id")
    return subprocess.getoutput(cmd)

@app.route("/read")
def path_traversal():
    file = request.args.get("file", "/etc/passwd")
    return open(file).read()

@app.route("/yaml", methods=["POST"])
def unsafe_yaml():
    data = request.data.decode()
    return str(yaml.load(data))

@app.route("/secret")
def secret():
    return "AWS_ACCESS_KEY_ID=AKIAEXAMPLE123456789"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

ls
cat > secrets.txt <<'EOF'
username=admin
password=password123
aws_access_key_id=AKIAEXAMPLE123456789
aws_secret_access_key=examplefakekeyonlynotreal
private_key=-----BEGIN RSA PRIVATE KEY----- FAKE TEST KEY -----END RSA PRIVATE KEY-----
EOF

ls
cat > README.md <<'EOF'
# Chola Phase 2 Vulnerable Container Image

Purpose: AccuKnox Phase 2 Container Image Scan validation.

Contains:
- Old Ubuntu base image
- Vulnerable Python packages
- Weak credentials
- Risky utilities
- Insecure app patterns

No real malware or real secrets are included.
EOF

ls
ll
ll -al
tree
sudo apt install tree
tree
sudo dnf update -y
sudo dnf install -y git curl jq yum-utils
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
cd ~/chola-phase2-vuln-image
sudo apt update -y
sudo apt install -y git curl jq docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
cd ~/chola-phase2-vuln-image
sudo apt update -y
sudo apt install -y git curl jq docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
exit
