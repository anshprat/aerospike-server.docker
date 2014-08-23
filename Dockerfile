#
# Aerospike Server Dockerfile
#
# http://github.com/aerospike/aerospike-server.docker
#

FROM ubuntu:14.04

# Add Aerospike package and run script
ADD http://aerospike.com/download/server/3.3.12/artifact/ubuntu12 /tmp/aerospike.tgz

# Work from /tmp
WORKDIR /tmp

# Install Aerospike
RUN \
  sudo dpkg -i http://us2.citrusleaf.net/files/aerospike-server-community-3.3.12-ubuntu12.04/aerospike-server-community-3.3.12.ubuntu12.04.x86_64.deb 

# Add the Aerospike configuration specific to this dockerfile
ADD aerospike.conf /etc/aerospike/aerospike.conf

# Mount the Aerospike data directory
VOLUME ["/opt/aerospike/data"]

# Expose Aerospike ports
#
#   3000 – service port, for client connections
#   3001 – fabric port, for cluster communication
#   3002 – mesh port, for cluster heartbeat
#   3003 – info port
#
EXPOSE 3000 3001 3002 3003 9918

# Execute the run script
# We use the `ENTRYPOINT` because it allows us to forward additional
# arguments to `asd`
ENTRYPOINT ["/usr/bin/asd","--foreground"]
