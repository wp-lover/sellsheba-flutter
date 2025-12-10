import '../../domain/entities/configuration_entity.dart';

class ConfigurationModel extends ConfigurationEntity {
  const ConfigurationModel({required super.siteUrl, required super.licenseKey});

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
      siteUrl: json['site_url'] as String,
      licenseKey: json['license_key'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'site_url': siteUrl, 'license_key': licenseKey};
  }
}
