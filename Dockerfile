FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# run as a non-root user
RUN useradd --create-home appuser
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]
