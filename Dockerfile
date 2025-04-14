FROM python:3.9-slim

# ---------------------- SYSTEM DEPENDENCIES ----------------------
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git curl wget build-essential python3-dev \
    && rm -rf /var/lib/apt/lists/*

# ---------------------- SETUP WORKDIR ----------------------
WORKDIR /app
COPY . .

# ---------------------- PYTHON PACKAGES ----------------------
RUN pip install --upgrade pip
RUN pip install torch==1.13.0 torchvision==0.14.0 --index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

# ---------------------- INSTALL DETECTRON2 FROM SOURCE ----------------------
RUN pip install cython
RUN git clone https://github.com/facebookresearch/detectron2.git && \
    pip install -e detectron2

# ---------------------- FINAL SETUP ----------------------
EXPOSE 8501
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
