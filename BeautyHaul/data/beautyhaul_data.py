"""Test data for https://www.beautyhaul.com (production site).

Only client-side validation is exercised: the site is real and protected by
reCAPTCHA, so no test is allowed to send a login or registration request.
Validation messages mirror the site's ``VALIDATION_RULES`` object.
"""

BASE_URL = "https://www.beautyhaul.com"
LOGIN_URL = f"{BASE_URL}/account/login"
REGISTER_URL = f"{BASE_URL}/account/register"
FORGOT_PASSWORD_PATH = "/account/forgotpassword"
PHONE_LOGIN_PATH = "/account/login/phone"

LOGIN_HEADING = "Masuk ke Beautyhaul"
REQUIRED_TOAST = "Ups, masih ada form yang wajib diisi"

MSG = {
    "first_name_required": "Nama depan harus diisi",
    "first_name_min": "Nama depan minimal 2 karakter",
    "first_name_max": "Nama depan maksimal 20 karakter",
    "last_name_required": "Nama belakang harus diisi",
    "last_name_min": "Nama belakang minimal 2 karakter",
    "last_name_max": "Nama belakang maksimal 20 karakter",
    "email_required": "Email harus diisi",
    "email_format": "Format email tidak sesuai",
    "phone_required": "Nomor ponsel harus diisi",
    "phone_min": "Nomor ponsel minimal 8 karakter",
    "phone_max": "Nomor ponsel maksimal 15 karakter",
    "password_required": "Password harus diisi",
    "password_min": "Password minimal 6 karakter",
    "password_rule": "Password harus memiliki 1 karakter dan 1 angka",
    "confirm_required": "Konfirmasi password harus diisi",
    "confirm_mismatch": "Konfirmasi password tidak sesuai",
    "birth_date_required": "Tanggal lahir harus diisi",
}

INVALID_EMAILS = [
    "ivan",
    "ivan@",
    "ivan@mail",
    "@mail.com",
    "ivan mail@mail.com",
]
