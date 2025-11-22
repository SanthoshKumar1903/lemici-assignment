FROM python:3.11-slim

# Create a non-root user and group
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

WORKDIR /app

# Install Flask as root
RUN pip install --no-cache-dir flask

# Copy your app, give ownership to the non-root user
COPY --chown=appuser:appgroup app.py .

# Drop privileges to non-root user
USER appuser

EXPOSE 8080
CMD ["python", "app.py"]
