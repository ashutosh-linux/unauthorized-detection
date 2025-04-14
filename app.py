import streamlit as st
import cv2
import numpy as np
import tempfile
import torch
import os
from detectron2.engine import DefaultPredictor
from detectron2.config import get_cfg
from detectron2 import model_zoo
from detectron2.utils.visualizer import Visualizer
from detectron2.data import MetadataCatalog
import geopandas as gpd
from shapely.geometry import Point
from fpdf import FPDF
import matplotlib.pyplot as plt

# ------------------ CONFIG ------------------
MODEL_PATH = "model_final.pth"
import gdown
if not os.path.exists(MODEL_PATH):
    gdown.download('https://drive.google.com/uc?id=1lAQfN-7JB_WoYWO0L-cq_EtWdxsWjExQ', output=MODEL_PATH, quiet=False)
RED_ZONE_PATH = "red_zone_real.geojson"
YELLOW_ZONE_PATH = "yellow_zone_real.geojson"

st.set_page_config(page_title="Unauthorized Construction Detector", layout="wide")
st.title("\U0001F3D7️ AI-Powered Unauthorized Construction Detection")

# ------------------ LOAD MODEL ------------------
@st.cache_resource
def load_model():
    cfg = get_cfg()
    cfg.merge_from_file(model_zoo.get_config_file("COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml"))
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = 0.5
    cfg.MODEL.WEIGHTS = MODEL_PATH
    cfg.MODEL.DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
    return DefaultPredictor(cfg)

predictor = load_model()

# ------------------ LOAD ZONES ------------------
red_zone = gpd.read_file(RED_ZONE_PATH)
yellow_zone = gpd.read_file(YELLOW_ZONE_PATH)

# ------------------ IMAGE UPLOAD ------------------
uploaded_file = st.file_uploader("Upload an aerial image", type=["jpg", "jpeg", "png"])

if uploaded_file:
    tfile = tempfile.NamedTemporaryFile(delete=False)
    tfile.write(uploaded_file.read())
    image = cv2.imread(tfile.name)
    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    height, width = image.shape[:2]

    st.image(image_rgb, caption="Original Image", use_column_width=True)

    outputs = predictor(image_rgb)
    instances = outputs["instances"].to("cpu")
    boxes = instances.pred_boxes.tensor.numpy()

    overlay = image_rgb.copy()
    authorized, unauthorized = 0, 0
    points = []

    def pixel_to_latlon(x, y):
        min_lat, min_lon, max_lat, max_lon = yellow_zone.total_bounds[[1, 0, 3, 2]]
        lon = min_lon + (x / width) * (max_lon - min_lon)
        lat = max_lat - (y / height) * (max_lat - min_lat)
        return lon, lat

    for box in boxes:
        x1, y1, x2, y2 = box.astype(int)
        cx, cy = (x1 + x2) // 2, (y1 + y2) // 2
        lon, lat = pixel_to_latlon(cx, cy)
        point = Point(lon, lat)

        if red_zone.contains(point).any():
            label, color = "Unauthorized", (255, 0, 0)
            unauthorized += 1
        elif yellow_zone.contains(point).any():
            label, color = "Authorized", (0, 255, 0)
            authorized += 1
        else:
            label, color = "Unzoned", (255, 255, 255)

        cv2.rectangle(overlay, (x1, y1), (x2, y2), color, 2)
        cv2.putText(overlay, label, (x1, y1 - 5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)

        if label == "Unauthorized":
            points.append([lon, lat])

    st.image(overlay, caption="Detection Result", use_column_width=True)

    # ------------------ HEATMAP ------------------
    if len(points) > 1:
        st.subheader("\U0001F525 Unauthorized Construction Hotspot Map")
        heat_df = np.array(points)
        fig, ax = plt.subplots(figsize=(10, 6))
        plt.hexbin(heat_df[:, 0], heat_df[:, 1], gridsize=30, cmap="Reds", mincnt=1)
        plt.colorbar(label="Unauthorized Count")
        plt.xlabel("Longitude")
        plt.ylabel("Latitude")
        st.pyplot(fig)

    # ------------------ PDF REPORT ------------------
    st.subheader("\U0001F4C4 Generate Report")
    if st.button("Download PDF Report"):
        pdf = FPDF()
        pdf.add_page()
        pdf.set_font("Arial", size=12)
        pdf.cell(200, 10, txt="Unauthorized Construction Detection Report", ln=True, align="C")
        pdf.cell(200, 10, txt="Authorized Buildings: {}".format(authorized), ln=True)
        pdf.cell(200, 10, txt="Unauthorized Buildings: {}".format(unauthorized), ln=True)

        overlay_path = os.path.join(tempfile.gettempdir(), "overlayed.jpg")
        cv2.imwrite(overlay_path, cv2.cvtColor(overlay, cv2.COLOR_RGB2BGR))
        pdf.image(overlay_path, x=10, y=None, w=180)

        pdf_path = os.path.join(tempfile.gettempdir(), "report.pdf")
        pdf.output(pdf_path)

        with open(pdf_path, "rb") as f:
            st.download_button("\U0001F4E5 Download Report PDF", f, file_name="unauthorized_report.pdf")
