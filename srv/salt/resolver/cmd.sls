# resolv.cmd
resolv-update:
    cmd.run:
        - name: resolvconf -u
        - onchanges:
            - file: resolv-file
