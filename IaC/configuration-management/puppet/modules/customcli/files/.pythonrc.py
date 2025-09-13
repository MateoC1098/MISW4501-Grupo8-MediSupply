# -*- coding: utf-8 -*-
import atexit
import os
import site
import sys
from datetime import datetime
from threading import Lock

# ========== COLORS ==========
DEFAULT = "\033[0m"
RED = "\033[0;31m"
BOLD_RED = "\033[1;31m"
GREEN = "\033[0;32m"
BOLD_GREEN = "\033[1;32m"
YELLOW = "\033[0;33m"
BOLD_YELLOW = "\033[1;33m"
BLUE = "\033[0;34m"
BOLD_BLUE = "\033[1;34m"
MAGENTA = "\033[0;35m"
BOLD_MAGENTA = "\033[1;35m"
CYAN = "\033[0;36m"
BOLD_CYAN = "\033[1;36m"
# ============================

EMOJI_HOURS = {
    '12:00': '🕛',
    '12:30': '🕧',
    '01:00': '🕐',
    '01:30': '🕜',
    '02:00': '🕑',
    '02:30': '🕝',
    '03:00': '🕒',
    '03:30': '🕞',
    '04:00': '🕓',
    '04:30': '🕟',
    '05:00': '🕔',
    '05:30': '🕠',
    '06:00': '🕕',
    '06:30': '🕡',
    '07:00': '🕖',
    '07:30': '🕢',
    '08:00': '🕗',
    '08:30': '🕣',
    '09:00': '🕘',
    '09:30': '🕤',
    '10:00': '🕙',
    '10:30': '🕥',
    '11:00': '🕚',
    '11:30': '🕦'
}


# https://refactoring.guru/es/design-patterns/singleton/python/example#example-1
class SingletonMeta(type):
    """
    This is a thread-safe implementation of Singleton.
    """
    _instances = {}
    _lock: Lock = Lock()
    """
    We now have a lock object that will be used to synchronize threads during
    first access to the Singleton.
    """

    def __call__(cls, *args, **kwargs):
        """
        Possible changes to the value of the `__init__` argument do not affect
        the returned instance.
        """
        # Now, imagine that the program has just been launched. Since there's no
        # Singleton instance yet, multiple threads can simultaneously pass the
        # previous conditional and reach this point almost at the same time. The
        # first of them will acquire lock and will proceed further, while the
        # rest will wait here.
        with cls._lock:
            # The first thread to acquire the lock, reaches this conditional,
            # goes inside and creates the Singleton instance. Once it leaves the
            # lock block, a thread that might have been waiting for the lock
            # release may then enter this section. But since the Singleton field
            # is already initialized, the thread won't create a new object.
            if cls not in cls._instances:
                instance = super().__call__(*args, **kwargs)
                cls._instances[cls] = instance
        return cls._instances[cls]


class Singleton(metaclass=SingletonMeta):
    line_number: int

    def __init__(self) -> None:
        self.line_number = 0

    def increment_line(self):
        self.line_number += 1
        return self.line_number


class IPythonPromptPS1(object):
    def __init__(self):
        self.singleton = Singleton()

    def __str__(self):
        line = self.singleton.increment_line()
        time = datetime.now()
        current_minute = int(time.strftime('%M'))
        aprox_minute = '00' if current_minute < 30 else '30'
        aprox_time = time.strftime('%I:') + aprox_minute
        return f"{BOLD_GREEN}🐍 In[{line}] {EMOJI_HOURS[aprox_time]} {time.strftime('%I:%M:%S %p')}:{DEFAULT} "


class IPythonPromptPS2(object):
    def __init__(self):
        self.singleton = Singleton()

    def __str__(self):
        base_line = f"🐍 In[{self.singleton.line_number}] 🕕 HH:MM:SS AM: "
        num_blanks = len(base_line) - len('...')
        blanks = ' ' * num_blanks
        return blanks + f"{BOLD_BLUE}...:{DEFAULT} "


def print_separator():
    print(f"{BOLD_BLUE}================================================={DEFAULT}")


print_separator()
print(f"{BOLD_MAGENTA}sys.path:{DEFAULT} {sys.path}")
color_enabled_user_site = BOLD_GREEN if site.ENABLE_USER_SITE else BOLD_RED
print("{}Enabled{}[{}{}{}] {}user_site_packages:{} {}".format(
    BOLD_MAGENTA, DEFAULT,
    color_enabled_user_site, site.ENABLE_USER_SITE, DEFAULT,
    BOLD_MAGENTA, DEFAULT,
    site.getusersitepackages()
))
print(f"{BOLD_MAGENTA}PYTHONSTARTUP:{DEFAULT} {os.environ.get('PYTHONSTARTUP')}")
print_separator()

sys.ps1 = IPythonPromptPS1()
sys.ps2 = IPythonPromptPS2()
# sys.__interactivehook__ # Execute at startup
# import inspect
# print(inspect.getsource(sys.__interactivehook__))


@ atexit.register
def goodbye():
    print_separator()
    print(f"🦉 {BOLD_YELLOW}Mischief managed!{DEFAULT}")
    print_separator()
