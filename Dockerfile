# Use an official Python runtime as a base image
FROM python:3.9-alpine3.14

# Install required system packages and Python modules
RUN apk update && \
    apk add --no-cache \
        python3 \
        python3-dev \
        py3-pip \
        build-base \
        libffi-dev \
        openssl-dev \
        libc-dev \
        linux-headers && \
    pip install --upgrade pip && \
    pip install supervisor && \
    rm -rf /var/cache/apk/*


# Expose the ports for Supervisor web UI (default is 9001) and any other service ports you need


# Copy Supervisor configuration files
COPY supervisord.conf /etc/supervisord.conf

# Set up directories for Supervisor
RUN mkdir -p /var/log/supervisor

# Start Supervisor
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
