FROM node:18.1.0-bullseye as builder

WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm ci

COPY . .

RUN npx rescript build

RUN npx webpack

FROM node:18.1.0-alpine

WORKDIR /app

COPY --from=builder /app/dist /app

CMD node ./index.js
