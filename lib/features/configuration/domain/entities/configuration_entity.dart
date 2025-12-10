import 'package:equatable/equatable.dart';

class ConfigurationEntity extends Equatable {
  final String siteUrl;
  final String licenseKey;

  const ConfigurationEntity({required this.siteUrl, required this.licenseKey});

  @override
  List<Object?> get props => [siteUrl, licenseKey];
}
