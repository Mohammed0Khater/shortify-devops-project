from flask import Flask, request, jsonify, redirect
import redis
import hashlib
import os

app = Flask(__name__)
redis_client = redis.Redis(host='redis', port=6379, db=0, decode_responses=True)

@app.route('/shorten', methods=['POST'])
def shorten_url():
    data = request.json
    long_url = data.get('url')
    if not long_url:
        return jsonify({"error": "URL is required"}), 400
    short_hash = hashlib.md5(long_url.encode()).hexdigest()[:6]
    redis_client.set(short_hash, long_url)
    domain = os.environ.get('DOMAIN', 'http://localhost:5000')
    return jsonify({"short_url": f"{domain}/{short_hash}"})

@app.route('/<short_hash>')
def redirect_url(short_hash):
    long_url = redis_client.get(short_hash)
    if long_url:
        return redirect(long_url)
    return jsonify({"error": "URL not found"}), 404

@app.route('/health')
def health_check():
    return jsonify({"status": "OK"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
