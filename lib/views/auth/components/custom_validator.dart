class CustomValidator {
  static String? email(String? value) {
    if (value!.isEmpty) {
      return ' Email is required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return ' Please enter valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty) {
      return ' Password is required';
    } else if (value.length < 6) {
      return ' Password should be greater than 6 digits';
    }
    return null;
  }

  static String? loginPassword(String? value) {
    if (value!.isEmpty) {
      return ' Password is required';
    }

    return null;
  }

  static String? confirmPassword(String? value, String oldPassword) {
    if (value!.isEmpty) {
      return ' Confirm Password is required';
    } else if (value.length < 6) {
      return ' Password should be greater than 6 digits';
    } else if (value != oldPassword) {
      return ' Confirm Password is not matched';
    }
    return null;
  }

  static String? isEmpty(String? value) {
    if (value!.isEmpty) {
      return ' Field cannot not be empty';
    }
    return null;
  }

  static String? isEmptyTitle(String? value) {
    if (value!.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  static String? isEmptyUserName(String? value) {
    if (value!.isEmpty) {
      return ' Username is required';
    }
    return null;
  }

  static String? number(String? value) {
    if (value!.isEmpty) {
      return ' Phone Number is required';
    } else if (value.length < 6) {
      return 'Phone number should be at least 6 digits';
    }
    return null;
  }

  static String? age(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    // Check if the value is a valid number
    final RegExp numberRegExp = RegExp(r'^\d+$');
    if (!numberRegExp.hasMatch(value)) {
      return 'Age must be a number';
    }

    // Convert the value to an integer
    final int ageValue = int.parse(value);

    // Check if the age is within a valid range
    if (ageValue < 10 || ageValue > 200) {
      return 'Age must be between 10 and 200';
    }

    // If all checks pass, return null indicating no errors
    return null;
  }

  static String? gender(String? value) {
    // Define the list of valid gender options
    const List<String> validGenders = [
      'Male',
      'Female',
      'Other',
    ];

    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }

    // Convert the input to lowercase for case-insensitive comparison
    final String normalizedValue = value.trim().toLowerCase();

    // Check if the normalized value is in the list of valid genders (case-insensitive)
    final bool isValidGender = validGenders.any((gender) => gender.toLowerCase() == normalizedValue);

    if (!isValidGender) {
      // return 'Please select valid gender';
      return 'Please select from: ${validGenders.join(', ')}';
    }

    // If all checks pass, return null indicating no errors
    return null;
  }



  static String? lessThen2(String? value) {
    return (value!.length < 2) ? ' Enter more than 1 characters' : null;
  }

  static String? lessThen3(String? value) {
    return (value!.length < 3) ? ' Enter more than 2 characters' : null;
  }

  static String? lessThen4(String? value) {
    return (value!.length < 4) ? ' Enter more than 3 characters' : null;
  }

  static String? lessThen5(String? value) {
    return (value!.length < 5) ? ' Enter more than 4 characters' : null;
  }

  static String? greaterThen(String? input, double compareWith) {
    return (double.parse(input ?? '0') < compareWith)
        ? ' New input must be greater'
        : null;
  }

  static String? returnNull(String? value) => null;
}
