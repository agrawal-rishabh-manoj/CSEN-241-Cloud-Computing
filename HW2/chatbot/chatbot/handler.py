import datetime
from pyfiglet import Figlet
import sys

def handle(req):
    """Process incoming requests based on the input text"""
    if "name" in req.lower() or "what is your name" in req.lower():
        # Respond with the bot's name in 3 different ways
        response = [
            "My name is Rishabh",
            "I'm called Agrawal also.",
            "You can call me RMA."
        ]
        return "\n".join(response)
    elif "current time" in req.lower() or "current date" in req.lower():
        # Respond with the current date and time in 3 different ways
        current_time = datetime.datetime.now()
        responses = [
            current_time.strftime("The current time is %H:%M on %B %d, %Y."),
            current_time.strftime("It's now %H:%M on %d/%m/%Y."),
            current_time.strftime("Today is %B %d, %Y, and the time is %H:%M.")
        ]
        return "\n".join(responses)
    elif req.lower().startswith("generate a figlet for"):
        # Extract the text to generate figlet
        extract_text = req[len("generate a figlet for"):].strip("\" ")
        # For the purpose of this example, we'll simulate figlet output using PyFiglet
        f = Figlet(font='slant')
        return f.renderText(extract_text)
    else:
        return "I'm not sure how to process that request."

if __name__ == "__main__":
    # For local testing, input can be sent directly through command line
    req = sys.argv[1] if len(sys.argv) > 1 else ""
    print(handle(req))
