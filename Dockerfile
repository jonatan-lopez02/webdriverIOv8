FROM node:18-slim
RUN  apt-get update \
     && apt-get install -y wget gnupg procps libxss1 libxcb-dri3-0 libnss3-dev libatk-bridge2.0-0 libxkbcommon-x11-0 libgtk-3-0 libgbm-dev \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update -y \
     && apt-get install -y -f google-chrome-stable \
     && rm -f *.deb*

COPY package.json wdio.conf.js babel.config.cjs  /
COPY ./test/ /test/

RUN npm install