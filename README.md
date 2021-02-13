# wsuzume/docker-alpine-texlive

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg)](https://github.com/RichardLitt/standard-readme)

> Minimal TeX Live image based on alpine

Forked from [Paperist/docker-alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja
) \(under the MIT License\).

Template:

* preprint\_en\_single\_column: George Kour's [Style and Template for Preprints (arXiv, bio-arXiv)](https://ja.overleaf.com/latex/templates/style-and-template-for-preprints-arxiv-bio-arxiv/fxsnsrzpnvwc) \(under the Creative Commons CC BY 4.0\)

## Table of Contents

- [Install](#install)
- [Usage](#usage)
- [Contribute](#contribute)
- [License](#license)

## Install

```bash
docker pull paperist/alpine-texlive-ja
```

## Usage

```bash
$ docker run --rm -it -v $PWD:/workdir paperist/alpine-texlive-ja
$ latexmk -C main.tex && latexmk main.tex && latexmk -c main.tex
```

## Contribute

PRs accepted.

## License

MIT © 3846masa



