FROM python:3.9-slim

# ------------------ Install system dependencies ------------------
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git curl wget unzip build-essential \
    && rm -rf /var/lib/apt/lists/*

# ------------------ Set working directory ------------------
WORKDIR /app
COPY . .

# ------------------ Download and extract model_final.zip ------------------
RUN curl -L -o model_final.zip https://github.com/ashutosh-linux/unauthorized-detection/releases/download/v2.0/model_final.zip && \
    unzip model_final.zip && \
    ls -lh && echo "🧠 MODEL FILE STATUS:" && ls -lh model_final.pth || echo "❌ model_final.pth MISSING" && \
    rm model_final.zip

# ------------------ Install Python dependencies ------------------
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# ------------------ Install Detectron2 (CPU build) ------------------
RUN pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cpu/torch1.10/index.html

# ------------------ Expose port & run Streamlit ------------------
EXPOSE 8501
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
