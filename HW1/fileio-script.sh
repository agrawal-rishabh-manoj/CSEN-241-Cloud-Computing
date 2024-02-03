#!/bin/bash

# Function to perform a file I/O test
perform_file_io_test() {
    local iteration=$1
    local total_size=$2
    local test_mode=$3

    echo "Iteration $iteration"
    
    # Prepare
    sysbench --test=fileio --file-total-size=$total_size --file-test-mode=$test_mode prepare
    
    # Run
    sysbench --test=fileio --file-total-size=$total_size --file-test-mode=$test_mode run
    
    # Cleanup
    sysbench --test=fileio --file-total-size=$total_size cleanup
    
    echo ""
}

# Define test cases
test_cases=(
    {1..5}:250M:seqwr  # Sequential Write
    {1..5}:300M:rndrd  # Random Read
)

echo "Starting File I/O Tests"

# Iterate through test cases
for test_case in "${test_cases[@]}"; do
    IFS=':' read -r iteration total_size test_mode <<< "$test_case"
    echo "Running File I/O Test: $test_mode"
    for ((i=1; i<=$iteration; i++)); do
        perform_file_io_test $i $total_size $test_mode
    done
done

echo "All File I/O tests are completed."
