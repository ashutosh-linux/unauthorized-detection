# 🏗️ AI-Powered Unauthorized Construction Detection

This project uses deep learning and GIS zoning to detect **unauthorized constructions** in aerial images. It leverages **Mask R-CNN (Detectron2)** for building detection, overlays GIS data, and generates **PDF reports** with predictive heatmaps.

---

## 🚀 Features

- 🧠 Deep learning with **Mask R-CNN**
- 🗺️ Red/Yellow **GIS zoning overlays**
- 📍 Converts pixel detections to **lat/lon**
- 🔥 Generates **heatmaps** of unauthorized areas
- 📄 Exports **PDF reports** with image and stats
- ☁️ Hosted on **Render.com** (Streamlit UI)

---

## 🗂️ Folder Structure

```
.
├── app.py                       # Streamlit application
├── Dockerfile                  # Docker config for Render
├── requirements.txt            # Python dependencies
├── .render.yaml                # Render deployment config
├── red_zone_real.geojson       # Red zone map
├── yellow_zone_real.geojson    # Yellow zone map
```

---

## 📦 Dependencies

- `streamlit`
- `torch`, `torchvision`
- `detectron2`
- `opencv-python-headless`
- `geopandas`, `shapely`
- `fpdf`, `matplotlib`, `gdown`

Install with:

```bash
pip install -r requirements.txt
```

---

## 💻 Running Locally

```bash
streamlit run app.py
```

The model (`model_final.pth`) is auto-downloaded from Google Drive via `gdown` when first run:
[Download Link](https://drive.google.com/uc?id=1lAQfN-7JB_WoYWO0L-cq_EtWdxsWjExQ)

---

## 🌐 Live Deployment

Deployed using **Render** via Docker + `.render.yaml`.  
Model is downloaded at runtime — no manual upload needed.

---

## 📢 Credits

Developed by Ashutosh Kumar and team @ SR University  
Part of a smart city solution for illegal construction tracking 🚁📡
