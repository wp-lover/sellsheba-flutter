import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/configuration_entity.dart';
import '../../domain/repositories/configuration_repository.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationRepository repository;

  ConfigurationBloc({required this.repository})
    : super(ConfigurationInitial()) {
    on<SubmitConfigurationEvent>(_onSubmitConfiguration);
    on<CheckConfigurationEvent>(_onCheckConfiguration);
  }

  Future<void> _onSubmitConfiguration(
    SubmitConfigurationEvent event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(ConfigurationLoading());
    final result = await repository.verifyAndSave(
      siteUrl: event.siteUrl,
      licenseKey: event.licenseKey,
    );

    result.fold(
      (failure) =>
          emit(const ConfigurationFailure(message: "Verification Failed")),
      (success) => emit(ConfigurationSuccess()),
    );
  }

  Future<void> _onCheckConfiguration(
    CheckConfigurationEvent event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(ConfigurationLoading());
    final result = await repository.getConfiguration();

    result.fold((failure) => emit(ConfigurationInitial()), (config) {
      if (config != null) {
        emit(ConfigurationLoaded(config: config));
      } else {
        emit(ConfigurationInitial());
      }
    });
  }
}
