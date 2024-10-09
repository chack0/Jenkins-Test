# Setting the base image of which docker image is being created
FROM jenkins/jenkins:lts

LABEL description="A docker image made from jenkins lts and flutter installed"

# Switching to root user to install dependencies and flutter
USER root

# # Set environment variables
# ENV FLUTTER_HOME=/opt/flutter
# ENV PATH="$PATH:$FLUTTER_HOME/bin"

# Install dependencies for Flutter
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Cleaning dependencies and installing flutter from the root user.

RUN  apt-get clean \
    && git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter \
    && chown -R jenkins:jenkins /usr/local/flutter

# Install Docker from official repo
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz    

# Switching to jenkins user - a good practice
USER jenkins

# Running flutter doctor to check if flutter was installed correctly
RUN /usr/local/flutter/bin/flutter doctor -v \
    && rm -rfv /flutter/bin/cache/artifacts/gradle_wrapper

# Setting flutter and dart-sdk to PATH so they are accessible from terminal
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# # Use an Nginx image as a base
# FROM nginx:alpine

# # Remove the default Nginx website
# RUN rm -rf /usr/share/nginx/html/*

# # Copy the Flutter web build output to Nginx's html folder
# COPY build/web /usr/share/nginx/html

# # Expose port 80 for the web server
# EXPOSE 80

# # Start Nginx server
# CMD ["nginx", "-g", "daemon off;"]
