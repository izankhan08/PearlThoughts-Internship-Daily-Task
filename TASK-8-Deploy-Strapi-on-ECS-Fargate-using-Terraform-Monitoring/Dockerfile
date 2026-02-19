FROM node:18-bullseye

# Create app directory
WORKDIR /app

# Install dependencies needed by Strapi
RUN apt-get update && apt-get install -y \
  build-essential \
  gcc \
  g++ \
  make \
  python3 \
  libvips-dev \
  git \
  && rm -rf /var/lib/apt/lists/*

# Copy package files first
COPY app/package*.json ./

# Install node modules
RUN npm install

# Copy app source
COPY app .

# Build admin panel
RUN npm run build

EXPOSE 1337

CMD ["npm","run","start"]