# apt-get install python-flask
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return "api is working"

@app.route("/dologin", methods=["POST"])
def login():
    name = request.form.get("name")
    password = request.form.get("password")

    if not all([name, password]):
        return jsonify(code=1, message="need parameter")
    if name == "admin" and password =="python":
        return jsonify(code=0, message="OK")
    else:
        return jsonify(code=2, message="user or password error")

if __name__ == "__main__":
    # Get Parameter
    app.run(host='0.0.0.0', port=10009)
