# 1. Use a slim Python image
FROM python:3.9-slim

# 2. Create app directory
WORKDIR /app

# 3. Install OS-level build tools (needed for CatBoost, etc.)
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# 5. Copy your code (not strictly required if you only use mounted volumes,
#    but good for reproducibility if you ever build without a bind mount)
COPY . .

# 6. Expose Jupyter port
EXPOSE 8888

# 7. Launch JupyterLab by default
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
