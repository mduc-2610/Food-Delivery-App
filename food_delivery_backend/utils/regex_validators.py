from django.core.validators import RegexValidator, validate_email

phone_regex = RegexValidator(
    regex=r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$',
    message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed."
)

password_regex = RegexValidator(
    regex=r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    message="Password must contain at least 8 characters, including uppercase, lowercase letters, and numbers."
)