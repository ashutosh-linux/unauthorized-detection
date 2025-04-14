FROM python:3.9-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git curl wget build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Upgrade pip and install torch
RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install detectron2 from pre-built wheel (CPU version)
RUN pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu113/torch1.10/index.html

# Install the rest of the requirements
RUN pip install -r requirements.txt

# Expose port
EXPOSE 8501

# Start Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
