import concurrent.futures
import requests
import time

# Endpoint for the chatbot function
CHAT_FUNCTION_URL = "http://127.0.0.1:8080/function/chatbot"

def post_chatbot_data(payload):
    """Post data to the chatbot function."""
    try:
        result = requests.post(CHAT_FUNCTION_URL, data=payload)
        return result.status_code
    except Exception as err:
        return str(err)

def launch_requests(rate_of_requests, test_duration=10):
    """Launch requests concurrently to achieve a certain rate."""
    with concurrent.futures.ThreadPoolExecutor() as pool:
        tasks = []
        start = time.time()
        
        while time.time() - start < test_duration:
            for _ in range(rate_of_requests):
                # Customize your request payload as necessary
                task = pool.submit(post_chatbot_data, "Can you tell me a joke?")
                tasks.append(task)
            time.sleep(1)  # Interval before the next group of requests

        outcomes = [task.result() for task in tasks]

    successful_outcomes = [outcome for outcome in outcomes if outcome == 200]
    print(f"Attempted requests: {len(outcomes)}")
    print(f"Successful replies: {len(successful_outcomes)}")
    print(f"Efficiency: {(len(successful_outcomes) / len(outcomes)) * 100:.2f}%")

# Usage example:
requests_each_second = 5  # Modify this to test different intensities
launch_requests(requests_each_second)
