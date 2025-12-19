/// A set of extensions to parse full names into first and last names.
extension HandleNames on String {
  /// Parses a full name into first and last names.
  Map<String, String> parseFullName() {
    // Trim leading and trailing spaces and split by whitespace
    final nameParts = trim().split(RegExp(r'\s+'));

    var firstName = '';
    var lastName = '';

    // If there's only one name part, treat it as the first name
    if (nameParts.length == 1) {
      firstName = nameParts[0];
    }
    // ignore: lines_longer_than_80_chars
    // If there are multiple parts, assign the first part to firstName and the rest to lastName
    else if (nameParts.length > 1) {
      firstName = nameParts.first;
      lastName = nameParts.skip(1).join(' ');
    }

    return {
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
