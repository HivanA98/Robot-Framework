"""Global runtime configuration shared by every project.

Every value can be overridden from the environment or from the command line:

    HEADLESS=true robot ...
    robot --variable BROWSER:firefox --variable HEADLESS:True ...
"""

import os

__all__ = ["BROWSER", "HEADLESS", "TIMEOUT", "WINDOW_WIDTH", "WINDOW_HEIGHT"]


def _env_bool(name: str, default: bool) -> bool:
    return os.getenv(name, str(default)).strip().lower() in ("1", "true", "yes", "on")


BROWSER = os.getenv("BROWSER", "chrome")
HEADLESS = _env_bool("HEADLESS", False)
TIMEOUT = os.getenv("TIMEOUT", "10s")
WINDOW_WIDTH = int(os.getenv("WINDOW_WIDTH", "1920"))
WINDOW_HEIGHT = int(os.getenv("WINDOW_HEIGHT", "1080"))
