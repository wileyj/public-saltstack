import sys, json;

raw = sys.stdin.read();

try:
	data = json.loads(raw);
	if "success" not in data:
		print "Success key not found in response.";
		sys.exit(1);
	if data["success"] != True:
		print "Value of success expected true, got", data["success"];
		sys.exit(2);
except Exception as e:
	print "Exception parsing server response.";
	print e;
	print "\n", raw;
	sys.exit(3);

print 'Success.';
sys.exit(0);
