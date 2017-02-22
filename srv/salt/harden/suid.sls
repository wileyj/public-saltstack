#See all set user id files:
find / -perm +4000
# See all group id files
find / -perm +2000
# Or combine both in a single command
find / \( -perm -4000 -o -perm -2000 \) -print
find / -path -prune -o -type f -perm +6000 -ls
