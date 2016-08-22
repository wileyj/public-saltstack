name = "puppet-master-001.core.use1.domain.com"
split = name.split(".")
length = len(split)
print "len: ", length
name = split[length-2]+"."+split[length-1]
print "name: %s" % (name)
