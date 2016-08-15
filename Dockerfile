FROM andrewosh/binder-base

MAINTAINER Evgeny Frolov

USER root

# Add dependency
RUN apt-get update && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get update \
  && apt-get clean
#  && apt-get install -y binutils mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl \
#  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list \
  && apt-get update \
  && apt-get clean

USER main

# Install requirements for Python 2
RUN pip install seaborn
