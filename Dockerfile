FROM python:3.9-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git curl wget build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install --upgrade pip

# Install torch 1.13 for Detectron2 CPU support
RUN pip install torch==1.13.0 torchvision==0.14.0 --index-url https://download.pytorch.org/whl/cpu

# ✅ Install Detectron2 (CPU) using compatible wheel
RUN pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cpu/torch1.13/index.html

# Install other requirements
RUN pip install -r requirements.txt

EXPOSE 8501
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
