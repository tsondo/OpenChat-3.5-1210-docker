# OpenChat-3.5-1210 Docker

Minimal Dockerized scaffold for running [OpenChat-3.5-1210](https://huggingface.co/openchat/openchat-3.5-1210) locally with vLLM.

---

## 📦 Requirements
- NVIDIA GPU (tested on RTX 5090, 32GB VRAM)
- NVIDIA driver >= 550.xx
- Docker + NVIDIA Container Toolkit

---

## 🐧 Setup for Linux (Ubuntu, Debian, Arch, etc.)

### 1. Clone the repo
git clone https://github.com/tsondo/OpenChat-3.5-1210-docker.git ~/OpenChat-3.5-1210-docker
cd ~/OpenChat-3.5-1210-docker

### 2. Build and launch
docker compose up --build

This exposes an OpenAI-compatible API at:
http://localhost:8000/v1/chat/completions

---

## 🧪 Test the API
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openchat/openchat-3.5-1210",
    "messages": [{"role": "user", "content": "Hello, who are you?"}]
  }'

---

## 🧱 Project Structure
- `Dockerfile` → container definition
- `docker-compose.yml` → service orchestration
- `README.md` → usage instructions

---

## 🔁 Daily Usage
To start the API each day:
docker compose up

To stop the container:
docker compose down

---

## 📝 Notes
- This is a **baseline scaffold**. No memory, tools, or agent layers yet.
- Next steps will be layered in once this baseline is confirmed stable.
