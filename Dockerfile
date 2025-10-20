# Base image with CUDA 12.2 + cuDNN8 runtime
FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

# Avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# System dependencies
RUN apt-get update && apt-get install -y \
    git curl wget python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Install PyTorch (CUDA 12.1 wheels are compatible with 12.2 runtime)
RUN pip install --no-cache-dir \
    torch==2.2.2+cu121 \
    torchvision==0.17.2+cu121 \
    torchaudio==2.2.2+cu121 \
    --index-url https://download.pytorch.org/whl/cu121

# Pin NumPy to <2.0.0 to avoid outlines/vLLM incompatibility
RUN pip install --no-cache-dir "numpy==1.26.4"

# Install vLLM (this will bring in lm-format-enforcer==0.9.8 and outlines)
RUN pip install --no-cache-dir vllm==0.4.2

# Override transformers to a compatible version (still has LogitsWarper)
RUN pip install --no-cache-dir "transformers[torch]==4.36.2"

# Pin tokenizers to match transformers 4.36.2
RUN pip install --no-cache-dir "tokenizers==0.15.2"

# Working directory
WORKDIR /workspace

# Expose API port
EXPOSE 8000

# Default command: launch vLLM OpenAI-compatible server
CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", "--model", "openchat/openchat-3.5-1210"]
