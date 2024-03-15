# a simple script that reads some log file apache_logs and writes into the file not_found.txt information about address, HTTP method and path from all requests where a 404 status code was thrown.
#!/bin/bash

cat apache_logs | grep ' 404 ' | awk '{print $1, $6, $7}' > not_found.txt