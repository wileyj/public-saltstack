## this will add to global crontab, which we don't necessarily want. cron.d files are much better, but have to be done manually for now
#clean_clientmqueue:
#    cron.present:
#        - user: root
#        - name: 'if [ `ls /var/spool/clientmqueue | wc -l` -gt 0 ]; then /bin/rm -rf /var/spool/clientmqueue/* > /dev/null 2>&1; fi'
#        - minute: '0'
#        - hour: '2'
#        - daymonth: '*'
#        - month: '*'
#        - dayweek: '*'
#        - identifier: 'clean_clientmqueue'
#        - comment: 'Installed via Salt'

/etc/cron.d/clean_clientmqueue.cron:  
  file.managed:
    - source: salt://base/files/etc/cron.d/clean_clientmqueue.j2
    - user: root
    - group: root
    - mode: 0644


