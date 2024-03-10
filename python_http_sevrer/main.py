from fastapi import FastAPI, Request

app = FastAPI()

@app.get("/")
async def index():
    return {"server_status": "Healthy"}

@app.get("/hello")
async def hello(request: Request):
    client_host = request.client.host
    return {"message": "Hello", "client_ip": client_host}
