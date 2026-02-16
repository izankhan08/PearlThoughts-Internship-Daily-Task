FROM node:20-alpine

WORKDIR /app

COPY app/package*.json ./
RUN npm install

COPY app .

RUN npm run build

EXPOSE 1337

CMD ["npm","run","start"]