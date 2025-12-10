part of 'configuration_bloc.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object?> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoading extends ConfigurationState {}

class ConfigurationSuccess extends ConfigurationState {}

class ConfigurationLoaded extends ConfigurationState {
  final ConfigurationEntity config;

  const ConfigurationLoaded({required this.config});

  @override
  List<Object?> get props => [config];
}

class ConfigurationFailure extends ConfigurationState {
  final String message;

  const ConfigurationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
