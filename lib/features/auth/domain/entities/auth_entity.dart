import 'package:equatable/equatable.dart';

/**
 * AuthEntity: The pure representation of a successfully logged-in user.
 * This lives in the Domain layer and is framework/API agnostic.
 */
class AuthEntity extends Equatable {
  // The JWT Access Token returned by the API (used for subsequent API calls)
  final String token;

  // Basic user details
  final int userId;
  final String userDisplayName;

  // Optional but useful for the app's internal logic and display
  final String userRole; // e.g., 'sellsheba_employee', 'administrator'

  // Note: The JWT plugin may also return a 'refresh_token',
  // but we'll stick to the core token for now.

  const AuthEntity({
    required this.token,
    required this.userId,
    required this.userDisplayName,
    required this.userRole,
  });

  // Equatable is used for clean object comparison
  @override
  List<Object?> get props => [token, userId, userDisplayName, userRole];
}
