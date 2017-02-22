audit:

  ## Default settings for the audit daemon
  auditd:
    ## parameters in auditd.conf
    log_file: /var/log/audit/audit.log
    log_format: RAW
    # log_group: root
    # priority_boost: 4
    # flush: INCREMENTAL
    # freq: 20
    num_logs: 5
    # disp_qos: lossy
    # dispatcher: /sbin/audispd
    # name_format: NONE
    # name:
    max_log_file: 30MB
    max_log_file_action: ROTATE
    space_left: 90
    space_left_action: SYSLOG
    action_mail_acct: root
    admin_space_left: 50
    admin_space_left_action: SUSPEND
    disk_full_action: SUSPEND
    disk_error_action: SUSPEND
    # tcp_listen_port:
    # tcp_listen_queue: 5
    # tcp_max_per_addr: 1
    # tcp_client_ports:
    # tcp_client_max_idle: 0
    # enable_krb5: no
    # krb5_principal: auditd
    # krb5_key_file: /etc/audit/audit.key

    ## parameters in defaults / sysconfig
    # stop_disable: yes
    # clean_stop: yes
    # use_augenrules: no
    # lang: en_US
    # extraoptions:

  auditctl:
    ## common flags for auditctl (audit.rules)
    # enabled:
    # flag:
    # rate_limit:
    # backlog_limit: 320

# -a always,exit
# -F # rule
# arch=b64 # arch
# -S adjtimex # syscall
# -k audit_time_rules # filter key

  audispd:
    ## parameters for audit dispatcher daemon
    # q_depth: 80
    # overflow_action: SYSLOG
    # priority_boost: 4
    # max_restarts: 10
    # name_format: HOSTNAME
    # name:

    remote:
      ## audispd-remote.conf
      # remote_server:
      # port: 60
      # local_port:
      # transport: tcp
      # mode: immediate
      # queue_file: /var/spool/audit/remote.log
      # queue_depth: 200
      # format: managed
      # network_retry_time: 1
      # max_tries_per_record: 3
      # max_time_per_record: 5
      # heartbeat_timeout: 0
      # network_failure_action: stop
      # disk_low_action: ignore
      # disk_full_action: ignore
      # disk_error_action: syslog
      # remote_ending_action: suspend
      # generic_error_action: syslog
      # generic_warning_action: syslog
      # overflow_action: syslog
      # enable_krb5: no
      # krb5_principal:
      # krb5_client_name: auditd
      # krb5_key_file: /etc/audisp/audisp-remote.key

    zos_remote:
      ## zos-remote.conf
      # server: zos_server.localdomain
      # port: 389
      # user: RACF_ID
      # password: racf_password
      # timeout: 15
      # q_depth: 64

    plugins:
      ## Plugins configuration
      af_unix:
        ## af_unix
        # active: no
        # direction: out
        # path: builtin_af_unix
        # type: builtin
        # args: 0640 /var/run/audispd_events
        # format: string

      au_prelude:
        ## au_prelude
        # active: no
        # direction: out
        # path: /sbin/audisp-prelude
        # type: always
        # args:
        # format: string

      au_remote:
        ## au_remote
        # active: no
        # direction: out
        # path: /sbin/audisp-remote
        # type: always
        # args:
        # format: string

      zos_remote:
        ## zos-remote
        # active: no
        # direction: out
        # path: /sbin/audispd-zos-remote
        # type: always
        # args: /etc/audisp/zos-remote.conf
        # format: string

      syslog:
        ## syslog
        # active: no
        # direction: out
        # path: builtin_syslog
        # type: builtin
        # args: LOG_INFO
        # format: string
