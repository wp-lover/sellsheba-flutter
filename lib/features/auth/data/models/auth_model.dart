import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_entity.dart';

// IMPORTANT: Requires running 'flutter pub run build_runner build' later
part 'auth_model.g.dart';

/**
 * AuthModel: Maps the raw JSON response from the SellSheba Connect API
 * to the AuthEntity format.
 */
@JsonSerializable()
class AuthModel extends AuthEntity {
  // Use the exact JSON keys returned by the Tmeister/wp-api-jwt-auth plugin
  @JsonKey(name: 'token') // This key is standard for the JWT plugin
  final String tokenModel;

  @JsonKey(name: 'user_email') // The WP user email (often used for ID lookup)
  final String userEmailModel;

  @JsonKey(name: 'user_nicename') // The WP username/nicename
  final String userNicenameModel;

  // NOTE: The standard JWT plugin usually returns the user ID and role
  // via a separate 'user_data' field in the JSON payload, or requires a second API call.
  // We will assume a slightly modified API or handle the lookup in the DataSource.

  // We map the model fields back to the entity fields for clarity
  const AuthModel({
    required this.tokenModel,
    required this.userEmailModel,
    required this.userNicenameModel,
    // We'll pass placeholders for userId/userRole for now,
    // as we need to adjust the backend response or make a second call to get them.
  }) : super(
         token: tokenModel,
         userId: 0, // Placeholder
         userDisplayName: userNicenameModel,
         userRole: 'sellsheba_employee', // Placeholder
       );

  // Factory methods for JSON serialization
  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  // CRITICAL: A method to map the incomplete JWT response to the full AuthEntity
  AuthEntity toEntity({required int userId, required String userRole}) {
    return AuthEntity(
      token: tokenModel,
      userId: userId,
      userDisplayName: userNicenameModel,
      userRole: userRole,
    );
  }
}
