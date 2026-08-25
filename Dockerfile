FROM python:3.12-slim

WORKDIR /app

COPY scanner.py cli.py dashboard.py ./

# Unbuffered stdout so scan progress streams to `docker compose logs` live
# instead of sitting in Python's block buffer until the process exits.
ENV PYTHONUNBUFFERED=1
ENV HOST=0.0.0.0
ENV PORT=8080

EXPOSE 8080

CMD ["python3", "cli.py", "dashboard", "--no-browser"]
