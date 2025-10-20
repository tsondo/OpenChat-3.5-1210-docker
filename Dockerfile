FROM nvidia/cuda:12.2.2-runtime-ubuntu22.04

# System deps
RUN apt-get update && apt-get install -y \
    git python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install vLLM (fast inference engine)
RUN pip install --upgrade pip
RUN pip install vllm==0.4.2 huggingface_hub

# Expose OpenAI-compatible API server
EXPOSE 8000

# Default command: run vLLM with OpenChat
CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", \
     "--model", "openchat/openchat-3.5-1210", \
     "--port", "8000", \
     "--dtype", "float16"]
