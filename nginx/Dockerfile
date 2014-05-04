FROM stackbrew/ubuntu:saucy
MAINTAINER Marcel de Graaf <mail@marceldegraaf.net>

# Install Nginx
RUN apt-get install -y --force-yes software-properties-common
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y --force-yes nginx curl

# Install confd
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.3.0/confd_0.3.0_linux_amd64.tar.gz | tar xz
RUN mv confd /usr/local/bin/confd

# Create directories
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Add confd files
ADD ./confd /etc/confd/

# Remove default site
RUN rm -f /etc/nginx/sites-enabled/default

# Add boot script
ADD ./bin/boot.sh /boot.sh
RUN chmod +x /boot.sh

# Run the boot script
CMD /boot.sh
