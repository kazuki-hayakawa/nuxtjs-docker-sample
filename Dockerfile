FROM node:10.11.0-alpine as builder

WORKDIR /app
ENV NODE_ENV=production

RUN apk add --no-cache curl git && cd /tmp && \
    curl -#L https://github.com/tj/node-prune/releases/download/v1.0.1/node-prune_1.0.1_linux_amd64.tar.gz | tar -xvzf- && \
    mv -v node-prune /usr/local/bin && rm -rvf * && \
    echo "yarn cache clean && node-prune" > /usr/local/bin/node-clean && chmod +x /usr/local/bin/node-clean

ADD sample-app/package.json ./
RUN yarn --frozen-lockfile --non-interactive && node-clean
ADD sample-app/ ./
RUN yarn build


FROM node:10.11.0-alpine

WORKDIR /app
ENV HOST=0.0.0.0

ADD sample-app/package.json ./
ADD sample-app/nuxt.config.js ./

COPY --from=builder ./app/node_modules ./node_modules/
COPY --from=builder ./app/.nuxt ./.nuxt/
COPY --from=builder ./app/static ./static/

EXPOSE 3000
CMD ["yarn", "start"]
