/usr/bin/java:
  file.symlink:
    - target: /usr/java/current/bin/java
    - require:
      - pkg: jdk
