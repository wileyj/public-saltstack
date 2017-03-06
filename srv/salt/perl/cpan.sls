# perl.cpan
cpan_env:
   environ.setenv:
     - name: PERL_MM_USE_DEFAULT
     - value: "1"

/root/.cpan:
    file.directory:
        - user: root
        - group: root
        - mode: 0755

/root/.cpan/build:
    file.directory:
        - user: root
        - group: root
        - mode: 0755
