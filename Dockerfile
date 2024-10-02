# Use the official Flutter image
FROM cirrusci/flutter:stable-web AS builder

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Get dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Use a lightweight web server to serve the app
FROM nginx:alpine

# Copy the built app to Nginx's html directory
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
