FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .

# Set placeholder API URLs for build time. At runtime, client logic might need to be adjusted or we use these defaults.
# Ideally, Traefik routes /api to the backend.
ENV NEXT_PUBLIC_API_URL=/api
ENV NEXT_PUBLIC_WS_URL=ws://localhost:38280/api

RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

RUN npm install -g serve

COPY --from=builder /app/out ./out

EXPOSE 3000

CMD ["serve", "-s", "out", "-p", "3000"]