# 🏗️ AI-Powered Unauthorized Construction Detection

This project uses deep learning and GIS zoning to detect unauthorized constructions in aerial images.  
It leverages Mask R-CNN (Detectron2) for building detection, overlays GIS data, and generates PDF reports with heatmaps.

## 🚀 Features

- 🧠 Deep learning with Mask R-CNN (Detectron2)
- 🗺️ Red/Yellow GIS zoning overlays
- 📍 Converts pixel detections to latitude/longitude
- 🔥 Generates heatmaps of unauthorized construction hotspots
- 📄 Exports PDF reports with visuals, statistics & maps
- ☁️ Deployed on Render.com with a Streamlit UI

## 🗂️ Folder Structure

```
.
├── app.py                      # Streamlit application
├── Dockerfile                 # Docker config for Render
├── requirements.txt           # Python dependencies
├── .render.yaml               # Render deployment config
├── red_zone_real.geojson      # Red zone GIS map
├── yellow_zone_real.geojson   # Yellow zone GIS map
```

## 📦 Dependencies

- streamlit  
- torch, torchvision  
- detectron2  
- opencv-python-headless  
- geopandas, shapely  
- fpdf, matplotlib  
- requests  

Install locally using:
```bash
pip install -r requirements.txt
```

## 💻 Run Locally

```bash
streamlit run app.py
```

⚠️ Make sure you're connected to the internet the first time — the app will automatically download and unzip the trained model from GitHub Releases.

## 📦 Model Download via GitHub Release

This app uses a pretrained Detectron2 Mask R-CNN model hosted on GitHub:

🔗 [`model_final.zip`](https://github.com/ashutosh-linux/unauthorized-detection/releases/download/v2.0/model_final.zip)

✅ The app automatically downloads and extracts the model at runtime — **no manual upload needed**.

## 🌐 Live Deployment

Deployed using Docker + `.render.yaml` on [Render](https://render.com):

👉 **[Live Demo](https://unauthorized-detection.onrender.com)**

## 📢 Credits

Developed by **Ashutosh Kumar** and team @ **SR University**  
Built as part of a Smart City solution to track unauthorized construction 🚁📡
