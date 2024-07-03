# Stage 1: Build the React application
FROM node:14 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the React application using Nginx
FROM nginx:latest

# Copy the built React files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to be able to access the application
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
