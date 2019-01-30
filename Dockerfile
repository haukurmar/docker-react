# ---------- Build phase ----------
# Use an existing docker image as a base
FROM node:alpine as builder

# Set working directory
WORKDIR '/app'

# Install dependencies
COPY ./package.json .
RUN npm install

# Copy all files
COPY . .

# Build to the ./build folder
RUN npm run build

# ---------- Run phase ----------
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# nginx has a default command already so we don't need to define it
