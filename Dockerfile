# Use an official Dart image
FROM dart:stable

# Set working directory
WORKDIR /app

# Copy pubspec and get dependencies
COPY pubspec.* ./
RUN dart pub get

# Copy application files
COPY . .

# Build the Flutter web app
RUN flutter build web

# Serve the app using a web server
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
