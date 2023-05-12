#!/bin/bash

docker build -t create-ec2 .
docker run -p 5000:5000 create-ec2

# Explanations
# Running on all addresses (0.0.0.0): This message indicates that the Flask application is running and listening on all available network interfaces inside the Docker container. The IP address 0.0.0.0 means it's bound to all network interfaces.

# Running on http://127.0.0.1:5000: This message tells you that the Flask application is accessible from the localhost or loopback interface within the Docker container. The IP address 127.0.0.1 is the loopback address, and the port 5000 is the port number on which the Flask application is listening.

# Running on http://172.17.0.2:5000: This message indicates the IP address and port number at which the Flask application is accessible from outside the Docker container. The IP address 172.17.0.2 is an example IP address assigned to the container's network interface.

# To access the Flask application from your host machine, you can use the URL http://localhost:5000. This will map to http://172.17.0.2:5000 inside the Docker container, allowing you to interact with the Flask application.