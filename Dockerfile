FROM node:16-alpine as  builder 

RUN mkdir /app && chown node:node /app
WORKDIR /app
USER node
COPY --chown=node:node package.json package-lock.json* ./
RUN npm install
COPY --chown=node:node . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder  /app/build  /usr/share/nginx/html
