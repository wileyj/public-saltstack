harden files - /etc/profile.d/os-security.sh:
    file.managed:
        - name: /etc/profile.d/os-security.sh
        - user: root
        - group: root
        - mode: 0755
        - contents:
            - "readonly TMOUT=900"
            - "readonly HISTFILE"
