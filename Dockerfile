FROM node:lts as build
RUN mkdir /tmp/brouter-web
WORKDIR /tmp/brouter-web
COPY package.json yarn.lock .
RUN yarn install
COPY . .
RUN yarn run build

FROM nginx:alpine
COPY --from=build /tmp/brouter-web/index.html /usr/share/nginx/html
COPY --from=build /tmp/brouter-web/dist /usr/share/nginx/html/dist
