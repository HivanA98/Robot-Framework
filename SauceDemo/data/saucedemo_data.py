"""Static test data for https://www.saucedemo.com (public demo credentials)."""

BASE_URL = "https://www.saucedemo.com"
INVENTORY_URL = f"{BASE_URL}/inventory.html"
CART_URL = f"{BASE_URL}/cart.html"

PASSWORD = "secret_sauce"
WRONG_PASSWORD = "NotAPassword"

STANDARD_USER = "standard_user"
LOCKED_USER = "locked_out_user"
PROBLEM_USER = "problem_user"
GLITCH_USER = "performance_glitch_user"
ERROR_USER = "error_user"
VISUAL_USER = "visual_user"
UNKNOWN_USER = "Ivan"

ACCEPTED_USERS = [STANDARD_USER, PROBLEM_USER, GLITCH_USER, ERROR_USER, VISUAL_USER]

LOGIN_ERRORS = {
    "mismatch": "Epic sadface: Username and password do not match any user in this service",
    "locked": "Epic sadface: Sorry, this user has been locked out.",
    "username_required": "Epic sadface: Username is required",
    "password_required": "Epic sadface: Password is required",
    "not_logged_in": "Epic sadface: You can only access '/inventory.html' when you are logged in.",
}

CHECKOUT_ERRORS = {
    "first_name": "Error: First Name is required",
    "last_name": "Error: Last Name is required",
    "postal_code": "Error: Postal Code is required",
}

TAX_RATE = "0.08"
ORDER_COMPLETE_HEADER = "Thank you for your order!"

BACKPACK = "Sauce Labs Backpack"
BIKE_LIGHT = "Sauce Labs Bike Light"
BOLT_TSHIRT = "Sauce Labs Bolt T-Shirt"
FLEECE_JACKET = "Sauce Labs Fleece Jacket"
ONESIE = "Sauce Labs Onesie"
RED_TSHIRT = "Test.allTheThings() T-Shirt (Red)"

PRODUCT_PRICES = {
    BACKPACK: "29.99",
    BIKE_LIGHT: "9.99",
    BOLT_TSHIRT: "15.99",
    FLEECE_JACKET: "49.99",
    ONESIE: "7.99",
    RED_TSHIRT: "15.99",
}
ALL_PRODUCTS = list(PRODUCT_PRICES)

SORT_OPTIONS = {
    "name_asc": "az",
    "name_desc": "za",
    "price_asc": "lohi",
    "price_desc": "hilo",
}
