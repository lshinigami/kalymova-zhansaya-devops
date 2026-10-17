import os
import signal
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler

# Values come from environment variables; the second value is the default
NAME = os.getenv("STUDENT_NAME", "Zhansaya")
SURNAME = os.getenv("STUDENT_SURNAME", "Kalymova")
GROUP = os.getenv("STUDENT_GROUP", "IT2-2312")
STUDENT_ID = os.getenv("STUDENT_ID", "37552")
PORT = int(os.getenv("PORT", "8000"))


def info_text():
    line = "=" * 32
    return (
        f"{line}\n"
        "DevOps Student Application\n"
        f"{line}\n"
        f"Name: {NAME}\n"
        f"Surname: {SURNAME}\n"
        f"Group: {GROUP}\n"
        f"Student ID: {STUDENT_ID}\n"
        "\n"
        "Application is running successfully!\n"
    )


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = info_text().encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(body)


def stop(signum, frame):
    print("Application stopped.")
    sys.exit(0)


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, stop)  # lets "docker stop" end the app quickly
    print(info_text())
    print(f"Web page available on port {PORT}")
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
