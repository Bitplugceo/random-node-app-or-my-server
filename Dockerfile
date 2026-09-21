FROM node:22-bookworm-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ffmpeg python3 make g++ ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
RUN chmod +x start.sh
ENV NODE_ENV=production
EXPOSE 10000
CMD ["./start.sh"]
