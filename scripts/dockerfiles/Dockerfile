# Use a slim Python image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libpq-dev \
    python3-dev \
    build-essential \
    libffi-dev \
    libxml2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip with timeout and retry
RUN pip install --upgrade pip --default-timeout=100

# Use a fast PyPI mirror and install Python packages individually
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple pandas --default-timeout=100
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple sqlalchemy --default-timeout=100
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple psycopg2-binary --default-timeout=100
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple pyarrow --default-timeout=200
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple openpyxl --default-timeout=100

# Set working directory
WORKDIR /app

# Copy your ingestion script
COPY ingest.py ingest.py

# Default command
CMD ["python", "ingest.py"]
