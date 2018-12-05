FROM ubuntu:16.04

ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install Ubuntu Dependences
RUN apt-get update && apt-get upgrade -y
    
RUN apt-get install -y \
    curl \
    apt-transport-https \
    git-core \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    unixodbc-dev \
    tzdata

RUN ln -fs /usr/share/zoneinfo/America/Fortaleza /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Install Pyenv
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Update Pyenv
RUN pyenv update

# Install Python 3.6.5
RUN pyenv install 3.6.5

# Set Python Global
RUN pyenv global 3.6.5
RUN pyenv rehash

# Upgrade PIP
RUN pip install --upgrade pip

# Install ODBC Driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17 mssql-tools -y
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

# Create Main Path Application
RUN mkdir application

# Copy requirements Project for Main Path
COPY requirements.txt /application

WORKDIR /application

# Install Python Dependences
RUN pip install -r requirements.txt

CMD ["waitress-serve", "--call", "--listen=0.0.0.0:5000", "app:create_app"]
