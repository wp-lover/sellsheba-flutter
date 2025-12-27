// features/configuration/presentation/bloc/configuration_event.dart
part of 'configuration_bloc.dart';

abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent();

  @override
  List<Object> get props => [];
}

class LoadConfiguration extends ConfigurationEvent {}

class SaveSiteUrl extends ConfigurationEvent {
  final String url;

  const SaveSiteUrl(this.url);

  @override
  List<Object> get props => [url];
}

class ClearConfiguration extends ConfigurationEvent {}
