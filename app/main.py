from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "ok",
        "message": "cicd-demo app is running"
    })

@app.route("/health")
def health():
    return jsonify({"healthy": True}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)