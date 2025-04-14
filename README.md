[![Render Deployment](https://img.shields.io/badge/Live%20App-On%20Render-green?style=for-the-badge&logo=render&logoColor=white)](https://ai-driven-unauthorized-detection.onrender.com)

# 🏗️ AI-Powered Unauthorized Construction Detection

This project uses deep learning and GIS zoning to detect **unauthorized constructions** in aerial images.  
It leverages **Mask R-CNN (Detectron2)** for building detection, overlays GIS data, and generates **PDF reports with heatmaps**.

---

## 🚀 Features

- 🧠 Deep learning with **Mask R-CNN**
- 🗺️ Red/Yellow **GIS zoning overlays**
- 📍 Converts pixel detections to **lat/lon**
- 🔥 Generates **heatmaps** of unauthorized hotspots
- 📄 Exports **PDF reports** with image, stats & map
- ☁️ Deployed on **Render.com** (Streamlit UI)

---

## 🗂️ Folder Structure

```
.
├── app.py                       # Streamlit application
├── Dockerfile                  # Docker config for Render
├── requirements.txt            # Python dependencies
├── .render.yaml                # Render deployment config
├── red_zone_real.geojson       # Red zone GIS map
├── yellow_zone_real.geojson    # Yellow zone GIS map
```

---

## 📦 Dependencies

- `streamlit`
- `torch`, `torchvision`
- `detectron2`
- `opencv-python-headless`
- `geopandas`, `shapely`
- `fpdf`, `matplotlib`, `requests`

Install locally using:

```bash
pip install -r requirements.txt
```

---

## 💻 Run Locally

```bash
streamlit run app.py
```

> ⚠️ Make sure you're connected to internet the first time — it will automatically download and unzip the trained model from GitHub Releases.

---

## 📦 Model Download via GitHub Release

This project uses a trained Detectron2 Mask R-CNN model hosted via GitHub Releases:

🔗 **[model_final.pth.zip](https://github.com/ashutosh-linux/unauthorized-detection/releases/download/v1.0/model_final1.zip)**

- The app automatically downloads and unzips this model at runtime
- No need for manual uploads

---

## 🌐 Live Deployment

Deployed with **Docker + .render.yaml** on Render:

👉 **Live App:** [https://ai-driven-unauthorized-detection.onrender.com](https://ai-driven-unauthorized-detection.onrender.com)

---

## 📢 Credits

Developed by **Ashutosh Kumar** and team @ **SR University**  
Built as part of a **Smart City solution** for tracking unauthorized construction 🚁📡

