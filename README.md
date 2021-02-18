# wsuzume/docker-alpine-texlive

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg)](https://github.com/RichardLitt/standard-readme)

> TeX Live image based on alpine

Forked from [Paperist/docker-alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja
) \(under the MIT License\).

Template:

* sample: George Kour's [Style and Template for Preprints (arXiv, bio-arXiv)](https://ja.overleaf.com/latex/templates/style-and-template-for-preprints-arxiv-bio-arxiv/fxsnsrzpnvwc) \(under the Creative Commons CC BY 4.0\)
* preprint\_en\_single\_column: George Kour's [Style and Template for Preprints (arXiv, bio-arXiv)](https://ja.overleaf.com/latex/templates/style-and-template-for-preprints-arxiv-bio-arxiv/fxsnsrzpnvwc) \(under the Creative Commons CC BY 4.0\)
* tohoku\_univ\_master\_thesis: Master's thesis template of Tohoku University \(under the Unlicense\)

## Table of Contents

- [Install](#install)
- [Usage](#usage)
- [Contribute](#contribute)
- [License](#license)

## Install

```bash
$ git clone https://github.com/wsuzume/docker-alpine-texlive
$ cd docker-alpine-texlive

$ make pull
# or
$ make build
```

Building an image sometimes fails if choosed mirror sever was weak.

## Usage
### Entering docker container

Just run

```bash
$ make shell
```

and you can use `platex`, `dvipdfmx`, etc. in the docker container.


### Compiling from the outside of docker container
Choose template from `templates`, and copy to `workdir`.

```bash
$ cp -r templates/preprint_en_single_column workdir/mypaper
```

Then, edit `Makefile`. Copy and paste `sample` command and edit like following.

```Makefile
## target file is workdir/${XXDIR}/${XXMAIN}.tex
MYPAPERDIR=mypaper
MYPAPERMAIN=main
# uncomment if you want to compile with platex
#MYPAPERARG=-latex=platex
mypaper: workdir/sample/${MYPAPERMAIN}.tex
	docker container run -it --rm \
	-v ${PWD}/workdir:/workdir \
	-w /workdir/${MYPAPERDIR} \
	${IMAGE} \
	sh -c "mktexlsr && latexmk -C ${MYPAPERMAIN}.tex && latexmk ${MYPAPERARG} ${MYPAPERMAIN}.tex && dvipdfmx ${MYPAPERMAIN}.dvi && latexmk -c ${MYPAPERMAIN}.tex"

```

Finally, you can compile LaTeX file by following command.

```bash
$ make mypaper
```

### Adding modules
Edit `Dockerfile` and add `[modulename].sty` file to `${TEXMFLOCAL}/[modulename]`.

## Contribute

PRs accepted.

## License

MIT © wsuzume

## Contact
使い方わからない，とかでも声かけて大丈夫です．

Twitter: [@wsuzume](https://twitter.com/wsuzume)
