"""Python helper keywords that would be verbose to express in Robot syntax."""

from datetime import date, timedelta
from decimal import ROUND_HALF_UP, Decimal

from robot.api import logger
from robot.api.deco import keyword, library
from selenium.webdriver import ChromeOptions, EdgeOptions, FirefoxOptions

_TRUTHY = ("1", "true", "yes", "on")


@library(scope="GLOBAL", auto_keywords=False)
class TestHelpers:
    """Browser option factory, price parsing and ordering assertions."""

    @keyword
    def build_browser_options(self, browser: str, headless=False, width: int = 1920, height: int = 1080):
        """Return a Selenium options object for ``browser``.

        Chromium browsers get the password manager / leak-detection popups
        disabled, because they block the UI after logging in to demo sites.
        """
        headless = str(headless).strip().lower() in _TRUTHY
        name = browser.lower()

        if name in ("chrome", "gc", "googlechrome", "headlesschrome", "edge", "msedge"):
            options = EdgeOptions() if "edge" in name else ChromeOptions()
            options.add_experimental_option(
                "prefs",
                {
                    "credentials_enable_service": False,
                    "profile.password_manager_enabled": False,
                    "profile.password_manager_leak_detection": False,
                },
            )
            options.add_argument("--disable-features=PasswordLeakDetection")
            options.add_argument("--disable-search-engine-choice-screen")
            options.add_argument("--no-first-run")
            options.add_argument(f"--window-size={width},{height}")
            if headless:
                options.add_argument("--headless=new")
            return options

        if name in ("firefox", "ff", "headlessfirefox"):
            options = FirefoxOptions()
            options.add_argument(f"--width={width}")
            options.add_argument(f"--height={height}")
            if headless:
                options.add_argument("-headless")
            return options

        raise ValueError(f"Unsupported browser '{browser}'. Use chrome, edge or firefox.")

    @keyword
    def parse_price(self, text: str) -> Decimal:
        """``"Item total: $29.99"`` -> ``Decimal("29.99")``."""
        return Decimal(text.rsplit("$", 1)[-1].strip())

    @keyword
    def parse_prices(self, texts) -> list:
        return [self.parse_price(text) for text in texts]

    @keyword
    def sum_prices(self, prices) -> Decimal:
        return sum((Decimal(str(p)) for p in prices), Decimal("0"))

    @keyword
    def calculate_tax(self, subtotal, rate) -> Decimal:
        """Tax rounded to cents the same way the shop does (half up)."""
        tax = Decimal(str(subtotal)) * Decimal(str(rate))
        return tax.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)

    @keyword
    def list_should_be_sorted(self, items, order: str = "asc", numeric=False):
        """Fail unless ``items`` is sorted ascending (``asc``) or descending (``desc``)."""
        values = [Decimal(str(i)) for i in items] if str(numeric).lower() in _TRUTHY else list(items)
        expected = sorted(values, reverse=order.lower() == "desc")
        logger.info(f"Actual:   {values}\nExpected: {expected}")
        if values != expected:
            raise AssertionError(f"List is not sorted {order}: {values}")

    @keyword
    def date_in_days(self, days: int = 7, fmt: str = "%d/%m/%Y") -> str:
        """Date ``days`` from today, formatted with ``fmt``."""
        return (date.today() + timedelta(days=int(days))).strftime(fmt)
