FROM node:20-bookworm-slim

WORKDIR /app

COPY package.json ./
RUN corepack enable && pnpm install --config.strict-peer-dependencies=false

COPY . .

EXPOSE 5173

CMD ["pnpm", "dev", "--host", "0.0.0.0", "--port", "5173"]
