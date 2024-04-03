FROM node:20-bullseye as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:20-bullseye as prod

WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./
COPY --from=builder /app/build /app/build

RUN npm ci --omit=dev

ENTRYPOINT [ "npm", "run", "prod" ]
