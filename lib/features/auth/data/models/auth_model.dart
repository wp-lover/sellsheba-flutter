import '../../domain/entities/auth_entity.dart';

/**
 * AuthModel: Maps the raw JSON response from the SellSheba Connect API
 * to the AuthEntity format.
 */
class AuthModel extends AuthEntity {
  const AuthModel({
    required super.token,
    required super.userId,
    required super.userDisplayName,
    required super.userRole,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String? ?? '',
      userDisplayName: json['user_nicename'] as String? ?? '',
      // Default to 0 if not present, assuming API behavior described in original file
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString()) ?? 0
          : 0,
      // Default role if not present
      userRole: json['role'] as String? ?? 'sellsheba_employee',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_nicename': userDisplayName,
      'user_id': userId,
      'role': userRole,
    };
  }

  // Helper to convert model usage to entity if needed explicitly (though it IS an entity)
  AuthEntity toEntity() {
    return AuthEntity(
      token: token,
      userId: userId,
      userDisplayName: userDisplayName,
      userRole: userRole,
    );
  }
}
