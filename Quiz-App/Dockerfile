# Stage 1: Build the application
FROM node:lts-alpine as builder

WORKDIR /app

# Copy only the necessary files for package installation
COPY package*.json ./

# Install project dependencies
RUN npm ci --only=production

# Copy the rest of the application files
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create a minimal runtime image
FROM node:lts-alpine

WORKDIR /app

# Copy only the built application files from the previous stage
COPY --from=builder /app .

# Expose the port on which the application will run
EXPOSE 3000

# Specify the command to run the application
CMD ["npm", "start"]


# Note
# the Dockerfile uses a multi-stage build. The first stage (builder) is responsible for installing dependencies, building the application, and creating the necessary files. 
# The second stage (runtime) only includes the built application files from the previous stage, resulting in a smaller final image. 
# Additionally, the --only=production flag during package installation ensures that only production dependencies are installed, further reducing the image size.