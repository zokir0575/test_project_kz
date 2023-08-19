enum ErrorField {
  name,
  phone,
  password,
  confirmPassword,
  passwordMissMach,
  email,
  pure,
  pinCode,
}

extension ErrorFieldX on ErrorField {
  bool get isName => this == ErrorField.name;

  bool get pinCode => this == ErrorField.pinCode;

  bool get isPhone => this == ErrorField.phone;

  bool get isPassword => this == ErrorField.password;

  bool get isConfirmPassword => this == ErrorField.confirmPassword;

  bool get isPasswordMissMatch => this == ErrorField.confirmPassword;

  bool get isEmail => this == ErrorField.confirmPassword;

  bool get isPure => this == ErrorField.pure;
}
