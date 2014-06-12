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

for d in csv.DictReader(open(sys.argv[1])):
    test_id = d['test']
    if '[' in test_id:
        test_id = test_id[:test_id.index('[')]
    result = result_map.get(d.get('status', 'unknown'))
    test_id = re.sub('[^0-9A-Za-z_.]', '-', test_id)
    print test_id, result
