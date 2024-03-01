#!/bin/bash

# wait for initial setup for aws instance
sleep 2;

sudo apt update -y

sudo systemctl stop ufw
sudo systemctl disable ufw

cat <<EOF | sudo tee /root/http_server.py
from http.server import BaseHTTPRequestHandler, HTTPServer
import socket

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header('Content-type', 'text/html')
    self.end_headers()
    message = str(self.client_address[0])
    self.wfile.write(bytes(message, "utf8"))
    return

def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler):
  server_address = ('0.0.0.0', 80)  # Bind to IPv6 address
  httpd = server_class(server_address, handler_class)
  print(f'Starting httpd server on port 80')
  httpd.serve_forever()
run()
EOF

cat <<EOF | sudo tee /etc/systemd/system/http_server.service
[Unit]
Description=HTTP Server
After=network.target

[Service]
ExecStart=/usr/bin/python3 /root/http_server.py
WorkingDirectory=/root
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable http_server
sudo systemctl start http_server
