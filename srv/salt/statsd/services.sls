# statsd.services
statsd services:
    service.running:
        - require:
            - pkg: statsd.packages
