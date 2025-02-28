from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import requests
import socket
import os

app = Flask(__name__, static_folder='static', static_url_path='/')
CORS(app)

API_KEY = '1ba3bd84-f523-11ef-8b17-0200cd936042'

@app.route('/send-otp', methods=['POST'])
def send_otp():
    """ Sends OTP to the provided phone number """
    data = request.json
    phone = data.get('phone')

    if not phone:
        return jsonify({"status": "Error", "message": "Phone number is required"}), 400

    response = requests.post(
        f'https://2factor.in/API/V1/{API_KEY}/SMS/{phone}/AUTOGEN'
    )

    return jsonify(response.json()), response.status_code

@app.route('/verify-otp', methods=['POST'])
def verify_otp():
    """ Verifies the OTP entered by the user """
    data = request.json
    phone = data.get('phone')
    otp = data.get('otp')

    if not phone or not otp:
        return jsonify({"status": "Error", "message": "Phone and OTP are required"}), 400

    response = requests.post(
        f'https://2factor.in/API/V1/{API_KEY}/SMS/VERIFY3/{phone}/{otp}'
    )

    response_data = response.json()
    status = response_data.get("Status", "Failure")
    
    if status == "Success":
        return jsonify({"status": "Success", "message": "Login successful.", "redirect": "/welcome.html"})
    else:
        return jsonify({"status": "Failure", "message": "OTP not correct. Please try again."})

@app.route('/')
def home():
    """ Health check endpoint """
    return jsonify({"status": "OK", "message": "Flask OTP Verification API is running!"})

@app.route('/welcome.html')
def welcome():
    """ Serves the welcome page after successful OTP verification """
    return send_from_directory(app.static_folder, 'welcome.html')

def find_available_port(default_port=5000):
    """ Find an available port dynamically """
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    try:
        sock.bind(("0.0.0.0", default_port))
        sock.close()
        return default_port
    except OSError:
        return 8000  # If default is taken, use 8000

if __name__ == '__main__':
    port = find_available_port()
    print(f"Running on port {port}...")
    app.run(debug=True, host='0.0.0.0', port=port)