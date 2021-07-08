# MkDocs + gfm-toc Docker

Docker image for [MkDocs](https://www.mkdocs.org) and [gfm-toc](https://github.com/lacti/gfm-toc).

## Support

- [MkDocs](https://www.mkdocs.org)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material)
- [PlantUML Markdown](https://github.com/mikitex70/plantuml-markdown)
- [gfm-toc](https://github.com/lacti/gfm-toc)

## Why gfm-toc

I use MkDocs on Monorepo so I want to use _Table of Contents_ for whole documents. I haven't used MkDocs for a while, so I don't know what plugins there are.

## Usage

1. Put `mkdocs.yml` in working directory.
2. Put all documents and resources into `$PWD/docs` directory

And then, we can run `mkdocs` using this Docker image and get all built result from `$PWD/site`.

```bash
docker run \
  -u ${UID} \
  -v $PWD:/opt \
  lacti/mkdocs-gfm-toc \
  build
```

Please run Docker on `UID` user for grant same permission to result files in `site` directory.

### Directory structure

```text
.
├── mkdocs.yml
├── docs
│   └── README.md
└── site
    ├── index.html
    └── ...
```

### Configuration

First, copy `mkdocs.example.yml` to `mkdocs.yml` and give some information such as `site_name` and `repo_url`.

### Document gathering

If the target repository isn't large, it's good to use it as is. However, if you want to run docker with only documents and resources, use the following command: It copies only markdown files and png files to the specified directory.

```bash
find . \( -name "*.md" -o -name "*.png" \) -exec cp --parents {} "${TARGET_DIR}/docs" \;
```

## License

MIT

