FROM andrewosh/binder-base

MAINTAINER Evgeny Frolov

USER root

# Add dependency
# libmono-system-design4.0-cil libmono-system-drawing-design4.0-cil libmono-system-drawing4.0-cil libmono-system-web4.0-cil libmono-system-web-services4.0-cil libmono-system-windows-forms4.0-cil
RUN apt-get update \
  && apt-get install -y curl libmono-system-web4.0-cil \
  && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/4.4.2.11 main" > /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get update \
  && apt-get install -y mono-xsp4-base mono-xsp4 ca-certificates-mono \
  && rm -rf /var/lib/apt/lists/* /tmp/*

#RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" >> /etc/apt/sources.list.d/mono-xamarin.list \
#  && apt-get update \
#  && rm -rf /var/lib/apt/lists/* /tmp/*

USER main

# Install requirements for Python 2
RUN conda install -y seaborn --no-dep
