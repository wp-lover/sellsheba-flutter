import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/configuration_model.dart';

abstract class ConfigurationLocalDataSource {
  Future<void> saveConfiguration(ConfigurationModel configuration);
  Future<ConfigurationModel?> getConfiguration();
  Future<void> clearConfiguration();
}

class ConfigurationLocalDataSourceImpl implements ConfigurationLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static const String cachedSiteUrl = 'CACHED_SITE_URL';
  static const String cachedLicenseKey = 'CACHED_LICENSE_KEY';

  ConfigurationLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<void> saveConfiguration(ConfigurationModel configuration) async {
    await sharedPreferences.setString(cachedSiteUrl, configuration.siteUrl);
    await secureStorage.write(
      key: cachedLicenseKey,
      value: configuration.licenseKey,
    );
  }

  @override
  Future<ConfigurationModel?> getConfiguration() async {
    final siteUrl = sharedPreferences.getString(cachedSiteUrl);
    final licenseKey = await secureStorage.read(key: cachedLicenseKey);

    if (siteUrl != null && licenseKey != null) {
      return ConfigurationModel(siteUrl: siteUrl, licenseKey: licenseKey);
    }
    return null;
  }

  @override
  Future<void> clearConfiguration() async {
    await sharedPreferences.remove(cachedSiteUrl);
    await secureStorage.delete(key: cachedLicenseKey);
  }
}
