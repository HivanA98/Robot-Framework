"""Test data for https://voila.id (production site - UI checks only, nothing is submitted)."""

BASE_URL = "https://voila.id"
LOGIN_URL = f"{BASE_URL}/account/login"
REGISTER_PATH = "/account/register"

LOGIN_TITLE = "Sign In"

# The Sign In button only becomes enabled for a well-formed e-mail or phone number.
VALID_IDENTIFIERS = ["ivan@example.com", "081234567890", "6281234567890"]
INVALID_IDENTIFIERS = ["ivan", "ivan@", "ivan@example", "12345", "81234567890"]
