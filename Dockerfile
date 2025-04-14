FROM python:3.9-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git curl wget build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Upgrade pip and install core Python libs
RUN pip install --upgrade pip

# Install PyTorch CPU
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install Detectron2 (CPU)
RUN pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cpu/torch2.0/index.html

# Install other dependencies
RUN pip install -r requirements.txt

# Expose Streamlit port
EXPOSE 8501

# Start the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
