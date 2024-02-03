#!/bin/bash

echo "Hey, you are in $0, and about to test CPU!"

# Define test configurations
test_configs=(
    {1000,30,1}     # Test Case 1: max-prime=1000, time=30 seconds, threads=1
    {10000,30,1}    # Test Case 2: max-prime=10000, time=30 seconds, threads=1
    {100000,30,1}   # Test Case 3: max-prime=100000, time=30 seconds, threads=1
)

TEST_RUNS=5
TEST_CASES=3

for ((i=0; i<$TEST_CASES; i++))
do
    IFS=',' read -r max_prime max_time threads <<< "${test_configs[$i]}"
    echo "*****************************Starting ${i+1}st Test Case***************************************"
    for (( j=1; j<=$TEST_RUNS; j++ ))
    do
        echo "Running ${j}st run of Test Case ${i+1}"
        sysbench cpu --threads=$threads --cpu-max-prime=$max_prime --time=$max_time run
        echo "Completed ${j}st run of Test Case ${i+1}"
    done
    echo "*****************************Completed ${i}st Test Case***************************************"
done
