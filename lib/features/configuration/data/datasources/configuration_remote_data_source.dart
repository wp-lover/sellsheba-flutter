import 'package:dio/dio.dart';

abstract class ConfigurationRemoteDataSource {
  Future<bool> verifyLicense(String siteUrl, String licenseKey);
}

class ConfigurationRemoteDataSourceImpl
    implements ConfigurationRemoteDataSource {
  final Dio client;

  ConfigurationRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> verifyLicense(String siteUrl, String licenseKey) async {
    // TODO: Implement actual API call when backend is ready
    // For now, simulate a network delay and return true
    await Future.delayed(const Duration(seconds: 2));

    // We can add some basic validation here if needed, e.g. checking URL format
    if (Uri.tryParse(siteUrl) == null || !siteUrl.startsWith('http')) {
      throw Exception("Invalid URL");
    }

    return true;
  }
}
