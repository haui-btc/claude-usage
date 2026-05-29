FROM python:3.12-slim

WORKDIR /app

COPY scanner.py cli.py dashboard.py ./

ENV HOST=0.0.0.0
ENV PORT=8080

EXPOSE 8080

CMD ["python", "-c", "from dashboard import serve; serve()"]
