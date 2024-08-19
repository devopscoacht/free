# Base docker image
FROM python:3.8-slim

# Set the working directory to the location of the dashboard
WORKDIR /demo_gtxpro

# Copy the current directory contents into the container
COPY . .

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc python3-dev git && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install packages/* && \
    rm -rf packages && \
    pip install "brix.vizx_charts[integrations]" && \
    pip install --upgrade dash>=2.17.0 dash-core-components>=2.17.0 dash-html-components>=2.17.0 && \
    python -m pip uninstall oscrypto -y && \
    python -m pip install git+https://github.com/wbond/oscrypto.git@d5f3437ed24257895ae1edd9e503cfb352e635a8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to the location of the dashboard script
WORKDIR /demo_gtxpro/src

# Specify the port on which the app is listening
EXPOSE 8050

# Run the application
CMD ["python", "000 GTPro master PROD.py"]
