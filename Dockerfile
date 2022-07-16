FROM node:16.16.0-alpine as build
WORKDIR /app
COPY package.json yarn.lock /app/
RUN yarn
COPY tsconfig.json /app/
COPY src src
RUN yarn compile

FROM node:16.16.0-alpine as runtime
WORKDIR /app
COPY package.json yarn.lock /app/
COPY --from=build /app/build/ /app/build/
RUN yarn --prod
CMD ["node", "./dist/index.js"]
