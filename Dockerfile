# Use the official Python image as the base image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose port 5000 for the Flask application
EXPOSE 5000

# Set the environment variable for Flask
ENV FLASK_APP=create_dashboard.py

# Run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]
