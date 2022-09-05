FROM ubuntu:22.04

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y -q \
  texlive-latex-base \
  texlive-latex-recommended \
  texlive-fonts-recommended \
  texlive-latex-extra \
  texlive-xetex \
  texlive-full \
  python3-pip \
  libx11-xcb-dev \
  libxcomposite-dev \
  libxcursor-dev \
  libxdamage-dev \
  libxtst-dev \
  libxss-dev \
  libxrandr-dev \
  libasound-dev \
  libatk1.0-dev \
  libatk-bridge2.0-dev \
  libpango1.0-dev \
  libgtk-3-dev \
  wget \
  && apt-get -y -q autoremove \
  && rm -rf /var/lib/apt/lists/

RUN wget --inet4-only -O- https://deb.nodesource.com/setup_16.x  | bash - \
  && apt-get update && apt-get install -y -q nodejs \
  && apt-get -y -q autoremove \
  && rm -rf /var/lib/apt/lists/

RUN wget https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-amd64.tar.gz \
  && tar zxf pandoc-2.19.2-linux-amd64.tar.gz \
  && mv pandoc-2.19.2/bin/* /usr/bin/

WORKDIR /node

RUN npm install --global mermaid mermaid.cli mermaid-filter

VOLUME /u
WORKDIR /u
