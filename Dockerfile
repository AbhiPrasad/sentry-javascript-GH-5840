FROM node:16.13.0
ARG GIT_COMMIT_ID
ARG GIT_COMMIT_DATE
ARG BUILD_DATE
ARG VERSION_TAG
# LABEL quay.expires-after=12w
LABEL org.opencontainers.image.revision=$GIT_COMMIT_ID
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.version=$VERSION_TAG
COPY package.json /app/
COPY yarn.lock /app/
# RUN chown -R org:org /app/
WORKDIR /app
RUN yarn install
COPY . /app/
RUN yarn build
RUN ls | grep -v dist | grep -v node_modules | xargs rm -rf
# Include build-info as env vars for app
ENV GIT_COMMIT_ID=$GIT_COMMIT_ID
ENV GIT_COMMIT_DATE=$GIT_COMMIT_DATE
ENV BUILD_DATE=$BUILD_DATE
ENV VERSION_TAG=$VERSION_TAG
EXPOSE 4000
CMD ["node", "dist/index.js"]
