# Use official Python runtime as base image
FROM python:3.9-slim

# Set working directory in container
WORKDIR /app

# Install system dependencies, install gcc for pymongo and clear the cache.
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies, --no-cache-dir can reduce the size of the image.
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create static directories if they don't exist
RUN mkdir -p static/assets static/images

# Expose port 5000
# The Flask application inside the container listens on port 5000.
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py
ENV PYTHONUNBUFFERED=1

# Run the application
CMD ["python", "app.py"]
