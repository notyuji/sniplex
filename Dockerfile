FROM node:14-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Install client dependencies
RUN mkdir -p ./public ./data \
    && cd client \
    && npm install \
    && npm rebuild node-sass

# Build 
RUN npm run build \
    && mv ./client/build/* ./public

# Clean up src files
RUN rm -rf src/ ./client \
    && npm prune --production

EXPOSE 5000

ENV NODE_ENV=production

CMD ["node", "build/server.js"]