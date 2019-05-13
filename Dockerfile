from saltinfra/saltmaster

RUN cat /etc/issue

RUN apt-get update && \
  apt-get install cron && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*