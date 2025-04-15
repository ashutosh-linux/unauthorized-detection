# 🏗️ AI-Powered Unauthorized Construction Detection

This Streamlit app detects unauthorized constructions in aerial images using deep learning (Mask R-CNN with Detectron2) and GIS zoning overlays (Red & Yellow zones). It's designed for urban monitoring, smart city compliance, and aerial surveillance analysis.

## 🚀 Features
- 🧠 Deep learning with **Mask R-CNN (Detectron2)**
- 🗺️ Red/Yellow GIS zoning overlays using GeoJSON
- 📍 Converts pixel coordinates to **latitude/longitude**
- 🔥 Generates **hotspot heatmaps** of unauthorized construction
- 📄 Generates downloadable **PDF reports** with visuals and stats
- 🖼️ Streamlit-based interactive interface

## 🛠️ Tech Stack
- `Streamlit`, `Torch`, `Detectron2`, `OpenCV`
- `GeoPandas`, `Shapely`, `Matplotlib`, `FPDF`

## 📦 Files

## 📥 Model Download

The pretrained **Mask R-CNN** model (`model_final.pth`) is downloaded automatically at runtime from this GitHub Release:

🔗 https://github.com/ashutosh-linux/unauthorized-detection/releases/tag/v2.0

You **don’t need to upload it manually** — it's extracted and used by the app on first run.

## 🚀 How to Run on Hugging Face

This app is built for **Hugging Face Spaces** using:

- ✅ `Streamlit SDK`
- ✅ `GPU` hardware (for Detectron2)
- 📁 GitHub-hosted model with auto-download logic

## 💻 Run Locally
```bash
git clone https://github.com/ashutosh-linux/unauthorized-detection
cd unauthorized-detection
pip install -r requirements.txt
streamlit run app.py

