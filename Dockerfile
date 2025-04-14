FROM python:3.9-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Upgrade pip and install torch first
RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# THEN install the rest (including detectron2)
RUN pip install -r requirements.txt

# Expose Streamlit port
EXPOSE 8501

# Start the app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
