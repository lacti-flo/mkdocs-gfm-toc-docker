# Build gfm-toc
FROM node:14-slim AS gfm-toc-builder

RUN npm i -g npm

WORKDIR /opt/gfm-toc
COPY gfm-toc/package.json gfm-toc/package-lock.json /opt/gfm-toc/
RUN npm i

COPY gfm-toc /opt/gfm-toc
RUN npm run build && npm run pkg:linux

# Start mkdocs
FROM python:3-slim AS mkdocs

# Install gfm-toc
COPY --from=gfm-toc-builder /opt/gfm-toc/gfm-toc /usr/local/bin/gfm-toc

# Install mkdocs
RUN pip install -U pip mkdocs mkdocs-material plantuml-markdown

COPY entrypoint.sh /
WORKDIR /opt
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

