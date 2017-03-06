# java.files
java symlink - /usr/bin/java:
    file.symlink:
        - name: /usr/bin/java
        - target: /usr/java/current/bin/java
        - require:
            - pkg: jdk

javac symlink - /usr/bin/javac:
    file.symlink:
        - name: /usr/bin/javac
        - target: /usr/java/current/bin/javac
        - require:
            - pkg: jdk
