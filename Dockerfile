# Use official Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json
COPY package.json .

# Install dependencies
RUN npm install

# Copy application files
COPY app.js .

# Expose port 3000
EXPOSE 3000

# Run the application using Node.js
CMD ["node", "app.js"]
