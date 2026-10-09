# n8n chạy video affiliate — Dockerfile 0đ
# Dùng image n8n gốc + cài thêm ffmpeg, python3 và edge-tts (giọng đọc AI tiếng Việt)
# để các node Execute Command trong workflow chạy được.

FROM n8nio/n8n:latest

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 python3-pip ffmpeg fonts-dejavu \
 && pip3 install --break-system-packages --no-cache-dir edge-tts \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Thư mục làm việc cho workflow (node Config dùng /home/node/afl)
RUN mkdir -p /home/node/afl && chown -R node:node /home/node/afl

USER node
