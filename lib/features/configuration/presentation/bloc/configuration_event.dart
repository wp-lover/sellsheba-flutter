part of 'configuration_bloc.dart';

abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent();

  @override
  List<Object?> get props => [];
}

class SubmitConfigurationEvent extends ConfigurationEvent {
  final String siteUrl;
  final String licenseKey;

  const SubmitConfigurationEvent({
    required this.siteUrl,
    required this.licenseKey,
  });

  @override
  List<Object?> get props => [siteUrl, licenseKey];
}

class CheckConfigurationEvent extends ConfigurationEvent {}
