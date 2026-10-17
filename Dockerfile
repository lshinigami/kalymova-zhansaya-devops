# Base image: a small Linux with Python 3.12 already installed
FROM python:3.12-slim

# All following commands run in /app inside the image
WORKDIR /app

# Copy the application and the student file from your project into the image
COPY app/ /app/
COPY Kalymova_Zhansaya_info.txt /app/

# Run commands while BUILDING the image
RUN echo "Image built for Kalymova Zhansaya" > /app/build_info.txt && \
    useradd --create-home appuser

# Print Python output immediately (so docker logs shows it)
ENV PYTHONUNBUFFERED=1

# Run the app as a normal user, not root (safer)
USER appuser

# Document that the app listens on port 8000
EXPOSE 8000

# Command that runs when a CONTAINER starts
CMD ["python", "app.py"]
