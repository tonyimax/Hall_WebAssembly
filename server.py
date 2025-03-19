from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        super().end_headers()

# 创建 HTTPS 服务器
httpd = HTTPServer(('localhost', 8000), CORSRequestHandler)

# 创建 SSL 上下文
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile='cert.pem', keyfile='key.pem')  # 加载证书和密钥

# 包装 socket
httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

# 启动服务器
print("Serving on https://localhost:8000")
httpd.serve_forever()
