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
