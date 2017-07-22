FROM andrewosh/binder-base
#FROM jupyter/base-notebook

LABEL maintainer="Evgeny Frolov"

USER root

# General dependencies
RUN apt-get update \
  && apt-get install -y curl libmono-cil-dev \
  && rm -rf /var/lib/apt/lists/*

# Latex dependencies
RUN apt-get update \
  && apt-get --no-install-recommends install -y texlive-latex-extra texlive-fonts-recommended dvipng \
  && rm -rf /var/lib/apt/lists/*

# Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get update \
  && apt-get install -y mono-runtime mono-devel ca-certificates-mono \
  && rm -rf /var/lib/apt/lists/* /tmp/*

USER main

# Install requirements for Python 2
RUN conda install -y seaborn --no-dep

CMD chmod =rx /home/main/notebooks/MyMediaLite-3.11/bin/item_recommendation
