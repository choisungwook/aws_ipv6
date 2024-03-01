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

class HTTPServerV6(HTTPServer):
  address_family = socket.AF_INET6

def run(server_class=HTTPServerV6, handler_class=SimpleHTTPRequestHandler):
  server_address = ('::', 8000)  # Bind to IPv6 address
  httpd = server_class(server_address, handler_class)
  print(f'Starting httpd server on port 8000')
  httpd.serve_forever()

run()
