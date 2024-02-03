#!/bin/bash

# Function to perform a memory test
perform_memory_test() {
    local iteration=$1
    local access_mode=$2

    echo "Iteration $iteration"
    
    sysbench --test=memory --memory-block-size=1K --memory-total-size=2G --memory-access-mode=$access_mode run
    
    echo ""
}

# Define memory test cases
memory_test_cases=(
    {1..5}:seq  # Sequential Memory Access
    {1..5}:rnd  # Random Memory Access
)

echo "Starting Memory Tests"

# Iterate through memory test cases
for test_case in "${memory_test_cases[@]}"; do
    IFS=':' read -r iteration access_mode <<< "$test_case"
    echo "Running Memory Test: $access_mode Access"
    for ((i=1; i<=$iteration; i++)); do
        perform_memory_test $i $access_mode
    done
done

echo "All Memory tests are completed."