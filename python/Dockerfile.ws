FROM python:3.10-slim

EXPOSE 8000

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY api/requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
COPY websocket /app/websocket
COPY utils /app/utils
COPY schema /app/schema

RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "-k", "uvicorn.workers.UvicornWorker", "websocket.main:app"]
