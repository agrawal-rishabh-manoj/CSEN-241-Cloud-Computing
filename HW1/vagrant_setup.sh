#! /bin/bash
#

CPUTEST_PATH="/cpu-script.sh"
FILEIOTEST_PATH="/fileio-script.sh"
MEMORYTEST_PATH="/memory-script.sh"

sudo apt-get update
sudo apt-get install -y sysbench
chmod +x /cpu-script.sh
chmod +x /fileio-script.sh
chmod +x /memory-script.sh

"$CPUTEST_PATH"
"$FILEIOTEST_PATH"
"$MEMORYTEST_PATH"
