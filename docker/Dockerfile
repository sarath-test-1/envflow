FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm ci

FROM base AS development
RUN npm install --include=dev
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]

FROM base AS production
RUN npm ci --only=production
COPY src/ ./src/
EXPOSE 3000
CMD ["npm", "start"]
