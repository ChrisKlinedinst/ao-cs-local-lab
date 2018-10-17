FROM saltinfra/saltmaster AS prod
ENV PORT 4505-4506
EXPOSE 4505-4506

RUN apt-get update && \
  apt-get install salt-master \
#  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ENV SALT_HOME /srv/salt
#RUN mkdir $SALT_HOME

#COPY salt/file_root $SALT_HOME
#COPY /salt/config/master /etc/salt/master

CMD ["sudo service salt-master start"]
