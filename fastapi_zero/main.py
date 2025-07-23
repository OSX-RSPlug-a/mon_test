from http import HTTPStatus
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI()


app.mount("/static", StaticFiles(directory="static"), name="static")


templates = Jinja2Templates(directory="templates")


@app.get("/api/hello")
async def read_hello():
    return {"message": "Hello, World!"}


@app.get("/api/greet/{name}")
async def greet(name: str):
    return {"message": f"Hi api, {name}!"}


@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request, "title": "Welcome Page"})


@app.get("/health")
def health():
    return {"status": "ok"}
