# Build stage
# Using secure Node.js LTS (Node 18) instead of vulnerable Node.js 12
FROM node:18-alpine as build
WORKDIR /app
ENV DISABLE_ESLINT_PLUGIN=true

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .
RUN npm run build

# Production stage
# Using secure Nginx stable-alpine instead of vulnerable 1.14.0
FROM nginx:stable-alpine

# Update Alpine packages to eliminate known CVEs
RUN apk update && apk upgrade

# Copy the build output to replace the default nginx contents
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Install additional packages with latest security fixes
RUN apk add --no-cache curl openssl

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
# Triggering build with secure image

