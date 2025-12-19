import 'package:coubot/core/extensions/parse_full_name.dart';
import 'package:coubot/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Helper class to update user metadata after sign in
class SignInHelper {
  /// Update user metadata after sign in
  static Future<void> updateUserMetadata(User user) async {
    if (user.userMetadata != null) {
      final fullName = (user.userMetadata!['full_name'] as String?) ??
          (user.userMetadata!['name'] as String?) ??
          '';
      final parsedNames = fullName.parseFullName();
      await supabaseClient.auth.updateUser(
        UserAttributes(
          data: {
            'first_name': parsedNames['first_name'],
            'last_name': parsedNames['last_name'],
          },
        ),
      );
      await supabaseClient.auth.refreshSession(); // Ensure session is refreshed
    }
  }

  /// Check if first name and second name of user exists
  static bool firstAndSecondNameEmpty(User? user) {
    final firstName = user?.userMetadata!['first_name'] as String?;
    final lastName = user?.userMetadata!['last_name'] as String?;
    return (firstName == null || lastName == null) ||
        (firstName.isEmpty || lastName.isEmpty);
  }
}
