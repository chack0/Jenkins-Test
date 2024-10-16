# Setting the base image of which docker image is being created
FROM jenkins/jenkins:lts

LABEL description="A docker image made from jenkins lts and flutter installed"

# Switching to root user to install dependencies and flutter
USER root

# Set environment variables
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$PATH:$FLUTTER_HOME/bin"

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

# InstallDocker and give jenkins docker rights
RUN apt-get update && apt-get install -y docker.io && \
    groupadd docker && \
    usermod -aG docker jenkins

# Switching to jenkins user - a good practice
USER jenkins

# Running flutter doctor to check if flutter was installed correctly
RUN /usr/local/flutter/bin/flutter doctor -v \
    && rm -rfv /flutter/bin/cache/artifacts/gradle_wrapper

# Setting flutter and dart-sdk to PATH so they are accessible from terminal
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"


#//////////////////////////////////////////////////////////////////////////////////////////////////////////

#Stage 1 - Install dependencies and build the app in a build environment
# FROM debian:latest AS build-env
# # Install flutter dependencies
# RUN apt-get update
# RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed
# RUN apt-get clean
# # Clone the flutter repo
# RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
# # Set flutter path
# ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"
# # Run flutter doctor
# RUN flutter doctor -v
# RUN flutter channel master
# RUN flutter upgrade
# # Copy files to container and build
# RUN mkdir /app/
# COPY . /app/
# WORKDIR /app/
# RUN flutter build web
# # Stage 2 - Create the run-time image
# FROM nginx:1.21.1-alpine
# COPY --from=build-env /app/build/web /usr/share/nginx/html