FROM python:3.8

# RUN \
#     apt-get update && \
#     apt-get install -y unixodbc unixodbc-dev

# COPY docker/odbcinst.ini /etc/odbcinst.ini

ENV PYTHONPATH /opt/code/tap-db2
RUN mkdir -p /opt/code/tap-db2
COPY ./setup.py /opt/code/tap-db2/setup.py
COPY ./tap_db2 /opt/code/tap-db2/tap_db2
RUN pip install ibm_db
RUN pip install /opt/code/tap-db2

COPY ./config/db2dsdriver.cfg /usr/local/lib/python3.8/site-packages/clidriver/cfg/db2dsdriver.cfg
WORKDIR /opt/code/tap-db2
ENTRYPOINT ["python", "-m", "tap_db2"]
CMD []
