
FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 cmake gcc git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
