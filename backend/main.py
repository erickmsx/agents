from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import os

app = FastAPI()

# 🔥 CORS (obrigatório pro Flutter Web)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 📁 garante pasta de vídeos
if not os.path.exists("outputs"):
    os.makedirs("outputs")

# 🎥 servir vídeos
app.mount("/outputs", StaticFiles(directory="outputs"), name="outputs")


# 📩 request model
class Request(BaseModel):
    text: str


# 🧪 teste
@app.get("/")
def home():
    return {"status": "API rodando 🚀"}


# 🚀 endpoint principal
@app.post("/generate-avatar")
def generate_avatar(req: Request):
    text = req.text

    return {
        "message": f"Recebi o texto: {text}",
        "video_url": "http://localhost:8000/outputs/teste-video.mp4"
    }