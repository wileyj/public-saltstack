# sumologic.services
sumologic services:
    service.running:
        - require:
            - pkg: sumologic.packages
