# sumologic.users
sumologic user - sumologic_collector:
    user.present:
        - name: sumologic_collector
        - fullname: sumologic_collector
        - shell: /sbin/nologin
        - home: /opt/SumoCollector
        - createhome: false


# /usr/sbin/useradd -d /opt/SumoCollector -M -r -s /sbin/nologin -U sumologic_collector
# rpm -ivh https://collectors.sumologic.com/rest/download/rpm/64
