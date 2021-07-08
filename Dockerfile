FROM python:3-slim

# Install gfm-toc
COPY nodejs-14-setup.sh /
RUN bash /nodejs-14-setup.sh && \
  apt-get install -y nodejs && \
  npm i -g npm gfm-toc

# Install mkdocs
RUN pip install -U pip mkdocs mkdocs-material plantuml-markdown

COPY entrypoint.sh /
WORKDIR /opt
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

