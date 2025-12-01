# Build stage
# Using Node.js 12.22.0 which has CVE-2021-22883 (OpenSSL vulnerabilities)
FROM node:12.22.0-alpine as build
WORKDIR /app
ENV DISABLE_ESLINT_PLUGIN=true

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --no-package-lock --legacy-peer-deps

# Copy the rest of the application code
COPY . .
RUN npm run build

# Production stage
# Using Nginx 1.14.0 which has CVE-2019-9516 (HTTP/2 DoS vulnerability)
FROM nginx:1.14.0-alpine

# Copy the build output to replace the default nginx contents
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Install additional packages - using a vulnerable version of curl
# CVE-2018-1000120 in curl 7.60.0
RUN apk add --no-cache curl openssl

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
# Triggering build with vulnerable image
