from pynput.mouse import Button, Controller as MouseController
from pynput.keyboard import Listener, KeyCode
import threading
import time

TOGGLE_KEY = KeyCode(char="#")
DELAY: float = 0.005

clicking = False
mouse = MouseController()


def clicker():
    while True:
        if clicking:
            mouse.click(Button.left, 1)
            time.sleep(DELAY)
        else:
            time.sleep(0.1)


def on_press(key):
    global clicking
    if key == TOGGLE_KEY:
        clicking = not clicking
        print("Clicking:", clicking)


click_thread = threading.Thread(target=clicker)
click_thread.daemon = True
click_thread.start()

with Listener(on_press=on_press) as listener:
    listener.join()
