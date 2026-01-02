// features/configuration/presentation/bloc/configuration_state.dart

part of './configuration_bloc.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object?> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoading extends ConfigurationState {}

class ConfigurationEmpty extends ConfigurationState {}

class ConfigurationLoaded extends ConfigurationState {
  final AppConfiguration config;

  const ConfigurationLoaded({required this.config});

  @override
  List<Object?> get props => [config];
}

class ConfigurationSaving extends ConfigurationState {}

class ConfigurationSaved extends ConfigurationState {
  final AppConfiguration config;

  const ConfigurationSaved({required this.config});

  @override
  List<Object?> get props => [config];
}

class ConfigurationError extends ConfigurationState {
  final String message;

  const ConfigurationError({required this.message});

  @override
  List<Object?> get props => [message];
}
