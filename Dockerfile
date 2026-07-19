FROM python:alpine

WORKDIR /app

COPY app.py .
COPY app2.py .

# CMD ["python", "app.py"]
ENTRYPOINT ["python"]
CMD ["app.py"]
