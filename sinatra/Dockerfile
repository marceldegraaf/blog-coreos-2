FROM paintedfox/ruby
MAINTAINER Marcel de Graaf <mail@marceldegraaf.net>

# Install dependencies
RUN apt-get install -y curl
RUN gem install sinatra foreman thin --no-ri --no-rdoc

# Install confd
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.3.0/confd_0.3.0_linux_amd64.tar.gz | tar xz
RUN mv confd /usr/local/bin/confd

# Create directories
RUN mkdir -p /opt/logstash/ssl
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Add files
ADD ./confd                   /etc/confd
ADD ./bin/boot.sh             /boot.sh
ADD ./bin/logstash-forwarder  /usr/local/bin/logstash-forwarder
ADD ./app /opt/app

# Make sure logstash-forwarder is executable
RUN chmod +x /usr/local/bin/logstash-forwarder

# Expose port 5000
EXPOSE 5000

# Start the container
RUN chmod +x /boot.sh
CMD /boot.sh
