# Stage 1: Build React
FROM node:18 AS react-build

WORKDIR /app/client

COPY client/package*.json ./
RUN npm install

COPY client/ .
RUN npm run build


# Stage 2: Production
FROM node:18-alpine

RUN addgroup appgroup && \
    adduser -D -G appgroup appuser

WORKDIR /app

COPY server/package*.json ./
RUN npm ci --only=production

COPY server/server.js .

COPY --from=react-build /app/client/build ./build

USER appuser

EXPOSE 3000

CMD ["node","server.js"]

