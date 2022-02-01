FROM  library/centos:centos7
LABEL version="4.2.5"
LABEL description="Wazuh Docker Agent"
ENV JOIN_MANAGER_MASTER_HOST=""
ENV JOIN_MANAGER_WORKER_HOST=""
ENV VIRUS_TOTAL_KEY=""
ENV JOIN_MANAGER_PROTOCOL="https"
ENV JOIN_MANAGER_USER = ""
ENV JOIN_MANAGER_PASSWORD=""
ENV JOIN_MANAGER_API_PORT="55000"
ENV HEALTH_CHECK_PROCESSES=""
ENV FLASK_APP="register_agent.py"
ENV FLASK_ENV="development"
ENV FLASK_DEBUG=0
ENV FLASK_BIND=0.0.0.0
ENV t=t
COPY . /var/ossec/
COPY wazuh.repo /etc/yum.repos.d/
RUN yum install --nogpgcheck -y procps curl apt-transport-https gnupg2 inotify-tools python-docker python3-pip python3-setuptools python3-devel gcc && \
  rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH && \
  yum install --nogpgcheck -y wazuh-agent && \
  pip3 --no-cache-dir install -r /var/ossec/requirements.txt && \
  rm -rf /var/ossec/requirements.txt && \
  chmod +x /var/ossec/register_agent.py && \
  yum remove -y python3-devel gcc && \
  yum -y clean all && rm -rf /var/cache && \
  rm -rf  /tmp/* /var/tmp/* /var/log/*
WORKDIR /var/ossec/
COPY entrypoint.sh /bin/
EXPOSE 5000
ENTRYPOINT ["entrypoint.sh"]
