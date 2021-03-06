FROM node:9-alpine

RUN apk --no-cache add curl

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

HEALTHCHECK CMD curl -f http://localhost:4000/healthcheck || exit 1

EXPOSE 4000

CMD ["node", "app.js"]
