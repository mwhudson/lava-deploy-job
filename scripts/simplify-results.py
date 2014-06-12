import csv
import re
import sys

result_map = {
    'success': 'pass',
    'failure': 'fail',
    'error': 'fail',
    'skip': 'skip',
    'xfail': 'pass' #?
    }

def clean_test_id(test_id):
    if '[' in test_id:
        test_id = test_id[:test_id.index('[')]
    return re.sub('[^-0-9A-Za-z_.]', '-', test_id)

seen_tests = set()

for d in csv.DictReader(open(sys.argv[1])):
    test_id = clean_test_id(d['test'])
    seen_tests.add(test_id)
    result = result_map.get(d.get('status', 'unknown'))
    print "TEST@%s@ RESULT@%s@" % (test_id, result)

all_tests = set()
for l in open(sys.argv[2]):
    all_tests.add(clean_test_id(l.strip()))

for test_id in all_tests - seen_tests:
    print "TEST@%s@ RESULT@%s@" % (test_id, 'unknown')
