// lib/core/constants/storage_keys.dart

class StorageKeys {
  StorageKeys._(); // Private constructor — can't instantiate

  // Secure storage keys (sensitive data)
  static const String baseUrl = 'sellsheba_base_url';
  static const String jwtToken = 'sellsheba_jwt_token';

  // SharedPreferences keys (non-sensitive)
  static const String languageCode = 'sellsheba_language_code';
  static const String themeMode = 'sellsheba_theme_mode';
  static const String selectedBranchId = 'sellsheba_selected_branch_id';
  static const String lastSyncTime = 'sellsheba_last_sync_time';

  // Future keys can be added here easily
  // static const String licenseKey = 'sellsheba_license_key';
}
