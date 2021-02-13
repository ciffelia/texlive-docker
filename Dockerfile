# Copyright (c) 2016 Kaito Udagawa
# Copyright (c) 2016-2020 3846masa
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc:latest

ENV PATH /usr/local/texlive/2020/bin/x86_64-linuxmusl:$PATH

RUN apk add --no-cache curl perl fontconfig-dev freetype-dev && \
    apk add --no-cache --virtual .fetch-deps xz tar wget && \
    mkdir /tmp/install-tl-unx && \
    curl -L ftp://tug.org/historic/systems/texlive/2020/install-tl-unx.tar.gz | \
      tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      latexmk && \
    rm -fr /tmp/install-tl-unx && \
    apk del .fetch-deps


# for additional modules
ARG TEXMFLOCAL=/usr/local/texlive/texmf-local/tex/latex
WORKDIR /workspace

## pseudo code
RUN wget http://captain.kanpaku.jp/LaTeX/jlisting.zip \
    && unzip jlisting.zip \
    && mkdir -p ${TEXMFLOCAL}/listings \
    && cp jlisting/jlisting.sty ${TEXMFLOCAL}/listings

RUN wget http://mirrors.ctan.org/macros/latex/contrib/algorithms.zip \
    && unzip algorithms.zip \
    && cd algorithms \
    && latex algorithms.ins \
    && mkdir -p ${TEXMFLOCAL}/algorithms \
    && cp *.sty ${TEXMFLOCAL}/algorithms

RUN wget http://mirrors.ctan.org/macros/latex/contrib/algorithmicx.zip \
    && unzip algorithmicx.zip \
    && mkdir -p ${TEXMFLOCAL}/algorithmicx \
    && cp algorithmicx/*.sty ${TEXMFLOCAL}/algorithmicx



WORKDIR /workdir

CMD ["sh"]
