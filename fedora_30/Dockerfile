FROM fedora:30

RUN yum -y update

RUN yum -y groupinstall "Development Tools" "C Development Tools and Libraries"

RUN yum -y install redhat-rpm-config python3 python3-pip python3-setuptools python3-wheel python3-cffi libffi-devel cairo pango gdk-pixbuf2

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

RUN yum -y update

RUN ACCEPT_EULA=Y yum -y install python3-devel msodbcsql17 mssql-tools

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

RUN source ~/.bashrc

RUN yum -y install unixODBC-devel langpacks-pt_BR

RUN LANG=pt_BR.UTF-8

WORKDIR /application
