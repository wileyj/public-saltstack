# sumologic:packages

sumologic install https://collectors.sumologic.com/rest/download/rpm/64:
    cmd.run:
        - cwd: /
        - name: 'rpm -ivh https://collectors.sumologic.com/rest/download/rpm/64'
